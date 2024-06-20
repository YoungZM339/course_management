<template>
  <div id="app">
    <el-menu class="sidebar" router>
      <el-menu-item index="1" @click="$router.push('/')">
        <el-icon>
          <HomeFilled/>
        </el-icon>
        主页
      </el-menu-item>
      <el-menu-item index="2" @click="$router.push('/teacher-admin')">
        <el-icon>
          <User/>
        </el-icon>
        教师信息管理
      </el-menu-item>
      <el-menu-item index="3" @click="$router.push('/course-admin')">
        <el-icon>
          <OfficeBuilding/>
        </el-icon>
        课程信息管理
      </el-menu-item>
      <el-menu-item index="4" @click="$router.push('/search')">
        <el-icon>
          <Search/>
        </el-icon>
        综合信息查询
      </el-menu-item>
      <el-menu-item index="5" @click="$router.push('/teacher-selection')">
        <el-icon>
          <Notebook/>
        </el-icon>
        教师自主选课
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script setup>
import {HomeFilled, Search, OfficeBuilding, User, Notebook} from "@element-plus/icons";
</script>

<style scoped>
.sidebar {
  width: 200px;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: start;
}
</style>
