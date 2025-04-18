<?php

namespace App\Models;

use CodeIgniter\Model;

class ProductModel extends Model
{
    protected $table = 'products';
    protected $primaryKey = 'id';

    protected $useSoftDeletes = true;
    protected $deletedField = 'deleted_at';
    protected $allowedFields = [
        'sku', 'name', 'category_id', 'price', 'price_from', 'price_to',
        'show_contact_price', 'avatar', 'image', 'video', 'certificate_file',
        'description', 'attributes', 'status', 'created_at', 'updated_at'
    ];

    protected $useTimestamps = true;

    public function getProductWithAttributes($id = null)
    {
        $builder = $this->db->table($this->table);
        $builder->select('products.*');
        $builder->where('products.id', $id);

        $product = $builder->get()->getRowArray();

        if ($product) {
            $product['attributes'] = (new ProductAttributeModel())
                ->where('product_id', $product['id'])
                ->findAll();
        }

        return $product;
    }
}
