import axios from 'axios'

const instance = axios.create({
    baseURL: 'http://api.giang.test/api'
})

export const getStores = (params) => instance.get('/stores', { params })
export const getStore = (id) => instance.get(`/stores/${id}`)
export const createStore = (data) => instance.post('/stores', data)
export const updateStore = (id, data) => instance.put(`/stores/${id}`, data)
export const deleteStore = (id) => instance.delete(`/stores/${id}`)
