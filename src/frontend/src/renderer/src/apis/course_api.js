import api from './index';

export const getCourse = async (id) => {
  const {data} = await api.get(`/api/courses/${id}`);
  return data;
}

export const getCourses = async () => {
  const {data} = await api.get('/api/courses');
  return data;
}

export const createCourse = async (course) => {
  const {data} = await api.post('/api/courses', course);
  return data;
}

export const updateCourse = async (id, course) => {
  const {data} = await api.put(`/api/courses/${id}`, course);
  return data;
}

export const deleteCourse = async (id) => {
  const {data} = await api.delete(`/api/courses/${id}`);
  return data;
}
