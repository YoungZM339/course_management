# Course Management

课程管理示例系统，由 Spring Boot 后端和 Electron/Vue 3 桌面端组成。系统围绕课程、教师以及课程授课关系提供管理和查询界面。

## 已实现范围

- 课程信息的新增、查询、修改和删除。
- 教师信息的新增、查询、修改和删除。
- 将课程分配给教师，并处理不合法分配请求。
- 桌面端的课程管理、教师管理、课程搜索/统计与授课分配页面。
- 使用 ECharts 展示查询或统计结果。

## 架构

- 后端：Java 17、Spring Boot 3.3、Spring Web、Spring Data JPA、MySQL。
- 桌面端：Electron、Vue 3、Element Plus、Pinia、axios、ECharts。
- 后端源码：src/main/java。
- 桌面端源码：src/frontend。

## 运行前准备

1. 安装 Java 17、MySQL 和 Node.js。
2. 创建仅供本地开发使用的 MySQL 数据库。
3. 修改后端的数据源配置，使其使用自己的本地数据库账号和密码。
4. 不要使用或保留任何提交到仓库中的开发凭据。

## 启动后端

在仓库根目录执行：

    .\mvnw.cmd spring-boot:run

项目配置的开发服务端口为 9090。启动后可根据控制器路径查看课程、教师和课程分配接口。

## 启动桌面端

在另一个终端执行：

    cd src/frontend
    npm install
    npm run dev

Electron 开发窗口会连接到已启动的后端。用于打包时可使用 package.json 中定义的 build、build:win、build:mac 或 build:linux 脚本。

## 开发说明

后端与桌面端分别维护依赖。修改接口地址、跨域策略或数据库字段后，应同步检查：

- 后端控制器、实体与数据库迁移；
- src/frontend 中的 API 调用；
- 课程、教师和分配页面的交互与错误提示。

## 安全与部署

本仓库是课程管理应用示例，不应直接作为生产教务系统上线。部署前至少应：

- 将数据库、密钥和服务地址移至环境配置；
- 收紧跨域来源；
- 加入身份认证、授权和审计策略；
- 备份并迁移真实数据前进行数据校验。

## 许可证

仓库当前未声明许可证。