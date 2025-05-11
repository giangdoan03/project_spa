<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id';

    // Danh sách các trường cho phép thêm/sửa
    protected $allowedFields = [
        'email',
        'password',
        'name',
        'phone',
        'avatar',
        'role',
        'role_id',
        'created_at',
        'updated_at'
    ];

    protected $useTimestamps = true; // Tự động set created_at và updated_at
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
}
