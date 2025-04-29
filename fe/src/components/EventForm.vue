<template>
    <div>
        <!-- Nút quay lại -->
        <a-button type="default" @click="goBack" style="margin-bottom: 16px">
            Quay lại danh sách
        </a-button>

        <a-tabs default-active-key="info">
            <a-tab-pane key="info" tab="Thông tin sự kiện">
                <!-- Bổ sung form đầy đủ các trường đã có trong bảng `events` -->
                <a-form :model="form" layout="vertical" @finish="handleSubmit">
                    <a-card style="margin-bottom: 24px" class="bg_card_gray ">
                        <a-row :gutter="24">
                            <!-- Cột trái -->
                            <a-col :xs="24" :md="12">

                                <!-- Ảnh banner -->
                                <a-card class="mb_24">
                                    <a-form-item label="Ảnh banner">
                                        <a-upload
                                                list-type="picture-card"
                                                :file-list="bannerFileList"
                                                :on-preview="handlePreview"
                                                :on-remove="() => handleRemoveFile('banner')"
                                                :before-upload="file => handleBeforeUpload('banner', file)"
                                        >
                                            <div>
                                                <upload-outlined />
                                                <div style="margin-top: 8px">Upload</div>
                                            </div>
                                        </a-upload>
                                    </a-form-item>

                                    <!-- Hình ảnh -->
                                    <a-form-item label="Ảnh sự kiện">
                                        <a-upload
                                                list-type="picture-card"
                                                :file-list="imagesFileList"
                                                :on-preview="handlePreview"
                                                :on-remove="() => handleRemoveFile('images')"
                                                :before-upload="file => handleBeforeUpload('images', file)"
                                        >
                                            <div>
                                                <upload-outlined />
                                                <div style="margin-top: 8px">Upload</div>
                                            </div>
                                        </a-upload>
                                    </a-form-item>

                                    <!-- Video -->
                                    <a-form-item label="Video">
                                        <a-upload
                                                list-type="picture-card"
                                                :file-list="videoFileList"
                                                :on-preview="handlePreview"
                                                :on-remove="() => handleRemoveFile('video')"
                                                :before-upload="file => handleBeforeUpload('video', file)"
                                        >
                                            <div>
                                                <upload-outlined />
                                                <div style="margin-top: 8px">Upload</div>
                                            </div>
                                        </a-upload>
                                        <ImageUploader />
                                    </a-form-item>
                                </a-card>

                                <!-- Tên sự kiện -->
                               <a-card class="mb_24">
                                   <a-form-item label="Tên sự kiện" required>
                                       <a-input v-model:value="form.name" placeholder="Nhập tên sự kiện" />
                                   </a-form-item>

                                   <!-- Địa điểm -->
                                   <a-form-item label="Địa điểm tổ chức">
                                       <a-input v-model:value="form.location" />
                                   </a-form-item>
                               </a-card>

                                <!-- Định dạng -->
                                <a-card class="mb_24">
                                    <a-form-item label="Định dạng">
                                        <a-radio-group v-model:value="form.event_mode">
                                            <a-radio value="online">Trực tuyến</a-radio>
                                            <a-radio value="offline">Ngoại tuyến</a-radio>
                                        </a-radio-group>
                                    </a-form-item>
                                </a-card>

                                <!-- Vé -->
                                <a-card class="mb_24">
                                    <a-form-item label="Tùy chọn vé">
                                        <a-textarea v-model:value="form.ticket_options" placeholder="Nhập thông tin vé dạng JSON hoặc mô tả..." />
                                    </a-form-item>
                                </a-card>

                                <!-- Mạng xã hội -->
                                <a-card class="mb_24">
                                    <a-form-item label="Liên kết MXH">
                                        <a-textarea
                                                v-model:value="form.social_links"
                                                placeholder='Ví dụ: {"facebook": "https://facebook.com/yourpage"}'
                                        />
                                    </a-form-item>
                                </a-card>

                                <!-- Trạng thái -->
                                <a-card>
                                    <a-form-item label="Trạng thái">
                                        <a-switch v-model:checked="form.is_enabled" checked-children="Bật" un-checked-children="Tắt" />
                                    </a-form-item>
                                </a-card>

                            </a-col>

                            <!-- Cột phải -->
                            <a-col :xs="24" :md="12">

                                <!-- Thời gian bắt đầu -->
                               <a-card class="mb_24">
                                   <a-form-item label="Thời gian bắt đầu">
                                       <a-date-picker show-time v-model:value="form.start_time" style="width: 100%" />
                                   </a-form-item>

                                   <!-- Thời gian kết thúc -->
                                   <a-form-item label="Thời gian kết thúc">
                                       <a-date-picker show-time v-model:value="form.end_time" style="width: 100%" />
                                   </a-form-item>
                               </a-card>

                                <!-- Mô tả -->
                                <a-card class="mb_24">
                                    <a-form-item label="Mô tả">
                                        <a-textarea v-model:value="form.description" :rows="4" />
                                    </a-form-item>
                                </a-card>

                                <!-- Quốc gia -->
                                <a-card class="mb_24">
                                    <a-form-item label="Quốc gia">
                                        <a-input v-model:value="form.country" />
                                    </a-form-item>

                                    <!-- Thành phố -->
                                    <a-form-item label="Thành phố">
                                        <a-input v-model:value="form.city" />
                                    </a-form-item>

                                    <!-- Quận/Huyện -->
                                    <a-form-item label="Quận/Huyện">
                                        <a-input v-model:value="form.district" />
                                    </a-form-item>

                                    <!-- Thông tin liên hệ -->
                                    <a-form-item label="Họ">
                                        <a-input v-model:value="form.contact_first_name" />
                                    </a-form-item>
                                    <a-form-item label="Tên">
                                        <a-input v-model:value="form.contact_last_name" />
                                    </a-form-item>
                                    <a-form-item label="Số điện thoại">
                                        <a-input v-model:value="form.contact_phone" />
                                    </a-form-item>
                                    <a-form-item label="Email">
                                        <a-input v-model:value="form.contact_email" />
                                    </a-form-item>
                                </a-card>

                            </a-col>
                        </a-row>
                    </a-card>

                    <!-- Nút hành động -->
                    <a-form-item>
                        <a-space>
                            <a-button type="primary" html-type="submit">Lưu</a-button>
                            <a-button @click="goBack">Huỷ</a-button>
                        </a-space>
                    </a-form-item>
                </a-form>

            </a-tab-pane>
            <a-tab-pane key="settings" tab="Cài đặt hiển thị">
            </a-tab-pane>
        </a-tabs>

        <!-- Modal xem ảnh -->
        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" alt="Preview" style="width: 100%"/>
        </a-modal>
    </div>
