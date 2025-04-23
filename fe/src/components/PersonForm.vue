<template>
    <div>
        <!-- Nút quay lại -->
        <a-button type="default" @click="goBack" style="margin-bottom: 16px">
            Quay lại danh sách
        </a-button>
        <a-form :model="form" layout="vertical" @finish="handleSubmit">
            <!-- Ảnh đại diện -->
            <a-form-item label="Ảnh đại diện">
                <a-upload
                    list-type="picture-card"
                    :file-list="avatarFileList"
                    :on-preview="handlePreview"
                    :on-remove="(file) => handleRemoveFile('avatar', file)"
                    :before-upload="(file) => handleBeforeUpload('avatar', file)"
                >
                    <div>
                        <upload-outlined />
                        <div style="margin-top: 8px">Upload</div>
                    </div>
                </a-upload>
            </a-form-item>

            <!-- Họ tên -->
            <a-form-item label="Họ và tên" required>
                <a-input v-model:value="form.name" placeholder="Nhập họ tên" />
            </a-form-item>

            <!-- Email -->
            <a-form-item label="Email">
                <a-input v-model:value="form.email" placeholder="example@mail.com" />
            </a-form-item>

            <!-- Số điện thoại -->
            <a-form-item label="Số điện thoại">
                <a-input v-model:value="form.phone" placeholder="Nhập số điện thoại" />
            </a-form-item>

            <!-- Chức danh -->
            <a-form-item label="Chức danh">
                <a-input v-model:value="form.job_title" placeholder="VD: Giám đốc Marketing" />
            </a-form-item>

            <!-- Tiểu sử -->
            <a-form-item label="Tiểu sử">
                <a-textarea v-model:value="form.bio" :rows="4" placeholder="Giới thiệu ngắn gọn về cá nhân..." />
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
import { createPerson, updatePerson, getPerson } from '../api/person'
import { uploadFile } from '../api/product'
import { message } from 'ant-design-vue'
import { UploadOutlined } from '@ant-design/icons-vue'

import { useUserStore } from '../stores/user'

const userStore = useUserStore()

const route = useRoute()
const router = useRouter()
const isEditMode = !!route.params.id

const form = ref({
    user_id: null, // 👈 Thêm dòng này
    name: '',
    email: '',
    phone: '',
    job_title: '',
    bio: '',
    avatar: ''
})

const avatarFileList = ref([])
const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const fetchPerson = async () => {
    try {
        const response = await getPerson(route.params.id)
        Object.assign(form.value, response.data)

        if (form.value.avatar) {
            avatarFileList.value = [
                {
                    uid: '1',
                    name: 'avatar.jpg',
                    status: 'done',
                    url: form.value.avatar
                }
            ]
        }
    } catch (error) {
        message.error('Không tìm thấy thông tin cá nhân')
    }
}

const handleSubmit = async () => {
    try {
        form.value.user_id = userStore.user?.id // 👈 Lấy user_id trước khi gửi

        if (isEditMode) {
            await updatePerson(route.params.id, form.value)
            message.success('Cập nhật thành công')
        } else {
            await createPerson(form.value)
            message.success('Tạo mới thành công')
        }

        router.push('/persons')
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
        form.value.avatar = url
        avatarFileList.value = [
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
    form.value.avatar = ''
    avatarFileList.value = []
}

const goBack = () => router.push('/persons')

onMounted(() => {
    if (isEditMode) {
        fetchPerson()
    }
})
</script>

<style scoped></style>