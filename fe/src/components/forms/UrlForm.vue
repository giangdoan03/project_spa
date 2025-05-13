<template>
    <a-form layout="vertical">
        <a-form-item label="Liên kết/URL">
            <a-input v-model:value="phone" placeholder="Nhập URL/Liên kết" />
        </a-form-item>
        <a-form-item label="Tên QR">
            <a-textarea v-model:value="message" :rows="3" placeholder="Nhập tên cho QR của bạn" />
        </a-form-item>
    </a-form>
</template>

<script setup>
import { computed } from 'vue'
const form = defineModel()

const phone = computed({
    get: () => form?.settings?.phone || '',
    set: val => {
        if (form?.settings) form.settings.phone = val
    }
})

const message = computed({
    get: () => form?.settings?.message || '',
    set: val => {
        if (form?.settings) form.settings.message = val
    }
})
</script>
