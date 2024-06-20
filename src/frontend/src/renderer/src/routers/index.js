import {createRouter, createWebHashHistory} from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/course-admin',
    name: 'CourseAdmin',
    component: () => import('../views/CourseAdmin.vue')
  },
  {
    path: '/teacher-admin',
    name: 'TeacherAdmin',
    component: () => import('../views/TeacherAdmin.vue')
  },
  {
    path: '/search',
    name: 'Search',
    component: () => import('../views/Search.vue')
  },
  {
    path: '/teacher-selection',
    name: 'TeacherSelection',
    component: () => import('../views/Assign.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
