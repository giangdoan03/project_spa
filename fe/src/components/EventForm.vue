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
                                    <a-form-item label="Ảnh sự kiện">
                                        <ImageUploader
                                            type="image"
                                            :modelValue="form.images"
                                            @update:modelValue="val => form.images = val"
                                            @set-cover="handleSetMainImage"
                                        />
                                    </a-form-item>
                                    <a-form-item label="Bìa sự kiện">
                                        <ImageUploader
                                            type="image"
                                            :multiple="false"
                                            :modelValue="normalizeBanner(form.banner)"
                                            @update:modelValue="val => form.banner = val[0]?.url || ''"
                                        />
                                    </a-form-item>

                                    <a-form-item label="Video sự kiện">
                                        <ImageUploader
                                            type="video"
                                            :modelValue="normalizeToArray(form.video)"
                                            @update:modelValue="val => form.video = val"
                                        />
                                    </a-form-item>
                                </a-card>
                                <!-- Tên sự kiện -->
                                <a-card class="mb_24" title="Thông tin">
                                    <a-form-item label="Tên sự kiện" required>
                                        <a-input v-model:value="form.name" placeholder="Nhập tên sự kiện"/>
                                    </a-form-item>
                                    <a-form-item label="Quốc gia">
                                        <a-input v-model:value="form.country"/>
                                    </a-form-item>

                                    <!-- Thành phố -->
                                    <a-form-item label="Thành phố">
                                        <a-input v-model:value="form.city"/>
                                    </a-form-item>

                                    <!-- Quận/Huyện -->
                                    <a-form-item label="Quận/Huyện">
                                        <a-input v-model:value="form.district"/>
                                    </a-form-item>
                                    <!-- Địa điểm -->
                                    <a-form-item label="Địa điểm tổ chức">
                                        <a-input v-model:value="form.location"/>
                                    </a-form-item>
                                </a-card>
                                <a-card title="Trạng thái">
                                    <a-form-item>
                                        <a-switch v-model:checked="form.is_enabled" checked-children="Bật"
                                                  un-checked-children="Tắt"/>
                                    </a-form-item>
                                </a-card>

                            </a-col>

                            <!-- Cột phải -->
                            <a-col :xs="24" :md="12">

                                <!-- Quốc gia -->
                                <a-card class="mb_24" title="Liên hệ">
                                    <a-row :gutter="16">
                                        <a-col>
                                            <a-form-item label="Họ">
                                                <a-input v-model:value="form.contact_first_name"/>
                                            </a-form-item>
                                        </a-col>
                                        <a-col>
                                            <a-form-item label="Tên">
                                                <a-input v-model:value="form.contact_last_name"/>
                                            </a-form-item>
                                        </a-col>
                                    </a-row>
                                    <a-row :gutter="16">
                                        <a-col>
                                            <a-form-item label="Số điện thoại">
                                                <a-input v-model:value="form.contact_phone"/>
                                            </a-form-item>
                                        </a-col>
                                        <a-col>
                                            <a-form-item label="Email">
                                                <a-input v-model:value="form.contact_email"/>
                                            </a-form-item>
                                        </a-col>
                                    </a-row>
                                </a-card>
                                <a-card class="mb_24" title="Định dạng">
                                    <a-form-item>
                                        <a-radio-group v-model:value="form.event_mode">
                                            <a-radio value="online">Trực tuyến</a-radio>
                                            <a-radio value="offline">Ngoại tuyến</a-radio>
                                        </a-radio-group>
                                    </a-form-item>
                                    <a-row :gutter="16">
                                        <a-col>
                                            <a-form-item label="Thời gian bắt đầu">
                                                <a-date-picker show-time v-model:value="form.start_time"
                                                               style="width: 100%"/>
                                            </a-form-item>
                                        </a-col>
                                        <a-col>
                                            <!-- Thời gian kết thúc -->
                                            <a-form-item label="Thời gian kết thúc">
                                                <a-date-picker show-time v-model:value="form.end_time"
                                                               style="width: 100%"/>
                                            </a-form-item>
                                        </a-col>
                                    </a-row>
                                </a-card>
                                <!-- Mô tả -->
                                <a-card class="mb_24" title="Mô tả sự kiện">
                                    <div
                                        v-for="(item, index) in form.description"
                                        :key="index"
                                        class="mb-4 p-4 border border-gray-200 rounded"
                                    >
                                        <a-card class="mb_24">
                                            <a-form-item label="Tiêu đề mô tả">
                                                <a-input v-model:value="item.title" placeholder="Nhập tiêu đề mô tả"/>
                                            </a-form-item>

                                            <a-form-item label="Nội dung mô tả">
                                                <div
                                                    :ref="el => setDescriptionEditorRef(index, el)"
                                                    style="min-height: 150px; padding: 8px;"
                                                />
                                            </a-form-item>

                                            <a-button danger @click="removeDescription(index)"
                                                      v-if="form.description.length > 1">
                                                Xoá mô tả
                                            </a-button>
                                        </a-card>
                                    </div>

                                    <a-button type="dashed" block @click="addNewDescription">
                                        + Thêm mô tả
                                    </a-button>
                                </a-card>

                                <!-- Tùy chọn vé -->
                                <a-card class="mb_24" title="Mạng xã hội">
                                    <div
                                        v-for="(item, index) in form.social_links"
                                        :key="index"
                                        style="margin-bottom: 12px; overflow-x: auto"
                                    >
                                        <a-space :size="12" :wrap="false" align="center">
                                            <!-- Logo -->
                                            <ImageUploader
                                                type="image"
                                                :multiple="false"
                                                :hideUploadIfSingle="true"
                                                :modelValue="item.icon ? [item.icon] : []"
                                                @update:modelValue="val => item.icon = val[0]?.url || ''"
                                            />

                                            <!-- Select -->
                                            <a-select
                                                v-model:value="item.type"
                                                :options="socialPlatforms"
                                                :field-names="{ label: 'label', value: 'value' }"
                                                placeholder="Chọn MXH"
                                                style="width: 90px"
                                            />

                                            <!-- URL input -->
                                            <a-input
                                                v-model:value="item.url"
                                                placeholder="https://..."
                                                style="width: 300px"
                                            />

                                            <!-- Nút xoá -->
                                            <a-button
                                                type="text"
                                                danger
                                                @click="removeSocialLink(index)"
                                                v-if="form.social_links.length > 1"
                                            >
                                                <DeleteOutlined/>
                                            </a-button>

                                        </a-space>
                                    </div>

                                    <a-button type="dashed" @click="addSocialLink">
                                        ➕ Thêm
                                    </a-button>
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

