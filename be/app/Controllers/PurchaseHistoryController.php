<?php

namespace App\Controllers;

use App\Models\PurchaseHistoryModel;
use App\Models\CustomerModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class PurchaseHistoryController extends ResourceController
{
    use AuthTrait;

    protected $modelName = PurchaseHistoryModel::class;
    protected $format = 'json';

    public function index()
    {
        $userId = $this->getUserId();
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $builder = $this->model->where('user_id', $userId);

        if ($search) {
            $builder->groupStart()
                ->like('product_name', $search)
                ->orLike('note', $search)
                ->groupEnd();
        }

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
        $data['user_id'] = $this->getUserId();

        $this->model->insert($data);
        $data['id'] = $this->model->getInsertID();

        return $this->respondCreated($data);
    }

    public function update($id = null)
    {
        $userId = $this->getUserId();
        $existing = $this->model->where('user_id', $userId)->find($id);

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy lịch sử mua hàng');
        }

        $data = $this->request->getJSON(true);
        $this->model->update($id, $data);

        return $this->respond(['id' => $id, 'message' => 'Đã cập nhật']);
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