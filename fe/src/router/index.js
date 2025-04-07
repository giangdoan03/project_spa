import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '../stores/user'
import { checkSession } from '../api/auth'

import LoginForm from '../components/LoginForm.vue'
import Dashboard from '../components/Dashboard.vue'
import Layout from '../components/Layout.vue'

const routes = [
    { path: '/', component: LoginForm },
    {
        path: '/',
        component: Layout,
        children: [
            { path: 'dashboard', component: Dashboard },
        ]
    },
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

router.beforeEach(async (to, from, next) => {
    try {
        const response = await checkSession()
        const data = response.data
        const isLoggedIn = data.status === 'success'

        if (isLoggedIn) {
            const userStore = useUserStore()
            userStore.setUser(data.user)
        }

        if (!isLoggedIn && to.path !== '/') {
            next('/')
        } else if (isLoggedIn && to.path === '/') {
            next('/dashboard')
        } else {
            next()
        }
    } catch (error) {
        console.error('Error in router guard:', error)
        next('/')
    }
})

export default router