<script setup>
import {ref, onMounted, nextTick} from 'vue'
import {useRoute, useRouter} from 'vue-router'
import {createEvent, updateEvent, getEvent, uploadFile} from '../api/event'
// import {uploadFile} from '../api/product'`
import {message} from 'ant-design-vue'
import {UploadOutlined, DeleteOutlined} from '@ant-design/icons-vue'
import dayjs from 'dayjs'
import {useUserStore} from '../stores/user'
import ImageUploader from './ImageUploader.vue' // đường dẫn đúng tới file bạn lưu
import Quill from 'quill'
import 'quill/dist/quill.snow.css'

const ticketEditorRefs = ref([])
const ticketEditorInstances = ref([])


const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const isEditMode = !!route.params.id

const form = ref({
    user_id: null,
    name: '',
    location: '',
    start_time: null,
    end_time: null,
    description: [
        {
            title: '',
            content: ''
        }
    ],
    event_mode: 'online',
    is_enabled: true,
    contact_first_name: '',
    contact_last_name: '',
    contact_phone: '',
    contact_email: '',
    ticket_options: [
        {
            title: '',
            description: '',
            price: 0
        }
    ],
    social_links: [
        { type: 'facebook', url: '', icon: '' }
    ],

    images: [
        // { url: '', is_main: false }
    ],
    banner: '', // chỉ 1 ảnh (string)
    video: [''] // danh sách nhiều video (mảng string)
})

const socialPlatforms = [
    {label: 'Facebook', value: 'facebook', icon: 'facebook.png'},
    {label: 'Instagram', value: 'instagram', icon: 'instagram.png'},
    {label: 'Twitter', value: 'twitter', icon: 'twitter.png'},
    {label: 'LinkedIn', value: 'linkedin', icon: 'linkedin.png'}
]

const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const descriptionEditorRefs = ref([])
const descriptionEditorInstances = ref([])


const fetchEvent = async () => {
    try {
        const response = await getEvent(route.params.id)
        const data = response.data

        // Parse các trường JSON (nếu là string)
        data.images = typeof data.images === 'string'
            ? JSON.parse(data.images)
            : (Array.isArray(data.images) ? data.images : [])

        data.video = typeof data.video === 'string'
            ? JSON.parse(data.video)
            : (Array.isArray(data.video) ? data.video : [])

        data.ticket_options = (() => {
            if (Array.isArray(data.ticket_options)) return data.ticket_options
            if (typeof data.ticket_options === 'string') {
                try {
                    const parsed = JSON.parse(data.ticket_options)
                    return Array.isArray(parsed) ? parsed : []
                } catch (e) {
                    console.warn('⚠️ ticket_options không phải JSON:', data.ticket_options)
                    return [] // fallback nếu là HTML cũ
                }
            }
            return []
        })()


        data.banner = data.banner || ''

        // Gán vào form
        Object.assign(form.value, data)

        form.value.social_links = typeof data.social_links === 'string'
            ? JSON.parse(data.social_links)
            : (Array.isArray(data.social_links) ? data.social_links : [])


        // Convert thời gian về dayjs nếu có
        if (form.value.start_time) {
            form.value.start_time = dayjs(form.value.start_time)
        }

        if (form.value.end_time) {
            form.value.end_time = dayjs(form.value.end_time)
        }

    } catch (error) {
        console.error('Lỗi lấy sự kiện:', error)
        message.error('Không tìm thấy thông tin sự kiện')
    }
}

