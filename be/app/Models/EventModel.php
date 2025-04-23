<?php

namespace App\Models;

use CodeIgniter\Model;

class EventModel extends Model
{
    protected $table = 'events';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'user_id', 'name', 'banner', 'location',
        'start_time', 'end_time', 'description',
        'created_at', 'updated_at'
    ];
    protected $useTimestamps = true;
}
