<?php

namespace App\Models;

use CodeIgniter\Model;

class PurchaseHistoryModel extends Model
{
    protected $table = 'purchase_histories';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'user_id', 'customer_id', 'product_name',
        'amount', 'quantity', 'note', 'purchased_at',
        'starts_at', 'expires_at', 'is_paid', 'is_active',
        'created_at', 'updated_at'
    ];
    protected $useTimestamps = true;
}
