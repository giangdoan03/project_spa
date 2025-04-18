<?php

namespace App\Controllers;

use App\Models\BusinessModel;
use App\Models\BusinessExtraInfoModel;
use CodeIgniter\RESTful\ResourceController;

class BusinessController extends ResourceController
{
    protected $modelName = BusinessModel::class;
    protected $format    = 'json';

    public function index()
    {
        $perPage = $this->request->getGet('per_page') ?? 10;
        $page = $this->request->getGet('page') ?? 1;
        $search = $this->request->getGet('search');

        $model = new BusinessModel();
        $builder = $model->where('deleted_at', null);

        if (!empty($search)) {
            $builder->groupStart()
                ->like('name', $search)
                ->orLike('tax_code', $search)
                ->groupEnd();
        }

        $data = $builder->paginate($perPage, 'default', $page);

        // Format lại các field JSON trước khi trả về
        $data = array_map([$this, 'formatBusinessItem'], $data);

        return $this->respond([
            'data' => $data,
            'pager' => $model->pager->getDetails(),
        ]);
    }

    public function show($id = null)
    {
        $model = new BusinessModel();
        $extraInfoModel = new BusinessExtraInfoModel();

        $business = $model->find($id);
        if (!$business) {
            return $this->failNotFound('Không tìm thấy doanh nghiệp');
        }

        // Format business data
        $business = $this->formatBusinessItem($business);

        // Thêm extra_info riêng
        $business['extra_info'] = $extraInfoModel->where('business_id', $id)->findAll();

        return $this->respond($business);
    }

    public function create()
    {
        $model = new BusinessModel();
        $extraInfoModel = new BusinessExtraInfoModel();

        $data = $this->request->getJSON(true);

        $businessData = $this->cleanBusinessData($data);
        $businessId = $model->insert($businessData);

        // Insert extra info
        $this->saveExtraInfo($businessId, $data['extra_info'] ?? []);

        return $this->respondCreated(['id' => $businessId]);
    }

    public function update($id = null)
    {
        $model = new BusinessModel();
        $extraInfoModel = new BusinessExtraInfoModel();

        $data = $this->request->getJSON(true);

        $businessData = $this->cleanBusinessData($data);
        $model->update($id, $businessData);

        // Xoá và thêm lại extra info
        $extraInfoModel->where('business_id', $id)->delete();
        $this->saveExtraInfo($id, $data['extra_info'] ?? []);

        return $this->respond(['message' => 'Cập nhật doanh nghiệp thành công']);
    }

    public function delete($id = null)
    {
        $model = new BusinessModel();
        $extraInfoModel = new BusinessExtraInfoModel();

        $model->delete($id);
        $extraInfoModel->where('business_id', $id)->delete();

        return $this->respondDeleted(['message' => 'Đã xoá doanh nghiệp']);
    }

    /**
     * Clean input data
     */
    private function cleanBusinessData($data)
    {
        return [
            'name' => $data['name'] ?? null,
            'tax_code' => $data['tax_code'] ?? null,
            'country' => $data['country'] ?? null,
            'city' => $data['city'] ?? null,
            'district' => $data['district'] ?? null,
            'ward' => $data['ward'] ?? null,
            'address' => $data['address'] ?? null,
            'phone' => $data['phone'] ?? null,
            'email' => $data['email'] ?? null,
            'website' => $data['website'] ?? null,
            'description' => $data['description'] ?? null,
            'career' => $data['career'] ?? null,
            'facebook_link' => $data['facebook_link'] ?? null,
            'other_links' => $this->encodeJson($data['other_links'] ?? []),
            'logo' => $this->encodeJson($data['logo'] ?? []),
            'cover_image' => $this->encodeJson($data['cover_image'] ?? []),
            'library_images' => $this->encodeJson($data['library_images'] ?? []),
            'video_intro' => $this->encodeJson($data['video_intro'] ?? []),
            'certificate_file' => $this->encodeJson($data['certificate_file'] ?? []),
            'lat' => $data['lat'] ?? null,
            'lng' => $data['lng'] ?? null,
            'extra_info' => $this->encodeJson($data['extra_info'] ?? []),
            'status' => !empty($data['status']) ? 1 : 0,
        ];
    }

    /**
     * Helper: JSON encode an array safely
     */
    private function encodeJson($value)
    {
        if (is_string($value)) {
            $decoded = json_decode($value, true);
            if (json_last_error() === JSON_ERROR_NONE) {
                $value = $decoded;
            }
        }
        return json_encode(is_array($value) ? $value : []);
    }

    /**
     * Format business item when returning to client
     */
    private function formatBusinessItem($item)
    {
        foreach (['logo', 'cover_image', 'library_images', 'video_intro', 'certificate_file', 'other_links', 'extra_info'] as $field) {
            $item[$field] = json_decode($item[$field] ?? '[]', true) ?? [];
        }
        return $item;
    }

    /**
     * Save extra info
     */
    private function saveExtraInfo($businessId, $extraInfos)
    {
        $extraInfoModel = new BusinessExtraInfoModel();

        if (!is_array($extraInfos)) {
            $extraInfos = json_decode($extraInfos, true) ?? [];
        }

        foreach ($extraInfos as $info) {
            $extraInfoModel->insert([
                'business_id' => $businessId,
                'title' => $info['title'] ?? '',
                'description' => $info['description'] ?? '',
                'image' => $info['image'] ?? null,
            ]);
        }
    }
}
