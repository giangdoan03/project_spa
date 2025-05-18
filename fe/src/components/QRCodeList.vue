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
                    <a-row type="flex" align="middle" :style="{ gap: '6px' }">
                        <a-tooltip :title="buildQrLink(record)">
                            <a
                                :href="buildQrLink(record)"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="text-blue-600 underline"
                                style="max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; display: inline-block"
                            >
                                {{ record.short_code }}
                            </a>
                        </a-tooltip>

                        <a-button
                            type="link"
                            size="small"
                            @click="() => copyToClipboard(buildQrLink(record))"
                            title="Sao chép liên kết"
                        >
                            <template #icon>
                                <CopyOutlined />
                            </template>
                        </a-button>
                    </a-row>
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
import { CopyOutlined } from '@ant-design/icons-vue'
import dayjs from 'dayjs'


import { h } from 'vue'
import { Tooltip } from 'ant-design-vue'

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
    {
        title: 'Liên kết',
        key: 'qr_url',
        dataIndex: 'qr_url',
        customRender: ({ record }) => {
            const short = record.short_code || record.qr_url?.split('/').pop()
            const fullUrl = httpOnlyUrl(record.qr_url)

            return h('div', { class: 'flex items-center gap-2' }, [
                h('a', {
                    href: fullUrl,
                    target: '_blank',
                    class: 'text-blue-600 underline',
                    title: fullUrl
                }, `qrcode.io/${short}`),

                h('button', {
                    onClick: () => {
                        navigator.clipboard.writeText(fullUrl)
                        message.success('Đã sao chép liên kết')
                    },
                    title: 'Sao chép',
                    class: 'text-gray-400 hover:text-blue-600'
                }, [h('i', { class: 'fas fa-copy' })])
            ])
        }
    },
    { title: 'Tên mã QR', key: 'qr_name', dataIndex: 'qr_name' },
    { title: 'Tên đối tượng', key: 'target_name', dataIndex: 'target_name' },
    { title: 'Kiểu', key: 'target_type', dataIndex: 'target_type' },
    { title: 'Nhật ký quét', key: 'scan_count', dataIndex: 'scan_count' },
    {
        title: 'Tạo lúc',
        key: 'created_at',
        dataIndex: 'created_at',
        customRender: ({ text }) => dayjs(text).format('HH:mm DD/MM/YYYY')
    },
    { title: 'Hành động', key: 'action' },
]

const allowedHosts = import.meta.env.VITE_ALLOWED_HOSTS?.split(',') || []
const defaultQRUrl = import.meta.env.VITE_DEFAULT_QR_URL || 'https://labit365.com'

const httpOnlyUrl = (url) => {
    const isLocal = allowedHosts.includes(window.location.hostname)
    return isLocal && url.startsWith('https://') ? url.replace('https://', 'https://') : url
}

const buildQrLink = (record) => {
    const baseUrl = import.meta.env.VITE_QR_BASE; // Lấy từ .env
    return `${baseUrl}/views/${record.target_type}.html?${record.qr_id}`;
};

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
        data: httpOnlyUrl(record.qr_url || config?.data || defaultQRUrl)
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

const copyToClipboard = (text) => {
    if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(() => {
            message.success("Đã sao chép vào clipboard!");
        }).catch(err => {
            message.error("Lỗi khi sao chép: " + err);
        });
    } else {
        // Fallback cho trình duyệt cũ hoặc môi trường không hỗ trợ
        const textarea = document.createElement("textarea");
        textarea.value = text;
        textarea.setAttribute("readonly", "");
        textarea.style.position = "absolute";
        textarea.style.left = "-9999px";
        document.body.appendChild(textarea);
        textarea.select();
        try {
            const successful = document.execCommand("copy");
            message.success("Đã sao chép (fallback).");
        } catch (err) {
            message.error("Không thể sao chép (fallback).");
        }
        document.body.removeChild(textarea);
    }
};


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
            data: httpOnlyUrl(record.qr_url || config?.data || defaultQRUrl)
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
