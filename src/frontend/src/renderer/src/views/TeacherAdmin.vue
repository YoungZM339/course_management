<template>
  <div>
    <!-- 操作按钮 -->
    <div class="mb-4">
      <el-button type="primary" @click="openAddForm">增加教师</el-button>
      <el-button type="danger" @click="confirmDeleteTeacher" :disabled="!selectedTeacher">删除教师</el-button>
      <el-button type="warning" @click="openEditForm" :disabled="!selectedTeacher">修改教师</el-button>
    </div>

    <!-- 筛选输入框 -->
    <div class="filters mb-4">
      <el-input v-model="searchId" placeholder="筛选职工号" class="filter-input" clearable></el-input>
      <el-input v-model="searchName" placeholder="筛选姓名" class="filter-input" clearable></el-input>
      <el-input v-model="searchSchool" placeholder="筛选学院" class="filter-input" clearable></el-input>
    </div>

    <!-- 教师信息表格 -->
    <el-table :data="pagedTeachers" border @row-click="rowClick" highlight-current-row
              :current-row-key="selectedTeacher ? selectedTeacher.id : null" class="mb-4">
      <el-table-column prop="id" label="职工号" width="100" sortable/>
      <el-table-column prop="name" label="姓名" width="200" sortable/>
      <el-table-column prop="school" label="学院" sortable/>
    </el-table>

    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-size="pageSize"
      layout="total, prev, pager, next, jumper"
      :total="filteredTeachers.length">
    </el-pagination>

    <!-- 增加/修改教师信息表单 -->
    <el-dialog title="教师信息" v-model="formVisible">
      <h3>{{ formTitle }}</h3>
      <el-form :model="teacherForm">
        <el-form-item label="姓名">
          <el-input v-model="teacherForm.name"></el-input>
        </el-form-item>
        <el-form-item label="学院">
          <el-select v-model="teacherForm.school" filterable>
            <el-option v-for="school in schools" :value="school">{{ school }}</el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div class="form-footer">
        <el-button @click="formVisible = false">取消</el-button>
        <el-button type="primary" @click="saveTeacher">保存</el-button>
      </div>
    </el-dialog>

    <!-- 删除确认提示 -->
    <el-dialog title="确认删除" v-model="deleteDialogVisible">
      <span>确定要删除选中的教师吗？</span>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="deleteDialogVisible = false">取消</el-button>
          <el-button type="danger" @click="deleteTeacherConfirmed">删除</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import {computed, onMounted, ref, watch} from 'vue';
import {createTeacher, deleteTeacher as apiDeleteTeacher, getTeachers, updateTeacher} from "../apis/teacher_api";

const table_data = ref([]);

const searchId = ref('');
const searchName = ref('');
const searchSchool = ref('');

const teacherForm = ref({id: '', name: '', school: ''});
const selectedTeacher = ref(null);
const formVisible = ref(false);
const deleteDialogVisible = ref(false);
const formTitle = ref('');
const schools = ref(['粮油食品学院', '粮食和物资储备学院', '机电工程学院', '土木工程（建筑）学院', '信息科学与工程学院', '人工智能与大数据学院']);

// 打开增加教师表单
const openAddForm = () => {
  formTitle.value = '增加教师';
  teacherForm.value = {id: '', name: '', school: ''};
  formVisible.value = true;
};

// 打开修改教师表单
const openEditForm = () => {
  if (selectedTeacher.value) {
    formTitle.value = '修改教师';
    teacherForm.value = {...selectedTeacher.value};
    formVisible.value = true;
  }
};

// 保存教师信息
const saveTeacher = async () => {
  if (formTitle.value === '增加教师') {
    await createTeacher({...teacherForm.value});
  } else {
    await updateTeacher(selectedTeacher.value.id, {...teacherForm.value});
  }
  await fetchTeachers();
  formVisible.value = false;
  selectedTeacher.value = null;
  teacherForm.value = {id: '', name: '', school: ''}; // 清空表单数据
};

// 删除教师信息
const confirmDeleteTeacher = () => {
  deleteDialogVisible.value = true;
};

const deleteTeacherConfirmed = async () => {
  await apiDeleteTeacher(selectedTeacher.value.id);
  await fetchTeachers();
  selectedTeacher.value = null;
  deleteDialogVisible.value = false;
};

// 查询教师信息
const filteredTeachers = computed(() => {
  return table_data.value.filter(teacher =>
    (!searchId.value || String(teacher.id).includes(searchId.value)) &&
    (!searchName.value || teacher.name.includes(searchName.value)) &&
    (!searchSchool.value || teacher.school.includes(searchSchool.value))
  );
});

// 选择教师
const rowClick = (row) => {
  selectedTeacher.value = row;
};

const currentPage = ref(1);
const pageSize = ref(10);

const pagedTeachers = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return filteredTeachers.value.slice(start, end);
});

const handleSizeChange = (val) => {
  pageSize.value = val;
  currentPage.value = 1;
};

const handleCurrentChange = (val) => {
  currentPage.value = val;
};

const fetchTeachers = async () => {
  table_data.value = await getTeachers();
};

// 监听筛选框内容变化
watch([searchId, searchName, searchSchool], () => {
  currentPage.value = 1; // 筛选时重置当前页码
});

onMounted(fetchTeachers);

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
