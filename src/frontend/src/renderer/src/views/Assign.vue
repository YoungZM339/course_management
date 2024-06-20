<script setup>
import {onMounted, ref} from "vue";
import {getCourses} from "../apis/course_api";
import {getTeachers} from "../apis/teacher_api";
import {createAssign} from "../apis/assign_api";
import {ElMessage, ElSelect, ElOption, ElButton} from "element-plus";

const courses = ref([]);
const teachers = ref([]);

const assign = async () => {
  const courseId = selectedCourse.value;
  const teacherId = selectedTeacher.value;
  await createAssign({courseId, teacherId});
  ElMessage.success('课程分配成功');
};

const selectedCourse = ref(null);
const selectedTeacher = ref(null);

onMounted(async () => {
  teachers.value = await getTeachers();
  courses.value = await getCourses();
});
</script>

<template>
  <div>
    <h1>教师自主选课</h1>
    <el-form>
      <el-form-item label="授课教师">
        <el-select
          v-model="selectedTeacher"
          placeholder="请选择教师或输入教师名"
          filterable>
          <el-option
            v-for="teacher in teachers"
            :key="teacher.id"
            :label="teacher.name"
            :value="teacher.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="所选课程">
        <el-select
          v-model="selectedCourse"
          placeholder="请选择课程或输入课程名"
          filterable>
          <el-option
            v-for="course in courses"
            :key="course.id"
            :label="course.name"
            :value="course.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="assign">确认分配</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<style scoped>
</style>
