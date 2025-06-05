<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use App\Traits\AuthTrait;

class ScanHistoryController extends ResourceController
{
    use AuthTrait;

    protected $format = 'json';
    protected string $table = 'qr_scan_logs';

    public function index()
    {
        $user = $this->getUser();
        $userId = $user['id'];
        $role = $user['role'] ?? 'customer';

        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $db = db_connect();
        $builder = $db->table($this->table);

        if ($role !== 'admin') {
            $builder->where('user_id', $userId);
        }

        if ($search) {
            $builder->groupStart()
                ->like('qr_type', $search)
                ->orLike('city', $search)
                ->groupEnd();
        }

        $total = $builder->countAllResults(false);
        $results = $builder
            ->orderBy('created_at', 'DESC')
            ->limit($perPage, ($page - 1) * $perPage)
            ->get()
            ->getResult();

        return $this->respond([
            'data' => $results,
            'pager' => [
                'total' => $total,
                'per_page' => $perPage,
                'current_page' => $page,
            ]
        ]);
    }

    public function show($id = null)
    {
        $db = db_connect();
        $data = $db->table($this->table)->where('id', $id)->get()->getRow();

        return $data
            ? $this->respond($data)
            : $this->failNotFound('Không tìm thấy lịch sử quét');
    }

    public function create()
    {
        $json = $this->request->getJSON(true);
        $cleanData = [];

        foreach ($json ?? [] as $key => $value) {
            if (is_string($key)) {
                $cleanData[$key] = $value;
            }
        }

        $request = service('request');
        $cleanData['ip_address']  = $request->getIPAddress();
        $cleanData['user_agent']  = (string) $request->getUserAgent();
        $cleanData['os']          = $request->getUserAgent()->getPlatform();
        $cleanData['app']         = $request->getUserAgent()->getBrowser();
        $cleanData['created_at']  = date('Y-m-d H:i:s');

        $user = $this->getUser();
        if ($user) {
            $cleanData['user_id'] = $user['id'];
        }

        $db = db_connect();
        $db->table($this->table)->insert($cleanData);
        $cleanData['id'] = $db->insertID();

        return $this->respondCreated($cleanData);
    }

    public function delete($id = null)
    {
        $db = db_connect();
        $deleted = $db->table($this->table)->where('id', $id)->delete();

        if ($deleted) {
            return $this->respondDeleted(['id' => $id, 'message' => 'Đã xoá']);
        }

        return $this->failNotFound('Không xoá được bản ghi');
    }

    public function summary(): ResponseInterface
    {
        $user = $this->getUser();
        $userId = $user['id'];
        $role = $user['role'] ?? 'customer';

        $db = db_connect();

        $makeBuilder = function () use ($db, $userId, $role) {
            $builder = $db->table('qr_scan_logs');
            if ($role !== 'admin') {
                $builder->where('user_id', $userId);
            }
            return $builder;
        };

        $summary = [
            'by_country' => (clone $makeBuilder())->select('country, COUNT(*) as total')
                ->groupBy('country')->get()->getResult(),
            'by_city' => (clone $makeBuilder())->select('city, COUNT(*) as total')
                ->groupBy('city')->get()->getResult(),
            'by_device' => (clone $makeBuilder())->select('device_type, COUNT(*) as total')
                ->groupBy('device_type')->get()->getResult(),
            'by_browser' => (clone $makeBuilder())->select('browser, COUNT(*) as total')
                ->groupBy('browser')->get()->getResult(),
            'by_os' => (clone $makeBuilder())->select('os, COUNT(*) as total')
                ->groupBy('os')->get()->getResult(),
        ];

        return $this->respond($summary);
    }

    // ⚠️ Phải có nếu dùng getUser thay getAuth
    public function getUser(): array
    {
        $model = new \App\Models\UserModel();
        $userId = session()->get('user_id');
        return $model->find($userId);
    }
}
