<template>
    <div>
        <a-page-header title="Thông tin người dùng & Cài đặt" class="header-title" />

        <a-form layout="vertical" @submit.prevent>
            <a-tabs v-model:activeKey="activeTab">
                <!-- Tab: Thông tin người dùng -->
                <a-tab-pane key="userInfo" tab="Thông tin người dùng">
                    <a-row :gutter="16">
                        <a-col :xs="24" :md="12">
                            <a-card>
                                <a-form-item label="Tên người dùng">
                                    <a-input v-model:value="userInfo.name" placeholder="Nhập tên" />
                                </a-form-item>

                                <a-form-item label="Email">
                                    <a-input v-model:value="userInfo.email" disabled />
                                </a-form-item>

                                <a-form-item label="Số điện thoại">
                                    <a-input v-model:value="userInfo.phone" />
                                </a-form-item>

                                <a-form-item label="Vai trò">
                                    <a-input v-model:value="userInfo.role" disabled />
                                </a-form-item>

                                <a-form-item label="Trạng thái">
                                    <a-input v-model:value="userInfo.status" />
                                </a-form-item>

                                <a-form-item>
                                    <a-checkbox v-model:checked="changePassword">Đổi mật khẩu</a-checkbox>
                                </a-form-item>

                                <a-form-item label="Mật khẩu hiện tại" v-if="changePassword">
                                    <a-input-password v-model:value="passwordForm.current" placeholder="Nhập mật khẩu hiện tại" />
                                </a-form-item>

                                <a-form-item label="Mật khẩu mới" v-if="changePassword">
                                    <a-input-password v-model:value="passwordForm.new" placeholder="Nhập mật khẩu mới" />
                                </a-form-item>

                                <a-form-item label="Xác nhận mật khẩu mới" v-if="changePassword">
                                    <a-input-password v-model:value="passwordForm.confirm" placeholder="Nhập lại mật khẩu mới" />
                                </a-form-item>

                                <a-form-item label="Ảnh đại diện">
                                    <a-image
                                        :src="userInfo.avatar"
                                        style="width: 100px; height: 100px; object-fit: cover"
                                        v-if="userInfo.avatar"
                                    />
                                </a-form-item>
                            </a-card>
                        </a-col>
                    </a-row>
                </a-tab-pane>

                <!-- Tab: Cài đặt người dùng -->
                <a-tab-pane key="userSettings" tab="Cài đặt người dùng">
                    <a-table
                        :columns="columns"
                        :data-source="settings"
                        row-key="id"
                        :loading="loading"
                        :pagination="false"
                    >
                        <template #bodyCell="{ column, record }">
                            <template v-if="column.key === 'action'">
                                <a-space>
                                    <a-button type="link" @click="edit(record)">Sửa</a-button>
                                    <a-popconfirm title="Xoá cài đặt này?" @confirm="remove(record.id)">
                                        <a-button type="link" danger>Xoá</a-button>
                                    </a-popconfirm>
                                </a-space>
                            </template>
                        </template>
                    </a-table>

                    <a-divider />

                    <a-form layout="inline">
                        <a-form-item>
                            <a-input v-model:value="newSetting.key" placeholder="Key" />
                        </a-form-item>
                        <a-form-item>
                            <a-input v-model:value="newSetting.value" placeholder="Value" />
                        </a-form-item>
                    </a-form>
                </a-tab-pane>
            </a-tabs>

            <!-- Nút lưu tổng hợp -->
            <a-form-item style="margin-top: 24px">
                <a-button type="primary" @click="saveAll">Lưu tất cả</a-button>
            </a-form-item>
        </a-form>
    </div>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import { message } from 'ant-design-vue'
import {
    getSettings,
    createSetting,
    deleteSetting,
    updateSetting
} from '../api/setting'

import { getUser, updateUser, changePasswordAPI } from '../api/user'
import { useUserStore } from '../stores/user'

const activeTab = ref('userInfo')
const userStore = useUserStore()
const userInfo = ref({})
const changePassword = ref(false)
const passwordForm = reactive({
    current: '',
    new: '',
    confirm: ''
})

const settings = ref([])
const loading = ref(false)
const newSetting = ref({ id: null, key: '', value: '' })

const columns = [
    { title: 'Key', dataIndex: 'key', key: 'key' },
    { title: 'Value', dataIndex: 'value', key: 'value' },
    { title: 'Hành động', key: 'action' }
]

onMounted(async () => {
    const userId = userStore.user?.id
    if (userId) {
        const res = await getUser(userId)
        userInfo.value = res.data
    }
    await fetchSettings()
})

const fetchSettings = async () => {
    loading.value = true
    try {
        const res = await getSettings()
        settings.value = res.data
    } catch (err) {
        message.error('Không thể tải cài đặt')
    } finally {
        loading.value = false
    }
}

const edit = (item) => {
    newSetting.value = { ...item }
}

const remove = async (id) => {
    try {
        await deleteSetting(id)
        message.success('Đã xoá')
        fetchSettings()
    } catch (err) {
        message.error('Lỗi khi xoá')
    }
}

const saveAll = async () => {
    try {
        // Cập nhật thông tin người dùng
        await updateUser(userInfo.value.id, {
            name: userInfo.value.name,
            phone: userInfo.value.phone,
            status: userInfo.value.status
        })

        // Đổi mật khẩu nếu có chọn
        if (changePassword.value) {
            if (passwordForm.new !== passwordForm.confirm) {
                return message.error('Mật khẩu mới không khớp')
            }
            await changePasswordAPI({
                current_password: passwordForm.current,
                new_password: passwordForm.new
            })
            message.success('Đã đổi mật khẩu thành công')
        }

        // Lưu cài đặt nếu có
        if (newSetting.value.key && newSetting.value.value) {
            if (newSetting.value.id) {
                await updateSetting(newSetting.value.id, newSetting.value)
                message.success('Đã cập nhật cài đặt')
            } else {
                await createSetting(newSetting.value)
                message.success('Đã thêm cài đặt')
            }
            newSetting.value = { id: null, key: '', value: '' }
            await fetchSettings()
        }

        message.success('Đã lưu toàn bộ thông tin')
    } catch (err) {
        console.error('Lỗi khi lưu:', err)
        message.error(err?.response?.data?.message || 'Lỗi khi lưu dữ liệu')
    }
}
</script>
<style>
.header-title {
    padding-left: 0;
    padding-right: 0;
    padding-top: 0;
}
</style>