</template>

// File: EventForm.vue
<script setup>
    import {ref, onMounted} from 'vue'
    import {useRoute, useRouter} from 'vue-router'
    import {createEvent, updateEvent, getEvent} from '../api/event'
    import {uploadFile} from '../api/product'
    import {message} from 'ant-design-vue'
    import {UploadOutlined} from '@ant-design/icons-vue'
    import dayjs from 'dayjs'
    import {useUserStore} from '../stores/user'
    import ImageUploader from './ImageUploader.vue' // đường dẫn đúng tới file bạn lưu

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
        description: '',
        event_mode: 'online',
        is_enabled: true,
        contact_first_name: '',
        contact_last_name: '',
        contact_phone: '',
        contact_email: '',
        video: '',
        ticket_options: '',
        social_links: '',
        images: []
    })

    const bannerFileList = ref([])
    const imagesFileList = ref([])
    const videoFileList = ref([])
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
                bannerFileList.value = [{uid: '1', name: 'banner.jpg', status: 'done', url: form.value.banner}]
            }
            if (form.value.video) {
                videoFileList.value = [{uid: '1', name: 'video.mp4', status: 'done', url: form.value.video}]
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

    const handleBeforeUpload = async (field, file) => {
        const hide = message.loading('Đang tải lên...', 0)
        try {
            const response = await uploadFile(file)
            const url = response.data.url
            form.value[field] = url

            if (field === 'banner') {
                bannerFileList.value = [{uid: Date.now(), name: file.name, status: 'done', url}]
            }  else if (field === 'images') {
                imagesFileList.value = [{uid: Date.now(), name: file.name, status: 'done', url}]
            }else if (field === 'video') {
                videoFileList.value = [{uid: Date.now(), name: file.name, status: 'done', url}]
            }

            message.success('Upload thành công')
        } catch (error) {
            message.error('Upload thất bại')
        } finally {
            hide()
        }
        return false
    }

    const handleRemoveFile = (field) => {
        form.value[field] = ''
        if (field === 'banner') bannerFileList.value = []
        if (field === 'images') imagesFileList.value = []
        if (field === 'video') videoFileList.value = []
    }

    const handlePreview = (file) => {
        previewImage.value = file.url || file.thumbUrl
        previewVisible.value = true
        previewTitle.value = file.name || ''
    }

    const goBack = () => router.push('/events')

    onMounted(() => {
        if (isEditMode) fetchEvent()
    })
</script>

<style>
    .mb_24 {
        margin-bottom: 24px;
    }

    .bg_card_gray {
        background: #f3f4f5;
    }

</style>
