<template>
    <div>
        <a-page-header title="Quản lý khách hàng" />

        <!-- Bộ lọc -->
        <a-row :gutter="[16, 16]" style="margin-bottom: 16px;">
            <a-col :span="4">
                <a-input v-model:value="filters.name" placeholder="Tên khách hàng" />
            </a-col>
            <a-col :span="4">
                <a-input v-model:value="filters.phone" placeholder="Số điện thoại" />
            </a-col>
            <a-col :span="4">
                <a-input v-model:value="filters.email" placeholder="Email" />
            </a-col>
            <a-col :span="4">
                <a-input v-model:value="filters.city" placeholder="Tỉnh/TP" />
            </a-col>
            <a-col :span="6">
                <a-range-picker v-model:value="filters.dateRange" style="width: 100%" />
            </a-col>
            <a-col :span="2">
                <a-button type="primary" block @click="fetchCustomers">Tìm kiếm</a-button>
            </a-col>
        </a-row>

        <div style="margin-bottom: 12px; display: flex; justify-content: space-between">
            <a-button @click="exportExcel">Export</a-button>
            <a-button type="primary" @click="openDrawer">Thêm khách hàng</a-button>
        </div>

        <!-- Danh sách khách hàng -->
        <a-table
            :columns="columns"
            :data-source="customers"
            :loading="loading"
            row-key="id"
            :pagination="pagination"
            @change="handleTableChange"
        >
            <template #bodyCell="{ column, record, index }">
                <template v-if="column.key === 'avatar'">
                    <img v-if="record.avatar" :src="record.avatar" alt="avatar" style="width: 50px; height: 50px; object-fit: cover;" />
                </template>
                <template v-else-if="column.key === 'stt'">
                    {{ (pagination.current - 1) * pagination.pageSize + index + 1 }}
                </template>
                <template v-else-if="column.key === 'customer_status'">
                    <a-tag :color="customerStatusColor(record.customer_status)">
                        {{ statusLabel(record.customer_status) }}
                    </a-tag>
                </template>
                <template v-else-if="column.key === 'package_start_date' || column.key === 'package_end_date'">
                    {{ formatDate(record[column.key]) }}
                </template>
                <template v-else-if="column.key === 'action'">
                    <a-space>
                        <a-button type="link" @click="editCustomer(record)">Sửa</a-button>
                        <a-popconfirm title="Bạn có chắc muốn xoá?" @confirm="deleteCustomer(record.id)">
                            <a-button type="link" danger>Xoá</a-button>
                        </a-popconfirm>
                    </a-space>
                </template>
                <template v-else>
                    {{ record[column.key] }}
                </template>
            </template>
        </a-table>

        <!-- Drawer tạo/sửa khách hàng -->
        <a-drawer
            :title="isEditing ? 'Cập nhật khách hàng' : 'Thêm khách hàng'"
            :open="drawerVisible"
            :width="720"
            :body-style="{ paddingBottom: '80px' }"
            :footer-style="{ textAlign: 'right' }"
            @close="closeDrawer"
        >
            <a-form layout="vertical">
                <a-form-item label="Tên khách hàng">
                    <a-input v-model:value="form.name" />
                </a-form-item>
                <a-form-item label="Số điện thoại">
                    <a-input v-model:value="form.phone" />
                </a-form-item>
                <a-form-item label="Email">
                    <a-input v-model:value="form.email" />
                </a-form-item>
                <a-form-item label="Địa chỉ">
                    <a-input v-model:value="form.address" />
                </a-form-item>
                <a-form-item label="Tỉnh/TP">
                    <a-input v-model:value="form.city" />
                </a-form-item>
                <a-form-item label="Trạng thái khách hàng">
                    <a-select v-model:value="form.customer_status">
                        <a-select-option value="new">Mới</a-select-option>
                        <a-select-option value="active">Đang hoạt động</a-select-option>
                        <a-select-option value="inactive">Ngừng hoạt động</a-select-option>
                        <a-select-option value="vip">VIP</a-select-option>
                        <a-select-option value="expired">Hết hạn</a-select-option>
                    </a-select>
                </a-form-item>

                <a-form-item label="Trạng thái thanh toán">
                    <a-select v-model:value="form.payment_status">
                        <a-select-option value="paid">Đã thanh toán</a-select-option>
                        <a-select-option value="unpaid">Chưa thanh toán</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Thời hạn gói (năm)">
                    <a-select v-model:value="form.package_duration_years">
                        <a-select-option v-for="n in 5" :key="n" :value="n">{{ n }} năm</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Ghi chú">
                    <a-textarea v-model:value="form.note" rows="3" />
                </a-form-item>
            </a-form>
            <template #extra>
                <a-space>
                    <a-button @click="closeDrawer">Hủy</a-button>
                    <a-button type="primary" @click="saveCustomer">Lưu</a-button>
                </a-space>
            </template>
        </a-drawer>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { message } from 'ant-design-vue'
