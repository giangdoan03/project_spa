<template>
    <a-form layout="vertical">
        <a-form-item label="Nội dung văn bản">
            <a-textarea
                v-model:value="form.settings.data"
                :rows="4"
                placeholder="Nhập nội dung văn bản..."
            />
        </a-form-item>
    </a-form>
</template>

<script setup>
import { computed } from 'vue'

// Nhận prop từ component cha qua v-model (defineModel)
const form = defineModel()

// Dùng computed để ánh xạ `form.settings.data`
const text = computed({
    get: () => form?.settings?.data || '',
    set: (val) => {
        if (form?.settings) form.settings.data = val
    }
})
</script>
