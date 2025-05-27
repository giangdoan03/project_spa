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
import {useUserStore} from '../stores/user'
import {computed} from 'vue'
import {formatDate} from '../utils/formUtils'

const userStore = useUserStore()

const columns = [
    {title: 'Trường thông tin', dataIndex: 'label', key: 'label'},
    {title: 'Giá trị', dataIndex: 'value', key: 'value'}
]

const data = computed(() => [
    {key: 'name', label: 'Tên khách hàng', value: userStore.user.name},
    {key: 'email', label: 'Email', value: userStore.user.email},
    {key: 'phone', label: 'Số điện thoại', value: userStore.user.phone},
    {key: 'address', label: 'Địa chỉ', value: `${userStore.user.address}, ${userStore.user.city}`},
    {
        key: 'payment_status',
        label: 'Trạng thái thanh toán',
        value: userStore.user.payment_status === 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán'
    },
    {
        key: 'status',
        label: 'Trạng thái gói',
        value:
            userStore.user.status === 3
                ? 'VIP'
                : userStore.user.status === 4
                    ? 'Hết hạn'
                    : userStore.user.status === 1
                        ? 'Đang hoạt động'
                        : 'Khác'
    },
    {
        key: 'start_date',
        label: 'Ngày bắt đầu gói',
        value: formatDate(userStore.user.package_start_date)
    },
    {
        key: 'end_date',
        label: 'Ngày hết hạn gói',
        value: formatDate(userStore.user.package_end_date)
    },
    {
        key: 'note',
        label: 'Ghi chú',
        value: userStore.user.note || 'Không có ghi chú'
    }
])

</script>
