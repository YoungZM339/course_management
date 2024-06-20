// style sheets
import './assets/css/main.css'
import 'element-plus/dist/index.css'
// packages
import {createApp} from 'vue'
import ElementPlus from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import router from './routers'
import pinia from './stores'
import App from './App.vue'
// create app
const app = createApp(App)
app.use(ElementPlus, {
  locale: zhCn,
})
app.use(pinia)
app.use(router)
app.mount('#app')
