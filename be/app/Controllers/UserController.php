<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;

class UserController extends ResourceController
{
    protected $modelName = UserModel::class;
    protected $format = 'json';

    public function index()
    {
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $builder = new UserModel();

        if ($search) {
            $builder->groupStart()
                ->like('name', $search)
                ->orLike('phone', $search)
                ->orLike('email', $search)
                ->groupEnd();
        }

        $data = $builder->paginate($perPage, 'default', $page);
        $pager = $builder->pager;

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
        $data = $this->model->find($id);
        return $data ? $this->respond($data) : $this->failNotFound('Không tìm thấy người dùng');
    }

    public function create()
    {
        $data = $this->request->getPost();

        // Xử lý file upload
        $file = $this->request->getFile('avatar');
        if ($file && $file->isValid()) {
            $newName = $file->getRandomName();
            $file->move(WRITEPATH . 'uploads', $newName);
            $data['avatar'] = base_url('uploads/' . $newName);
        }

        // Hash mật khẩu nếu có
        if (!empty($data['password'])) {
            $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
        }

        $this->model->insert($data);
        $data['id'] = $this->model->getInsertID();
        return $this->respondCreated($data);
    }

    public function update($id = null)
    {
        $data = $this->request->getPost(); // lấy từ form-data

        $file = $this->request->getFile('avatar');
        if ($file && $file->isValid()) {
            $newName = $file->getRandomName();
            $file->move(WRITEPATH . 'uploads', $newName);
            $data['avatar'] = base_url('uploads/' . $newName);
        }

        if (!empty($data['password'])) {
            $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
        } else {
            unset($data['password']);
        }

        $this->model->update($id, $data);
        return $this->respond(['id' => $id, 'message' => 'Đã cập nhật']);
    }

    public function delete($id = null)
    {
        $this->model->delete($id);
        return $this->respondDeleted(['id' => $id, 'message' => 'Đã xoá']);
    }

    public function changePassword()
    {
        $request = $this->request->getJSON(true);
        $userId = session('user_id'); // hoặc lấy từ token nếu dùng JWT

        if (!$userId) {
            return $this->failUnauthorized('Không xác thực');
        }

        $currentPassword = $request['current_password'] ?? '';
        $newPassword     = $request['new_password'] ?? '';

        if (!$newPassword) {
            return $this->failValidationErrors('Mật khẩu mới không được để trống');
        }

        $user = $this->model->find($userId);
        if (!$user) {
            return $this->failNotFound('Không tìm thấy người dùng');
        }

        // Nếu không phải super admin thì phải kiểm tra mật khẩu cũ
        if (($user['role'] ?? '') !== 'super admin') {
            if (!password_verify($currentPassword, $user['password'])) {
                return $this->failValidationErrors('Mật khẩu hiện tại không đúng');
            }
        }

        $this->model->update($userId, [
            'password' => password_hash($newPassword, PASSWORD_BCRYPT),
        ]);

        return $this->respond(['message' => 'Đã đổi mật khẩu thành công']);
    }

}
