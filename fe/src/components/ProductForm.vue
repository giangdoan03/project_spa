<template>
    <div>
        <a-button @click="goBack" style="margin-bottom: 16px">Quay lại</a-button>
        <a-tabs default-active-key="info">
            <a-tab-pane key="info" tab="Thông tin sản phẩm">
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
                        <a-radio-group v-model:value="form.price_mode">
                            <a-radio :value="'single'">Nhập 1 giá</a-radio>
                            <a-radio :value="'range'">Nhập khoảng giá</a-radio>
                        </a-radio-group>

                        <div v-if="form.price_mode === 'single'" style="margin-top: 10px;">
                            <a-input-number v-model:value="form.price" style="width: 100%" placeholder="Nhập giá bán" />
                        </div>

                        <div v-if="form.price_mode === 'range'" style="margin-top: 10px; display: flex; gap: 8px;">
                            <a-input-number v-model:value="form.price_from" style="width: 100%" placeholder="Giá từ" />
                            <a-input-number v-model:value="form.price_to" style="width: 100%" placeholder="Giá đến" />
                        </div>

                        <a-checkbox v-model:checked="form.show_contact_price" style="margin-top: 10px;">
                            Hiển thị 'Liên hệ báo giá' nếu không có thông tin giá bán
                        </a-checkbox>
                    </a-form-item>



                    <!-- Mô tả sản phẩm -->
                    <a-form-item label="Mô tả sản phẩm">
                        <div ref="editorRef" style="min-height: 200px; border: 1px solid #ccc; padding: 8px;" />
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
            </a-tab-pane>

            <a-tab-pane key="settings" tab="Cài đặt hiển thị">
                <a-row :gutter="24">
                    <a-col :span="16">
                        <a-form layout="vertical">
                            <!-- Giao diện mẫu -->
                            <a-form-item label="Chọn giao diện mẫu">
                                <a-row :gutter="16">
                                    <a-col v-for="tpl in templateOptions" :key="tpl.id" :xs="24" :sm="12" :md="8" :lg="8" style="margin-bottom: 16px">
                                        <a-card hoverable :class="{ 'selected-card': settings.selectedTemplate === tpl.id, 'active-card': isActiveTemplate(tpl.id) }" @click="selectTemplate(tpl)">
                                            <template #cover>
                                                <img :src="tpl.thumbnail" alt="template" style="height: 200px; object-fit: cover" />
                                            </template>
                                            <a-card-meta :title="tpl.title" :description="tpl.description" />
                                        </a-card>
                                    </a-col>
                                </a-row>
                            </a-form-item>

                            <!-- Sản phẩm liên quan -->
                            <a-form-item label="Sản phẩm liên quan">
                                <a-radio-group v-model:value="settings.relatedProducts" @change="handleRelatedProductModeChange">
                                    <a-radio :value="'all'">Tất cả sản phẩm</a-radio>
                                    <a-radio :value="'selected'">Chọn sản phẩm</a-radio>
                                </a-radio-group>
                            </a-form-item>
                            <div v-if="settings.relatedProducts === 'selected'" style="margin-bottom: 24px">
                                <a-select mode="multiple" style="width: 100%; margin-bottom: 12px" placeholder="Chọn sản phẩm" v-model:value="selectedProductIds" @change="handleProductSelect">
                                    <a-select-option v-for="product in allProducts" :key="product.id" :value="product.id">
                                        {{ product.name }} - {{ product.price }}đ
                                    </a-select-option>
                                </a-select>
                                <a-table :columns="productColumns" :data-source="productList" row-key="id" bordered size="small">
                                    <template #bodyCell="{ column, record }">
                                        <template v-if="column.key === 'avatar'">
                                            <img v-if="record.avatar" :src="parseAvatar(record.avatar)" alt="Avatar" style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px" />
                                        </template>
                                        <template v-if="column.key === 'action'">
                                            <a-button type="link" @click="removeProduct(record.id)" danger>Xoá</a-button>
                                        </template>
                                    </template>
                                </a-table>
                            </div>

                            <!-- Công ty -->
                            <a-form-item label="Công ty liên quan">
                                <a-radio-group v-model:value="settings.company" @change="handleCompanyModeChange">
                                    <a-radio :value="'all'">Tất cả công ty</a-radio>
                                    <a-radio :value="'selected'">Chọn công ty</a-radio>
                                </a-radio-group>
                            </a-form-item>
                            <div v-if="settings.company === 'selected'" style="margin-bottom: 24px">
                                <a-select mode="multiple" style="width: 100%; margin-bottom: 12px" placeholder="Chọn công ty" v-model:value="selectedCompanies" @change="handleCompanySelect">
                                    <a-select-option v-for="b in allBusinesses" :key="b.id" :value="b.id">
                                        {{ b.name }} - {{ b.email }}
                                    </a-select-option>
                                </a-select>

                                <a-table :columns="businessColumns" :data-source="businessList" row-key="id" bordered size="small">
                                    <template #bodyCell="{ column, record }">
                                        <template v-if="column.key === 'logo'">
                                            <img v-if="record.logo?.[0]" :src="record.logo[0]" alt="Logo" style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px" />
                                        </template>
                                        <template v-if="column.key === 'action'">
                                            <a-button type="link" @click="removeBusiness(record.id)" danger>Xoá</a-button>
                                        </template>
                                    </template>
                                </a-table>
                            </div>


                            <!-- Cửa hàng -->
                            <a-form-item label="Cửa hàng liên quan">
                                <a-radio-group v-model:value="settings.store" @change="handleStoreModeChange">
                                    <a-radio :value="'all'">Tất cả cửa hàng</a-radio>
                                    <a-radio :value="'selected'">Chọn cửa hàng</a-radio>
                                </a-radio-group>
                            </a-form-item>
                            <div v-if="settings.store === 'selected'" style="margin-bottom: 24px">
                                <a-select mode="multiple" style="width: 100%; margin-bottom: 12px" placeholder="Chọn cửa hàng" v-model:value="selectedStores" @change="handleStoreSelect">
                                    <a-select-option v-for="s in allStores" :key="s.id" :value="s.id">
                                        {{ s.name }} - {{ s.address }}
                                    </a-select-option>
                                </a-select>

                                <a-table :columns="storeColumns" :data-source="storeList" row-key="id" bordered size="small">
                                    <template #bodyCell="{ column, record }">
                                        <template v-if="column.key === 'logo'">
                                            <img v-if="record.logo" :src="record.logo" alt="Logo" style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px" />
                                        </template>
                                        <template v-if="column.key === 'action'">
                                            <a-button type="link" @click="removeStore(record.id)" danger>Xoá</a-button>
                                        </template>
                                    </template>
                                </a-table>
                            </div>


                            <!-- Khảo sát + nút đặt hàng -->
                            <a-form-item label="Khảo sát">
                                <a-switch v-model:checked="settings.enableSurvey" disabled/>
                            </a-form-item>
                            <a-form-item label="Link bán hàng (nút đặt hàng)">
                                <a-switch v-model:checked="settings.enableOrderButton" />
                            </a-form-item>
                            <a-form-item>
                                <a-button type="primary" @click="handleSubmit" :loading="loading">Lưu</a-button>
                            </a-form-item>
                        </a-form>
                    </a-col>
                    <a-col :xs="24" :md="8">
                        <div class="iphone-mockup">
                            <div :class="['dynamic-island', { expanded: isIslandExpanded }]">
                                <div class="marquee">
                                    <div class="marquee-content">{{ selectedTemplateData?.title }}</div>
                                </div>
                            </div>
                            <div class="iphone-screen">
                                <component v-if="AsyncTemplate" :is="AsyncTemplate" :title="form.name" :description="form.description" :thumbnail="form.image?.[0]" />
                            </div>
                        </div>
                    </a-col>
                </a-row>
            </a-tab-pane>
        </a-tabs>

        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" alt="Preview" style="width: 100%" />
        </a-modal>
    </div>
