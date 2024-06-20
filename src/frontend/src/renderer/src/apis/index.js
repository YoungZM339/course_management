import axios from 'axios'
import router from '../routers'

const api = axios.create({
  timeout: 1000,
  headers: {'Content-Type': 'application/json'}
})

api.interceptors.request.use(
  async (config) => {
    let token = localStorage.getItem('token')
    const refreshToken = localStorage.getItem('refreshToken')

    if (!token && refreshToken) {
      try {
        const {data} = await api.post('/refresh-token', {refreshToken})
        token = data.token
        localStorage.setItem('token', token)
      } catch (err) {
        router.push('/login')
        return Promise.reject(err)
      }
    }

    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config
    if (error.response.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true
      const refreshToken = localStorage.getItem('refreshToken')
      if (refreshToken) {
        try {
          const {data} = await api.post('/refresh-token', {refreshToken})
          localStorage.setItem('token', data.token)
          originalRequest.headers.Authorization = `Bearer ${data.token}`
          return api.request(originalRequest)
        } catch (err) {
          localStorage.removeItem('token')
          localStorage.removeItem('refreshToken')
          router.push('/login')
          return Promise.reject(err)
        }
      } else {
        router.push('/login')
      }
    }
    return Promise.reject(error)
  }
)


export default api
