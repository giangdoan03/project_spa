<template>
    <div>
        <a-form :model="form" layout="vertical" @finish="handleSubmit">
            <!-- Ảnh đại diện -->
            <a-form-item label="Ảnh đại diện của sản phẩm">
                <a-upload
                    list-type="picture-card"
                    :file-list="avatarFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('avatar', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('avatar', file)"
                    multiple
                >
                    <div>
                        <upload-outlined />
                        <div style="margin-top: 8px">Upload</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Ảnh sản phẩm -->
            <a-form-item label="Ảnh sản phẩm">
                <a-upload
                    list-type="picture-card"
                    :file-list="imageFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('image', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('image', file)"
                    multiple
                >
                    <div>
                        <upload-outlined />
                        <div style="margin-top: 8px">Upload</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Video sản phẩm -->
            <a-form-item label="Video giới thiệu sản phẩm">
                <a-upload
                    list-type="picture-card"
                    :file-list="videoFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('video', file)"
                    :before-upload="(file) => handleBeforeUploadMultiple('video', file)"
                    multiple
                >
                    <div>
                        <upload-outlined />
                        <div style="margin-top: 8px">Upload</div>
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
                    <a-button>Upload</a-button>
                </a-upload>
            </a-form-item>

            <!-- SKU -->
            <a-form-item label="Mã sản phẩm (SKU)">
                <a-input v-model:value="form.sku" placeholder="Mã sản phẩm (SKU)" />
            </a-form-item>

            <!-- Tên sản phẩm -->
            <a-form-item label="Tên sản phẩm" :rules="[{ required: true, message: 'Nhập tên sản phẩm' }]">
                <a-input v-model:value="form.name" placeholder="Tên sản phẩm" />
            </a-form-item>

            <!-- Danh mục -->
            <a-form-item label="Danh mục">
                <a-select v-model:value="form.category_id" placeholder="Chọn danh mục">
                    <a-select-option v-for="category in categories" :key="category.id" :value="category.id">
                        {{ category.name }}
                    </a-select-option>
                </a-select>
            </a-form-item>

            <!-- Giá bán -->
            <a-form-item label="Giá bán">
                <a-radio-group v-model:value="priceMode">
                    <a-radio :value="'single'">Nhập 1 giá</a-radio>
                    <a-radio :value="'range'">Nhập khoảng giá</a-radio>
                </a-radio-group>

                <div v-if="priceMode === 'single'" style="margin-top: 10px;">
                    <a-input-number v-model:value="form.price" style="width: 100%" placeholder="Nhập giá bán" />
                </div>

                <div v-if="priceMode === 'range'" style="margin-top: 10px; display: flex; gap: 8px;">
                    <a-input-number v-model:value="form.price_from" style="width: 100%" placeholder="Giá từ" />
                    <a-input-number v-model:value="form.price_to" style="width: 100%" placeholder="Giá đến" />
                </div>

                <a-checkbox v-model:checked="form.show_contact_price" style="margin-top: 10px;">
                    Hiển thị 'Liên hệ báo giá' nếu không có thông tin giá bán
                </a-checkbox>
            </a-form-item>

            <!-- Mô tả sản phẩm -->
            <a-form-item label="Mô tả sản phẩm">
                <a-textarea v-model:value="form.description" :rows="4" placeholder="Mô tả sản phẩm" />
            </a-form-item>

            <!-- Thuộc tính sản phẩm -->
            <a-form-item label="Tiêu đề thuộc tính">
                <div v-for="(attr, index) in form.attributes" :key="index" style="margin-bottom: 8px; display: flex;">
                    <a-input v-model:value="attr.name" placeholder="Tên thuộc tính" style="margin-right: 8px;" />
                    <a-input v-model:value="attr.value" placeholder="Giá trị" style="margin-right: 8px;" />
                    <a-button type="link" danger @click="removeAttribute(index)">Xoá</a-button>
                </div>
                <a-button type="dashed" block @click="addAttribute">Thêm thuộc tính</a-button>
            </a-form-item>

            <!-- Trạng thái -->
            <a-form-item label="Trạng thái">
                <a-switch v-model:checked="form.status" checked-children="Bật" un-checked-children="Tắt" />
            </a-form-item>

            <!-- Nút hành động -->
            <a-form-item>
                <a-space>
                    <a-button type="primary" html-type="submit" :loading="loading">Lưu</a-button>
                    <a-button @click="goBack">Huỷ</a-button>
                </a-space>
            </a-form-item>
        </a-form>

        <!-- Modal xem ảnh to -->
        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" alt="Preview" style="width: 100%" />
        </a-modal>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { createProduct, getProduct, updateProduct } from '../api/product'
import { getCategories } from '../api/category'
import { message } from 'ant-design-vue'
import { UploadOutlined } from '@ant-design/icons-vue'
import { uploadFile } from '../api/product'

