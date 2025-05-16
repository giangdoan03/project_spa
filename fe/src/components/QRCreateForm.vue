<template>
    <div class="content_box">
        <a-button
            type="link"
            @click="goBackToList"
            style="padding-left: 0; margin-bottom: 24px; color: #000000"
        >
            <template #icon><ArrowLeftOutlined /></template>
            Quay lại danh sách
        </a-button>
        <a-card style="margin-bottom: 24px" class="bg_card_gray">
            <a-row :gutter="16" class="item-selector">
                <a-col
                    v-for="item in qrTypes"
                    :key="item.key"
                    xs="12" sm="8" md="6" lg="4" xl="3" xxl="2"
                >
                    <div
                        class="item"
                        :class="{ active: selectedKey === item.key }"
                        @click="selectItem(item.key)"
                    >
                        <div v-if="item.pro" class="badge">Pro</div>
                        <component :is="item.icon" class="icon"/>
                        <div class="label">{{ item.label }}</div>
                    </div>
                </a-col>
            </a-row>
        </a-card>
        <a-form layout="vertical" @submit.prevent="handleSubmit">
            <a-card class="bg_card_gray">
                <a-row :gutter="24">
                    <!-- Bên trái: Tabs cấu hình -->
                    <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="14">
                        <a-card v-if="formComponent" :title="selectedLabel" style="margin-bottom: 24px;">
                            <component
                                :is="formComponent"
                                :key="selectedKey"
                                ref="formComponentRef"
                                v-model="form"
                            />
                        </a-card>

                        <a-card title="Cấu hình mã QR" bordered>
                            <a-tabs tab-position="top">
                                <a-tab-pane key="main" tab="Main Options">
                                    <a-form-item label="Chiều rộng">
                                        <a-input-number v-model:value="form.settings.width" :min="100" :step="10" style="width: 100%;"/>
                                    </a-form-item>
                                    <a-form-item label="Chiều cao">
                                        <a-input-number v-model:value="form.settings.height" :min="100" :step="10" style="width: 100%;"/>
                                    </a-form-item>
                                    <a-form-item label="Khoảng cách viền (margin)">
                                        <a-input-number v-model:value="form.settings.margin" :min="0" style="width: 100%;"/>
                                    </a-form-item>
                                    <a-form-item label="Logo QR (tuỳ chọn)">
                                        <a-upload
                                            list-type="picture-card"
                                            :file-list="logoFile ? [logoFile] : []"
                                            :on-preview="handlePreview"
                                            :on-remove="handleRemoveFile"
                                            :before-upload="(file) => handleBeforeUploadSingle('logo', file)"
                                            :max-count="1"
                                        >
                                            <div v-if="!logoFile">
                                                <plus-outlined />
                                                <div style="margin-top: 8px">Tải logo</div>
                                            </div>
                                        </a-upload>
                                    </a-form-item>

                                </a-tab-pane>

                                <a-tab-pane key="dots" tab="Dots">
                                    <a-form-item label="Kiểu chấm">
                                        <a-select v-model:value="form.settings.dotsOptions.type">
                                            <a-select-option value="square">Square</a-select-option>
                                            <a-select-option value="dots">Dots</a-select-option>
                                            <a-select-option value="rounded">Rounded</a-select-option>
                                            <a-select-option value="extra-rounded">Extra Rounded</a-select-option>
                                        </a-select>
                                    </a-form-item>
                                    <a-form-item label="Màu chấm">
                                        <a-input type="color" v-model:value="form.settings.dotsOptions.color" style="max-width: 50px;"/>
                                    </a-form-item>
                                </a-tab-pane>

                                <a-tab-pane key="corners" tab="Corners">
                                    <a-row :gutter="12">
                                        <a-col :span="12">
                                            <a-form-item label="Corners Square Style">
                                                <a-select v-model:value="form.settings.cornersSquareOptions.type">
                                                    <a-select-option value="dot">Dot</a-select-option>
                                                    <a-select-option value="square">Square</a-select-option>
                                                    <a-select-option value="extra-rounded">Extra Rounded</a-select-option>
                                                </a-select>
                                            </a-form-item>
                                            <a-form-item label="Corners Square Color">
                                                <a-input type="color" v-model:value="form.settings.cornersSquareOptions.color" style="max-width: 50px;"/>
                                            </a-form-item>
                                        </a-col>
                                        <a-col :span="12">
                                            <a-form-item label="Corners Dot Style">
                                                <a-select v-model:value="form.settings.cornersDotOptions.type">
                                                    <a-select-option value="none">None</a-select-option>
                                                    <a-select-option value="dot">Dot</a-select-option>
                                                </a-select>
                                            </a-form-item>
                                            <a-form-item label="Corners Dot Color">
                                                <a-input type="color" v-model:value="form.settings.cornersDotOptions.color" style="max-width: 50px;"/>
                                            </a-form-item>
                                        </a-col>
                                    </a-row>
                                </a-tab-pane>

                                <a-tab-pane key="background" tab="Nền & Ảnh">
                                    <a-form-item label="Màu nền">
                                        <a-input type="color" v-model:value="form.settings.backgroundOptions.color" style="max-width: 50px;"/>
                                    </a-form-item>
                                    <a-form-item label="Ẩn chấm nền">
                                        <a-checkbox v-model:checked="form.settings.imageOptions.hideBackgroundDots"/>
                                    </a-form-item>
                                    <a-form-item label="Kích thước logo (0 - 1)">
                                        <a-input-number v-model:value="form.settings.imageOptions.imageSize" :min="0" :max="1" :step="0.1"/>
                                    </a-form-item>
                                </a-tab-pane>

                                <a-tab-pane key="qrOptions" tab="QR Code">
                                    <a-form-item label="Type Number">
                                        <a-input-number v-model:value="form.settings.qrOptions.typeNumber" :min="0"/>
                                    </a-form-item>
                                    <a-form-item label="Chế độ mã hoá">
                                        <a-select v-model:value="form.settings.qrOptions.mode">
                                            <a-select-option value="Byte">Byte</a-select-option>
                                            <a-select-option value="Numeric">Numeric</a-select-option>
                                            <a-select-option value="Alphanumeric">Alphanumeric</a-select-option>
                                        </a-select>
                                    </a-form-item>
                                    <a-form-item label="Mức sửa lỗi">
                                        <a-select v-model:value="form.settings.qrOptions.errorCorrectionLevel">
                                            <a-select-option value="L">L</a-select-option>
                                            <a-select-option value="M">M</a-select-option>
                                            <a-select-option value="Q">Q</a-select-option>
                                            <a-select-option value="H">H</a-select-option>
                                        </a-select>
                                    </a-form-item>
                                </a-tab-pane>
                            </a-tabs>
                        </a-card>
                    </a-col>

                    <!-- Bên phải: QR Preview -->
                    <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="10">
                        <a-card title="Xem trước mã QR" class="qr_code_image" bordered>
                            <div class="preview">
                                <div ref="qrRef"></div>
                            </div>
                            <a-button class="btn_save_qr_code" type="primary" block @click="handleSubmit" style="max-width: 334px;">Tạo và lưu QR
                            </a-button>
                            <div class="flex items-center justify-center gap-2 mt-4 btn_download">
                                <a-select v-model:value="downloadFormat" style="width: 100px; margin-right: 10px">
                                    <a-select-option value="png">PNG</a-select-option>
                                    <a-select-option value="jpeg">JPEG</a-select-option>
                                </a-select>
                                <a-button @click="downloadQRCode" type="default">Download</a-button>
                            </div>
                        </a-card>
                    </a-col>
                </a-row>
            </a-card>
        </a-form>
    </div>
