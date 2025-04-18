import axios from 'axios'

const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL, // Đúng nè!
})

export const getProducts = (params) => api.get('/products', { params })
export const getProduct = (id) => api.get(`/products/${id}`)
export const createProduct = (data) => api.post('/products', data)
export const updateProduct = (id, data) => api.put(`/products/${id}`, data)
export const deleteProduct = (id) => api.delete(`/products/${id}`)

export const uploadFile = (file) => {
    const formData = new FormData()
    formData.append('file', file)
    return api.post('/upload', formData)
}
