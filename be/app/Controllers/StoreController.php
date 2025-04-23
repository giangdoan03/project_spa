<?php

namespace App\Controllers;

use App\Models\StoreModel;
use App\Models\ProductModel;
use CodeIgniter\RESTful\ResourceController;

class StoreController extends ResourceController
{
    protected $modelName = StoreModel::class;
    protected $format    = 'json';

    public function index()
    {
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $builder = $this->model;

        if ($search) {
            $builder = $builder->like('name', $search);
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
        $store = $this->model->find($id);
        if (!$store) {
            return $this->failNotFound('Không tìm thấy cửa hàng');
        }

        $store['products'] = [];

        if (!empty($store['product_ids'])) {
            $productIds = json_decode($store['product_ids'], true);
            if (is_array($productIds) && count($productIds)) {
                $productModel = new ProductModel();

                // Lấy tất cả sp theo id
                $products = $productModel
                    ->select('id, name, price, avatar') // 👈 lấy thêm avatar
                    ->whereIn('id', $productIds)
                    ->findAll();

                // Giữ thứ tự
                $productMap = array_column($products, null, 'id');
                $store['products'] = array_values(array_filter(array_map(
                    fn($id) => $productMap[$id] ?? null,
                    $productIds
                )));
            }
        }

        return $this->respond($store);
    }


    public function create()
    {
        $data = $this->request->getJSON(true);

        if (!isset($data['user_id']) || !isset($data['name'])) {
            return $this->failValidationErrors('Thiếu user_id hoặc name');
        }

        // Lưu product_ids nếu có
        if (isset($data['product_ids'])) {
            if (is_string($data['product_ids'])) {
                // Nếu là chuỗi JSON, decode về mảng trước rồi lại encode
                $decoded = json_decode($data['product_ids'], true);
                $data['product_ids'] = is_array($decoded) ? json_encode($decoded) : null;
            } elseif (is_array($data['product_ids'])) {
                $data['product_ids'] = json_encode($data['product_ids']);
            } else {
                $data['product_ids'] = null;
            }
        }
        else {
            $data['product_ids'] = null;
        }

        $this->model->insert($data);
        $data['id'] = $this->model->getInsertID();

        return $this->respondCreated($data);
    }

    public function update($id = null)
    {
        $data = $this->request->getJSON(true);

        $existing = $this->model->find($id);
        if (!$existing) {
            return $this->failNotFound('Không tìm thấy cửa hàng');
        }

        // Đảm bảo product_ids là JSON hợp lệ nếu có
        if (isset($data['product_ids'])) {
            if (is_array($data['product_ids'])) {
                // nếu FE gửi mảng (chưa stringify) — encode lại
                $data['product_ids'] = json_encode($data['product_ids']);
            } elseif (is_string($data['product_ids'])) {
                // nếu FE gửi string — validate bằng json_decode
                $decoded = json_decode($data['product_ids'], true);
                $data['product_ids'] = is_array($decoded) ? json_encode($decoded) : null;
            } else {
                $data['product_ids'] = null;
            }
        }

        $this->model->update($id, $data);

        return $this->respond([
            'id' => $id,
            'message' => 'Đã cập nhật'
        ]);
    }



    public function delete($id = null)
    {
        $existing = $this->model->find($id);
        if (!$existing) {
            return $this->failNotFound('Không tìm thấy cửa hàng');
        }

        $this->model->delete($id);

        return $this->respondDeleted([
            'id' => $id,
            'message' => 'Đã xoá'
        ]);
    }
}
