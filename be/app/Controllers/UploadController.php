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
            'http://api.giang.test'     // API chính
        ];

        $origin = $_SERVER['HTTP_ORIGIN'] ?? null;

        if ($origin && !in_array($origin, $allowedOrigins)) {
            return $this->failForbidden('Không được phép upload từ domain này.');
        }

        $file = $this->request->getFile('file');

        if (!$file || !$file->isValid()) {
            return $this->fail('Không tìm thấy file hoặc file không hợp lệ.');
        }

        // ✅ Lấy upload dir từ .env, fallback mặc định nếu chưa khai báo
        $customUploadDir = getenv('UPLOAD_DIR') ?: 'C:/php82/htdocs/assets/image/';
        if (!is_dir($customUploadDir)) {
            mkdir($customUploadDir, 0777, true);
        }

        $newName = $file->getRandomName();
        $file->move($customUploadDir, $newName);

        // ✅ Lấy domain ảnh public từ .env
        $assetsDomain = getenv('ASSETS_DOMAIN') ?: 'http://assets.giang.test/image/';
        $publicUrl = rtrim($assetsDomain, '/') . '/' . $newName;

        return $this->respond([
            'url' => $publicUrl
        ]);
    }
}
