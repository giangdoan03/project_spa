<template>
    <div>
        <a-button @click="goBack" style="margin-bottom: 16px">Quay lại</a-button>

        <a-form :model="form" layout="vertical" @finish="handleSubmit">
            <a-card style="margin-bottom: 24px">
                <a-form-item label="Tên cửa hàng" required>
                    <a-input v-model:value="form.name" placeholder="Nhập tên cửa hàng" />
                </a-form-item>

                <a-form-item label="Email">
                    <a-input v-model:value="form.email" placeholder="example@mail.com" />
                </a-form-item>

                <a-form-item label="Số điện thoại">
                    <a-input v-model:value="form.phone" placeholder="Nhập số điện thoại" />
                </a-form-item>

                <a-form-item label="Địa chỉ">
                    <a-input v-model:value="form.address" placeholder="Nhập địa chỉ" />
                </a-form-item>

                <a-form-item label="Mô tả ngắn gọn">
                    <div ref="editorRef" style="min-height: 200px; border: 1px solid #ccc; border-radius: 4px; padding: 8px;" />
                </a-form-item>

                <a-form-item label="Logo">
                    <a-upload
                            list-type="picture-card"
                            :file-list="logoFileList"
                            :on-preview="handlePreview"
                            :on-remove="handleRemoveFile"
                            :before-upload="handleBeforeUpload"
                    >
                        <div>
                            <upload-outlined />
                            <div style="margin-top: 8px">Upload</div>
                        </div>
                    </a-upload>
                </a-form-item>

                <a-form-item>
                    <a-switch v-model:checked="form.status" checked-children="Bật" un-checked-children="Tắt" />
                </a-form-item>

                <a-form-item label="Thêm sản phẩm vào cửa hàng">
                    <a-switch v-model:checked="enableAddProduct" />
                </a-form-item>

                <div v-if="enableAddProduct" style="margin-bottom: 24px">
                    <a-select
                            mode="multiple"
                            style="width: 100%; margin-bottom: 12px"
                            placeholder="Chọn sản phẩm"
                            v-model:value="selectedProductIds"
                            @change="handleProductSelect"
                    >
                        <a-select-option v-for="product in allProducts" :key="product.id" :value="product.id">
                            {{ product.name }} - {{ product.price }}đ
                        </a-select-option>
                    </a-select>

                    <a-table
                            :columns="productColumns"
                            :data-source="productList"
                            row-key="id"
                            bordered
                            size="small"
                    >
                        <template #bodyCell="{ column, record }">
                            <template v-if="column.key === 'avatar'">
                                <img
                                        v-if="record.avatar"
                                        :src="parseAvatar(record.avatar)"
                                        alt="Avatar"
                                        style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px"
                                />
                            </template>
                            <template v-if="column.key === 'action'">
                                <a-button type="link" @click="removeProduct(record.id)" danger>Xoá</a-button>
                            </template>
                        </template>
                    </a-table>
                </div>
            </a-card>

            <a-form-item>
                <a-button type="primary" html-type="submit">Lưu</a-button>
                <a-button @click="goBack">Huỷ</a-button>
            </a-form-item>
        </a-form>

        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" style="width: 100%" />
        </a-modal>
    </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getStore, createStore, updateStore } from '../api/store'
import { getProducts, uploadFile } from '../api/product'
import { useUserStore } from '../stores/user'
import { message } from 'ant-design-vue'
import { UploadOutlined } from '@ant-design/icons-vue'
import Quill from 'quill'
import 'quill/dist/quill.snow.css'

const userStore = useUserStore()
const router = useRouter()
const route = useRoute()
const isEditMode = !!route.params.id

const editorRef = ref(null)
let quillInstance = null

const form = ref({
    user_id: null,
    name: '',
    email: '',
    phone: '',
    address: '',
    description: '',
    logo: '',
    status: true,
    product_ids: []
})

const enableAddProduct = ref(false)
const productList = ref([])
const selectedProductIds = ref([])
const allProducts = ref([])