import { normalizeProductData } from '../utils/formUtils'

const route = useRoute()
const router = useRouter()

const loading = ref(false)
const form = ref({
    name: '',
    sku: '',
    category_id: null,
    price: null,
    price_from: null,
    price_to: null,
    show_contact_price: false,
    avatar: [],
    image: [],
    video: [],
    certificate_file: [],
    description: '',
    attributes: [],
    status: true,
})

const categories = ref([])
const priceMode = ref('single')

// File lists
const avatarFileList = ref([])
const imageFileList = ref([])
const videoFileList = ref([])
const certificateFileList = ref([])

// Preview modal
const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const isEditMode = !!route.params.id

// Load categories
const fetchCategories = async () => {
    const response = await getCategories()
    categories.value = response.data
}

// Load product data when edit
// ✅ Sau đó sửa fetchProduct thành:
const fetchProduct = async () => {
    try {
        const response = await getProduct(route.params.id)
        const data = normalizeProductData(response.data)

        Object.assign(form.value, data)

        priceMode.value = data.price_from || data.price_to ? 'range' : 'single'

        const fieldsToParse = ['avatar', 'image', 'video', 'certificate_file']
        fieldsToParse.forEach(field => {
            if (form.value[field] && form.value[field].length) {
                const files = form.value[field]
                files.forEach(url => updateFileList(field, url))
            }
        })
    } catch (error) {
        message.error('Không tìm thấy sản phẩm')
    }
}


// Update file list
const updateFileList = (field, url) => {
    const file = {
        uid: Date.now() + Math.random(),
        name: url.split('/').pop(),
        status: 'done',
        url,
    }
    switch (field) {
        case 'avatar':
            avatarFileList.value.push(file)
            break
        case 'image':
            imageFileList.value.push(file)
            break
        case 'video':
            videoFileList.value.push(file)
            break
        case 'certificate_file':
            certificateFileList.value.push(file)
            break
    }
}

// Upload multiple files
const handleBeforeUploadMultiple = async (field, file) => {
    const hide = message.loading('Đang tải lên...', 0)

    try {
        const response = await uploadFile(file)
        const url = response.data.url

        if (!Array.isArray(form.value[field])) {
            form.value[field] = []
        }

        form.value[field].push(url)
        updateFileList(field, url)

        message.success('Tải lên thành công!')
    } catch (error) {
        message.error('Tải lên thất bại!')
    } finally {
        hide()
    }

    // Không upload mặc định
    return false
}

// Remove file
const handleRemoveFile = (field, file) => {
    form.value[field] = form.value[field].filter(url => url !== file.url)
    switch (field) {
        case 'avatar':
            avatarFileList.value = avatarFileList.value.filter(item => item.url !== file.url)
            break
        case 'image':
            imageFileList.value = imageFileList.value.filter(item => item.url !== file.url)
            break
        case 'video':
            videoFileList.value = videoFileList.value.filter(item => item.url !== file.url)
            break
        case 'certificate_file':
            certificateFileList.value = certificateFileList.value.filter(item => item.url !== file.url)
            break
    }
}

// Preview modal
const handlePreview = (file) => {
    previewImage.value = file.url || file.thumbUrl
    previewVisible.value = true
    previewTitle.value = file.name || ''
}

// Reset form
const resetForm = () => {
    form.value = {
        name: '',
        sku: '',
        category_id: null,
        price: null,
        price_from: null,
        price_to: null,
        show_contact_price: false,
        avatar: [],
        image: [],
        video: [],
        certificate_file: [],
        description: '',
        attributes: [],
        status: true,
    }

    avatarFileList.value = []
    imageFileList.value = []
    videoFileList.value = []
    certificateFileList.value = []
}

// Submit form
const handleSubmit = async () => {
    // Validate ảnh sản phẩm bắt buộc
    if (!form.value.image.length) {
        message.error('Vui lòng upload ít nhất 1 ảnh sản phẩm!')
        return
    }

    loading.value = true
    try {
        if (isEditMode) {
            await updateProduct(route.params.id, form.value)
            message.success('Cập nhật sản phẩm thành công 🎉')
        } else {
            await createProduct(form.value)
            message.success('Thêm sản phẩm thành công 🎉')
            resetForm()
        }
        router.push('/products')
    } catch (error) {
        message.error('Có lỗi khi lưu sản phẩm 😢')
    } finally {
        loading.value = false
    }
}

// Attribute functions
const addAttribute = () => {
    form.value.attributes.push({ name: '', value: '' })
}

const removeAttribute = (index) => {
    form.value.attributes.splice(index, 1)
}

const goBack = () => {
    router.push('/products')
}

onMounted(() => {
    fetchCategories()
    if (isEditMode) fetchProduct()
})
</script>
