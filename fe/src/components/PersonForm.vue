<template>
    <div>
        <!-- Nút quay lại -->
        <a-button type="default" @click="goBack" style="margin-bottom: 16px">
            Quay lại danh sách
        </a-button>
        <a-tabs default-active-key="info">
            <a-tab-pane key="info" tab="Thông tin cá nhân">
                <a-form :model="form" layout="vertical" @finish="handleSubmit">
                    <a-card style="margin-bottom: 24px">
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
                                    <upload-outlined/>
                                    <div style="margin-top: 8px">Upload</div>
                                </div>
                            </a-upload>
                        </a-form-item>

                        <!-- Họ tên -->
                        <a-form-item label="Họ và tên" required>
                            <a-input v-model:value="form.name" placeholder="Nhập họ tên"/>
                        </a-form-item>

                        <!-- Email -->
                        <a-form-item label="Email">
                            <a-input v-model:value="form.email" placeholder="example@mail.com"/>
                        </a-form-item>

                        <!-- Số điện thoại -->
                        <a-form-item label="Số điện thoại">
                            <a-input v-model:value="form.phone" placeholder="Nhập số điện thoại"/>
                        </a-form-item>

                        <!-- Chức danh -->
                        <a-form-item label="Chức danh">
                            <a-input v-model:value="form.job_title" placeholder="VD: Giám đốc Marketing"/>
                        </a-form-item>

                        <!-- Tiểu sử -->
                        <a-form-item label="Tiểu sử">
                            <a-textarea v-model:value="form.bio" :rows="4"
                                        placeholder="Giới thiệu ngắn gọn về cá nhân..."/>
                        </a-form-item>
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
                <a-row :gutter="24">
                    <a-col :span="16">
                        <a-form layout="vertical">
                            <!-- Giao diện mẫu -->
                            <a-card title="Chọn giao diện mẫu" style="margin-bottom: 24px;">
                                <a-form-item label="Chọn giao diện mẫu">
                                    <a-row :gutter="16">
                                        <a-col v-for="tpl in templateOptions" :key="tpl.id" :xs="24" :sm="12" :md="8"
                                               :lg="8" style="margin-bottom: 16px">
                                            <a-card hoverable
                                                    :class="{ 'selected-card': settings.selectedTemplate === tpl.id, 'active-card': isActiveTemplate(tpl.id) }"
                                                    @click="selectTemplate(tpl)">
                                                <template #cover>
                                                    <img :src="tpl.thumbnail" alt="template"
                                                         style="height: 200px; object-fit: cover"/>
                                                </template>
                                                <a-card-meta :title="tpl.title" :description="tpl.description"/>
                                            </a-card>
                                        </a-col>
                                    </a-row>
                                </a-form-item>
                            </a-card>

                            <!-- Sản phẩm liên quan -->
                            <a-card title="Sản phẩm" style="margin-bottom: 24px;">
                                <a-form-item>
                                    <a-radio-group v-model:value="settings.relatedProducts"
                                                   @change="handleRelatedProductModeChange">
                                        <a-radio :value="'all'">Tất cả sản phẩm</a-radio>
                                        <a-radio :value="'selected'">Chọn sản phẩm</a-radio>
                                    </a-radio-group>
                                </a-form-item>

                                <div v-if="settings.relatedProducts === 'selected'" style="margin-bottom: 24px">
                                    <a-select mode="multiple" style="width: 100%; margin-bottom: 12px"
                                              placeholder="Chọn sản phẩm" v-model:value="selectedProductIds"
                                              @change="handleProductSelect">
                                        <a-select-option v-for="product in allProducts" :key="product.id"
                                                         :value="product.id">
                                            {{ product.name }} - {{ product.price }}đ
                                        </a-select-option>
                                    </a-select>

                                    <a-table :columns="productColumns" :data-source="productList" row-key="id" bordered
                                             size="small">
                                        <template #bodyCell="{ column, record }">
                                            <template v-if="column.key === 'avatar'">
                                                <img v-if="record.avatar" :src="parseAvatar(record.avatar)" alt="Avatar"
                                                     style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px"/>
                                            </template>
                                            <template v-if="column.key === 'action'">
                                                <a-button type="link" @click="removeProduct(record.id)" danger>Xoá
                                                </a-button>
                                            </template>
                                        </template>
                                    </a-table>
                                </div>
                            </a-card>


                            <a-card title="Công ty" style="margin-bottom: 24px;">
                                <!-- Công ty -->
                                <a-form-item>
                                    <a-radio-group v-model:value="settings.company" @change="handleCompanyModeChange">
                                        <a-radio :value="'all'">Tất cả công ty</a-radio>
                                        <a-radio :value="'selected'">Chọn công ty</a-radio>
                                    </a-radio-group>
                                </a-form-item>
                                <div v-if="settings.company === 'selected'" style="margin-bottom: 24px">
                                    <a-select
                                            mode="multiple"
                                            style="width: 100%; margin-bottom: 12px"
                                            placeholder="Chọn công ty"
                                            v-model:value="selectedCompanies"
                                            @change="handleCompanySelect"
                                            :key="settings.company"
                                    >

                                        <a-select-option v-for="b in allBusinesses" :key="b.id" :value="b.id">
                                            {{ b.name }} - {{ b.email }}
                                        </a-select-option>
                                    </a-select>

                                    <a-table :columns="businessColumns" :data-source="businessList" row-key="id"
                                             bordered
                                             size="small">
                                        <template #bodyCell="{ column, record }">
                                            <template v-if="column.key === 'logo'">
                                                <img v-if="record.logo?.[0]" :src="record.logo[0]" alt="Logo"
                                                     style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px"/>
                                            </template>
                                            <template v-if="column.key === 'action'">
                                                <a-button type="link" @click="removeBusiness(record.id)" danger>Xoá
                                                </a-button>
                                            </template>
                                        </template>
                                    </a-table>
                                </div>
                            </a-card>


                            <a-card title="Cửa hàng" style="margin-bottom: 24px;">
                                <!-- Cửa hàng -->
                                <a-form-item>
                                    <a-radio-group v-model:value="settings.store" @change="handleStoreModeChange">
                                        <a-radio :value="'all'">Tất cả cửa hàng</a-radio>
                                        <a-radio :value="'selected'">Chọn cửa hàng</a-radio>
                                    </a-radio-group>
                                </a-form-item>
                                <div v-if="settings.store === 'selected'" style="margin-bottom: 24px">
                                    <a-select mode="multiple" style="width: 100%; margin-bottom: 12px"
                                              placeholder="Chọn cửa hàng" v-model:value="selectedStores"
                                              @change="handleStoreSelect">
                                        <a-select-option v-for="s in allStores" :key="s.id" :value="s.id">
                                            {{ s.name }} - {{ s.address }}
                                        </a-select-option>
                                    </a-select>

                                    <a-table :columns="storeColumns" :data-source="storeList" row-key="id" bordered
                                             size="small">
                                        <template #bodyCell="{ column, record }">
                                            <template v-if="column.key === 'logo'">
                                                <img v-if="record.logo" :src="record.logo" alt="Logo"
                                                     style="height: 40px; width: 40px; object-fit: cover; border-radius: 4px"/>
                                            </template>
                                            <template v-if="column.key === 'action'">
                                                <a-button type="link" @click="removeStore(record.id)" danger>Xoá
                                                </a-button>
                                            </template>
                                        </template>
                                    </a-table>
                                </div>
                            </a-card>

                            <a-form-item>
                                <a-space>
                                    <a-button type="primary" @click="handleSubmit" :loading="loading">Lưu</a-button>
                                    <a-button @click="goBack">Huỷ</a-button>
                                </a-space>
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
                                <component
                                        :is="AsyncTemplate"
                                        :product="form"
                                        :business="businessList"
                                        :store="storeList"
                                        :all-businesses="allBusinesses"
                                        :all-stores="allStores"
                                />
                            </div>
                        </div>
                    </a-col>
                </a-row>
            </a-tab-pane>
        </a-tabs>

        <!-- Modal xem ảnh -->
        <a-modal v-model:open="previewVisible" :title="previewTitle" footer={null}>
            <img :src="previewImage" alt="Preview" style="width: 100%"/>
        </a-modal>
    </div>
