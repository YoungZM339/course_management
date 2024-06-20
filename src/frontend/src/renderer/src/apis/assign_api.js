import api from './index'

export const createAssign = async (assign) => {
  const {data} = await api.post('/api/assign', assign)
  return data
}
