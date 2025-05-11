import axios from 'axios'

const instance = axios.create({
    baseURL: import.meta.env.VITE_API_URL,
    withCredentials: true // 👈 Giữ session cho login
})

export const getCustomers = (params = {}) => instance.get('/customers', { params })
export const getCustomer = (id) => instance.get(`/customer/${id}`)
export const createCustomer = (data) => instance.post('/customer', data)
export const updateCustomer = (id, data) => instance.put(`/customer/${id}`, data)
export const deleteCustomer = (id) => instance.delete(`/customer/${id}`)
