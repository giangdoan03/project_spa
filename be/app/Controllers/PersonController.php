<?php

namespace App\Controllers;

use App\Models\PersonModel;
use CodeIgniter\RESTful\ResourceController;

class PersonController extends ResourceController
{
    protected $modelName = PersonModel::class;
    protected $format = 'json';

    public function index()
    {
        return $this->respond($this->model->findAll());
    }

    public function show($id = null)
    {
        $data = $this->model->find($id);
        return $data ? $this->respond($data) : $this->failNotFound('Không tìm thấy cá nhân');
    }

    public function create()
    {
        $data = $this->request->getJSON(true);

        if (!isset($data['user_id']) || !isset($data['name'])) {
            return $this->failValidationErrors('Thiếu user_id hoặc name');
        }

        $id = $this->model->insert($data);
        return $this->respondCreated(['id' => $id]);
    }

    public function update($id = null)
    {
        $data = $this->request->getJSON(true);
        if (!$this->model->find($id)) {
            return $this->failNotFound('Không tìm thấy cá nhân');
        }

        $this->model->update($id, $data);
        return $this->respond(['id' => $id, 'message' => 'Đã cập nhật thành công']);
    }

    public function delete($id = null)
    {
        if (!$this->model->find($id)) {
            return $this->failNotFound('Không tìm thấy cá nhân');
        }

        $this->model->delete($id);
        return $this->respondDeleted(['id' => $id]);
    }
}
