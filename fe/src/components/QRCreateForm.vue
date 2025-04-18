<template>
    <div>
        <a-page-header title="Tạo mã QR" @back="router.back()" />

        <a-form layout="vertical" @submit.prevent="handleSubmit">
            <a-row :gutter="16">
                <a-col :span="8">
                    <a-form-item label="Loại đối tượng">
                        <a-select v-model:value="form.target_type" placeholder="Chọn loại" @change="loadTargetList">
                            <a-select-option value="product">Sản phẩm</a-select-option>
                            <a-select-option value="store">Cửa hàng</a-select-option>
                            <a-select-option value="event">Sự kiện</a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
                <a-col :span="8">
                    <a-form-item label="Chọn đối tượng">
                        <a-select v-model:value="form.target_id" :disabled="targetList.length === 0" placeholder="Chọn đối tượng">
                            <a-select-option v-for="item in targetList" :key="item.id" :value="item.id">
                                {{ item.name }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
                <a-col :span="8">
                    <a-form-item label="Tên mã QR (tuỳ chọn)">
                        <a-input v-model:value="form.qr_name" placeholder="VD: QR Sản phẩm A" />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="24">
                <!-- Bên trái: Tabs cấu hình -->
                <a-col :span="16">
                    <a-card title="Cấu hình mã QR" bordered>
                        <a-tabs tab-position="top">
                            <a-tab-pane key="main" tab="Main Options">
                                <a-form-item label="Chiều rộng">
                                    <a-input-number v-model:value="form.settings.width" :min="100" :step="10" style="width: 100%;" />
                                </a-form-item>
                                <a-form-item label="Chiều cao">
                                    <a-input-number v-model:value="form.settings.height" :min="100" :step="10" style="width: 100%;" />
                                </a-form-item>
                                <a-form-item label="Khoảng cách viền (margin)">
                                    <a-input-number v-model:value="form.settings.margin" :min="0" style="width: 100%;" />
                                </a-form-item>
                                <a-form-item label="Logo URL (tuỳ chọn)">
                                    <a-input v-model:value="form.settings.image" placeholder="https://logo.png" />
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
                                    <a-input type="color" v-model:value="form.settings.dotsOptions.color" />
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
                                            <a-input type="color" v-model:value="form.settings.cornersSquareOptions.color" />
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
                                            <a-input type="color" v-model:value="form.settings.cornersDotOptions.color" />
                                        </a-form-item>
                                    </a-col>
                                </a-row>
                            </a-tab-pane>

                            <a-tab-pane key="background" tab="Nền & Ảnh">
                                <a-form-item label="Màu nền">
                                    <a-input type="color" v-model:value="form.settings.backgroundOptions.color" />
                                </a-form-item>
                                <a-form-item label="Ẩn chấm nền">
                                    <a-checkbox v-model:checked="form.settings.imageOptions.hideBackgroundDots" />
                                </a-form-item>
                                <a-form-item label="Kích thước logo (0 - 1)">
                                    <a-input-number v-model:value="form.settings.imageOptions.imageSize" :min="0" :max="1" :step="0.1" />
                                </a-form-item>
                            </a-tab-pane>

                            <a-tab-pane key="qrOptions" tab="QR Code">
                                <a-form-item label="Type Number">
                                    <a-input-number v-model:value="form.settings.qrOptions.typeNumber" :min="0" />
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
                <a-col :span="8">
                    <a-card title="Xem trước mã QR" bordered>
                        <div class="preview">
                            <div ref="qrRef"></div>
                        </div>
                        <a-button type="primary" block @click="handleSubmit">Tạo và lưu QR</a-button>
                    </a-card>
                </a-col>
            </a-row>
        </a-form>
    </div>
</template>


<script setup>
import { ref, watch, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import QRCodeStyling from 'qr-code-styling'

const router = useRouter()

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

const targetList = ref([])
const qrRef = ref(null)
let qrCode = null

const loadTargetList = async () => {
    targetList.value = [
        { id: 1, name: 'Demo 1' },
        { id: 2, name: 'Demo 2' }
    ]
}

const updateQRCode = () => {
    if (!qrCode) return
    const config = {
        ...form.value.settings,
        data: `https://example.com/redirect/${form.value.target_type}/${form.value.target_id}`
    }
    qrCode.update(config)
}

watch(form, updateQRCode, { deep: true })

onMounted(() => {
    qrCode = new QRCodeStyling({
        ...form.value.settings,
        data: 'https://example.com'
    })
    qrCode.append(qrRef.value)
    loadTargetList()
})

const handleSubmit = async () => {
    if (!form.value.target_id || !form.value.target_type) {
        alert('Chọn đối tượng trước')
        return
    }

    const payload = {
        ...form.value,
        qr_url: `https://example.com/redirect/${form.value.target_type}/${form.value.target_id}`,
        settings_json: JSON.stringify(form.value.settings)
    }

    console.log('Submit payload:', payload)
    alert('Tạo thành công!')
}
</script>

<style scoped>
.preview {
    margin: 16px 0;
    border: 1px dashed #ccc;
    padding: 16px;
    display: inline-block;
}
</style>
