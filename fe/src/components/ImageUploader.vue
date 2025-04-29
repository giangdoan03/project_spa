<template>
    <div>
        <h3>Hình Ảnh</h3>
        <div style="display: flex; flex-wrap: wrap; gap: 10px">
            <div
                    v-for="(image, index) in imageList"
                    :key="index"
                    style="position: relative; width: 100px; height: 100px; border: 1px solid #ccc; border-radius: 8px; overflow: hidden"
            >
                <img :src="image.url" alt="image" style="width: 100%; height: 100%; object-fit: cover" />
                <span
                        v-if="image.isCover"
                        style="position: absolute; bottom: 0; left: 0; right: 0; background: rgba(0,0,0,0.6); color: #fff; font-size: 12px; text-align: center"
                >
          Đặt hình đại diện
        </span>
                <button
                        @click="removeImage(index)"
                        style="position: absolute; top: 2px; right: 2px; background: red; color: white; border: none; border-radius: 50%; width: 20px; height: 20px; cursor: pointer"
                >×</button>
                <button
                        @click="setAsCover(index)"
                        style="position: absolute; bottom: 2px; left: 2px; background: #000; color: white; font-size: 10px; padding: 2px; border-radius: 4px; cursor: pointer"
                >Chọn</button>
            </div>

            <!-- Nút Thêm -->
            <div style="width: 100px; height: 100px; display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px dashed #ccc; border-radius: 8px; cursor: pointer">
                <input type="file" accept="image/*" @change="handleFileUpload" style="display: none" ref="fileInput" />
                <button @click="$refs.fileInput.click()">Thêm</button>
                <a @click="showUrlModal = true" style="color: green; font-size: 12px; margin-top: 4px; cursor: pointer">Thêm từ URL</a>
            </div>
        </div>

        <!-- Popup nhập URL -->
        <div v-if="showUrlModal" style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center">
            <div style="background: white; padding: 20px; border-radius: 10px; width: 300px">
                <h4>Thêm từ URL</h4>
                <input v-model="urlInput" placeholder="Nhập URL" style="width: 100%; padding: 8px; margin-bottom: 10px" />
                <div style="text-align: right">
                    <button @click="showUrlModal = false" style="margin-right: 8px">Hủy</button>
                    <button @click="addFromUrl">Thêm</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    import { ref } from 'vue'

    const imageList = ref([])
    const showUrlModal = ref(false)
    const urlInput = ref('')

    function handleFileUpload(event) {
        const file = event.target.files[0]
        if (file) {
            const reader = new FileReader()
            reader.onload = () => {
                imageList.value.push({ url: reader.result, isCover: false })
            }
            reader.readAsDataURL(file)
            event.target.value = ''
        }
    }

    function addFromUrl() {
        if (urlInput.value) {
            imageList.value.push({ url: urlInput.value, isCover: false })
            urlInput.value = ''
            showUrlModal.value = false
        }
    }

    function removeImage(index) {
        imageList.value.splice(index, 1)
    }

    function setAsCover(index) {
        imageList.value.forEach((img, i) => img.isCover = (i === index))
    }
</script>