const logoFileList = ref([])
const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const productColumns = [
    { title: 'ID', dataIndex: 'id', key: 'id' },
    { title: 'Ảnh', dataIndex: 'avatar', key: 'avatar' },
    { title: 'Tên sản phẩm', dataIndex: 'name', key: 'name' },
    { title: 'Giá', dataIndex: 'price', key: 'price' },
    { title: 'Hành động', key: 'action' }
]

const parseAvatar = (avatar) => {
    try {
        const parsed = JSON.parse(avatar)
        return Array.isArray(parsed) && parsed.length > 0 ? parsed[0] : ''
    } catch {
        return ''
    }
}

const handleProductSelect = (ids) => {
    productList.value = allProducts.value.filter(p => ids.includes(p.id))
    form.value.product_ids = [...ids]
}

const removeProduct = (id) => {
    selectedProductIds.value = selectedProductIds.value.filter(pid => pid !== id)
    productList.value = productList.value.filter(p => p.id !== id)
    form.value.product_ids = [...selectedProductIds.value]
}

const fetchProducts = async () => {
    try {
        const response = await getProducts({ per_page: 1000 })
        allProducts.value = response.data.data
    } catch (err) {
        message.error('Lỗi tải danh sách sản phẩm')
    }
}

const fetchStore = async () => {
    try {
        const response = await getStore(route.params.id)
        Object.assign(form.value, response.data)

        if (form.value.product_ids) {
            enableAddProduct.value = true
            selectedProductIds.value = JSON.parse(form.value.product_ids)
        }

        if (form.value.logo) {
            logoFileList.value = [
                {
                    uid: '1',
                    name: 'logo.jpg',
                    status: 'done',
                    url: form.value.logo
                }
            ]
        }

        await fetchProducts()
        if (selectedProductIds.value.length) {
            handleProductSelect(selectedProductIds.value)
        }

        // ⚠ Gán mô tả sau khi Quill đã khởi tạo
        nextTick(() => {
            if (quillInstance && form.value.description) {
                quillInstance.root.innerHTML = form.value.description
            }
        })
    } catch (error) {
        message.error('Không tìm thấy thông tin cửa hàng')
    }
}

const handleSubmit = async () => {
    form.value.description = quillInstance?.root.innerHTML || ''
    form.value.user_id = userStore.user?.id
    form.value.product_ids = [...selectedProductIds.value]

    try {
        if (isEditMode) {
            await updateStore(route.params.id, form.value)
            message.success('Cập nhật thành công')
        } else {
            await createStore(form.value)
            message.success('Tạo mới thành công')
        }
        router.push('/stores')
    } catch (error) {
        message.error('Có lỗi xảy ra')
    }
}

const handleBeforeUpload = async (file) => {
    const hide = message.loading('Đang tải lên...', 0)
    try {
        const res = await uploadFile(file)
        form.value.logo = res.data.url
        logoFileList.value = [
            {
                uid: Date.now(),
                name: file.name,
                status: 'done',
                url: res.data.url
            }
        ]
        message.success('Tải lên thành công')
    } catch (err) {
        message.error('Tải lên thất bại')
    } finally {
        hide()
    }
    return false
}

const handleRemoveFile = () => {
    form.value.logo = ''
    logoFileList.value = []
}

const handlePreview = (file) => {
    previewImage.value = file.url
    previewVisible.value = true
    previewTitle.value = file.name || ''
}

const goBack = () => router.push('/stores')

onMounted(() => {
    fetchProducts()
    if (isEditMode) fetchStore()

    nextTick(() => {
        if (editorRef.value) {
            quillInstance = new Quill(editorRef.value, {
                theme: 'snow',
                placeholder: 'Nhập mô tả sản phẩm...',
                modules: {
                    toolbar: [
                        ['bold', 'italic', 'underline', 'strike'],
                        [{ list: 'ordered' }, { list: 'bullet' }],
                        [{ header: [1, 2, false] }],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            })
        }
    })
})
</script>

<style scoped></style>