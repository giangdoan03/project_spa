<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;
use Config\Services;

class CustomerController extends ResourceController
{
    use AuthTrait;

    protected $modelName = UserModel::class;
    protected $format    = 'json';

    public function index()
    {
        $page    = $this->request->getGet('page') ?? 1;
        $perPage = $this->request->getGet('per_page') ?? 10;

        $query = $this->model->where('role', 'customer'); // ✅ chỉ lấy khách hàng

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

        $data  = $query->paginate($perPage, 'default', $page);
        $pager = $this->model->pager;

        return $this->respond([
            'data'  => $data,
            'pager' => [
                'total'     => $pager->getTotal(),
                'per_page'  => $perPage,
                'current'   => $page,
            ]
        ]);
    }

    public function create()
    {
        $data = $this->request->getJSON(true);

        $validation = Services::validation();

        $rules = [
            'name'              => 'required',
            'email'             => 'required|valid_email|is_unique[users.email]',
            'phone'             => 'required|regex_match[/^(0|\+84)[0-9]{9,10}$/]',
            'password'          => 'required|min_length[6]',
            'confirm_password'  => 'required|matches[password]',
        ];

        if (!$this->validate($rules)) {
            return $this->failValidationErrors($validation->getErrors());
        }

        unset($data['confirm_password']);

        // ✅ Băm mật khẩu trước khi lưu
        $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);

        // ✅ Gán role là customer
        $data['role'] = 'customer';

        $id = $this->model->insert($data);
        return $this->respondCreated(['id' => $id]);
    }


    public function update($id = null)
    {
        $existing = $this->model->where('role', 'customer')->find($id);

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy khách hàng');
        }

        $data = $this->request->getJSON(true);

        $validation = Services::validation();

        $rules = [
            'name'  => 'required',
            'email' => 'required|valid_email',
            'phone' => 'required|regex_match[/^(0|\+84)[0-9]{9,10}$/]',
        ];

        if (!empty($data['password'])) {
            $rules['password'] = 'min_length[6]';
            $rules['confirm_password'] = 'matches[password]';
        }

        if (!$this->validate($rules)) {
            return $this->failValidationErrors($validation->getErrors());
        }

        if (empty($data['password'])) {
            unset($data['password']);
        }

        unset($data['confirm_password']);

        $this->model->update($id, $data);

        return $this->respondUpdated(['id' => $id]);
    }

    public function delete($id = null)
    {
        $existing = $this->model->where('role', 'customer')->find($id);

        if (!$existing) {
            return $this->failNotFound('Không tìm thấy khách hàng');
        }

        $this->model->delete($id);

        return $this->respondDeleted(['id' => $id]);
    }
}
