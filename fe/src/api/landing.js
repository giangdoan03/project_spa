import axios from 'axios'

const instance = axios.create({
    baseURL: 'http://api.giang.test/api',
    withCredentials: true,
})

// Danh sách landing pages
export const getLandingPages = (params) => instance.get('/landing-pages', { params })

// Lấy chi tiết một landing page
export const getLandingPage = (id) => instance.get(`/landing-pages/${id}`)

// Tạo mới landing page
export const createLandingPage = (data) => instance.post('/landing-pages', data)

// Cập nhật landing page
export const updateLandingPage = (id, data) => instance.put(`/landing-pages/${id}`, data)

// Xoá landing page
export const deleteLandingPage = (id) => instance.delete(`/landing-pages/${id}`)
