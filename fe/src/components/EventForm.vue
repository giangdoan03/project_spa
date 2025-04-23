<template>
    <div>
        <!-- Nút quay lại -->
        <a-button type="default" @click="goBack" style="margin-bottom: 16px">
            Quay lại danh sách
        </a-button>

        <a-form :model="form" layout="vertical" @finish="handleSubmit">
            <!-- Banner -->
            <a-form-item label="Ảnh banner">
                <a-upload
                    list-type="picture-card"
                    :file-list="bannerFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('banner', file)"
                    :before-upload="(file) => handleBeforeUpload('banner', file)"
                >
                    <div>
                        <upload-outlined />
                        <div style="margin-top: 8px">Upload</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Tên sự kiện -->
            <a-form-item label="Tên sự kiện" required>
                <a-input v-model:value="form.name" placeholder="Nhập tên sự kiện" />
            </a-form-item>

            <!-- Địa điểm -->
            <a-form-item label="Địa điểm">
                <a-input v-model:value="form.location" placeholder="Nhập địa điểm tổ chức" />
            </a-form-item>

            <!-- Thời gian -->
            <a-form-item label="Thời gian bắt đầu">
                <a-date-picker show-time v-model:value="form.start_time" style="width: 100%" />
            </a-form-item>
            <a-form-item label="Thời gian kết thúc">
                <a-date-picker show-time v-model:value="form.end_time" style="width: 100%" />
            </a-form-item>

            <!-- Mô tả -->
            <a-form-item label="Mô tả sự kiện">
                <a-textarea v-model:value="form.description" :rows="4" placeholder="Mô tả chi tiết về sự kiện..." />
            </a-form-item>

            <!-- Nút hành động -->
            <a-form-item>
                <a-space>
                    <a-button type="primary" html-type="submit">Lưu</a-button>
                    <a-button @click="goBack">Huỷ</a-button>
                </a-space>
            </a-form-item>
        </a-form>

        <!-- Modal xem ảnh -->
        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" alt="Preview" style="width: 100%" />
        </a-modal>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { createEvent, updateEvent, getEvent } from '../api/event'
import { uploadFile } from '../api/product'
import { message } from 'ant-design-vue'
import { UploadOutlined } from '@ant-design/icons-vue'
import dayjs from 'dayjs'
import { useUserStore } from '../stores/user'

const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const isEditMode = !!route.params.id

const form = ref({
    user_id: null,
    name: '',
    banner: '',
    location: '',
    start_time: null,
    end_time: null,
    description: ''
})

const bannerFileList = ref([])
const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const fetchEvent = async () => {
    try {
        const response = await getEvent(route.params.id)
        Object.assign(form.value, response.data)
        if (form.value.start_time) form.value.start_time = dayjs(form.value.start_time)
        if (form.value.end_time) form.value.end_time = dayjs(form.value.end_time)

        if (form.value.banner) {
            bannerFileList.value = [
                {
                    uid: '1',
                    name: 'banner.jpg',
                    status: 'done',
                    url: form.value.banner
                }
            ]
        }
    } catch (error) {
        message.error('Không tìm thấy thông tin sự kiện')
    }
}

const handleSubmit = async () => {
    try {
        form.value.user_id = userStore.user?.id
        if (isEditMode) {
            await updateEvent(route.params.id, form.value)
            message.success('Cập nhật sự kiện thành công')
        } else {
            await createEvent(form.value)
            message.success('Tạo sự kiện thành công')
        }
        router.push('/events')
    } catch (error) {
        message.error('Có lỗi xảy ra')
    }
}

const handlePreview = (file) => {
    previewImage.value = file.url || file.thumbUrl
    previewVisible.value = true
    previewTitle.value = file.name || ''
}

const handleBeforeUpload = async (field, file) => {
    const hide = message.loading('Đang tải lên...', 0)
    try {
        const response = await uploadFile(file)
        const url = response.data.url
        form.value[field] = url
        bannerFileList.value = [
            {
                uid: Date.now(),
                name: file.name,
                status: 'done',
                url
            }
        ]
        message.success('Upload thành công')
    } catch (error) {
        message.error('Upload thất bại')
    } finally {
        hide()
    }
    return false
}

const handleRemoveFile = () => {
    form.value.banner = ''
    bannerFileList.value = []
}

const goBack = () => router.push('/events')

onMounted(() => {
    if (isEditMode) {
        fetchEvent()
    }
})
</script>

<style scoped></style>
