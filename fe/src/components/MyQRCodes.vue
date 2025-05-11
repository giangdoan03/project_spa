<template>
    <div>
        <a-page-header title="Mã QR của tôi" class="title-no-pd-l-r" />

        <a-row justify="space-between" style="margin-bottom: 16px;">
            <a-col>
                <a-space>
                    <a-input
                        v-model:value="search"
                        placeholder="Tìm theo tên hoặc link..."
                        @pressEnter="updateRoute"
                    />
                    <a-select
                        v-model:value="filterType"
                        placeholder="Đối tượng"
                        style="width: 150px"
                        @change="updateRoute"
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
                    <template #icon>
                        <PlusOutlined />
                    </template>
                    Tạo mã QR
                </a-button>
            </a-col>
        </a-row>

        <a-table
            :columns="columns"
            :data-source="qrCodes"
            row-key="qr_id"
            :loading="loading"
            :pagination="{
                current: currentPage,
                pageSize,
                total: totalItems,
                onChange: onPageChange
            }"
        >
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'qr_url'">
                    <a
                        :href="httpOnlyUrl(record.qr_url)"
                        target="_blank"
                        rel="noopener noreferrer"
                        style="color: #1677ff; text-decoration: underline"
                    >
                        {{ httpOnlyUrl(record.qr_url) }}
                    </a>
                </template>

                <template v-if="column.key === 'qr'">
                    <div :data-qr-id="record.qr_id" style="width: 60px; height: 60px;"></div>
                </template>

                <template v-if="column.key === 'target_name'">
                    <a :href="getTargetEditUrl(record)" style="color: #1677ff">
                        {{ record.target_name }}
                    </a>
                </template>

                <template v-if="column.key === 'action'">
                    <a-space>
                        <a-dropdown>
                            <a-button>
                                Tải
                            </a-button>
                            <template #overlay>
                                <a-menu @click="({ key }) => download(record, key)">
                                    <a-menu-item key="png">Tải PNG</a-menu-item>
                                    <a-menu-item key="jpg">Tải JPG</a-menu-item>
                                </a-menu>
                            </template>
                        </a-dropdown>

                        <a-button @click="edit(record)">Sửa</a-button>
                        <a-popconfirm title="Xoá mã QR này?" @confirm="remove(record.qr_id)">
                            <a-button danger>Xoá</a-button>
                        </a-popconfirm>
                    </a-space>
                </template>
            </template>
        </a-table>
    </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, nextTick } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { message } from 'ant-design-vue'
import { getQRList, deleteQR } from '@/api/qrcode'
import { PlusOutlined } from '@ant-design/icons-vue'
import QRCodeStyling from 'qr-code-styling'

const router = useRouter()
const route = useRoute()

const qrCodes = ref([])
const totalItems = ref(0)
const loading = ref(false)

const search = ref('')
const filterType = ref('')
const pageSize = 10
const qrInstances = ref({})

const currentPage = computed(() => parseInt(route.query.page || '1'))

const columns = [
    { title: 'Mã', key: 'qr', dataIndex: 'qr_image_url' },
    { title: 'Liên kết', key: 'qr_url', dataIndex: 'qr_url' },
    { title: 'Tên mã QR', key: 'qr_name', dataIndex: 'qr_name' },
    { title: 'Tên đối tượng', key: 'target_name', dataIndex: 'target_name' },
    { title: 'Kiểu', key: 'target_type', dataIndex: 'target_type' },
    { title: 'Nhật ký quét', key: 'scan_count', dataIndex: 'scan_count' },
    { title: 'Hành động', key: 'action' },
]

const httpOnlyUrl = (url) => {
    const isLocal = ['localhost', '127.0.0.1', 'admin-qrcode.labit365.com'].includes(window.location.hostname)
    return isLocal && url.startsWith('https://') ? url.replace('https://', 'https://') : url
}

const download = (record, format = 'png') => {
    const qrInstance = qrInstances.value[record.qr_id]
    if (!qrInstance) {
        message.error('Không tìm thấy QR để tải')
        return
    }

    // Clone QR với kích thước lớn hơn để tải (không ảnh hưởng ảnh nhỏ đã render)
    const config = typeof record.settings_json === 'string'
        ? JSON.parse(record.settings_json)
        : record.settings_json

    const largeQR = new QRCodeStyling({
        ...config,
        width: 600,
        height: 600,
        data: httpOnlyUrl(record.qr_url || config?.data || 'https://labit365.com')
    })

    largeQR.download({
        name: record.qr_name || 'qr-code',
        extension: format
    })
}


const getTargetEditUrl = (record) => {
    const type = record.target_type
    const id = record.target_id
    return type && id ? `/${type}s/${id}/edit` : '#'
}

const fetchQRCodes = async () => {
    try {
        const res = await getQRList({
            search: search.value,
            type: filterType.value,
            page: currentPage.value,
        })

        qrInstances.value = {} // 💥 Clear cache QR cũ
        qrCodes.value = res.data || []
        totalItems.value = res.total || 0
    } catch (err) {
        message.error('Lỗi tải danh sách QR')
        console.error(err)
    }

}

const updateRoute = () => {
    router.push({
        path: '/my-qr-codes',
        query: {
            search: search.value || undefined,
            type: filterType.value || undefined,
            page: 1
        }
    })
}

const onPageChange = (page) => {
    router.push({
        path: '/my-qr-codes',
        query: {
            search: search.value || undefined,
            type: filterType.value || undefined,
            page
        }
    })
}

const goToCreateQR = () => {
    router.push('/my-qr-codes/create')
}

const edit = (record) => {
    if (!record.qr_id) {
        message.error('Không tìm thấy ID mã QR')
        return
    }

    router.push({
        path: `/my-qr-codes/${record.qr_id}/edit`,
        query: {
            ...route.query // truyền toàn bộ query hiện tại
        }
    })
}

// const download = (record) => {
//     window.open(httpOnlyUrl(record.qr_image_url), '_blank')
// }

const remove = async (qr_id) => {
    try {
        await deleteQR(qr_id)
        message.success('Đã xoá thành công')
        await fetchQRCodes()
    } catch (err) {
        message.error('Xoá thất bại')
    }
}

const appendQRCode = (el, record) => {
    if (!el || qrInstances.value[record.qr_id]) return

    try {
        const config = typeof record.settings_json === 'string'
            ? JSON.parse(record.settings_json)
            : record.settings_json

        const qrCode = new QRCodeStyling({
            ...config,
            width: 60,
            height: 60,
            data: httpOnlyUrl(record.qr_url || config?.data || 'https://labit365.com'),
        })

        qrCode.append(el)
        qrInstances.value[record.qr_id] = qrCode
    } catch (e) {
        console.error('QR init failed for', record.qr_id, e)
    }
}

const renderAllQRCodes = async () => {
    await nextTick()
    qrCodes.value.forEach(record => {
        const container = document.querySelector(`[data-qr-id="${record.qr_id}"]`)
        if (container && !qrInstances.value[record.qr_id]) {
            appendQRCode(container, record)
        }
    })
}

// Re-fetch khi route.query thay đổi
watch(() => route.query, () => {
    fetchQRCodes().then(() => {
        renderAllQRCodes()
    })
}, { immediate: true })
</script>

<style>
.title-no-pd-l-r {
    padding-left: 0;
    padding-right: 0;
}
</style>
