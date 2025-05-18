<?php

namespace App\Models;

use CodeIgniter\Model;

class CustomerModel extends Model
{
    protected $table = 'customers';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'user_id',
        'name', 'phone', 'email', 'address', 'city',
        'avatar', 'last_interaction',
        'payment_status',     // ✅ đã thanh toán hoặc chưa
        'is_expired',         // ✅ trạng thái hết hạn
        'package_id',         // ✅ ID của gói đang dùng (nếu có)
        'package_start_date', // ✅ ngày bắt đầu dùng gói
        'package_end_date',   // ✅ ngày hết hạn
        'note',               // ✅ ghi chú nếu cần
        'created_at', 'updated_at'
    ];

    protected $useTimestamps = true;
}