</template>



<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { nextTick } from 'vue'
import {createProduct, getProduct, getProducts, updateProduct} from '../api/product'

import { getBusinesses } from '../api/business'
import { getStores } from '../api/store'


import { getCategories } from '../api/category'
import { message } from 'ant-design-vue'
import { UploadOutlined } from '@ant-design/icons-vue'
import { uploadFile } from '../api/product'
import { defineAsyncComponent } from 'vue'
import { normalizeProductData } from '../utils/formUtils'
import templateOptions from '@/components/templates'
import Quill from 'quill'
import 'quill/dist/quill.snow.css'

const editorRef = ref(null)
const quillInstance = ref(null)

const route = useRoute()
const router = useRouter()

const loading = ref(false)
const isIslandExpanded = ref(false)

const form = ref({
    name: '',
    sku: '',
    category_id: null,
    price_mode: 'single', // 👈 Thêm trường này
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

const selectedProductIds = ref([])
const selectedCompanies = ref([])
const selectedStores = ref([])
const selectedSurveys = ref([])

const allProducts = ref([])
const productList = ref([])

const allBusinesses = ref([])
const allStores = ref([])


const businessList = ref([])

const storeList = ref([])

const storeColumns = [
    { title: 'ID', dataIndex: 'id', key: 'id' },
    { title: 'Logo', dataIndex: 'logo', key: 'logo' },
    { title: 'Tên cửa hàng', dataIndex: 'name', key: 'name' },
    { title: 'Địa chỉ', dataIndex: 'address', key: 'address' },
    { title: 'SĐT', dataIndex: 'phone', key: 'phone' },
    { title: 'Email', dataIndex: 'email', key: 'email' },
    { title: 'Hành động', key: 'action' }
]


const businessColumns = [
    { title: 'ID', dataIndex: 'id', key: 'id' },
    { title: 'Logo', dataIndex: 'logo', key: 'logo' },
    { title: 'Tên công ty', dataIndex: 'name', key: 'name' },
    { title: 'Email', dataIndex: 'email', key: 'email' },
    { title: 'SĐT', dataIndex: 'phone', key: 'phone' },
    { title: 'Địa chỉ', dataIndex: 'address', key: 'address' },
    { title: 'Hành động', key: 'action' }
]



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

// Gọi API khi đổi mode
const handleRelatedProductModeChange = async (input) => {
    const value = typeof input === 'string' ? input : input?.target?.value
    if (!value) {
        console.warn('Giá trị không hợp lệ:', input)
        return
    }

    if (value === 'selected') {
        if (allProducts.value.length === 0) await fetchAllProducts()
        selectedProductIds.value = []
        productList.value = []
    } else if (value === 'all') {
        const res = await getProducts({ per_page: 1000 })
        allProducts.value = res.data.data
        productList.value = allProducts.value
        selectedProductIds.value = allProducts.value.map(p => p.id)
    }
}



// Chọn sản phẩm từ select box
const handleProductSelect = (ids) => {
    productList.value = allProducts.value.filter(p => ids.includes(p.id))
    settings.value.selectedProducts = ids
}

const removeProduct = (id) => {
    selectedProductIds.value = selectedProductIds.value.filter(pid => pid !== id)
    productList.value = productList.value.filter(p => p.id !== id)
    settings.value.selectedProducts = [...selectedProductIds.value]
}

// Load danh sách sản phẩm (chỉ gọi khi cần)
const fetchAllProducts = async () => {
    try {
        const response = await getProducts({ per_page: 1000 })
        allProducts.value = response.data.data
    } catch (err) {
        message.error('Lỗi tải danh sách sản phẩm')
    }
}


const handleCompanyModeChange = async (value) => {
    if (value === 'selected' && allBusinesses.value.length === 0) {
        await fetchAllBusinesses()
        selectedCompanies.value = []
    } else if (value === 'all') {
        const res = await getBusinesses({ per_page: 1000 })
        allBusinesses.value = res.data.data
        selectedCompanies.value = allBusinesses.value.map(b => b.id)
    }
}
const handleCompanySelect = (ids) => {
    businessList.value = allBusinesses.value.filter(b => ids.includes(b.id))
    selectedCompanies.value = ids
}

const removeBusiness = (id) => {
    selectedCompanies.value = selectedCompanies.value.filter(bid => bid !== id)
    businessList.value = businessList.value.filter(b => b.id !== id)
}


const fetchAllBusinesses = async () => {
    const res = await getBusinesses({ per_page: 1000 })
    allBusinesses.value = res.data.data
}

const handleStoreModeChange = async (value) => {
    if (value === 'selected' && allStores.value.length === 0) {
        await fetchAllStores()
        selectedStores.value = []
    } else if (value === 'all') {
        const res = await getStores({ per_page: 1000 })
        allStores.value = res.data.data
        selectedStores.value = allStores.value.map(s => s.id)
    }
}
const handleStoreSelect = (ids) => {
    storeList.value = allStores.value.filter(s => ids.includes(s.id))
    selectedStores.value = ids
}
const removeStore = (id) => {
    selectedStores.value = selectedStores.value.filter(sid => sid !== id)
    storeList.value = storeList.value.filter(s => s.id !== id)
}
const fetchAllStores = async () => {
    const res = await getStores({ per_page: 1000 })
    allStores.value = res.data.data
}


const settings = ref({
    selectedTemplate: 'tpl-1',         // Template hiển thị
    relatedProducts: 'all',            // 'all' hoặc 'selected'
    selectedProducts: [],              // ID sản phẩm được chọn khi relatedProducts = 'selected'

    company: 'all',                    // 'all' hoặc 'selected'
    selectedCompanies: [],             // ID công ty được chọn khi company = 'selected'

    store: 'all',                      // 'all' hoặc 'selected'
    selectedStores: [],                // ID cửa hàng được chọn khi store = 'selected'

    enableSurvey: false,                // Bật khảo sát
    selectedSurveys: [],               // ID khảo sát được chọn khi enableSurvey = true

    enableOrderButton: true            // Hiển thị nút đặt hàng
})


const categories = ref([])
const priceMode = ref('single')

const avatarFileList = ref([])
const imageFileList = ref([])
const videoFileList = ref([])
const certificateFileList = ref([])

const previewImage = ref('')
const previewVisible = ref(false)
const previewTitle = ref('')

const isEditMode = computed(() => !!route.params.id)

const selectedTemplateData = computed(() =>
    templateOptions.find(t => t.id === settings.value.selectedTemplate)
)

const AsyncTemplate = computed(() => {
    return selectedTemplateData.value?.component ? defineAsyncComponent(selectedTemplateData.value.component) : null
})

const selectTemplate = (tpl) => {
    settings.value.selectedTemplate = tpl.id
}

const isActiveTemplate = (tplId) => {
    return settings.value.selectedTemplate === tplId
}

const fetchCategories = async () => {
    try {
        const response = await getCategories()
        categories.value = response.data
    } catch (e) {
        message.error('Không tải được danh mục')
    }
}

const fetchProduct = async () => {
    try {
        const response = await getProduct(route.params.id)
        const data = normalizeProductData(response.data)

        console.log('Dữ liệu sản phẩm:', data) // 👈 Xem rõ ở đây

        Object.assign(form.value, data)

        form.value.price_mode = data.price_mode || 'single'  // fallback nếu null
        form.value.show_contact_price = data.show_contact_price === '1'

        if (typeof data.display_settings === 'string') {
            try {
                const parsedSettings = JSON.parse(data.display_settings)
                settings.value = { ...settings.value, ...parsedSettings }
            } catch (e) {
                console.warn('display_settings không hợp lệ:', e)
            }
        } else if (typeof data.display_settings === 'object') {
            settings.value = { ...settings.value, ...data.display_settings }
        }

        const fields = ['avatar', 'image', 'video', 'certificate_file']
        fields.forEach(field => {
            const fileUrls = form.value[field] || []
            fileUrls.forEach(url => updateFileList(field, url))
        })
    } catch (error) {
        message.error('Không tìm thấy sản phẩm')
    }
}


const updateFileList = (field, url) => {
    const file = {
        uid: Date.now() + Math.random(),
        name: url.split('/').pop(),
        status: 'done',
        url,
    }
    const lists = {
        avatar: avatarFileList,
        image: imageFileList,
        video: videoFileList,
        certificate_file: certificateFileList,
    }
    lists[field]?.value.push(file)
}

const handleBeforeUploadMultiple = async (field, file) => {
    const hide = message.loading('Đang tải lên...', 0)
    try {
        const response = await uploadFile(file)
        const url = response.data.url
        if (!Array.isArray(form.value[field])) form.value[field] = []
        form.value[field].push(url)
        updateFileList(field, url)
        message.success('Tải lên thành công!')
    } catch (error) {
        message.error('Tải lên thất bại!')
    } finally {
        hide()
    }
    return false
}

const handleRemoveFile = (field, file) => {
    form.value[field] = form.value[field].filter(url => url !== file.url)
    const lists = {
        avatar: avatarFileList,
        image: imageFileList,
        video: videoFileList,
        certificate_file: certificateFileList,
    }
    lists[field].value = lists[field].value.filter(item => item.url !== file.url)
}

const handlePreview = (file) => {
    previewImage.value = file.url || file.thumbUrl
    previewVisible.value = true
    previewTitle.value = file.name || ''
}

const resetForm = () => {
    form.value = {
        name: '', sku: '', category_id: null,
        price: null, price_from: null, price_to: null,
        show_contact_price: false,
        avatar: [], image: [], video: [], certificate_file: [],
        description: '', attributes: [], status: true,
    }
    settings.value = {
        selectedTemplate: 'tpl-1', relatedProducts: 'all',
        company: 'all', store: 'all',
        enableSurvey: true, enableOrderButton: true
    }
    avatarFileList.value = []
    imageFileList.value = []
    videoFileList.value = []
    certificateFileList.value = []
}

const handleSubmit = async () => {
    if (!form.value.image.length) {
        message.error('Vui lòng upload ít nhất 1 ảnh sản phẩm!')
        return
    }

    settings.value.selectedProducts = selectedProductIds.value
    settings.value.selectedCompanies = selectedCompanies.value
    settings.value.selectedStores = selectedStores.value
    settings.value.selectedSurveys = selectedSurveys.value

    const payload = {
        ...form.value,
        display_settings: JSON.stringify(settings.value)
    }

    loading.value = true
    try {
        if (isEditMode.value) {
            await updateProduct(route.params.id, payload)
            message.success('Cập nhật sản phẩm thành công 🎉')
        } else {
            await createProduct(payload)
            message.success('Thêm sản phẩm thành công 🎉')
            resetForm()
        }
        router.push('/products')
    } catch (e) {
        message.error('Có lỗi khi lưu sản phẩm 😢')
    } finally {
        loading.value = false
    }
}

const addAttribute = () => {
    form.value.attributes.push({ name: '', value: '' })
}

const removeAttribute = (index) => {
    form.value.attributes.splice(index, 1)
}

const goBack = () => {
    router.push('/products')
}

onMounted(async () => {

    await fetchAllProducts()
    await fetchAllBusinesses()
    await fetchAllStores()

    await nextTick() // Đảm bảo DOM đã render

    if (isEditMode.value) {
        await fetchProduct()

        if (settings.value.relatedProducts === 'selected') {
            selectedProductIds.value = settings.value.selectedProducts || []
            productList.value = allProducts.value.filter(p => selectedProductIds.value.includes(p.id))
        }

        // Công ty liên quan
        if (settings.value.company === 'selected') {
            selectedCompanies.value = settings.value.selectedCompanies || []
            businessList.value = allBusinesses.value.filter(b => selectedCompanies.value.includes(b.id))
        }

        if (settings.value.store === 'selected') {
            selectedStores.value = settings.value.selectedStores || []
            if (allStores.value.length === 0) await fetchAllStores()
            storeList.value = allStores.value.filter(s => selectedStores.value.includes(s.id))
        }
    }


    if (editorRef.value) {
        quillInstance.value = new Quill(editorRef.value, {
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
    } else {
        console.warn('⚠️ Không tìm thấy DOM editorRef để gắn Quill.')
    }
})


const getEditorContent = () => {
    const html = quillInstance.value.root.innerHTML
    console.log('Nội dung mô tả:', html)
}

// 🔧 Fix missing definition warning for surveyColumns
const surveyColumns = ref([
    { title: 'Tên khảo sát', dataIndex: 'name', key: 'name' },
    { title: 'Khoảng thời gian', dataIndex: 'time', key: 'time' },
    { title: 'Câu hỏi', dataIndex: 'question', key: 'question' },
    { title: 'Trạng thái', dataIndex: 'status', key: 'status' },
    { title: 'Chức năng', key: 'action' },
])
</script>



<style scoped>

.iphone-mockup {
    width: 310px;
    height: 640px;
    margin: 0 auto;
    border: 10px solid #1c1c1e;
    border-radius: 48px;
    background: #000;
    position: relative;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
    overflow: hidden;
}

/* Notch */
.notch {
    position: absolute;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 150px;
    height: 30px;
    background: #000;
    border-bottom-left-radius: 16px;
    border-bottom-right-radius: 16px;
    z-index: 2;
}

/* Inner screen */
.iphone-screen {
    width: 100%;
    height: 100%;
    background: #fff;
    border-radius: 36px;
    overflow-y: auto;
    padding-bottom: 12px;
    padding-top: 40px; /* để chừa notch */
    box-sizing: border-box;
    position: relative;
    z-index: 1;
}

/* Image and info inside screen */
.screen-img {
    width: 100%;
    height: auto;
    border-radius: 0;
    object-fit: cover;
}

.info {
    padding: 12px;
    font-size: 14px;
    text-align: center;
}

.dynamic-island {
    position: absolute;
    top: 14px;
    left: 50%;
    transform: translateX(-50%);
    width: 110px;
    height: 30px;
    background: #000;
    border-radius: 20px;
    z-index: 2;
    transition: all 0.3s ease;
    box-shadow: 0 0 6px rgba(255, 255, 255, 0.05);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    padding: 0 8px;
}

.dynamic-island.expanded {
    width: 180px;
    height: 40px;
    border-radius: 24px;
}

.marquee {
    width: 100%;
    overflow: hidden;
    white-space: nowrap;
    position: relative;
}

.marquee-content {
    display: inline-block;
    padding-left: 100%;
    animation: scrollText 10s linear infinite;
    color: #fff;
    font-size: 12px;
    opacity: 0.8;
}

.active-card {
    box-shadow: 0 0 8px #52c41a;
}

@keyframes scrollText {
    0% {
        transform: translateX(0);
    }
    100% {
        transform: translateX(-100%);
    }
}

</style>
