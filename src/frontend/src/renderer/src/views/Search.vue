<template>
  <div>
    <!-- ECharts图表容器 -->
    <div id="course-term-chart" style="width: 100%; height: 400px;"></div>
    <div id="course-school-chart" style="width: 100%; height: 400px;"></div>
    <div id="course-teacher-chart" style="width: 100%; height: 400px;"></div>
  </div>
</template>

<script setup>
import {onMounted} from 'vue';
import * as echarts from 'echarts';
import {getCourses} from '../apis/course_api';

const fetchCourses = async () => {
  const courses = await getCourses();
  setupECharts(courses);
};

onMounted(fetchCourses);

const setupECharts = (courses) => {
  // 课程按学期分布图表
  const courseTermChart = echarts.init(document.getElementById('course-term-chart'));
  const termData = ['2024春', '2024秋', '2023春', '2023秋'].map(term => {
    return courses.filter(course => course.term === term).length;
  });
  const termOption = {
    title: {
      text: '课程按学期分布'
    },
    tooltip: {
      trigger: 'axis'
    },
    xAxis: {
      type: 'category',
      data: ['2024春', '2024秋', '2023春', '2023秋']
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '课程数量',
        type: 'bar',
        data: termData
      }
    ]
  };
  courseTermChart.setOption(termOption);

  // 课程按学院分布图表
  const courseSchoolChart = echarts.init(document.getElementById('course-school-chart'));
  const schoolNames = ['粮油食品学院', '粮食和物资储备学院', '机电工程学院', '土木工程（建筑）学院', '信息科学与工程学院', '人工智能与大数据学院'];
  const schoolData = schoolNames.map(school => {
    return courses.filter(course => course.school === school).length;
  });
  const schoolOption = {
    title: {
      text: '课程按学院分布'
    },
    tooltip: {
      trigger: 'axis'
    },
    xAxis: {
      type: 'category',
      data: schoolNames,
      axisLabel: {
        interval: 0,
        rotate: 30
      }
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '课程数量',
        type: 'bar',
        data: schoolData
      }
    ]
  };
  courseSchoolChart.setOption(schoolOption);

  // 课程按教师分布图表
  const courseTeacherChart = echarts.init(document.getElementById('course-teacher-chart'));
  const teacherData = {};
  courses.forEach(course => {
    course.teachers.forEach(teacher => {
      if (!teacherData[teacher.name]) {
        teacherData[teacher.name] = 0;
      }
      teacherData[teacher.name]++;
    });
  });
  const teacherNames = Object.keys(teacherData);
  const teacherCounts = teacherNames.map(name => teacherData[name]);
  const teacherOption = {
    title: {
      text: '课程按教师分布'
    },
    tooltip: {
      trigger: 'axis'
    },
    xAxis: {
      type: 'category',
      data: teacherNames
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '课程数量',
        type: 'bar',
        data: teacherCounts
      }
    ]
  };
  courseTeacherChart.setOption(teacherOption);
};
</script>

<style scoped>
#course-term-chart,
#course-school-chart,
#course-teacher-chart {
  margin-bottom: 20px;
}
</style>
