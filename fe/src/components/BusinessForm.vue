<!-- BusinessForm.vue -->
<template>
    <div>
        <a-form :model="form" layout="vertical" @finish="handleSubmit">

            <!-- Ảnh đại diện / Logo (chỉ 1 ảnh) -->
            <a-form-item label="Ảnh đại diện / Ảnh logo">
                <a-upload
                    list-type="picture-card"
                    :file-list="logoFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('logo', file)"
                    :before-upload="(file) => handleBeforeUploadSingle('logo', file)"
                    :max-count="1"
                >
                    <div v-if="logoFileList.length === 0">
                        <upload-outlined/>
                        <div style="margin-top: 8px">Ảnh</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Ảnh bìa -->
            <a-form-item label="Ảnh bìa">
                <a-upload
                    list-type="picture-card"
                    :file-list="coverFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('cover_image', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('cover_image', file)"
                    multiple
                >
                    <div>
                        <upload-outlined/>
                        <div style="margin-top: 8px">Ảnh</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Thư viện ảnh -->
            <a-form-item label="Thư viện ảnh">
                <a-upload
                    list-type="picture-card"
                    :file-list="libraryFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('library_images', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('library_images', file)"
                    multiple
                >
                    <div>
                        <upload-outlined/>
                        <div style="margin-top: 8px">Ảnh</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Video giới thiệu -->
            <a-form-item label="Video giới thiệu">
                <a-upload
                    list-type="picture-card"
                    :file-list="videoFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('video_intro', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('video_intro', file)"
                    multiple
                >
                    <div>
                        <upload-outlined/>
                        <div style="margin-top: 8px">Video</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Chứng chỉ -->
            <a-form-item label="Chứng chỉ, chứng nhận">
                <a-upload
                    :file-list="certificateFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('certificate_file', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('certificate_file', file)"
                    multiple
                >
                    <a-button icon="upload">Tải lên</a-button>
                </a-upload>
            </a-form-item>

            <!-- Các trường thông tin khác (giữ nguyên bạn đã làm tốt) -->
            <a-form-item label="Tên Doanh nghiệp">
                <a-input v-model:value="form.name" placeholder="Nhập tên doanh nghiệp"/>
            </a-form-item>

            <a-form-item label="Mã số thuế">
                <a-input v-model:value="form.tax_code" placeholder="Mã số thuế"/>
            </a-form-item>

            <a-form-item label="Quốc gia">
                <a-input v-model:value="form.country" placeholder="Quốc gia"/>
            </a-form-item>

            <a-form-item label="Tỉnh thành">
                <a-input v-model:value="form.city" placeholder="Tỉnh thành"/>
            </a-form-item>

            <a-form-item label="Quận huyện">
                <a-input v-model:value="form.district" placeholder="Quận huyện"/>
            </a-form-item>

            <a-form-item label="Phường xã">
                <a-input v-model:value="form.ward" placeholder="Phường xã"/>
            </a-form-item>

            <a-form-item label="Địa chỉ chi tiết">
                <a-input v-model:value="form.address" placeholder="Địa chỉ chi tiết"/>
            </a-form-item>

            <a-form-item label="Số điện thoại">
                <a-input v-model:value="form.phone" placeholder="Số điện thoại"/>
            </a-form-item>

            <a-form-item label="Email">
                <a-input v-model:value="form.email" placeholder="Email"/>
            </a-form-item>

            <a-form-item label="Website">
                <a-input v-model:value="form.website" placeholder="Website"/>
            </a-form-item>

            <a-form-item label="Mô tả doanh nghiệp">
                <a-textarea v-model:value="form.description" :rows="4" placeholder="Mô tả doanh nghiệp"/>
            </a-form-item>

            <a-form-item label="Nghề nghiệp">
                <a-input v-model:value="form.career" placeholder="Nghề nghiệp"/>
            </a-form-item>

            <a-form-item label="Facebook">
                <a-input v-model:value="form.facebook_link" placeholder="Link Facebook"/>
            </a-form-item>

            <a-form-item label="Thêm liên kết">
                <a-textarea v-model:value="otherLinksText" :rows="3" placeholder="Mỗi dòng 1 liên kết"/>
            </a-form-item>

            <a-form-item label="Trạng thái">
                <a-switch v-model:checked="form.status" checked-children="Bật" un-checked-children="Tắt"/>
            </a-form-item>

            <a-form-item>
                <a-space>
                    <a-button type="primary" html-type="submit" :loading="loading">Lưu</a-button>
                    <a-button @click="goBack">Huỷ</a-button>
                </a-space>
            </a-form-item>
        </a-form>

        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" alt="Preview" style="width: 100%"/>
        </a-modal>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { createBusiness, getBusiness, updateBusiness } from '../api/business'