</template>

<script setup>
    import {ref, onMounted, computed, defineAsyncComponent} from 'vue'
    import {useRoute, useRouter} from 'vue-router'
    import {createPerson, updatePerson, getPerson} from '../api/person'
    import {uploadFile} from '../api/product'
    import {message} from 'ant-design-vue'
    import templateOptions from '@/components/templates/persons'
    import {UploadOutlined} from '@ant-design/icons-vue'

    import {useUserStore} from '../stores/user'

    const userStore = useUserStore()

    const route = useRoute()
    const router = useRouter()

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


    const selectedCompanies = ref([])
    const selectedSurveys = ref([])

    const isEditMode = computed(() => !!route.params.id);

    const selectedTemplateData = computed(() =>
        templateOptions.find(t => t.id === settings.value.selectedTemplate)
    )

    const AsyncTemplate = computed(() => {
        return selectedTemplateData.value?.component ? defineAsyncComponent(selectedTemplateData.value.component) : null
    })

    const selectTemplate = (tpl) => {
        settings.value.selectedTemplate = tpl.id;
    }

    const isActiveTemplate = (tplId) => {
        return settings.value.selectedTemplate === tplId;
    }

    const settings = ref({
        selectedTemplate: 'tpl-1',         // Template hiển thị

        relatedProducts: 'all',            // 'all' hoặc 'selected'
        selectedProducts: [],              // ID sản phẩm được chọn khi relatedProducts = 'selected'

        company: 'all',                    // 'all' hoặc 'selected'
        selectedCompanies: [],             // ID công ty được chọn khi company = 'selected'

        store: 'all',                      // 'all' hoặc 'selected'
        selectedStores: [],                // ID cửa hàng được chọn khi store = 'selected'

    });


    const parseAvatar = (avatar) => {
        try {
            const parsed = JSON.parse(avatar);
            return Array.isArray(parsed) && parsed.length > 0 ? parsed[0] : ''
        } catch {
            return ''
        }
    }

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