</template>
<script setup>
import { ref, watch, onMounted, computed, nextTick } from 'vue'
import {useRoute, useRouter} from 'vue-router'
const route = useRoute()
import QRCodeStyling from 'qr-code-styling'
import { h } from 'vue'
import {createQR, updateQR, getQR } from '@/api/qrcode'
import {uploadFile} from '../api/product'
import {message} from 'ant-design-vue'
const isEditMode = computed(() => !!route.params.qr_id)
const downloadFormat = ref('png')

const requireTarget = ref(false)
const formComponentRef = ref()
const QR_BASE_URL = import.meta.env.VITE_QR_BASE

import {
    LinkOutlined, FontSizeOutlined, MessageOutlined, ContactsOutlined, CalendarOutlined,
    PhoneOutlined, MailOutlined, EnvironmentOutlined, WifiOutlined, AppstoreAddOutlined,
    AppstoreOutlined, PictureOutlined, FilePdfOutlined, AudioOutlined, PlayCircleOutlined,
    ShopOutlined, ShoppingOutlined, UserOutlined, ApartmentOutlined, FlagOutlined, ArrowLeftOutlined, PlusOutlined
} from '@ant-design/icons-vue'

// Giả sử các form đã import đúng ở đây:
import UrlForm from '@/components/forms/UrlForm.vue'
import TextForm from '@/components/forms/TextForm.vue'
import SmsForm from '@/components/forms/SmsForm.vue'
import ProductForm from '@/components/forms/ProductForm.vue'
import CompanyForm from '@/components/forms/CompanyForm.vue'
import StoreForm from '@/components/forms/StoreForm.vue'
import EventForm from '@/components/forms/EventForm.vue'
import PersonForm from '@/components/forms/PersonForm.vue'
import Persons from "@/components/templates/persons/index.js";


