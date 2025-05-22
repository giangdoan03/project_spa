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
            <a-form layout="vertical" :model="form" :rules="rules" ref="formRef">
                <a-form-item label="Tên khách hàng" name="name">
                    <a-input v-model:value="form.name" />
                </a-form-item>
                <a-form-item label="Số điện thoại" name="phone">
                    <a-input v-model:value="form.phone" />
                </a-form-item>
                <a-form-item label="Email" name="email">
                    <a-input v-model:value="form.email" />
                </a-form-item>
                <!-- Hiển thị checkbox khi đang sửa -->
                <a-form-item v-if="isEditing" name="change_password">
                    <a-checkbox v-model:checked="changePassword">Sửa mật khẩu</a-checkbox>
                </a-form-item>

                <!-- Hiển thị input mật khẩu nếu đang thêm hoặc đã chọn sửa mật khẩu -->
                <a-form-item
                    v-if="!isEditing || changePassword"
                    label="Mật khẩu"
                    name="password"
                >
                    <a-input-password v-model:value="form.password" />
                </a-form-item>

                <a-form-item
                    v-if="!isEditing || changePassword"
                    label="Xác nhận mật khẩu"
                    name="confirm_password"
                >
                    <a-input-password v-model:value="form.confirm_password" />
                </a-form-item>


                <a-form-item label="Địa chỉ">
                    <a-input v-model:value="form.address" />
                </a-form-item>
                <a-form-item label="Tỉnh/TP">
                    <a-input v-model:value="form.city" />
                </a-form-item>
                <a-form-item label="Trạng thái khách hàng" name="customer_status">
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
                    <a-textarea v-model:value="form.note" :rows="3" />
                </a-form-item>
            </a-form>
            <template #extra>
                <a-space>
                    <a-button @click="closeDrawer">Hủy</a-button>
                    <a-button type="primary" @click="handleSubmit">Lưu</a-button>
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
const formRef = ref()
const changePassword = ref(false)


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

const rules = {
    name: [
        { required: true, message: 'Vui lòng nhập tên khách hàng', trigger: 'blur' }
    ],
    phone: [
        {
            validator: (_rule, value) => {
                if (!value) return Promise.reject('Vui lòng nhập số điện thoại')
                return /^(0|\+84)[0-9]{9,10}$/.test(value)
                    ? Promise.resolve()
                    : Promise.reject('Số điện thoại không hợp lệ')
            },
            trigger: 'blur'
        }
    ],
    email: [
        {
            type: 'email',
            message: 'Email không hợp lệ',
            trigger: 'blur'
        }
    ],
    customer_status: [
        { required: true, message: 'Vui lòng chọn trạng thái khách hàng', trigger: 'change' }
    ],
    password: [
        {
            validator: (_rule, value) => {
                if ((!isEditing.value || changePassword.value) && !value) {
                    return Promise.reject('Vui lòng nhập mật khẩu')
                }
                if (value && value.length < 6) {
                    return Promise.reject('Mật khẩu phải có ít nhất 6 ký tự')
                }
                return Promise.resolve()
            },
            trigger: 'blur'
        }
    ],
    confirm_password: [
        {
            validator: (_rule, value) => {
                if ((!isEditing.value || changePassword.value) && form.value.password && value !== form.value.password) {
                    return Promise.reject('Mật khẩu không khớp')
                }
                return Promise.resolve()
            },
            trigger: 'blur'
        }
    ]

}

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

const openDrawer = () => {
    isEditing.value = false
    form.value = { customer_status: 'new' }
    drawerVisible.value = true
}

const editCustomer = (record) => {
    isEditing.value = true
    form.value = {
        ...record,
        package_duration_years: undefined // không gán lại thời hạn nếu không chọn
    }
    changePassword.value = false
    drawerVisible.value = true
}



const closeDrawer = () => {
    drawerVisible.value = false
}

const handleSubmit = () => {
    formRef.value
        .validate()
        .then(saveCustomer)
        .catch(() => {
            message.warning('Vui lòng kiểm tra lại các trường bắt buộc')
        })
}

const saveCustomer = async () => {
    try {
        // Nếu có chọn số năm thời hạn gói
        if (form.value.package_duration_years) {
            const startDate = dayjs()
            const endDate = startDate.add(form.value.package_duration_years, 'year')
            form.value.duration_years = form.value.package_duration_years
            form.value.package_start_date = startDate.format('YYYY-MM-DD')
            form.value.package_end_date = endDate.format('YYYY-MM-DD')
        }

        // Xoá field không cần gửi
        delete form.value.package_duration_years

        // Nếu đang sửa và không đổi mật khẩu thì xoá cả password & confirm_password
        if (isEditing.value) {
            if (!changePassword.value) {
                delete form.value.password
                delete form.value.confirm_password
            }
        }

        if (isEditing.value) {
            await updateCustomer(form.value.id, form.value)
            message.success('Cập nhật thành công')
        } else {
            // ✅ confirm_password vẫn còn khi tạo mới
            await createCustomer(form.value)
            message.success('Thêm thành công')
        }

        drawerVisible.value = false
        await fetchCustomers()
    } catch (e) {
        console.error(e)
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
