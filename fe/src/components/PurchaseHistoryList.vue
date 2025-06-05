<template>
    <div>
        <!-- Header -->
        <a-page-header title="Thông tin gói của bạn"/>

        <!-- Bảng thông tin -->
        <a-table
            :columns="columns"
            :data-source="data"
            :pagination="false"
            bordered
            rowKey="key"
        />
    </div>
</template>

<script setup>
import {ref, onMounted, computed} from 'vue'
import {message} from 'ant-design-vue'
import {formatDate} from '../utils/formUtils'
import {getPurchaseHistories} from '../api/purchaseHistory'

const packageData = ref(null)
const loading = ref(false)

const fetchPackage = async () => {
    try {
        loading.value = true
        const res = await getPurchaseHistories({ per_page: 1 }) // chỉ lấy 1 gói mới nhất
        if (res.data.data.length > 0) {
            packageData.value = res.data.data[0]
        } else {
            message.warning('Chưa có gói nào được đăng ký')
        }
    } catch (e) {
        console.error(e)
        message.error('Không thể tải thông tin gói')
    } finally {
        loading.value = false
    }
}

onMounted(fetchPackage)

const columns = [
    {title: 'Trường thông tin', dataIndex: 'label', key: 'label'},
    {title: 'Giá trị', dataIndex: 'value', key: 'value'}
]

const data = computed(() => {
    if (!packageData.value) return []

    return [
        {key: 'name', label: 'Tên người tạo', value: packageData.value.user_name},
        {key: 'email', label: 'Email', value: packageData.value.user_email},
        {key: 'product_name', label: 'Gói đã đăng ký', value: packageData.value.product_name},
        {
            key: 'status',
            label: 'Trạng thái gói',
            value: packageData.value.is_active ? 'Đang hoạt động' : 'Chưa kích hoạt'
        },
        {
            key: 'payment_status',
            label: 'Thanh toán',
            value: packageData.value.is_paid ? 'Đã thanh toán' : 'Chưa thanh toán'
        },
        {
            key: 'start_date',
            label: 'Ngày bắt đầu',
            value: formatDate(packageData.value.starts_at)
        },
        {
            key: 'end_date',
            label: 'Ngày hết hạn',
            value: formatDate(packageData.value.expires_at)
        },
        {
            key: 'note',
            label: 'Ghi chú',
            value: packageData.value.note || 'Không có ghi chú'
        }
    ]
})
</script>

