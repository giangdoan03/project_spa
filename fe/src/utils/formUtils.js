export const normalizeProductData = (data) => {
    const fieldsToParse = ['avatar', 'image', 'video', 'certificate_file']
    fieldsToParse.forEach(field => {
        try {
            data[field] = JSON.parse(data[field] || '[]')
        } catch {
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