import { uploadFile } from '../api/product'
import { message } from 'ant-design-vue'
import { UploadOutlined } from '@ant-design/icons-vue'

const router = useRouter()
const route = useRoute()
const loading = ref(false)
const isEditMode = !!route.params.id
const otherLinksText = ref('')

const form = ref({
    name: '', tax_code: '', country: '', city: '', district: '', ward: '', address: '',
    phone: '', email: '', website: '', description: '', career: '', facebook_link: '',
    other_links: '', logo: [], cover_image: [], library_images: [], video_intro: [],
    certificate_file: [], status: true,
})

// File lists
const logoFileList = ref([])
const coverFileList = ref([])
const libraryFileList = ref([])
const videoFileList = ref([])
const certificateFileList = ref([])

// Modal preview
const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

// Fetch data if edit mode
const fetchBusiness = async () => {
    try {
        const { data } = await getBusiness(route.params.id)
        Object.assign(form.value, data)

        otherLinksText.value = Array.isArray(data.other_links)
            ? data.other_links.join('\n')
            : (data.other_links || '')

        const loadFileList = (field, list) => {
            let files = typeof list === 'string' ? JSON.parse(list) : list
            if (!Array.isArray(files)) files = [files]
            files.forEach(url => updateFileList(field, url))
        }

        ['logo', 'cover_image', 'library_images', 'video_intro', 'certificate_file'].forEach(field => {
            if (form.value[field]) loadFileList(field, form.value[field])
        })

    } catch (error) {
        message.error('Không tìm thấy doanh nghiệp')
    }
}

// Update file list
const updateFileList = (field, url) => {
    const file = { uid: Date.now() + Math.random(), name: url.split('/').pop(), status: 'done', url }
    switch (field) {
        case 'logo': logoFileList.value = [file]; break
        case 'cover_image': coverFileList.value.push(file); break
        case 'library_images': libraryFileList.value.push(file); break
        case 'video_intro': videoFileList.value.push(file); break
        case 'certificate_file': certificateFileList.value.push(file); break
    }
}

// Upload handler for single file (logo)
const handleBeforeUploadSingle = async (field, file) => {
    const { data } = await uploadFile(file)
    form.value[field] = [data.url]
    updateFileList(field, data.url)
    return false
}

// Upload handler for multiple files
const handleBeforeUploadMultiple = async (field, file) => {
    const { data } = await uploadFile(file)
    if (!Array.isArray(form.value[field])) form.value[field] = []
    form.value[field].push(data.url)
    updateFileList(field, data.url)
    return false
}

// Remove file handler
const handleRemoveFile = (field, file) => {
    form.value[field] = form.value[field].filter(url => url !== file.url)
    const updateList = list => list.value = list.value.filter(item => item.url !== file.url)
    switch (field) {
        case 'logo': updateList(logoFileList); break
        case 'cover_image': updateList(coverFileList); break
        case 'library_images': updateList(libraryFileList); break
        case 'video_intro': updateList(videoFileList); break
        case 'certificate_file': updateList(certificateFileList); break
    }
}

// Preview modal
const handlePreview = (file) => {
    previewImage.value = file.url || file.thumbUrl
    previewVisible.value = true
    previewTitle.value = file.name || ''
}

// Submit form
const handleSubmit = async () => {
    loading.value = true

    // ✅ Chuyển từ textarea (dạng chuỗi) thành mảng
    form.value.other_links = otherLinksText.value
        .split('\n')                   // tách từng dòng
        .map(s => s.trim())            // xóa khoảng trắng đầu/cuối
        .filter(Boolean)               // bỏ dòng rỗng

    try {
        if (isEditMode) {
            await updateBusiness(route.params.id, form.value)
            message.success('Cập nhật thành công')
        } else {
            await createBusiness(form.value)
            message.success('Tạo mới thành công')
        }
        router.push('/businesses')
    } catch (error) {
        message.error('Lỗi lưu doanh nghiệp')
    } finally {
        loading.value = false
    }
}


const goBack = () => router.push('/businesses')

onMounted(() => { if (isEditMode) fetchBusiness() })
</script>
