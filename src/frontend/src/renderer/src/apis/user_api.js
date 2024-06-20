import api from "./index";

export const login = async (username, password) => {
  try {
    const {data} = await api.post('/login', {username, password})
    localStorage.setItem('token', data.token)
    localStorage.setItem('refreshToken', data.refreshToken)
    return data
  } catch (error) {
    return Promise.reject(error)
  }
}
