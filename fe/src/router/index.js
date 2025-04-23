import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '../stores/user'
import { checkSession } from '../api/auth'

// Components
import LoginForm from '../components/LoginForm.vue'
import Dashboard from '../components/Dashboard.vue'
import Layout from '../components/Layout.vue'

import ProductList from '../components/ProductList.vue'
import ProductForm from '../components/ProductForm.vue'

import BusinessList from '../components/BusinessList.vue'
import BusinessForm from '../components/BusinessForm.vue'

import MyQRCodes from '../components/MyQRCodes.vue'
import QRCreateForm from '../components/QRCreateForm.vue'

import PersonList from '../components/PersonList.vue'
import PersonForm from '../components/PersonForm.vue'

import EventList from '../components/EventList.vue'
import EventForm from '../components/EventForm.vue'

import StoreList from '../components/StoreList.vue'
import StoreForm from '../components/StoreForm.vue'

import UserPermissionManager from '../components/UserPermissionManager.vue'


const routes = [
    {
        path: '/',
        component: LoginForm
    },
    {
        path: '/',
        component: Layout,
        children: [
            { path: 'dashboard', component: Dashboard },

            // Products
            { path: 'products', component: ProductList },
            { path: 'products/create', component: ProductForm },
            { path: 'products/:id/edit', component: ProductForm },

            // QR Codes
            { path: 'my-qr-codes', component: MyQRCodes },
            { path: 'my-qr-codes/create', component: QRCreateForm },

            // Businesses
            { path: 'businesses', component: BusinessList },
            { path: 'businesses/create', component: BusinessForm },
            { path: 'businesses/:id/edit', component: BusinessForm },

            // Persons
            { path: 'persons', component: PersonList },
            { path: 'persons/create', component: PersonForm },
            { path: 'persons/:id/edit', component: PersonForm },

            // Events ✅ mới thêm
            { path: 'events', component: EventList },
            { path: 'events/create', component: EventForm },
            { path: 'events/:id/edit', component: EventForm },

            // Stores ✅ mới thêm
            { path: 'stores', component: StoreList },
            { path: 'stores/create', component: StoreForm },
            { path: 'stores/:id/edit', component: StoreForm },

            { path: 'permissions', component: UserPermissionManager }
        ]
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
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