const router = useRouter()


const formMap = {
    url: UrlForm,
    text: TextForm,
    sms: SmsForm,
    product: ProductForm,
    store: StoreForm,
    event: EventForm,
    person: PersonForm,
    business: CompanyForm,
    // thêm các form còn lại tại đây
}


const qrTypes = [
    { key: 'url', label: 'Liên kết/URL', icon: LinkOutlined, pro: false },
    { key: 'text', label: 'Văn bản', icon: FontSizeOutlined, pro: false },
    { key: 'sms', label: 'SMS', icon: MessageOutlined, pro: false },
    { key: 'vcard', label: 'vCard', icon: ContactsOutlined, pro: false },
    { key: 'calendar', label: 'Lịch', icon: CalendarOutlined, pro: false },
    { key: 'phone', label: 'Điện thoại', icon: PhoneOutlined, pro: false },
    { key: 'email', label: 'Email', icon: MailOutlined, pro: false },
    { key: 'map', label: 'Bản đồ', icon: EnvironmentOutlined, pro: false },
    { key: 'wifi', label: 'Wifi', icon: WifiOutlined, pro: false },
    { key: 'custom-url', label: 'URL Tùy chỉnh', icon: AppstoreAddOutlined, pro: false },
    { key: 'app-store', label: 'App Store/Google Play', icon: AppstoreOutlined, pro: false },
    { key: 'image', label: 'Hình ảnh/PNG', icon: PictureOutlined, pro: false },
    { key: 'pdf', label: 'PDF', icon: FilePdfOutlined, pro: false },
    { key: 'audio', label: 'Âm thanh', icon: AudioOutlined, pro: false },
    { key: 'video', label: 'Video', icon: PlayCircleOutlined, pro: false },
    { key: 'product', label: 'Sản phẩm', icon: ShoppingOutlined, pro: true },
    { key: 'store', label: 'Cửa hàng', icon: ShopOutlined, pro: true },
    { key: 'person', label: 'Cá nhân', icon: UserOutlined, pro: true },
    { key: 'business', label: 'Công ty', icon: ApartmentOutlined, pro: true },
    { key: 'event', label: 'Sự kiện', icon: FlagOutlined, pro: true },
]

