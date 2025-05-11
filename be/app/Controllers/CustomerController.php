<?php

namespace App\Controllers;

use App\Models\BusinessModel;
use App\Models\CustomerModel;
use App\Models\EventModel;
use App\Models\PersonModel;
use App\Models\ProductModel;
use App\Models\QrCodeModel;
use App\Models\ScanHistoryModel;
use App\Models\StoreModel;
use CodeIgniter\HTTP\RedirectResponse;
use CodeIgniter\RESTful\ResourceController;

class CustomerController extends ResourceController
{
    protected $format = 'json';
    protected $modelName = CustomerModel::class;
    protected $qrModel;

    public function __construct()
    {
        $this->qrModel = new QrCodeModel();
    }

    public function redirectWithTrack($code): RedirectResponse
    {
        $qr = $this->qrModel->where('short_code', $code)->first();

        if (!$qr) {
            return redirect()->to('/not-found');
        }

        $targetModel = $this->getTargetModel($qr['target_type']);
        if (!$targetModel) {
            return redirect()->to('/not-found');
        }

        $target = $targetModel->where('id', $qr['target_id'])->first();
        if (!$target) {
            return redirect()->to('/not-found');
        }

        // Tạo mã tracking nếu chưa có
        $trackCode = uniqid();
        $scanModel = new ScanHistoryModel();
        $scanModel->insert([
            'qr_id' => $qr['id'],
            'tracking_code' => $trackCode,
            'ip_address' => $_SERVER['REMOTE_ADDR'] ?? null,
            'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? null,
            'referrer' => $_SERVER['HTTP_REFERER'] ?? null,
        ]);

        // Redirect đến trang quét
        return redirect()->to('/scan/' . $trackCode);
    }

    private function getTargetModel($type): BusinessModel|ProductModel|PersonModel|EventModel|StoreModel|CustomerModel|null
    {
        return match ($type) {
            'product' => new ProductModel(),
            'store' => new StoreModel(),
            'event' => new EventModel(),
            'person' => new PersonModel(),
            'business' => new BusinessModel(),
            'customer' => new CustomerModel(),
            default => null,
        };
    }

    public function index()
    {
        $perPage = (int) $this->request->getGet('per_page') ?? 10;
        $page    = (int) $this->request->getGet('page') ?? 1;
        $search  = $this->request->getGet('search');
        $phone   = $this->request->getGet('phone');
        $email   = $this->request->getGet('email');
        $city    = $this->request->getGet('city');
        $from    = $this->request->getGet('from');
        $to      = $this->request->getGet('to');

        $builder = $this->model;

        if ($search) {
            $builder->groupStart()
                ->like('name', $search)
                ->orLike('phone', $search)
                ->orLike('email', $search)
                ->groupEnd();
        }

        if ($phone) {
            $builder->like('phone', $phone);
        }

        if ($email) {
            $builder->like('email', $email);
        }

        if ($city) {
            $builder->like('city', $city);
        }

        if ($from && $to) {
            $builder->where("DATE(created_at) >=", $from);
            $builder->where("DATE(created_at) <=", $to);
        }

        $data = $builder->paginate($perPage, 'default', $page);
        $pager = $this->model->pager;

        return $this->respond([
            'data' => $data,
            'pager' => [
                'total'        => $pager->getTotal(),
                'per_page'     => $perPage,
                'current_page' => $page,
            ],
        ]);
    }

    public function show($id = null)
    {
        $data = $this->model->find($id);
        return $data
            ? $this->respond($data)
            : $this->failNotFound('Không tìm thấy khách hàng');
    }

    public function create()
    {
        $data = $this->request->getJSON(true);
        $this->model->insert($data);
        $data['id'] = $this->model->getInsertID();
        return $this->respondCreated($data);
    }

    public function update($id = null)
    {
        $data = $this->request->getJSON(true);
        $this->model->update($id, $data);
        return $this->respond(['id' => $id, 'message' => 'Đã cập nhật']);
    }

    public function delete($id = null)
    {
        $this->model->delete($id);
        return $this->respondDeleted(['id' => $id, 'message' => 'Đã xoá']);
    }
}
