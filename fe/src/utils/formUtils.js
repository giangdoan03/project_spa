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
