<?php

namespace App\Models;

use CodeIgniter\Model;

class ScanHistoryModel extends Model
{
    protected $table = 'scan_histories';
    protected $primaryKey = 'id';

    protected $allowedFields = [
        'qr_id',
        'tracking_code',
        'ip_address',
        'user_agent',
        'referrer',
        'created_at',
        'updated_at',
    ];

    protected $useTimestamps = true;
}