const logoFile = ref(null)

const handleBeforeUploadSingle = async (field, file) => {
    const { data } = await uploadFile(file)
    form.value.settings.image = data.url
    logoFile.value = {
        uid: Date.now().toString(),
        name: data.url.split('/').pop(),
        status: 'done',
        url: data.url
    }
    return false
}


const handleRemoveFile = () => {
    form.value.settings.image = ''
    logoFile.value = null
}

const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const handlePreview = async (file) => {
    previewImage.value = file.url || file.thumbUrl
    previewVisible.value = true
    previewTitle.value = file.name || ''
}
const downloadQRCode = () => {
    if (qrCode) {
        qrCode.download({
            name: `qr_code_${Date.now()}`,
            extension: downloadFormat.value
        })
    }
}

const selectedKey = ref('url')
const selectItem = async (key) => {
    selectedKey.value = key
    form.value.target_type = key

    await nextTick()
    const componentInstance = formComponentRef.value
    requireTarget.value = componentInstance?.requireTarget || false
}

const updateQrPreview = () => {
    if (!qrCode) return

    const dataValue = requireTarget.value
        ? `${import.meta.env.VITE_QR_BASE}/${form.value.short_code || form.value.qr_id}`
        : form.value.settings.data;

    qrCode.update({
        ...form.value.settings,
        data: dataValue
    })
}

const selectedLabel = computed(() => {
    const found = qrTypes.find(item => item.key === selectedKey.value)
    return found ? found.label : ''
})

const formComponent = computed(() => {
    return formMap[selectedKey.value] || null
})

const form = ref({
    target_type: '',
    target_id: null,
    qr_name: '',
    settings: {
        width: 300,
        height: 300,
        margin: 0,
        data: '',
        dotsOptions: {
            color: '#800053',
            type: 'extra-rounded'
        },
        cornersSquareOptions: {
            type: 'extra-rounded',
            color: '#000000'
        },
        cornersDotOptions: {
            type: 'dot',
            color: '#000000'
        },
        backgroundOptions: {
            color: '#eeeeee'
        },
        imageOptions: {
            imageSize: 0.4,
            hideBackgroundDots: true,
            margin: 0
        },
        qrOptions: {
            typeNumber: 0,
            mode: 'Byte',
            errorCorrectionLevel: 'Q'
        },
        image: ''
    }
})

const qrRef = ref(null)
let qrCode = null

watch(form, () => {
    if (!qrCode || !form.value.short_code) return
    updateQrPreview()

    const config = {
        ...form.value.settings,
        data: `${import.meta.env.VITE_QR_BASE}/${form.value.qr_id}`
    };


    qrCode.update(config)
}, { deep: true })



const generateUniqueQrId = () => {
    return Math.random().toString(36).substring(2, 10)
}

const handleSubmit = async () => {
    if (requireTarget.value) {
        if (!form.value.target_id) {
            message.warning('Vui lòng chọn đối tượng trước')
            return
        }
    } else {
        if (!form.value.settings?.data) {
            message.warning('Vui lòng nhập nội dung QR')
            return
        }
    }


    // Tạo qr_id nếu chưa có (chỉ khi tạo mới)
    if (!isEditMode.value && !form.value.qr_id) {
        form.value.qr_id = generateUniqueQrId()
    }

    const payload = {
        ...form.value,
        target_type: selectedKey.value,
        qr_url: requireTarget.value
            ? `${QR_BASE_URL}/${form.value.qr_id || 'placeholder'}`
            : form.value.settings.data,
        settings_json: JSON.stringify(form.value.settings)
    }

    try {
        if (isEditMode.value) {
            await updateQR(route.params.qr_id, payload)
            message.success('Cập nhật mã QR thành công!')
            updateQrPreview() // 👈 cập nhật preview động

            // ✅ Cập nhật QR preview đúng kiểu
            qrCode.update({
                ...form.value.settings,
                data: requireTarget.value
                    ? `${QR_BASE_URL}/${form.value.short_code || form.value.qr_id}`
                    : form.value.settings.data
            })

        } else {
            const res = await createQR(payload)
            const createdQrId = res.data?.qr_id
            const createdShortCode = res.data?.short_code

            message.success('Tạo mã QR thành công!')
            form.value.qr_id = createdQrId
            form.value.short_code = createdShortCode

            // ✅ Cập nhật QR preview đúng kiểu

            qrCode.update({
                ...form.value.settings,
                data: requireTarget.value
                    ? `${QR_BASE_URL}/${form.value.short_code || form.value.qr_id}`
                    : form.value.settings.data
            })
            updateQrPreview() // 👈 cập nhật preview động
            router.push(`/my-qr-codes/${createdQrId}/edit`)
        }

    } catch (err) {
        console.error('Lỗi:', err.response?.data || err.message)
        message.error(isEditMode.value ? 'Cập nhật thất bại!' : 'Tạo mã QR thất bại!')
    }
}


