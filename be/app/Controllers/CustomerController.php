<?php

namespace App\Controllers;

use App\Models\CustomerModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class CustomerController extends ResourceController
{
    use AuthTrait;

    protected $modelName = CustomerModel::class;
    protected $format = 'json';

    public function index()
    {
        $userId = $this->getUserId();

        $page = $this->request->getGet('page') ?? 1;
        $perPage = $this->request->getGet('per_page') ?? 10;

        $query = $this->model->where('user_id', $userId);

        if ($search = $this->request->getGet('search')) {
            $query->groupStart()
                ->like('name', $search)
                ->orLike('email', $search)
                ->orLike('phone', $search)
                ->groupEnd();
        }

        if ($phone = $this->request->getGet('phone')) {
            $query->like('phone', $phone);
        }

        if ($email = $this->request->getGet('email')) {
            $query->like('email', $email);
        }

        if ($city = $this->request->getGet('city')) {
            $query->like('city', $city);
        }

        if ($from = $this->request->getGet('from')) {
            $query->where('created_at >=', $from);
        }

        if ($to = $this->request->getGet('to')) {
            $query->where('created_at <=', $to);
        }

        $data = $query->paginate($perPage, 'default', $page);
        $pager = $this->model->pager;

        return $this->respond([
            'data' => $data,
            'pager' => [
                'total' => $pager->getTotal(),
                'per_page' => $perPage,
                'current' => $page,
            ]
        ]);
    }

    public function create()
    {
        $data = $this->request->getJSON(true);
        $data['user_id'] = $this->getUserId();

        $id = $this->model->insert($data);

        return $this->respondCreated(['id' => $id]);
    }

    public function update($id = null)
    {
        $userId = $this->getUserId();
        $existing = $this->model->where('user_id', $userId)->find($id);

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy khách hàng');
        }

        $data = $this->request->getJSON(true);
        $this->model->update($id, $data);

        return $this->respondUpdated(['id' => $id]);
    }

    public function delete($id = null)
    {
        $userId = $this->getUserId();
        $existing = $this->model->where('user_id', $userId)->find($id);

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy khách hàng');
        }

        $this->model->delete($id);

        return $this->respondDeleted(['id' => $id]);
    }
}
