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
                    <img v-if="record && record.avatar" :src="record.avatar" />
                </template>
                <template v-else-if="column.key === 'stt'">
                    {{ ((pagination?.current || 1) - 1) * (pagination?.pageSize || 10) + index + 1 }}
                </template>
                <template v-else-if="column.key === 'customer_status'">
                    <a-tag :color="customerStatusColor(getDisplayStatus(record))">
                        {{ statusLabel(getDisplayStatus(record)) }}
                    </a-tag>
                </template>
                <template v-else-if="column.key === 'payment_status'">
                    <a-tag :color="record.payment_status === 'paid' ? 'green' : 'orange'">
                        {{ record.payment_status === 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán' }}
                    </a-tag>
                </template>
                <template v-else-if="column.key === 'package_start_date'">
                    {{ record.package_start_date ? formatDate(record.package_start_date) : '—' }}
                </template>

                <template v-else-if="column.key === 'package_end_date'">
                    <span>
                        {{ formatDate(record.package_end_date) }}
                        <a-tag v-if="isExpired(record.package_end_date)" color="red" style="margin-left: 8px;">
                            Hết hạn
                        </a-tag>
                    </span>
                </template>
                <template v-else-if="column.key === 'action'">
                    <a-space>
                        <a-tooltip title="Sửa">
                            <a-button type="text" @click="editCustomer(record)">
                                <template #icon><EditOutlined /></template>
                            </a-button>
                        </a-tooltip>

                        <a-popconfirm title="Bạn có chắc muốn xoá?" @confirm="deleteCustomer(record.id)">
                            <a-tooltip title="Xoá">
                                <a-button type="text" danger>
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                            </a-tooltip>
                        </a-popconfirm>

                        <a-tooltip title="Đăng ký mua gói">
                            <a-button type="text" @click="registerPackage(record)">
                                <template #icon><ShoppingCartOutlined /></template>
                            </a-button>
                        </a-tooltip>
                    </a-space>
                </template>

                <template v-else>
                    {{ record[column.key] }}
                </template>
            </template>
        </a-table>

        <!-- Drawer tạo/sửa khách hàng -->
        <a-drawer
            :open="showDrawer"
            title="Quản lý gói đã đăng ký"
            @close="showDrawer = false"
            width="500"
        >
            <div style="margin-bottom: 12px">
                <strong>Khách hàng:</strong> {{ selectedCustomer?.name }}
            </div>

            <!-- Gói hiện tại -->
            <div v-if="currentPackage" style="margin-bottom: 24px; padding: 12px; background: #f0f2f5; border-radius: 6px">
                <h4>🎯 Gói hiện tại đang dùng:</h4>
                <p><strong>{{ currentPackage.product_name }}</strong></p>
                <p>Bắt đầu: {{ formatDate(currentPackage.starts_at) }}</p>
                <p>Hết hạn: {{ formatDate(currentPackage.expires_at) }}</p>
                <p>Thanh toán: {{ currentPackage.is_paid ? 'Đã thanh toán' : 'Chưa thanh toán' }}</p>
            </div>

            <a-form layout="vertical">
                <a-form-item label="Gói đăng ký">
                    <a-select v-model:value="form.product_name">
                        <a-select-option value="Gói Premium">Gói Premium</a-select-option>
                    </a-select>
                </a-form-item>

                <a-form-item label="Thời hạn gói (năm)">
                    <a-input-number v-model:value="form.years" :min="1" :max="5" />
                </a-form-item>

                <a-form-item>
                    <a-checkbox v-model:checked="form.is_active">Kích hoạt ngay</a-checkbox>
                </a-form-item>

                <a-form-item>
                    <a-checkbox v-model:checked="form.is_paid">Đã thanh toán</a-checkbox>
                </a-form-item>

                <a-button
                    type="primary"
                    block
                    @click="handleRegister"
                    :disabled="!!currentPackage"
                >
                    Đăng ký gói mới
                </a-button>

                <p v-if="currentPackage" style="color: red; margin-top: 8px">
                    ⚠️ Khách hàng đang có gói hoạt động. Không thể đăng ký gói mới.
                </p>
            </a-form>

            <div v-if="pastPackages.length" style="margin-top: 24px">
                <h4>Lịch sử gói đã mua:</h4>
                <a-timeline mode="left">
                    <a-timeline-item v-for="(item, idx) in pastPackages" :key="idx">
                        <p><strong>{{ item.product_name }}</strong></p>
                        <p>Bắt đầu: {{ formatDate(item.starts_at) }}</p>
                        <p>Hết hạn: {{ formatDate(item.expires_at) }}</p>
                        <p>Thanh toán: {{ item.is_paid ? 'Đã thanh toán' : 'Chưa thanh toán' }}</p>
                    </a-timeline-item>
                </a-timeline>
            </div>
        </a-drawer>

<!--        <a-drawer-->
<!--            :open="showDrawer"-->
<!--            :title="formMode === 'update' ? 'Cập nhật gói đã mua' : 'Đăng ký mua gói'"-->
<!--            @close="showDrawer = false"-->
<!--            width="400"-->
<!--        >-->
<!--            <a-form layout="vertical">-->
<!--                <a-form-item label="Khách hàng">-->
<!--                    <a-input :value="selectedCustomer?.name" disabled />-->
<!--                </a-form-item>-->

<!--                <a-form-item label="Gói đăng ký">-->
<!--                    <a-select v-model:value="form.product_name">-->
<!--                        <a-select-option value="Gói Premium">Gói Premium</a-select-option>-->
<!--                        <a-select-option value="Gói VIP" disabled>Gói VIP (Chưa mở)</a-select-option>-->
<!--                    </a-select>-->
<!--                </a-form-item>-->

<!--                <a-form-item label="Thời hạn gói (năm)">-->
<!--                    <a-input-number v-model:value="form.years" :min="1" :max="5" />-->
<!--                </a-form-item>-->

<!--                <a-form-item>-->
<!--                    <a-checkbox v-model:checked="form.is_active">Kích hoạt ngay</a-checkbox>-->
<!--                </a-form-item>-->

<!--                <a-form-item>-->
<!--                    <a-checkbox v-model:checked="form.is_paid">Đã thanh toán</a-checkbox>-->
<!--                </a-form-item>-->

<!--            </a-form>-->

<!--            <template #footer>-->
<!--                <a-space style="float: right;">-->
<!--                    <a-button @click="showDrawer = false">Hủy</a-button>-->
<!--                    <a-button type="primary" @click="formMode === 'update' ? handleUpdate() : handleRegister()">-->
<!--                        {{ formMode === 'update' ? 'Cập nhật' : 'Kích hoạt' }}-->
<!--                    </a-button>-->
<!--                </a-space>-->
<!--            </template>-->
<!--        </a-drawer>-->





    </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { message } from 'ant-design-vue'
import dayjs from 'dayjs'
import { h } from 'vue'
import { formatDate } from '../utils/formUtils.js'
import {
    EditOutlined,
    DeleteOutlined,
    ShoppingCartOutlined
} from '@ant-design/icons-vue'
import {
    getCustomers,
    createCustomer,
    updateCustomer,
    deleteCustomer as deleteCustomerById
} from '../api/customer'
import {createPurchaseHistory, getPurchaseHistories, updatePurchaseHistory} from '../api/purchaseHistory'

const customers = ref([])
const loading = ref(false)
const drawerVisible = ref(false)
const isEditing = ref(false)
const form = ref({
    years: 1,
    product_name: 'Gói Premium',
    is_active: true,
    is_paid: false // ✅ mặc định là chưa thanh toán
})
const formRef = ref()
const changePassword = ref(false)
const showDrawer = ref(false)
const filters = ref({ name: '', phone: '', email: '', city: '', dateRange: [] })
const pagination = ref({ current: 1, pageSize: 10, total: 0 })
const formMode = ref('create') // hoặc 'update'
const existingPackage = ref(null)
const selectedCustomer = ref({})


const packageHistory = ref([])

const currentPackage = computed(() => {
    return packageHistory.value.find(
        (p) =>
            p.is_active === 1 &&
            p.is_paid === 1 &&
            dayjs(p.expires_at).isAfter(dayjs(), 'day')
    )
})

const pastPackages = computed(() => {
    return packageHistory.value.filter((p) => p !== currentPackage.value)
})



const columns = [
    { title: 'STT', key: 'stt' },
    { title: 'Tên khách hàng', key: 'name', dataIndex: 'name' },
    { title: 'Số điện thoại', key: 'phone', dataIndex: 'phone' },
    { title: 'Email', key: 'email', dataIndex: 'email' },
    { title: 'Địa chỉ', key: 'address', dataIndex: 'address' },
    { title: 'Tỉnh thành', key: 'city', dataIndex: 'city' },
    { title: 'Trạng thái KH', key: 'customer_status', dataIndex: 'customer_status_text' },
    { title: 'Ngày bắt đầu', key: 'package_start_date', dataIndex: 'package_start_date' },
    { title: 'Ngày hết hạn', key: 'package_end_date', dataIndex: 'package_end_date' },
    { title: 'Thanh toán', key: 'payment_status', dataIndex: 'payment_status' },
    { title: 'Ghi chú', key: 'note', dataIndex: 'note' },
    { title: 'Thao tác', key: 'action' },
]


const statusOptions = [
    { value: 0, label: 'Mới' },
    { value: 1, label: 'Đang hoạt động' },
    { value: 2, label: 'Ngừng hoạt động' },
    { value: 3, label: 'VIP' },
    { value: 4, label: 'Hết hạn' },
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

const registerPackage = async (customer) => {
    selectedCustomer.value = customer
    showDrawer.value = true
    form.value = {
        years: 1,
        product_name: 'Gói Premium',
        is_active: true,
        is_paid: false
    }

    try {
        const res = await getPurchaseHistories({ customer_id: customer.id })
        packageHistory.value = res.data.data || []
    } catch (e) {
        message.error('Không tải được lịch sử gói')
    }
}




const handleUpdate = async () => {
    if (!existingPackage.value) return

    try {
        const payload = {
            customer_id: selectedCustomer.value.id,
            product_name: form.value.product_name,
            quantity: form.value.years, // ✅ sửa đúng ở đây
            is_active: form.value.is_active ? 1 : 0,
            is_paid: form.value.is_paid ? 1 : 0
        }

        await updatePurchaseHistory(existingPackage.value.id, payload)
        message.success('Cập nhật gói thành công')
        showDrawer.value = false
        await fetchCustomers()
    } catch (e) {
        console.error(e)
        message.error('Lỗi khi cập nhật gói')
    }
}



const handleRegister = async () => {
    if (currentPackage.value) {
        message.warning('Khách hàng đang có gói hoạt động. Không thể đăng ký mới.')
        return
    }

    try {
        const now = new Date()
        const years = form.value.years || 1

        const payload = {
            customer_id: selectedCustomer.value.id,
            product_name: form.value.product_name,
            quantity: years,
            is_active: form.value.is_active ? 1 : 0,
            is_paid: form.value.is_paid ? 1 : 0,
            starts_at: now.toISOString(),
            expires_at: new Date(now.setFullYear(now.getFullYear() + years)).toISOString()
        }

        await createPurchaseHistory(payload)
        message.success('Đăng ký gói thành công')
        await registerPackage(selectedCustomer.value)
    } catch (e) {
        message.error('Lỗi khi đăng ký gói')
    }
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
            to: filters.value.dateRange[1] ? dayjs(filters.value.dateRange[1]).format('YYYY-MM-DD') : undefined
        }

        const res = await getCustomers(params)
        customers.value = res.data.data.map((customer) => {
            const latestPackage = customer.packages?.[0] ?? null

            return {
                ...customer,
                packages: Array.isArray(customer.packages) ? customer.packages : [],
                customer_status_text: statusLabel(Number(customer.status)),
                customer_status: Number(customer.status),
                package_start_date: latestPackage?.starts_at ?? null,
                package_end_date: latestPackage?.expires_at ?? null,
                payment_status: latestPackage?.is_paid === '1' ? 'paid' : 'unpaid',
                note: latestPackage?.note ?? ''
            }
        })


        pagination.value.total = res.data.pager.total
    } catch (e) {
        message.error('Không thể tải danh sách khách hàng')
    } finally {
        loading.value = false
    }
}


const isExpired = (dateStr) => {
    return dayjs(dateStr).isBefore(dayjs(), 'day')
}

const getDisplayStatus = (record) => {
    const isPaid = record.payment_status === 'paid'
    const isExpiredPkg = isExpired(record.package_end_date)

    if (!isPaid) return 2 // Ngừng hoạt động
    if (isExpiredPkg) return 4 // Hết hạn
    return 1 // Đang hoạt động
}

const openDrawer = () => {
    isEditing.value = false
    form.value = { customer_status: 0 }
    drawerVisible.value = true
}

const editCustomer = (record) => {
    isEditing.value = true
    let duration = undefined
    if (record.package_start_date && record.package_end_date) {
        const start = dayjs(record.package_start_date)
        const end = dayjs(record.package_end_date)
        const diffYears = end.diff(start, 'year')
        duration = diffYears > 0 ? diffYears : undefined
    }

    form.value = {
        ...record,
        customer_status: Number(record.status),
        package_duration_years: duration
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
        if (form.value.package_duration_years) {
            const startDate = dayjs()
            const endDate = startDate.add(form.value.package_duration_years, 'year')

            form.value.package_start_date = startDate.format('YYYY-MM-DD')
            form.value.package_end_date = endDate.format('YYYY-MM-DD')
        }

        form.value.status = form.value.customer_status
        delete form.value.package_duration_years

        if (isEditing.value && !changePassword.value) {
            delete form.value.password
            delete form.value.confirm_password
        }

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
        case 0:
        case '0':
        case 'new': return 'blue'
        case 1:
        case '1':
        case 'active': return 'green'
        case 2:
        case '2':
        case 'inactive': return 'orange'
        case 3:
        case '3':
        case 'vip': return 'purple'
        case 4:
        case '4':
        case 'expired': return 'red'
        default: return 'default'
    }
}

const statusLabel = (status) => {
    switch (parseInt(status)) {
        case 0: return 'Mới'
        case 1: return 'Đang hoạt động'
        case 2: return 'Ngừng hoạt động'
        case 3: return 'VIP'
        case 4: return 'Hết hạn'
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
