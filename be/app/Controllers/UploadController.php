<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class UploadController extends ResourceController
{
    public function upload()
    {
        $file = $this->request->getFile('file');

        if (!$file || !$file->isValid()) {
            return $this->fail('Không tìm thấy file hoặc file không hợp lệ.');
        }

        // Tạo folder upload nếu chưa có
        $uploadPath = WRITEPATH . 'uploads/';
        if (!is_dir($uploadPath)) {
            mkdir($uploadPath, 0777, true);
        }

        // Đổi tên file cho đẹp
        $newName = $file->getRandomName();

        // Move file vào writable/uploads
        $file->move($uploadPath, $newName);

        // Copy thêm vào public/uploads để browser truy cập được
        $publicPath = FCPATH . 'uploads/';
        if (!is_dir($publicPath)) {
            mkdir($publicPath, 0777, true);
        }
        copy($uploadPath . $newName, $publicPath . $newName);

        // Trả về URL public
        $publicUrl = base_url('uploads/' . $newName);

        return $this->respond([
            'url' => $publicUrl
        ]);
    }

}