const addNewTicketOption = async () => {
    // Thêm block mới vào form
    form.value.ticket_options.push({
        title: '',
        description: '',
        price: 0
    })

    await nextTick()

    // Mount editor cho block vừa thêm
    const index = form.value.ticket_options.length - 1
    const container = ticketEditorRefs.value[index]

    if (container && !ticketEditorInstances.value[index]) {
        const quill = new Quill(container, {
            theme: 'snow',
            placeholder: 'Nhập mô tả vé...',
            modules: {
                toolbar: [
                    ['bold', 'italic', 'underline', 'strike'],
                    [{list: 'ordered'}, {list: 'bullet'}],
                    [{header: [1, 2, false]}],
                    ['link', 'image'],
                    ['clean']
                ]
            }
        })

        ticketEditorInstances.value[index] = quill
    }
}

const removeTicketOption = async (index) => {
    form.value.ticket_options.splice(index, 1)
    ticketEditorRefs.value.splice(index, 1)
    ticketEditorInstances.value.splice(index, 1)

    await nextTick()

    // Mount lại editor cho tất cả khối còn lại
    form.value.ticket_options.forEach((ticket, idx) => {
        const container = ticketEditorRefs.value[idx]
        if (container && !ticketEditorInstances.value[idx]) {
            const quill = new Quill(container, {
                theme: 'snow',
                placeholder: 'Nhập mô tả vé...',
                modules: {
                    toolbar: [
                        ['bold', 'italic', 'underline', 'strike'],
                        [{list: 'ordered'}, {list: 'bullet'}],
                        [{header: [1, 2, false]}],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            })

            if (ticket.description) {
                quill.root.innerHTML = ticket.description
            }

            ticketEditorInstances.value[idx] = quill
        }
    })
}


const addNewDescription = async () => {
    if (!Array.isArray(form.value.description)) {
        form.value.description = []
    }

    form.value.description.push({title: '', content: ''})

    await nextTick()

    const index = form.value.description.length - 1
    const container = descriptionEditorRefs.value[index]
    if (container) {
        const quill = new Quill(container, {
            theme: 'snow',
            placeholder: 'Nhập nội dung mô tả...',
            modules: {
                toolbar: [
                    ['bold', 'italic', 'underline', 'strike'],
                    [{list: 'ordered'}, {list: 'bullet'}],
                    [{header: [1, 2, false]}],
                    ['link', 'image'],
                    ['clean']
                ]
            }
        })

        descriptionEditorInstances.value[index] = quill
    }
}


const removeDescription = async (index) => {
    form.value.description.splice(index, 1)
    descriptionEditorRefs.value.splice(index, 1)
    descriptionEditorInstances.value.splice(index, 1)

    await nextTick()

    form.value.description.forEach((item, idx) => {
        const container = descriptionEditorRefs.value[idx]
        if (container && !descriptionEditorInstances.value[idx]) {
            const quill = new Quill(container, {
                theme: 'snow',
                placeholder: 'Nhập nội dung mô tả...',
                modules: {
                    toolbar: [
                        ['bold', 'italic', 'underline', 'strike'],
                        [{list: 'ordered'}, {list: 'bullet'}],
                        [{header: [1, 2, false]}],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            })

            quill.root.innerHTML = item.content || ''
            descriptionEditorInstances.value[idx] = quill
        }
    })
}


const setDescriptionEditorRef = (index, el) => {
    if (el) {
        descriptionEditorRefs.value[index] = el
    }
}


const addSocialLink = () => {
    form.value.social_links.push({type: '', url: ''})
}

const removeSocialLink = (index) => {
    form.value.social_links.splice(index, 1)
}


const handleSetMainImage = async (image) => {
    try {
        const eventId = route.params.id

        // Tạo bản sao images và cập nhật is_main
        const updatedImages = form.value.images.map(img => ({
            ...img,
            is_main: img.url === image.url
        }))

        // Gọi API cập nhật CHỈ trường images
        await updateEvent(eventId, {
            images: JSON.stringify(updatedImages)
        })

        // Cập nhật lại vào form để đồng bộ UI
        form.value.images = updatedImages

        message.success('Đã cập nhật ảnh chính thành công')
    } catch (err) {
        console.error(err)
        message.error('Không thể cập nhật ảnh chính')
    }
}

const handleSubmit = async () => {
    try {
        form.value.user_id = userStore.user?.id

        // ✅ Lấy nội dung từ mô tả sự kiện
        form.value.description = form.value.description.map((item, index) => ({
            ...item,
            content: descriptionEditorInstances.value[index]?.root.innerHTML || ''
        }))

        // ✅ Lấy nội dung từ từng Quill editor của vé
        form.value.ticket_options = form.value.ticket_options.map((ticket, index) => ({
            ...ticket,
            description: ticketEditorInstances.value[index]?.root.innerHTML || ''
        }))


        // ✅ Chuẩn bị payload
        const payload = {...form.value}


        payload.social_links = JSON.stringify(
            (Array.isArray(form.value.social_links) ? form.value.social_links : []).filter(
                item => item.type && item.url
            )
        )

        // JSON.stringify các trường cần thiết
        payload.images = JSON.stringify(
            (Array.isArray(form.value.images) ? form.value.images : []).map(img => ({
                url: img.url,
                is_main: img.is_main || false
            }))
        )
        payload.banner = form.value.banner || ''
        payload.video = JSON.stringify(Array.isArray(form.value.video) ? form.value.video : [])
        payload.ticket_options = JSON.stringify(form.value.ticket_options)



        // ✅ Gửi API
        let eventId

        if (isEditMode) {
            await updateEvent(route.params.id, payload)
            eventId = route.params.id
            message.success('Cập nhật sự kiện thành công')
        } else {
            const res = await createEvent(payload)
            eventId = res?.data?.id
            if (!eventId) throw new Error('Không lấy được ID sự kiện sau khi tạo')
            message.success('Tạo sự kiện thành công')
        }

        // ✅ Chuyển trang
        router.push('/events')
    } catch (error) {
        console.error('Lỗi khi lưu sự kiện:', error)
        message.error('Có lỗi xảy ra khi lưu sự kiện')
    }
}


const normalizeToArray = (val) => {
    if (Array.isArray(val)) return val
    if (typeof val === 'string' && val !== '') {
        return [{
            url: val,
            preview: val,
            uid: Date.now().toString(),
            isCover: true
        }]
    }
    return []
}

const normalizeBanner = (val) => {
    if (!val) return []
    return [{
        url: val,
        preview: val,
        uid: Date.now().toString()
    }]
}


const goBack = () => router.push('/events')

onMounted(async () => {
    if (isEditMode) {
        await fetchEvent()

        // Khởi tạo nếu ticket_options chưa có
        if (!Array.isArray(form.value.ticket_options) || form.value.ticket_options.length === 0) {
            form.value.ticket_options = [{title: '', description: '', price: 0}]
        }

        // Khởi tạo nếu description chưa có
        if (!Array.isArray(form.value.description) || form.value.description.length === 0) {
            form.value.description = [{title: '', content: ''}]
        }
    } else {
        // Tạo mới
        form.value.ticket_options = [{title: '', description: '', price: 0}]
        form.value.description = [{title: '', content: ''}]
    }

    await nextTick()

    // Mount Quill cho từng mô tả vé
    form.value.ticket_options.forEach((ticket, index) => {
        const container = ticketEditorRefs.value[index]
        if (container && !ticketEditorInstances.value[index]) {
            const quill = new Quill(container, {
                theme: 'snow',
                placeholder: 'Nhập mô tả vé...',
                modules: {
                    toolbar: [
                        ['bold', 'italic', 'underline', 'strike'],
                        [{list: 'ordered'}, {list: 'bullet'}],
                        [{header: [1, 2, false]}],
                        ['link'],
                        ['clean']
                    ]
                }
            })

            if (ticket.description) {
                quill.root.innerHTML = ticket.description
            }

            ticketEditorInstances.value[index] = quill
        }
    })

    // Mount Quill cho từng mô tả sự kiện
    form.value.description.forEach((desc, index) => {
        const container = descriptionEditorRefs.value[index]
        if (container && !descriptionEditorInstances.value[index]) {
            const quill = new Quill(container, {
                theme: 'snow',
                placeholder: 'Nhập nội dung mô tả...',
                modules: {
                    toolbar: [
                        ['bold', 'italic', 'underline', 'strike'],
                        [{list: 'ordered'}, {list: 'bullet'}],
                        [{header: [1, 2, false]}],
                        ['link'],
                        ['clean']
                    ]
                }
            })

            if (desc.content) {
                quill.root.innerHTML = desc.content
            }

            descriptionEditorInstances.value[index] = quill
        }
    })

    if (!Array.isArray(form.value.social_links) || form.value.social_links.length === 0) {
        form.value.social_links = [{type: '', url: '', icon: ''}]
    }
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
