<?php

namespace App\Controllers;

use App\Models\EventModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class EventController extends ResourceController
{
    use AuthTrait;

    protected $modelName = EventModel::class;
    protected $format    = 'json';

    public function index()
    {
        $userId = $this->getUserId();
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $builder = $this->model->where('user_id', $userId);

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
        $userId = $this->getUserId();
        $data = $this->model->where('user_id', $userId)->find($id);
        if (!$data) return $this->failNotFound('Không tìm thấy sự kiện');
        return $this->respond($data);
    }

    public function create()
    {
        $userId = $this->getUserId();
        $data = $this->request->getJSON(true);

        if (!isset($data['name'])) {
            return $this->failValidationErrors('Thiếu name');
        }

        $data['user_id'] = $userId;

        $this->model->insert($data);
        $data['id'] = $this->model->getInsertID();
        return $this->respondCreated($data);
    }

    public function update($id = null)
    {
        $userId = $this->getUserId();
        $data = $this->request->getJSON(true);
        $existing = $this->model->where('user_id', $userId)->find($id);

        if (!$existing) return $this->failNotFound('Không tìm thấy sự kiện');

        $this->model->update($id, $data);
        return $this->respond(['id' => $id, 'message' => 'Đã cập nhật']);
    }

    public function delete($id = null)
    {
        $userId = $this->getUserId();
        $existing = $this->model->where('user_id', $userId)->find($id);

        if (!$existing) return $this->failNotFound('Không tìm thấy sự kiện');

        $this->model->delete($id);
        return $this->respondDeleted(['id' => $id, 'message' => 'Đã xoá']);
    }
}
