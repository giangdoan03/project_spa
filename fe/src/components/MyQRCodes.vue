<template>
    <div>
        <a-page-header title="Mã QR của tôi" />

        <!-- Thanh công cụ gồm bộ lọc + nút Tạo mã QR -->
        <a-row justify="space-between" style="margin-bottom: 16px;">
            <a-col>
                <a-space>
                    <a-input
                        v-model:value="search"
                        placeholder="Tìm theo tên hoặc link..."
                        @pressEnter="fetchQRCodes"
                    />
                    <a-select
                        v-model:value="filterType"
                        placeholder="Đối tượng"
                        style="width: 150px"
                        @change="fetchQRCodes"
                    >
                        <a-select-option value="">Tất cả</a-select-option>
                        <a-select-option value="product">Sản phẩm</a-select-option>
                        <a-select-option value="store">Cửa hàng</a-select-option>
                        <a-select-option value="event">Sự kiện</a-select-option>
                    </a-select>
                </a-space>
            </a-col>

            <a-col>
                <a-button type="primary" @click="goToCreateQR">
                    <template #icon><PlusOutlined /></template>
                    Tạo mã QR
                </a-button>
            </a-col>
        </a-row>

        <!-- Bảng danh sách QR -->
        <a-table :columns="columns" :data-source="qrCodes" row-key="id" :loading="loading">
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'qr'">
                    <img :src="record.qr_image_url" alt="QR" style="height: 60px;" />
                </template>
                <template v-if="column.key === 'action'">
                    <a-space>
                        <a-button icon="download" @click="download(record)">Tải</a-button>
                        <a-button icon="edit" @click="edit(record)">Sửa</a-button>
                        <a-popconfirm title="Xoá mã QR này?" @confirm="remove(record.id)">
                            <a-button danger icon="delete" />
                        </a-popconfirm>
                    </a-space>
                </template>
            </template>
        </a-table>
    </div>
</template>


<script setup>
import {ref, onMounted} from 'vue'
import {message} from 'ant-design-vue'

import { useRouter } from 'vue-router'

const router = useRouter()

import {
    PlusOutlined,
} from '@ant-design/icons-vue'

const qrCodes = ref([])
const search = ref('')
const filterType = ref('')
const loading = ref(false)

const columns = [
    {title: 'Mã', key: 'qr', dataIndex: 'qr_image_url'},
    {title: 'Liên kết', key: 'url', dataIndex: 'qr_url'},
    {title: 'Tên', key: 'qr_name', dataIndex: 'qr_name'},
    {title: 'Tên đối tượng', key: 'target_name', dataIndex: 'target_name'},
    {title: 'Kiểu', key: 'target_type', dataIndex: 'target_type'},
    {title: 'Nhật ký quét', key: 'scan_count', dataIndex: 'scan_count'},
    {title: 'Hành động', key: 'action'},
]

const fetchQRCodes = async () => {
    loading.value = true
    // TODO: Gọi API, truyền search.value và filterType.value
    // qrCodes.value = await fetch('/api/my-qr-codes?search=...').then(r => r.json())
    loading.value = false
}

const download = (record) => {
    window.open(record.qr_image_url)
}

const edit = (record) => {
    // router.push(`/qr-codes/${record.id}/edit`)
}

const remove = async (id) => {
    // await fetch(`/api/qr-codes/${id}`, { method: 'DELETE' })
    message.success('Đã xoá thành công')
    fetchQRCodes()
}

const goToCreateQR = () => {
    router.push('/my-qr-codes/create')
}
onMounted(fetchQRCodes)
</script>
