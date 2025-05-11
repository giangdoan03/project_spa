<template>
    <div>
        <a-page-header title="Quản lý người dùng" class="title-no-pd-l-r" />

        <a-row justify="space-between" style="margin-bottom: 16px">
            <a-col>
                <a-input-search
                    v-model:value="search"
                    placeholder="Tìm theo tên, email, hoặc số điện thoại"
                    @search="fetchUsers"
                    style="width: 300px"
                />
            </a-col>
            <a-col>
                <a-button type="primary" @click="openCreateModal">Thêm người dùng</a-button>
            </a-col>
        </a-row>

        <a-table
            :columns="columns"
            :data-source="users"
            :loading="loading"
            row-key="id"
            :pagination="pagination"
            @change="handleTableChange"
        >
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'avatar'">
                    <a-avatar :src="record.avatar" :alt="record.name" />
                </template>
                <template v-else-if="column.key === 'actions'">
                    <a-space>
                        <a-button type="link" @click="editUser(record)">Sửa</a-button>
                        <a-popconfirm title="Xoá người dùng này?" @confirm="deleteUser(record.id)">
                            <a-button type="link" danger>Xoá</a-button>
                        </a-popconfirm>
                    </a-space>
                </template>
                <template v-else>
                    {{ record[column.key] }}
                </template>
            </template>
        </a-table>

        <!-- Modal tạo/sửa -->
        <a-modal
            :open="showCreateModal"
            title="Tạo người dùng mới"
            @ok="saveUser"
            @cancel="closeCreateModal"
            :maskClosable="true"
        >
            <a-form layout="vertical">
                <a-form-item label="Tên">
                    <a-input v-model:value="form.name" />
                </a-form-item>
                <a-form-item label="Email">
                    <a-input v-model:value="form.email" />
                </a-form-item>
                <a-form-item label="Số điện thoại">
                    <a-input v-model:value="form.phone" />
                </a-form-item>
                <a-form-item label="Vai trò">
                    <a-select v-model:value="form.role_id">
                        <a-select-option v-for="role in roles" :key="role.id" :value="role.id">
                            {{ role.name }}
                        </a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Trạng thái">
                    <a-select v-model:value="form.status">
                        <a-select-option value="active">Hoạt động</a-select-option>
                        <a-select-option value="inactive">Ngưng hoạt động</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="Ảnh đại diện">
                    <a-upload
                        list-type="picture-card"
                        :file-list="avatarFileList"
                        :on-preview="handlePreview"
                        :on-remove="file => handleRemoveFile('avatar', file)"
                        :before-upload="file => handleBeforeUploadSingle('avatar', file)"
                        :max-count="1"
                    >
                        <div v-if="avatarFileList.length === 0">
                            <upload-outlined />
                            <div style="margin-top: 8px">Tải ảnh</div>
                        </div>
                    </a-upload>
                </a-form-item>
                <a-form-item label="Mật khẩu" v-if="!form.id">
                    <a-input-password v-model:value="form.password" />
                </a-form-item>
            </a-form>
        </a-modal>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import {UploadOutlined} from '@ant-design/icons-vue'
import {
    getUsers,
    createUser,
    updateUser,
    deleteUserById,
    uploadFile
} from '../api/user'
import { getRoles } from '../api/permission'

const users = ref([])
const loading = ref(false)
const search = ref('')
const showCreateModal = ref(false)
const form = ref({})
const roles = ref([])
const avatarFileList = ref([])

const pagination = ref({ total: 0, pageSize: 10, current: 1 })

const columns = [
    { title: 'Avatar', key: 'avatar' },
    { title: 'Tên', key: 'name' },
    { title: 'Email', key: 'email' },
    { title: 'Số điện thoại', key: 'phone' },
    { title: 'Vai trò', key: 'role' },
    { title: 'Thao tác', key: 'actions' },
]

const fetchUsers = async () => {
    loading.value = true
    try {
        const res = await getUsers({
            page: pagination.value.current,
            per_page: pagination.value.pageSize,
            search: search.value,
        })
        users.value = res.data.data
        pagination.value.total = res.data.pager.total
    } catch (e) {
        message.error('Không thể tải danh sách người dùng')
    } finally {
        loading.value = false
    }
}

const handleTableChange = (paginationData) => {
    pagination.value.current = paginationData.current
    pagination.value.pageSize = paginationData.pageSize
    fetchUsers()
}

const saveUser = async () => {
    loading.value = true
    try {
        if (Array.isArray(form.value.avatar)) {
            form.value.avatar = form.value.avatar[0]
        }
        if (form.value.id) {
            await updateUser(form.value.id, form.value)
            message.success('Đã cập nhật người dùng')
        } else {
            await createUser(form.value)
            message.success('Đã thêm người dùng')
        }
        closeCreateModal()
        fetchUsers()
    } catch (e) {
        message.error('Lỗi khi lưu người dùng')
    } finally {
        loading.value = false
    }
}

const editUser = (record) => {
    form.value = { ...record, avatar: record.avatar ? [record.avatar] : [] }
    avatarFileList.value = record.avatar ? [{ url: record.avatar, name: 'avatar', status: 'done' }] : []
    showCreateModal.value = true
}

const deleteUser = async (id) => {
    loading.value = true
    try {
        await deleteUserById(id)
        message.success('Đã xoá người dùng')
        fetchUsers()
    } catch (e) {
        message.error('Không thể xoá người dùng')
    } finally {
        loading.value = false
    }
}

const openCreateModal = () => {
    form.value = {}
    avatarFileList.value = []
    showCreateModal.value = true
}

const closeCreateModal = () => {
    showCreateModal.value = false
}

const handlePreview = file => {
    window.open(file.url, '_blank')
}

const handleRemoveFile = (field, file) => {
    form.value[field] = []
    avatarFileList.value = []
}

const handleBeforeUploadSingle = async (field, file) => {
    const { data } = await uploadFile(file)
    form.value[field] = [data.url]
    avatarFileList.value = [{ uid: Date.now().toString(), name: file.name, status: 'done', url: data.url }]
    return false
}

onMounted(async () => {
    await fetchUsers()
    const res = await getRoles()
    roles.value = res.data
})
</script>

<style scoped>
.title-no-pd-l-r {
    padding-left: 0;
    padding-right: 0;
}
</style>