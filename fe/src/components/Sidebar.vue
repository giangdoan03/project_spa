<template>
    <a-layout-sider
        :collapsed="collapsed"
        :trigger="null"
        collapsible
        collapsedWidth="0"
        breakpoint="lg"
        @breakpoint="handleBreakpoint"
        @collapse="handleCollapse"
    >
        <div class="logo" />
        <a-menu
            :selectedKeys="selectedKeys"
            theme="dark"
            mode="inline"
            @update:selectedKeys="handleSelectedKeys"
        >
            <a-menu-item key="1">
                <UserOutlined />
                <span>nav 1</span>
            </a-menu-item>

            <a-sub-menu key="sub1">
                <template #title>
          <span>
            <VideoCameraOutlined />
            <span>Sub Menu</span>
          </span>
                </template>
                <a-menu-item key="2-1">Sub Item 1</a-menu-item>
                <a-menu-item key="2-2">Sub Item 2</a-menu-item>
            </a-sub-menu>

            <a-menu-item key="3">
                <UploadOutlined />
                <span>nav 3</span>
            </a-menu-item>
        </a-menu>
    </a-layout-sider>
</template>

<script setup>

import { UserOutlined, VideoCameraOutlined, UploadOutlined } from '@ant-design/icons-vue'

const props = defineProps({
    collapsed: Boolean,
    selectedKeys: Array
})

const emit = defineEmits(['update:collapsed', 'update:selectedKeys'])

// Khi vỡ layout responsive
const handleBreakpoint = (broken) => {
    emit('update:collapsed', broken)
}

// Khi collapse thủ công
const handleCollapse = (collapsed) => {
    emit('update:collapsed', collapsed)
}

// Khi chọn menu
const handleSelectedKeys = (selectedKeys) => {
    emit('update:selectedKeys', selectedKeys)
}
</script>

<style scoped>
.logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.3);
    margin: 16px;
}
</style>
