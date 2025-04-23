<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class UploadController extends ResourceController
{
    public function upload()
    {
        // Giới hạn chỉ upload từ domain api.giang.test
        $allowedOrigins = [
            'http://giang.test:5173',   // Frontend đang chạy local
            'http://api.giang.test'     // Chính server API của bạn
        ];

        $origin = $_SERVER['HTTP_ORIGIN'] ?? null;

        if ($origin && !in_array($origin, $allowedOrigins)) {
            return $this->failForbidden('Không được phép upload từ domain này.');
        }
        $file = $this->request->getFile('file');

        if (!$file || !$file->isValid()) {
            return $this->fail('Không tìm thấy file hoặc file không hợp lệ.');
        }

        // Thư mục upload ngoài project
        $customUploadDir = 'D:/laragon/www/assets/image/';
        if (!is_dir($customUploadDir)) {
            mkdir($customUploadDir, 0777, true);
        }

        $newName = $file->getRandomName();
        $file->move($customUploadDir, $newName);

        $publicUrl = 'http://assets.giang.test/image/' . $newName;

        return $this->respond([
            'url' => $publicUrl
        ]);
    }


}
