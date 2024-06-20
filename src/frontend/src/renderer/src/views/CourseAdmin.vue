<template>
  <div>
    <!-- 操作按钮 -->
    <div class="mb-4">
      <el-button type="primary" @click="openAddForm">增加课程</el-button>
      <el-button type="danger" @click="confirmDeleteCourse" :disabled="!selectedCourse">删除课程</el-button>
      <el-button type="warning" @click="openEditForm" :disabled="!selectedCourse">修改课程</el-button>
    </div>

    <!-- 筛选框 -->
    <div class="filters mb-4">
      <el-input v-model="filters.id" placeholder="按课程号筛选" class="filter-input" clearable></el-input>
      <el-input v-model="filters.name" placeholder="按课程名称筛选" class="filter-input" clearable></el-input>
      <el-select v-model="filters.term" placeholder="按学期筛选" class="filter-input" clearable>
        <el-option v-for="term in terms" :key="term" :value="term">{{ term }}</el-option>
      </el-select>
      <el-select v-model="filters.school" placeholder="按学院筛选" class="filter-input" clearable>
        <el-option v-for="school in schools" :key="school" :value="school">{{ school }}</el-option>
      </el-select>
      <el-input v-model="filters.teachers" placeholder="按授课老师筛选" class="filter-input" clearable></el-input>
    </div>

    <!-- 课程信息表格 -->
    <el-table :data="pagedCourses" border @row-click="rowClick" highlight-current-row
              :current-row-key="selectedCourse ? selectedCourse.id : null" class="mb-4">
      <el-table-column prop="id" label="课程号" width="100px" sortable/>
      <el-table-column prop="name" label="课程名称" sortable/>
      <el-table-column prop="term" label="学期" sortable/>
      <el-table-column prop="school" label="学院" sortable/>
      <el-table-column prop="teachers" label="授课老师" sortable/>
    </el-table>

    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-size="pageSize"
      layout="total, prev, pager, next, jumper"
      :total="filteredCourses.length">
    </el-pagination>

    <!-- 增加/修改课程信息表单 -->
    <el-dialog title="课程信息" v-model="formVisible">
      <h3>{{ formTitle }}</h3>
      <el-form :model="courseForm">
        <el-form-item label="课程名称">
          <el-input v-model="courseForm.name"></el-input>
        </el-form-item>
        <el-form-item label="学期选择">
          <el-select v-model="courseForm.term" filterable>
            <el-option v-for="term in terms" :value="term" :label="term">{{ term }}</el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="学院选择">
          <el-select v-model="courseForm.school" filterable>
            <el-option v-for="school in schools" :value="school" :label="school">{{ school }}</el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div class="form-footer">
        <el-button @click="formVisible = false">取消</el-button>
        <el-button type="primary" @click="saveCourse">保存</el-button>
      </div>
    </el-dialog>

    <!-- 删除确认提示 -->
    <el-dialog title="确认删除" v-model="deleteDialogVisible">
      <span>确定要删除选中的课程吗？</span>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="deleteDialogVisible = false">取消</el-button>
          <el-button type="danger" @click="deleteCourseConfirmed">删除</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import {computed, onMounted, ref, watch} from 'vue';
import {createCourse, deleteCourse as apiDeleteCourse, getCourses, updateCourse} from "../apis/course_api";

const table_data = ref([]);

const search = ref('');

const courseForm = ref({id: null, name: '', term: '', school: ''});
const selectedCourse = ref(null);
const formVisible = ref(false);
const deleteDialogVisible = ref(false);
const formTitle = ref('');
const terms = ref(['2024春', '2024秋', '2023春', '2023秋']);
const schools = ref(['粮油食品学院', '粮食和物资储备学院', '机电工程学院', '土木工程（建筑）学院', '信息科学与工程学院', '人工智能与大数据学院']);

// 筛选条件
const filters = ref({
  id: '',
  name: '',
  term: '',
  school: '',
  teachers: ''
});

// 打开增加课程表单
const openAddForm = () => {
  formTitle.value = '增加课程';
  courseForm.value = {id: null, name: '', term: '', school: ''};
  formVisible.value = true;
};

// 打开修改课程表单
const openEditForm = () => {
  if (selectedCourse.value) {
    formTitle.value = '修改课程';
    courseForm.value = {...selectedCourse.value};
    formVisible.value = true;
  }
};

// 保存课程信息
const saveCourse = async () => {
  if (formTitle.value === '增加课程') {
    await createCourse({...courseForm.value});
  } else {
    await updateCourse(courseForm.value.id, {...courseForm.value});
  }
  await fetchCourses();
  formVisible.value = false;
  selectedCourse.value = null;
  courseForm.value = {id: null, name: '', term: '', school: ''}; // 清空表单数据
};

// 删除课程信息
const confirmDeleteCourse = () => {
  deleteDialogVisible.value = true;
};

const deleteCourseConfirmed = async () => {
  await apiDeleteCourse(selectedCourse.value.id);
  await fetchCourses();
  selectedCourse.value = null;
  deleteDialogVisible.value = false;
};

const processedCourses = computed(() => {
  return table_data.value.map(course => {
    const newCourse = {...course};
    newCourse.teachers = newCourse.teachers.map(teacher => teacher.name).join(', ');
    return newCourse;
  });
});

// 查询课程信息
const filteredCourses = computed(() => {
  return processedCourses.value.filter(course => {
    return (!filters.value.id || String(course.id).includes(filters.value.id)) &&
      (!filters.value.name || course.name.includes(filters.value.name)) &&
      (!filters.value.term || course.term.includes(filters.value.term)) &&
      (!filters.value.school || course.school.includes(filters.value.school)) &&
      (!filters.value.teachers || course.teachers.includes(filters.value.teachers));
  });
});

// 选择课程
const rowClick = (row) => {
  selectedCourse.value = row;
};

const currentPage = ref(1);
const pageSize = ref(10);

const pagedCourses = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return filteredCourses.value.slice(start, end);
});

const handleSizeChange = (val) => {
  pageSize.value = val;
  currentPage.value = 1;
};

const handleCurrentChange = (val) => {
  currentPage.value = val;
};

const fetchCourses = async () => {
  table_data.value = await getCourses();
};

// 监听搜索框内容变化
watch(search, () => {
  currentPage.value = 1; // 搜索时重置当前页码
});

onMounted(fetchCourses);
</script>

<style scoped>
.form-footer {
  margin-top: 20px;
}

.filters {
  display: flex;
  gap: 10px;
}

.filter-input {
  width: 200px;
}
</style>
