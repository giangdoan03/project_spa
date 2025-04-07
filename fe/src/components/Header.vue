<template>
    <a-layout-header style="background: #fff; padding: 0; display: flex; justify-content: space-between; align-items: center;">
        <div>
            <MenuUnfoldOutlined
                v-if="collapsed"
                class="trigger"
                @click="emit('toggle')"
            />
            <MenuFoldOutlined
                v-else
                class="trigger"
                @click="emit('toggle')"
            />
        </div>

        <div style="margin-right: 24px; display: flex; align-items: center;">
      <span v-if="user" style="margin-right: 12px;">
        {{ user.email }}
      </span>
            <a-button
                v-if="user"
                type="text"
                danger
                shape="circle"
                @click="emit('logout')"
            >
                <template #icon>
                    <LogoutOutlined />
                </template>
            </a-button>
        </div>
    </a-layout-header>
</template>

<script setup>

import { storeToRefs } from 'pinia'
import { useUserStore } from '../stores/user'
import { MenuUnfoldOutlined, MenuFoldOutlined, LogoutOutlined } from '@ant-design/icons-vue'

const props = defineProps({
    collapsed: Boolean,
    user: Object
})


const emit = defineEmits(['toggle', 'logout'])

const userStore = useUserStore()
const { user } = storeToRefs(userStore)
</script>

<style scoped>
.trigger {
    font-size: 18px;
    line-height: 64px;
    padding: 0 24px;
    cursor: pointer;
    transition: color 0.3s;
}

.trigger:hover {
    color: #1890ff;
}
</style>
