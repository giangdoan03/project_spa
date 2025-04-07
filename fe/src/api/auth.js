import axios from 'axios'

const apiClient = axios.create({
    baseURL: 'http://api.giang.test',
    withCredentials: true
})

export const login = (email, password) => {
    return apiClient.post('/login', { email, password })
}

export const logout = () => {
    return apiClient.get('/logout')
}

export const checkSession = () => {
    return apiClient.get('/check')
}
