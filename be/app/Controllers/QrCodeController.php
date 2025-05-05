<?php
namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\QrCodeModel;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;

class QrCodeController extends BaseController
{
    use ResponseTrait;
    protected QrCodeModel $model;

    public function __construct()
    {
        $this->model = new QrCodeModel();
    }

    /**
     * Tạo QR Code mới
     */
    public function create(): ResponseInterface
    {
        $data = $this->request->getJSON(true);

        if (empty($data['short_code'])) {
            $data['short_code'] = bin2hex(random_bytes(4));
        }

        if (empty($data['qr_id'])) {
            do {
                $data['qr_id'] = bin2hex(random_bytes(4));
            } while ($this->model->where('qr_id', $data['qr_id'])->first());
        }

        if (isset($data['settings_json']) && is_array($data['settings_json'])) {
            $data['settings_json'] = json_encode($data['settings_json']);
        }

        if (!$this->model->insert($data)) {
            log_message('error', 'QR Insert Failed: ' . json_encode($data));
            return $this->fail($this->model->errors());
        }

        return $this->respondCreated([
            'id' => $this->model->getInsertID(),
            'qr_id' => $data['qr_id'],
            'short_code' => $data['short_code']
        ]);
    }

    /**
     * Cập nhật QR Code
     */
    public function update(string $qr_id): ResponseInterface
    {
        $data = $this->request->getJSON(true);

        if (isset($data['settings_json']) && is_array($data['settings_json'])) {
            $data['settings_json'] = json_encode($data['settings_json']);
        }

        $qr = $this->model->where('qr_id', $qr_id)->first();
        if (!$qr) {
            return $this->failNotFound('Không tìm thấy mã QR');
        }

        if (!$this->model->update($qr['id'], $data)) {
            return $this->fail($this->model->errors());
        }

        return $this->respondUpdated(['qr_id' => $qr_id]);
    }

    /**
     * Xoá QR Code
     */
    public function delete(string $qr_id): ResponseInterface
    {
        $qr = $this->model->where('qr_id', $qr_id)->first();
        if (!$qr) {
            return $this->failNotFound('Không tìm thấy mã QR');
        }

        if (!$this->model->delete($qr['id'])) {
            return $this->fail('Không xoá được mã QR');
        }

        return $this->respondDeleted(['qr_id' => $qr_id]);
    }

    /**
     * Lấy chi tiết 1 QR Code
     */
    public function show($qr_id): ResponseInterface
    {
        $qr = $this->model->where('qr_id', $qr_id)->first();
        if (!$qr) return $this->failNotFound('Không tìm thấy mã QR');
        $qr['settings_json'] = json_decode($qr['settings_json'], true);
        return $this->respond(['data' => $qr]);
    }
    /**
     * Quét QR và chuyển hướng
     */
    public function scan(string $shortCode): ResponseInterface
    {
        $qr = $this->model->where('short_code', $shortCode)->first();

        if (!$qr || !$qr['is_active']) {
            return redirect()->to(base_url('/not-found'));
        }

        $this->model->update($qr['id'], [
            'scan_count' => $qr['scan_count'] + 1,
            'last_scanned_at' => date('Y-m-d H:i:s')
        ]);

        return redirect()->to(base_url("/{$qr['target_type']}/{$qr['target_id']}"));
    }

    /**
     * Danh sách QR Code theo user, filter
     */
    public function list(): ResponseInterface
    {
        $userId = $this->request->getGet('user_id');
        $search = $this->request->getGet('search');
        $type = $this->request->getGet('type');

        $builder = $this->model;

        if ($userId) {
            $builder = $builder->where('user_id', $userId);
        }

        if ($search) {
            $builder = $builder->groupStart()
                ->like('qr_name', $search)
                ->orLike('qr_url', $search)
                ->groupEnd();
        }

        if ($type) {
            $builder = $builder->where('target_type', $type);
        }

        $data = $builder->orderBy('created_at', 'DESC')->findAll();

        // Bổ sung target_name dựa vào target_type
        foreach ($data as &$item) {
            $item['target_name'] = '';

            if ($item['target_type'] === 'product') {
                $product = model('ProductModel')->find($item['target_id']);
                $item['target_name'] = $product['name'] ?? '';
            } elseif ($item['target_type'] === 'store') {
                $store = model('StoreModel')->find($item['target_id']);
                $item['target_name'] = $store['name'] ?? '';
            } elseif ($item['target_type'] === 'event') {
                $event = model('EventModel')->find($item['target_id']);
                $item['target_name'] = $event['name'] ?? '';
            }
            // Bạn có thể thêm các loại khác tương tự nếu có
        }

        return $this->respond($data);
    }

}
