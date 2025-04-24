import axios from 'axios'

const instance = axios.create({
    baseURL: 'http://api.giang.test/api',
    withCredentials: true, // 👈 Bắt buộc để giữ session
})

export const getEvents = (params) => instance.get('/events', { params })
export const getEvent = (id) => instance.get(`/events/${id}`)
export const createEvent = (data) => instance.post('/events', data)
export const updateEvent = (id, data) => instance.put(`/events/${id}`, data)
export const deleteEvent = (id) => instance.delete(`/events/${id}`)
