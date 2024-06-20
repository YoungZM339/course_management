<template>
  <div class="layout">
    <el-container>
      <el-aside class="aside">
        <Sidebar/>
      </el-aside>
      <el-main class="main">
        <router-view></router-view>
      </el-main>
    </el-container>
  </div>
</template>

<script setup>
import Sidebar from './views/Sidebar.vue'
</script>

<style scoped>


.layout {
  height: 100%;
  display: flex;
  margin: 0;
  overflow: hidden;
}

.aside {
  width: 200px;
  height: 100vh;
  overflow: hidden;
}

.main {
  height: 100vh;
  flex: 1;
  overflow-y: auto;
}
</style>