import dayjs from 'dayjs'
import { formatDate } from '../utils/formUtils.js'
import {
    getCustomers,
    createCustomer,
    updateCustomer,
    deleteCustomer as deleteCustomerById
} from '../api/customer'

const customers = ref([])
const loading = ref(false)
const drawerVisible = ref(false)
const isEditing = ref(false)
const form = ref({})

const filters = ref({
    name: '', phone: '', email: '', city: '', dateRange: []
})

const pagination = ref({ current: 1, pageSize: 10, total: 0 })

const columns = [
    { title: 'STT', key: 'stt' },
    { title: 'Tên khách hàng', key: 'name', dataIndex: 'name' },
    { title: 'Số điện thoại', key: 'phone', dataIndex: 'phone' },
    { title: 'Email', key: 'email', dataIndex: 'email' },
    { title: 'Địa chỉ', key: 'address', dataIndex: 'address' },
    { title: 'Tỉnh thành', key: 'city', dataIndex: 'city' },
    { title: 'Trạng thái KH', key: 'customer_status', dataIndex: 'customer_status' },
    { title: 'Ngày bắt đầu', key: 'package_start_date', dataIndex: 'package_start_date' },
    { title: 'Ngày hết hạn', key: 'package_end_date', dataIndex: 'package_end_date' },
    { title: 'Thanh toán', key: 'payment_status', dataIndex: 'payment_status' },
    { title: 'Ghi chú', key: 'note', dataIndex: 'note' },
    { title: 'Thao tác', key: 'action' },
]

const fetchCustomers = async () => {
    loading.value = true
    try {
        const params = {
            page: pagination.value.current,
            per_page: pagination.value.pageSize,
            search: filters.value.name,
            phone: filters.value.phone,
            email: filters.value.email,
            city: filters.value.city,
            from: filters.value.dateRange[0] ? dayjs(filters.value.dateRange[0]).format('YYYY-MM-DD') : undefined,
            to: filters.value.dateRange[1] ? dayjs(filters.value.dateRange[1]).format('YYYY-MM-DD') : undefined,
        }

        const res = await getCustomers(params)
        customers.value = res.data.data
        pagination.value.total = res.data.pager.total
    } catch (e) {
        message.error('Không thể tải danh sách khách hàng')
    } finally {
        loading.value = false
    }
}

const customerStatusColor = (status) => {
    switch (status) {
        case 'new': return 'blue'
        case 'active': return 'green'
        case 'inactive': return 'orange'
        case 'vip': return 'purple'
        case 'expired': return 'red'
        default: return 'default'
    }
}

const statusLabel = (status) => {
    switch (status) {
        case 'new': return 'Mới'
        case 'active': return 'Đang hoạt động'
        case 'inactive': return 'Ngừng hoạt động'
        case 'vip': return 'VIP'
        case 'expired': return 'Hết hạn'
        default: return 'Không rõ'
    }
}

const openDrawer = () => {
    isEditing.value = false
    form.value = {
        customer_status: 'new'
    }
    drawerVisible.value = true
}

const editCustomer = (record) => {
    isEditing.value = true
    form.value = { ...record }
    drawerVisible.value = true
}

const closeDrawer = () => {
    drawerVisible.value = false
}

const saveCustomer = async () => {
    try {
        const startDate = dayjs()
        const endDate = startDate.add(form.value.package_duration_years, 'year')

        form.value.package_start_date = startDate.format('YYYY-MM-DD')
        form.value.package_end_date = endDate.format('YYYY-MM-DD')

        if (isEditing.value) {
            await updateCustomer(form.value.id, form.value)
            message.success('Cập nhật thành công')
        } else {
            await createCustomer(form.value)
            message.success('Thêm thành công')
        }

        drawerVisible.value = false
        await fetchCustomers()
    } catch (e) {
        message.error('Lỗi khi lưu thông tin khách hàng')
    }
}

const deleteCustomer = async (id) => {
    try {
        await deleteCustomerById(id)
        message.success('Đã xoá khách hàng')
        await fetchCustomers()
    } catch (e) {
        message.error('Không thể xoá khách hàng')
    }
}

const toggleStatus = (record) => {
    record.status = record.status === 'active' ? 'paused' : 'active'
    updateCustomer(record.id, record)
    fetchCustomers()
}

const statusColor = (status) => {
    return status === 'active' ? 'green' : status === 'paused' ? 'orange' : 'red'
}

const handleTableChange = (pager) => {
    pagination.value.current = pager.current
    pagination.value.pageSize = pager.pageSize
    fetchCustomers()
}

const exportExcel = () => {
    message.info('Đang phát triển chức năng export...')
}

fetchCustomers()
</script>
