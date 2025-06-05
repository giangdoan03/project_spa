<?php

namespace App\Controllers;

use App\Models\PurchaseHistoryModel;
use App\Models\CustomerModel;
use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class PurchaseHistoryController extends ResourceController
{
    use AuthTrait;

    protected $modelName = PurchaseHistoryModel::class;
    protected $format = 'json';

    public function index()
    {
        $currentUser = $this->getUser();
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');
        $customerId = $this->request->getGet('customer_id');

        $builder = $this->model;

        if ($currentUser['role'] === 'admin' && !empty($customerId)) {
            $builder->where('customer_id', $customerId);
        } elseif ($currentUser['role'] !== 'admin') {
            // Nếu là customer → chỉ xem của chính mình
            $builder->where('customer_id', $currentUser['id']);
        }

        // Tìm kiếm nếu có
        if ($search) {
            $builder->groupStart()
                ->like('product_name', $search)
                ->orLike('note', $search)
                ->groupEnd();
        }

        // Không join users nữa nếu không cần
        $data = $builder->paginate($perPage, 'default', $page);
        $pager = $this->model->pager;

        return $this->respond([
            'data' => $data,
            'pager' => [
                'total' => $pager->getTotal(),
                'per_page' => $perPage,
                'current_page' => $page,
            ]
        ]);
    }

    public function show($id = null)
    {
        $userId = $this->getUserId();
        $data = $this->model->where('user_id', $userId)->find($id);
        return $data ? $this->respond($data) : $this->failNotFound('Không tìm thấy lịch sử mua hàng');
    }

    public function create()
    {
        $data = $this->request->getJSON(true);
        $currentUser = $this->getUser(); // lấy user hiện tại
        $data['user_id'] = $currentUser['id'];

        // Nếu kích hoạt ngay thì kiểm tra gói hiện tại
        if (!empty($data['is_active']) && $data['is_active']) {
            $existing = $this->model
                ->where('customer_id', $data['customer_id'])
                ->where('is_active', 1)
                ->where('expires_at >', date('Y-m-d H:i:s'))
                ->first();

            if ($existing) {
                // Nếu là admin thì tự động vô hiệu hóa gói cũ
                if ($currentUser['role'] === 'admin') {
                    $this->model->update($existing['id'], ['is_active' => 0]);
                } else {
                    return $this->fail('Khách hàng hiện đang có gói còn hiệu lực.');
                }
            }

            $now = date('Y-m-d H:i:s');
            $years = (int) ($data['quantity'] ?? 1);
            $data['starts_at'] = $now;
            $data['expires_at'] = date('Y-m-d H:i:s', strtotime("+{$years} year"));
        }

        // Nếu chưa có purchased_at thì gán thời gian mua
        if (empty($data['purchased_at'])) {
            $data['purchased_at'] = date('Y-m-d H:i:s');
        }

        $this->model->insert($data);
        $data['id'] = $this->model->getInsertID();

        return $this->respondCreated($data);
    }


    protected function getUser(): array|object|null
    {
        // Ví dụ: bạn có thể lấy từ session, token hoặc tự tạo logic
        $userId = $this->getUserId();
        $model = new UserModel();
        return $model->find($userId);
    }


    public function update($id = null)
    {
        $data = $this->request->getJSON(true);
        $currentUser = $this->getUser(); // trả về user hiện tại (id, role)

        // Xác định quyền truy cập
        if ($currentUser['role'] === 'admin') {
            $existing = $this->model->find($id); // admin sửa bất kỳ
        } else {
            $existing = $this->model
                ->where('id', $id)
                ->where('customer_id', $currentUser['id']) // bảo vệ dữ liệu
                ->first();
        }

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy lịch sử mua hàng phù hợp.');
        }

        // Optional: cập nhật thời gian thủ công nếu không bật $useTimestamps
        $data['updated_at'] = date('Y-m-d H:i:s');
        $data['updated_by'] = $currentUser['id'];

        $this->model->update($id, $data);

        return $this->respond([
            'id' => $id,
            'message' => 'Đã cập nhật thành công'
        ]);
    }


    public function delete($id = null)
    {
        $userId = $this->getUserId();
        $existing = $this->model->where('user_id', $userId)->find($id);

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy lịch sử mua hàng');
        }

        $this->model->delete($id);

        return $this->respondDeleted(['id' => $id, 'message' => 'Đã xoá']);
    }

    public function customers()
    {
        $userId = $this->getUserId();
        $model = new CustomerModel();
        $data = $model->where('user_id', $userId)->findAll();

        return $this->respond($data);
    }
}