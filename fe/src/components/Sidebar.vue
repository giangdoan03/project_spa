<template>
    <a-layout-sider
        :collapsed="collapsed"
        :trigger="null"
        collapsible
        collapsedWidth="0"
        width="250"
        breakpoint="lg"
        @breakpoint="handleBreakpoint"
        @collapse="handleCollapse"
    >
        <div class="logo" />
        <a-menu
            :selectedKeys="selectedKeys"
            :openKeys="openKeys"
            theme="dark"
            mode="inline"
            @openChange="val => openKeys = val"
        >
            <a-menu-item key="dashboard" @click="goTo('/dashboard')">
                <PieChartOutlined />
                <span>Tổng quan</span>
            </a-menu-item>

            <a-sub-menu key="quan-ly-doi-tuong">
                <template #title>
          <span>
            <AppstoreOutlined />
            <span>Quản lý đối tượng</span>
          </span>
                </template>

                <a-menu-item key="san-pham" @click="goTo('/products')">
                    <ShoppingOutlined />
                    <span>Sản phẩm</span>
                </a-menu-item>

                <a-menu-item key="doanh-nghiep-ca-nhan" @click="goTo('/businesses')">
                    <BankOutlined />
                    <span>Doanh nghiệp</span>
                </a-menu-item>

                <a-menu-item key="ca-nhan" @click="goTo('/persons')">
                    <UserOutlined />
                    <span>Cá nhân</span>
                </a-menu-item>

                <a-menu-item key="cua-hang" @click="goTo('/stores')">
                    <ShopOutlined />
                    <span>Cửa hàng</span>
                </a-menu-item>

                <a-menu-item key="su-kien" @click="goTo('/events')">
                    <CalendarOutlined />
                    <span>Sự kiện</span>
                </a-menu-item>
            </a-sub-menu>

            <a-menu-item key="qr-code-marketing" @click="goTo('/my-qr-codes')">
                <QrcodeOutlined />
                <span>QR Code Marketing</span>
            </a-menu-item>

            <a-sub-menu key="chuong-trinh-loyalty">
                <template #title>
          <span>
            <GiftOutlined />
            <span>Chương trình loyalty</span>
          </span>
                </template>
                <a-menu-item key="chuong-trinh" @click="goTo('/loyalty/programs')">
                    <TrophyOutlined />
                    <span>Chương trình</span>
                </a-menu-item>
                <a-menu-item key="qua-tang" @click="goTo('/loyalty/gifts')">
                    <GiftOutlined />
                    <span>Quà tặng</span>
                </a-menu-item>
                <a-menu-item key="goi-voucher" @click="goTo('/loyalty/vouchers')">
                    <ShoppingCartOutlined />
                    <span>Gói voucher</span>
                </a-menu-item>
                <a-menu-item key="lich-su-nguoi-choi" @click="goTo('/loyalty/history')">
                    <HistoryOutlined />
                    <span>Lịch sử người chơi</span>
                </a-menu-item>
            </a-sub-menu>

            <a-menu-item key="trang-tu-thiet-ke" @click="goTo('/custom-pages')">
                <EditOutlined />
                <span>Trang tự thiết kế</span>
            </a-menu-item>

            <a-menu-item key="lich-su-quet" @click="goTo('/scan-history')">
                <SearchOutlined />
                <span>Lịch sử quét</span>
            </a-menu-item>

            <a-menu-item key="lich-su-checkin" @click="goTo('/checkin-history')">
                <EnvironmentOutlined />
                <span>Lịch sử checkin</span>
            </a-menu-item>

            <a-menu-item key="quan-ly-khach-hang" @click="goTo('/customers')">
                <TeamOutlined />
                <span>Quản lý khách hàng</span>
            </a-menu-item>

            <a-menu-item key="cau-hinh" @click="goTo('/settings')">
                <SettingOutlined />
                <span>Cấu hình</span>
            </a-menu-item>

            <a-menu-item key="lich-su-mua-goi" @click="goTo('/purchase-history')">
                <ClockCircleOutlined />
                <span>Lịch sử mua gói</span>
            </a-menu-item>
        </a-menu>
    </a-layout-sider>
</template>

<script setup>
import {
    PieChartOutlined, AppstoreOutlined, ShoppingOutlined, BankOutlined, QrcodeOutlined,
    GiftOutlined, TrophyOutlined, ShoppingCartOutlined, HistoryOutlined, EditOutlined,
    SearchOutlined, EnvironmentOutlined, TeamOutlined, SettingOutlined, ClockCircleOutlined,
    UserOutlined, ShopOutlined, CalendarOutlined
} from '@ant-design/icons-vue'

import { useRouter, useRoute } from 'vue-router'
import { ref, watch, onMounted } from 'vue'

const router = useRouter()
const route = useRoute()

const props = defineProps({
    collapsed: Boolean
})

const emit = defineEmits(['update:collapsed'])

const selectedKeys = ref([])
const openKeys = ref([])

const pathToKeyMap = {
    '/dashboard': 'dashboard',
    '/products': 'san-pham',
    '/businesses': 'doanh-nghiep-ca-nhan',
    '/persons': 'ca-nhan',
    '/stores': 'cua-hang',
    '/events': 'su-kien',
    '/my-qr-codes': 'qr-code-marketing',
    '/loyalty/programs': 'chuong-trinh',
    '/loyalty/gifts': 'qua-tang',
    '/loyalty/vouchers': 'goi-voucher',
    '/loyalty/history': 'lich-su-nguoi-choi',
    '/custom-pages': 'trang-tu-thiet-ke',
    '/scan-history': 'lich-su-quet',
    '/checkin-history': 'lich-su-checkin',
    '/customers': 'quan-ly-khach-hang',
    '/settings': 'cau-hinh',
    '/purchase-history': 'lich-su-mua-goi'
}

const keyToParentMap = {
    'san-pham': 'quan-ly-doi-tuong',
    'doanh-nghiep-ca-nhan': 'quan-ly-doi-tuong',
    'ca-nhan': 'quan-ly-doi-tuong',
    'cua-hang': 'quan-ly-doi-tuong',
    'su-kien': 'quan-ly-doi-tuong',
    'chuong-trinh': 'chuong-trinh-loyalty',
    'qua-tang': 'chuong-trinh-loyalty',
    'goi-voucher': 'chuong-trinh-loyalty',
    'lich-su-nguoi-choi': 'chuong-trinh-loyalty'
}

const updateSelectedAndOpenKeys = () => {
    const key = pathToKeyMap[route.path] || ''
    selectedKeys.value = [key]
    openKeys.value = keyToParentMap[key] ? [keyToParentMap[key]] : []
}

watch(() => route.path, updateSelectedAndOpenKeys)
onMounted(updateSelectedAndOpenKeys)

const handleBreakpoint = (broken) => {
    emit('update:collapsed', broken)
}

const handleCollapse = (collapsed) => {
    emit('update:collapsed', collapsed)
}

const goTo = (path) => {
    router.push(path)
}
</script>

<style scoped>
.logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.3);
    margin: 16px;
}
</style>
