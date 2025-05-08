export const normalizeProductData = (data) => {
    const fieldsToParse = ['avatar', 'image', 'video', 'certificate_file']

    fieldsToParse.forEach(field => {
        const value = data[field]

        if (!value) {
            data[field] = []
        } else if (Array.isArray(value)) {
            // Đã là mảng → dùng luôn
            data[field] = value
        } else if (typeof value === 'string') {
            try {
                const parsed = JSON.parse(value)
                data[field] = Array.isArray(parsed) ? parsed : [parsed]
            } catch (e) {
                // Nếu JSON.parse lỗi, giữ nguyên chuỗi gốc
                data[field] = []
            }
        } else {
            // Trường hợp không rõ → fallback về mảng rỗng
            data[field] = []
        }
    })

    data.show_contact_price = !!Number(data.show_contact_price)
    data.status = !!Number(data.status)

    return data
}



export const formatDate = (value) => {
    if (!value) return ''
    const date = new Date(value)
    return date.toLocaleString('vi-VN', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
    })
}


export const parseFieldsForList = (list, fields = ['logo']) => {
    return list.map(item => {
        fields.forEach(field => {
            const value = item[field]
            if (typeof value === 'string') {
                try {
                    const parsed = JSON.parse(value)
                    item[field] = Array.isArray(parsed) ? parsed : []
                } catch (e) {
                    item[field] = []
                }
            }
        })
        return item
    })
}
