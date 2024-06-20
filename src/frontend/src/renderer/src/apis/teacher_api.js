import api from './index'

export const getTeacher = async (id) => {
  const {data} = await api.get(`/api/teachers/${id}`)
  return data
}

export const getTeachers = async () => {
  const {data} = await api.get('/api/teachers')
  return data
}

export const createTeacher = async (teacher) => {
  const {data} = await api.post('/api/teachers', teacher)
  return data
}

export const updateTeacher = async (id, teacher) => {
  const {data} = await api.put(`/api/teachers/${id}`, teacher)
  return data
}

export const deleteTeacher = async (id) => {
  const {data} = await api.delete(`/api/teachers/${id}`)
  return data
}
