import { defineStore } from 'pinia'
const useUserStore = defineStore({
  id: 'user',
  state: () => ({
    user: {
      username: '',
      password: '',
      token: ''
    }
  }),
  actions: {
    setUser(user) {
      this.user = user
    }
  }
})
export default useUserStore
