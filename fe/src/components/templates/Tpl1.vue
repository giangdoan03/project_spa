<template>
    <div class="tpl-wrapper">
        <div class="tpl-image">
            <img :src="thumbnail" alt="Sản phẩm"/>
        </div>

        <div class="tpl-info">
            <div class="tpl-price-section">
                <div class="tpl-name">{{ title }}</div>
                <div class="tpl-price">$10,000</div>
                <div class="tpl-code">34234234324234234</div>
                <div class="tpl-size">Kích thước: <span class="pill">XS</span></div>
            </div>

            <div class="tpl-company">
                <div class="tpl-company-label">Company</div>
                <div class="tpl-company-detail">
                    <div class="company-logo">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Ant_Design_Logo_1x.svg/768px-Ant_Design_Logo_1x.svg.png"
                             alt="logo"/>
                    </div>
                    <div class="company-info">
                        <div class="company-name">cua hang demo</div>
                        <div class="company-phone">+84912345678</div>
                    </div>
                </div>
            </div>
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
    .tpl-name {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 6px;
        display: -webkit-box;
        -webkit-line-clamp: 2; /* Tối đa 2 dòng */
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .tpl-wrapper {
        font-family: 'Segoe UI', sans-serif;
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        color: #000;
        display: flex;
        flex-direction: column;
        height: 100%;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    }

    .tpl-image img {
        width: 100%;
        height: auto;
        object-fit: cover;
        display: block;
    }

    .tpl-info {
        display: flex;
        flex-direction: column;
        padding: 16px;
        gap: 16px;
    }

    .tpl-price-section {
        background: #22c55e;
        padding: 16px;
        border-radius: 8px;
        color: #fff;
    }

    .tpl-name {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 6px;
    }

    .tpl-price {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 4px;
    }

    .tpl-code {
        font-size: 13px;
        opacity: 0.9;
        margin-bottom: 4px;
    }

    .tpl-size {
        font-size: 13px;
    }

    .pill {
        background: #fff;
        color: #22c55e;
        padding: 2px 8px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 12px;
    }

    .tpl-company {
        background: #f5f5f5;
        padding: 12px;
        border-radius: 8px;
    }

    .tpl-company-label {
        font-weight: bold;
        font-size: 14px;
        margin-bottom: 8px;
    }

    .tpl-company-detail {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .company-logo img {
        width: 32px;
        height: 32px;
        object-fit: contain;
    }

    .company-info {
        display: flex;
        flex-direction: column;
    }

    .company-name {
        font-size: 14px;
        font-weight: 600;
    }

    .company-phone {
        font-size: 13px;
        color: #22c55e;
    }
</style>