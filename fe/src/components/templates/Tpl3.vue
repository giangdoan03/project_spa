<template>
    <div class="tpl3-wrapper">
        <div class="tpl3-header">
            <img :src="thumbnail" alt="Sản phẩm" />
        </div>

        <div class="tpl3-info">
            <div class="tpl3-title">{{ title }}</div>
            <div class="tpl3-price">$10,000</div>
            <div class="tpl3-size">Kích thước: <span class="pill">XS</span></div>
        </div>

        <div class="tpl3-button">
            <a-button block shape="round">{{ description }}</a-button>
        </div>

        <div class="tpl3-description">
            <div class="tpl3-tab">
                <div class="tab-title">{{ title }}</div>
                <div class="tab-content">Mô tả Sản phẩm</div>
            </div>
        </div>

        <div class="tpl3-company">
            <div class="tpl3-company-title">Company</div>
            <div class="tpl3-company-box">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Ant_Design_Logo_1x.svg/768px-Ant_Design_Logo_1x.svg.png" class="logo" />
                <div class="info">
                    <div class="name">cua hang demo</div>
                    <div class="phone">+84912345678</div>
                </div>
            </div>
        </div>

        <div class="tpl3-related">
            <div class="tpl3-related-title">Related products</div>
            <div class="tpl3-related-item">
                <img :src="thumbnail" />
                <div class="name">{{ title }}</div>
                <div class="price">$10,000</div>
            </div>
        </div>

        <div class="tpl3-powered">
            <span>Powered by <strong>iCheckQR</strong></span>
        </div>
    </div>
</template>

<script setup>
defineProps({
    title: String,
    description: String,
    thumbnail: String,
})
</script>

<style scoped>
.tpl3-wrapper {
    font-family: 'Segoe UI', sans-serif;
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    color: #111;
    display: flex;
    flex-direction: column;
    height: 100%;
    padding-bottom: 32px;
}

.tpl3-header img {
    width: 100%;
    object-fit: cover;
}

.tpl3-info {
    padding: 16px;
}

.tpl3-title {
    font-weight: 600;
    font-size: 18px;
    margin-bottom: 6px;
}

.tpl3-price {
    font-size: 20px;
    color: #8b4513;
    font-weight: bold;
    margin-bottom: 4px;
}

.tpl3-size {
    font-size: 14px;
    color: #555;
}

.pill {
    background: #eee;
    padding: 2px 8px;
    border-radius: 12px;
    font-weight: 600;
    font-size: 12px;
    margin-left: 6px;
}

.tpl3-button {
    padding: 0 16px;
}

.tpl3-description {
    padding: 16px;
}

.tpl3-tab {
    background: #fff;
    padding: 12px;
    border-radius: 12px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.tab-title {
    font-weight: 600;
    font-size: 14px;
    margin-bottom: 6px;
}

.tab-content {
    font-size: 13px;
    color: #444;
}

.tpl3-company {
    background: #fcf5f0;
    padding: 16px;
    margin-top: 12px;
}

.tpl3-company-title {
    font-weight: bold;
    font-size: 14px;
    margin-bottom: 8px;
}

.tpl3-company-box {
    display: flex;
    gap: 12px;
    align-items: center;
    background: #fff;
    padding: 12px;
    border-radius: 12px;
}

.logo {
    width: 32px;
    height: 32px;
}

.info .name {
    font-weight: 600;
    font-size: 14px;
}

.info .phone {
    font-size: 13px;
    color: #555;
}

.tpl3-related {
    padding: 16px;
}

.tpl3-related-title {
    font-weight: 600;
    font-size: 14px;
    margin-bottom: 8px;
}

.tpl3-related-item {
    text-align: center;
}

.tpl3-related-item img {
    width: 100%;
    border-radius: 8px;
    margin-bottom: 8px;
}

.tpl3-related-item .name {
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 4px;
}

.tpl3-related-item .price {
    font-weight: bold;
    color: #333;
}

.tpl3-powered {
    text-align: center;
    font-size: 12px;
    color: #888;
    margin-top: 16px;
}
</style>