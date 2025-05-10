// main.js

Handlebars.registerHelper("eq", (a, b) => a === b);
Handlebars.registerHelper("gt", (a, b) => a > b);

async function loadTemplate(id, url) {
    const res = await fetch(url);
    const tpl = await res.text();
    const script = document.createElement('script');
    script.id = id;
    script.type = 'text/x-handlebars-template';
    script.innerHTML = tpl;
    document.body.appendChild(script);
}

(async () => {
    await loadTemplate('product-template', '/templates/product-template.html');
    await loadTemplate('store-template', '/templates/store-template.html');
    await renderQRPage();
})();

async function renderQRPage() {
    const qrId = window.location.pathname.split("/").filter(Boolean)[0];
    const infoEl = document.getElementById("info");

    if (!qrId) {
        infoEl.innerHTML = `<p class="text-center p-4">Không tìm thấy mã QR</p>`;
        return;
    }

    const API_BASE = 'http://api.giang.test/api';

    try {
        const res = await fetch(`${API_BASE}/qr-codes/detail/${qrId}`);
        const data = await res.json();

        if (!data.qr || !data.target) {
            infoEl.innerHTML = `<p class="text-center p-4">QR không tồn tại hoặc không có dữ liệu.</p>`;
            return;
        }

        const { qr, target } = data;
        const images = Array.isArray(target.images)
            ? target.images.map(img => typeof img === 'string' ? img : img?.url)
            : [];

        // Lấy template phù hợp
        let templateId;
        switch (qr.target_type) {
            case 'product': templateId = 'product-template'; break;
            case 'store': templateId = 'store-template'; break;
            case 'event': templateId = 'event-template'; break;
            case 'person': templateId = 'person-template'; break;
            case 'company': templateId = 'company-template'; break;
            default: templateId = 'product-template';
        }

        // Nếu là store, fetch toàn bộ danh sách sản phẩm
        if (qr.target_type === 'store') {
            const productRes = await fetch(`${API_BASE}/products`);
            const productData = await productRes.json();
            const allProducts = Array.isArray(productData.data) ? productData.data : [];

            const displaySettings = safeParse(target.display_settings, {});
            const selectedIds = displaySettings.selectedProducts || [];

            target.selectedProducts = allProducts
                .filter(p => selectedIds.includes(String(p.id)))
                .map(p => ({
                    ...p,
                    image: Array.isArray(p.avatar) ? p.avatar[0] : p.avatar,
                    count: 'x1' // hoặc tuỳ logic
                }));

            // Giả lập relatedBusinesses (nếu cần)
            target.relatedBusinesses = [
                {
                    logo: "https://via.placeholder.com/48x48?text=B1",
                    name: "demo",
                    phone: "+84912345678"
                },
                {
                    logo: "https://via.placeholder.com/48x48?text=B2",
                    name: "cua hang democcc",
                    phone: "+84912345678"
                }
            ];
        }

        const templateEl = document.getElementById(templateId);
        if (!templateEl) {
            setTimeout(renderQRPage, 100);
            return;
        }

        const template = Handlebars.compile(templateEl.innerHTML);

        infoEl.innerHTML = template({
            qr,
            product: target,
            images,
            attributes: safeParse(target.attributes, []),
            productLinks: safeParse(target.display_settings, {}).productLinks || [],
            price: formatPrice(target.price)
        });

        if (images.length > 1) {
            requestAnimationFrame(() => {
                new Swiper(".mySwiper", {
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                });
            });
        }

    } catch (err) {
        infoEl.innerHTML = `<p class="text-center p-4">Lỗi kết nối máy chủ</p>`;
        console.error(err);
    }
}


function safeParse(val, fallback = {}) {
    try {
        return typeof val === 'string' ? JSON.parse(val) : (val || fallback);
    } catch {
        return fallback;
    }
}

function formatPrice(price) {
    const p = parseFloat(price || 0);
    return isNaN(p) ? '' : `${p.toLocaleString("vi-VN")} ₫`;
}
