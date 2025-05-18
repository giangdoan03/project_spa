<template>
    <div>
        <!-- Header + Button -->
        <a-page-header title="Lịch sử mua gói">
            <template #extra>
                <a-button type="primary" @click="showModal = true">
                    + Đăng ký mua gói
                </a-button>
            </template>
        </a-page-header>

        <!-- Modal -->
        <a-modal
            v-model:visible="showModal"
            title="Đăng ký mua gói"
            ok-text="Kích hoạt"
            cancel-text="Hủy"
            @ok="handleSubmit"
        >
            <a-form layout="vertical">
                <!-- Chọn khách hàng -->
                <a-form-item label="Khách hàng">
                    <a-select
                        v-model:value="form.customer_id"
                        show-search
                        placeholder="Chọn khách hàng"
                        :options="customerOptions"
                        option-filter-prop="label"
                    />
                </a-form-item>

                <!-- Thêm mới khách hàng -->
                <a-form-item>
                    <a-button type="link" @click="handleAddCustomer">+ Thêm mới khách hàng</a-button>
                </a-form-item>

                <!-- Chọn số năm -->
                <a-form-item label="Thời hạn gói (năm)">
                    <a-input-number v-model:value="form.years" :min="1" :max="5" />
                </a-form-item>
            </a-form>
        </a-modal>

        <!-- Bảng dữ liệu -->
        <a-table
            :columns="columns"
            :data-source="data"
            :pagination="pagination"
            row-key="id"
            :loading="loading"
        >
            <!-- bodyCell giữ nguyên -->
        </a-table>
    </div>
</template>


<script setup>
import { ref, onMounted } from 'vue'
import { getPurchaseHistories } from '../api/purchaseHistory'
import { getCustomers } from '../api/customer.js' // ví dụ gọi API
import { message } from 'ant-design-vue'

const data = ref([])
const loading = ref(false)
const showModal = ref(false)

const pagination = ref({
    total: 0,
    current: 1,
    pageSize: 10
})

const form = ref({
    customer_id: null,
    years: 1
})

const customerOptions = ref([])

const columns = [
    { title: 'STT', key: 'stt' },
    { title: 'Tên gói', dataIndex: 'package_name', key: 'package_name' },
    { title: 'Số lượng mã còn lại', dataIndex: 'remaining', key: 'remaining' },
    { title: 'Trạng thái gói', key: 'status' },
    { title: 'Trạng thái hết hạn', key: 'expired' },
    { title: 'Trạng thái nâng cấp', dataIndex: 'upgrade_status', key: 'upgrade_status' },
    { title: 'Ngày đăng ký', dataIndex: 'registered_at', key: 'registered_at' },
    { title: 'Ngày bắt đầu hợp đồng', dataIndex: 'start_date', key: 'start_date' },
    { title: 'Ngày hết hạn theo hợp đồng', dataIndex: 'end_date', key: 'end_date' },
    { title: 'Người đăng ký', dataIndex: 'registered_by', key: 'registered_by' },
    { title: 'Hành động', key: 'action' }
]

const fetchData = async () => {
    loading.value = true
    try {
        const res = await getPurchaseHistories()
        data.value = res.data.data
        pagination.value.total = res.data.pager.total
    } catch (err) {
        message.error('Không thể tải dữ liệu lịch sử mua gói')
    } finally {
        loading.value = false
    }
}

const fetchCustomers = async () => {
    try {
        const res = await getCustomers()
        customerOptions.value = res.data.map((c) => ({
            value: c.id,
            label: c.name
        }))
    } catch (e) {
        message.error('Không tải được danh sách khách hàng')
    }
}

const handleAddCustomer = () => {
    message.info('Tính năng thêm khách hàng sẽ được mở modal khác') // bạn có thể thêm modal riêng
}

const handleSubmit = async () => {
    if (!form.value.customer_id || !form.value.years) {
        return message.warning('Vui lòng điền đầy đủ thông tin')
    }

    try {
        await createPurchase({
            customer_id: form.value.customer_id,
            years: form.value.years
        })
        message.success('Đăng ký gói thành công')
        showModal.value = false
        fetchData()
    } catch (e) {
        message.error('Đăng ký gói thất bại')
    }
}

onMounted(() => {
    fetchData()
    fetchCustomers()
})

</script>
