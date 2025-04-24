<?php

namespace App\Controllers;

use App\Models\PersonModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class PersonController extends ResourceController
{
    use AuthTrait;

    protected $modelName = PersonModel::class;
    protected $format = 'json';

    public function index()
    {
        $userId = $this->getUserId();
        $data = $this->model->where('user_id', $userId)->findAll();
        return $this->respond($data);
    }

    public function show($id = null)
    {
        $userId = $this->getUserId();
        $data = $this->model->where('user_id', $userId)->find($id);
        return $data ? $this->respond($data) : $this->failNotFound('Không tìm thấy cá nhân');
    }

    public function create()
    {
        $data = $this->request->getJSON(true);
        $userId = $this->getUserId();

        if (!isset($data['name'])) {
            return $this->failValidationErrors('Thiếu name');
        }

        $data['user_id'] = $userId;
        $id = $this->model->insert($data);

        return $this->respondCreated(['id' => $id]);
    }

    public function update($id = null)
    {
        $userId = $this->getUserId();
        $data = $this->request->getJSON(true);
        $person = $this->model->where('user_id', $userId)->find($id);

        if (!$person) {
            return $this->failNotFound('Không tìm thấy cá nhân');
        }

        $this->model->update($id, $data);
        return $this->respond(['id' => $id, 'message' => 'Đã cập nhật thành công']);
    }

    public function delete($id = null)
    {
        $userId = $this->getUserId();
        $person = $this->model->where('user_id', $userId)->find($id);

        if (!$person) {
            return $this->failNotFound('Không tìm thấy cá nhân');
        }

        $this->model->delete($id);
        return $this->respondDeleted(['id' => $id]);
    }
}
