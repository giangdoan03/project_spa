<template>
    <div>
        <a-space style="margin-bottom: 16px;">
            <a-input v-model:value="search" placeholder="Tìm kiếm sản phẩm..." @pressEnter="fetchProducts" />
            <a-button type="primary" @click="fetchProducts">Tìm kiếm</a-button>
            <a-button type="primary" @click="goToCreate">Thêm sản phẩm</a-button>
        </a-space>

        <a-table
            :columns="columns"
            :data-source="products"
            :pagination="pagination"
            row-key="id"
            :loading="loading"
            @change="handleTableChange"
        >
            <template #bodyCell="{ column, record }">
                <!-- Cột ảnh đại diện -->
                <template v-if="column.key === 'avatar'">
                    <img
                        v-if="record.avatar && Array.isArray(parseJson(record.avatar)) && parseJson(record.avatar).length"
                        :src="parseJson(record.avatar)[0]"
                        alt="Avatar"
                        style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;"
                    />
                </template>

                <!-- Cột hành động -->
                <template v-if="column.key === 'action'">
                    <a-space>
                        <a-button type="link" @click="goToEdit(record.id)">Sửa</a-button>
                        <a-popconfirm title="Xác nhận xoá?" @confirm="deleteProduct(record.id)">
                            <a-button type="link" danger>Xoá</a-button>
                        </a-popconfirm>
                    </a-space>
                </template>
            </template>
        </a-table>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getProducts, deleteProduct as apiDeleteProduct } from '../api/product'
import { message } from 'ant-design-vue'

// Router
const router = useRouter()

// State
const products = ref([])
const loading = ref(false)
const search = ref('')
const pagination = ref({ current: 1, pageSize: 10, total: 0 })

// Columns table
const columns = [
    { title: 'ID', dataIndex: 'id', key: 'id' },
    { title: 'Ảnh đại diện', dataIndex: 'avatar', key: 'avatar' },
    { title: 'Tên sản phẩm', dataIndex: 'name', key: 'name' },
    { title: 'SKU', dataIndex: 'sku', key: 'sku' },
    { title: 'Giá', dataIndex: 'price', key: 'price' },
    { title: 'Ngày tạo', dataIndex: 'created_at', key: 'created_at' },
    { title: 'Ngày cập nhật', dataIndex: 'updated_at', key: 'updated_at' },
    { title: 'Hành động', key: 'action' },
]

// Fetch data
const fetchProducts = async () => {
    loading.value = true
    try {
        const response = await getProducts({
            page: pagination.value.current,
            per_page: pagination.value.pageSize,
            search: search.value,
        })
        products.value = response.data.data
        pagination.value.total = response.data.pager.total
    } catch (error) {
        message.error('Lỗi tải sản phẩm')
    } finally {
        loading.value = false
    }
}

// Table change
const handleTableChange = (paginationParam) => {
    pagination.value.current = paginationParam.current
    pagination.value.pageSize = paginationParam.pageSize
    fetchProducts()
}

// Router actions
const goToCreate = () => router.push('/products/create')
const goToEdit = (id) => router.push(`/products/${id}/edit`)

// Delete
const deleteProduct = async (id) => {
    try {
        await apiDeleteProduct(id)
        message.success('Đã xoá sản phẩm')
        fetchProducts()
    } catch (error) {
        message.error('Lỗi xoá sản phẩm')
    }
}

// Parse JSON safely
const parseJson = (value) => {
    try {
        return JSON.parse(value)
    } catch {
        return []
    }
}

// Init
onMounted(fetchProducts)
</script>