onMounted(async () => {
    if (isEditMode.value) {
        try {
            const res = await getQR(route.params.qr_id)
            const data = res.data?.data

            if (data) {
                form.value = {
                    ...form.value,
                    ...data,
                    target_id: Number(data.target_id),
                    settings: typeof data.settings_json === 'string'
                        ? JSON.parse(data.settings_json)
                        : (data.settings_json || form.value.settings)
                }

                if (form.value.settings?.image) {
                    logoFile.value = {
                        uid: Date.now().toString(),
                        name: form.value.settings.image.split('/').pop(),
                        status: 'done',
                        url: form.value.settings.image,
                    }
                }

                await selectItem(data.target_type || 'url')
            }
        } catch (err) {
            message.error('Không thể tải thông tin mã QR')
        }
    } else {
        // 👇 Tạo mã qr_id tạm để dùng cho preview QR
        form.value.qr_id = generateUniqueQrId()
    }

    // ✅ Init QR code sau khi đã có qr_id
    qrCode = new QRCodeStyling({
        ...form.value.settings,
        data: requireTarget.value
            ? `${QR_BASE_URL}/${form.value.qr_id || 'placeholder'}`
            : form.value.settings.data
    })

    qrCode.append(qrRef.value)
})

const goBackToList = () => {
    router.push({
        path: '/my-qr-codes',
        query: {
            ...route.query // giữ nguyên page, search, type
        }
    })
}

</script>

<style>
    .qr_code_image .ant-card-body{
        text-align: center;
    }
    .btn_save_qr_code {
        width: 150px !important;
    }
    .preview {
        margin-bottom: 24px;
    }

    .preview canvas {
        width: 100%;
    }
    .qr_code_image .ant-card-head-title {
        text-align: center;
        width: 100%;
    }
    .content_box .ant-page-header {
        padding-top: 0;
        padding-left: 0;
        padding-right: 0;
    }
</style>

<style scoped>
    .item-selector {
        display: flex;
        gap: 32px;
        padding: 12px 0;
    }

    .item {
        position: relative;
        text-align: center;
        cursor: pointer;
        color: #333;
        transition: all 0.3s;
    }

    .item .icon {
        font-size: 32px;
        padding: 8px;
        border: 2px solid transparent;
        border-radius: 50%;
    }

    .item .label {
        margin-top: 4px;
        font-size: 14px;
    }

    .item.active .icon {
        border-color: #52c41a;
        color: #52c41a;
    }

    .item.active .label {
        color: #52c41a;
    }

    .badge {
        position: absolute;
        top: -14px;
        right: -14px;
        background: #52c41a;
        color: white;
        font-size: 10px;
        padding: 0 6px;
        border-radius: 5px;
        white-space: nowrap;
        font-weight: 700;
    }

    .btn_download {
        margin-top: 24px;
    }
</style>
