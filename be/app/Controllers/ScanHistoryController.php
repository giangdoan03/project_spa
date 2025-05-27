<?php

namespace App\Controllers;

use App\Models\ScanHistoryModel;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class ScanHistoryController extends ResourceController
{
    use AuthTrait;

    protected $modelName = ScanHistoryModel::class;
    protected $format    = 'json';

    public function index()
    {
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $builder = $this->model;

        if ($search) {
            $builder = $builder->like('qr_type', $search)
                ->orLike('city', $search);
        }

        $data = $builder->paginate($perPage, 'default', $page);
        $pager = $this->model->pager;

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
        return $data ? $this->respond($data) : $this->failNotFound('Không tìm thấy lịch sử quét');
    }

    public function create()
    {
        $json = $this->request->getJSON(true);

        // ✅ Tạo lại mảng chỉ chứa các key dạng string (dứt điểm key số)
        $cleanData = [];
        foreach ($json ?? [] as $key => $value) {
            if (is_string($key)) {
                $cleanData[$key] = $value;
            } else {
                log_message('error', 'Key số phát hiện: ' . $key . ' => ' . json_encode($value));
            }
        }

        // Thêm các thông tin hệ thống
        $request = service('request');
        $cleanData['ip_address']  = $request->getIPAddress();
        $cleanData['user_agent']  = (string) $request->getUserAgent();
        $cleanData['os']          = $request->getUserAgent()->getPlatform();
        $cleanData['app']         = $request->getUserAgent()->getBrowser();

        // ✅ Debug trước khi insert
        log_message('debug', 'CleanData insert: ' . json_encode($cleanData));

        // Tiến hành insert
        $this->model->insert($cleanData);
        $cleanData['id'] = $this->model->getInsertID();

        return $this->respondCreated($cleanData);
    }

    public function delete($id = null)
    {
        $this->model->delete($id);
        return $this->respondDeleted(['id' => $id, 'message' => 'Đã xoá']);
    }
}
