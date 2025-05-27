<template>
    <div>
        <a-space style="margin-bottom: 16px;">
            <a-input v-model:value="search" placeholder="Tìm theo loại, tỉnh..." @pressEnter="fetchData" />
            <a-button type="primary" @click="fetchData">Tìm kiếm</a-button>
        </a-space>

        <a-table
            :columns="columns"
            :data-source="histories"
            :pagination="pagination"
            row-key="id"
            :loading="loading"
            @change="handleTableChange"
        >
            <template #bodyCell="{ column, record, index }">
                <template v-if="column.key === 'stt'">
                    {{ (pagination.current - 1) * pagination.pageSize + index + 1 }}
                </template>

                <template v-else-if="column.key === 'object_image'">
                    <img :src="record.object_image" alt="Ảnh" style="width: 50px; height: 50px; object-fit: cover;" />
                </template>

                <template v-else-if="column.key === 'qr_name' || column.key === 'object_name'">
                    <a-tooltip :title="record[column.key]">
                        <span class="truncate block max-w-[150px]">{{ record[column.key] }}</span>
                    </a-tooltip>
                </template>

                <template v-else-if="column.key === 'os'">
                    <a-tag>{{ record.os }}</a-tag>
                </template>

                <template v-else-if="column.key === 'app'">
                    <a-tag color="blue">{{ record.app || 'Không xác định' }}</a-tag>
                </template>

                <template v-else-if="column.key === 'created_at'">
                    {{ formatDateTime(record.created_at) }}
                </template>
            </template>

        </a-table>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import { formatDate } from '../utils/formUtils'
import axios from 'axios'
import { formatDateTime } from '../utils/formUtils'


const histories = ref([])
const loading = ref(false)
const search = ref('')
const pagination = ref({ current: 1, pageSize: 10, total: 0 })

const columns = [
    { title: 'STT', key: 'stt' },
    { title: 'Ảnh đối tượng', key: 'object_image', dataIndex: 'object_image' },
    { title: 'Tên QR Code', key: 'qr_name', dataIndex: 'qr_name', ellipsis: true },
    { title: 'Tên đối tượng', key: 'object_name', dataIndex: 'object_name', ellipsis: true },
    { title: 'Loại QR Code', key: 'qr_type', dataIndex: 'qr_type' },
    { title: 'Tỉnh thành', key: 'city', dataIndex: 'city' },
    { title: 'Vị trí', key: 'location', dataIndex: 'location' },
    { title: 'SĐT', key: 'phone', dataIndex: 'phone' },
    { title: 'IP', key: 'ip', dataIndex: 'ip' },
    { title: 'Hệ điều hành', key: 'os', dataIndex: 'os' },
    { title: 'Ứng dụng', key: 'app', dataIndex: 'app' },
    { title: 'Thời gian', key: 'created_at', dataIndex: 'created_at' }
]


const fetchData = async () => {
    loading.value = true
    try {
        const response = await axios.get('http://api.giang.test/api/scan-history', {
            params: {
                search: search.value,
                page: pagination.value.current,
                per_page: pagination.value.pageSize
            },
            withCredentials: true
        })
        histories.value = response.data.data.map((item, index) => {
            return {
                ...item,
                object_name: item.object_name || '', // bạn có thể lấy từ join nếu backend hỗ trợ
                object_image: item.object_image || '', // cần cập nhật từ avatar nếu có
                qr_name: item.qr_name || '',
                qr_type: item.qr_type || '',
                phone: item.phone_number || '',
                ip: item.ip_address || '',
                app: item.app || item.browser || 'Không xác định',
                customer: item.user_id ? `User #${item.user_id}` : '', // nếu có user map thêm tên ở backend
                location: item.city || '', // hoặc xử lý geolocation riêng nếu muốn chi tiết hơn
            }
        })
        pagination.value.total = response.data.pager.total
    } catch (err) {
        message.error('Không thể tải dữ liệu')
    } finally {
        loading.value = false
    }
}

const handleTableChange = (p) => {
    pagination.value.current = p.current
    pagination.value.pageSize = p.pageSize
    fetchData()
}

onMounted(fetchData)
</script>
