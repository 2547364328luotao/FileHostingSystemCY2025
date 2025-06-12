# 🌟 FileHostingSystem
## 基于Alist的现代化文件托管系统

<!-- 核心技术栈徽章 -->
<div align="center">
    <img src="https://img.shields.io/badge/Java-FF6B35?style=for-the-badge&logo=openjdk&logoColor=white" alt="Java">
    <img src="https://img.shields.io/badge/MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
    <img src="https://img.shields.io/badge/Bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white" alt="Bootstrap">
    <img src="https://img.shields.io/badge/Alist-70C0E8?style=for-the-badge&logo=files&logoColor=white" alt="Alist">
</div>

<br>

<!-- 项目状态徽章 -->
<div align="center">
    <img src="https://img.shields.io/badge/Version-v0.054-blue?style=flat-square&logo=semver" alt="Version">
    <img src="https://img.shields.io/badge/Build-Passing-brightgreen?style=flat-square&logo=github-actions" alt="Build Status">
    <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square&logo=opensourceinitiative" alt="License">
    <img src="https://img.shields.io/badge/Platform-Web-orange?style=flat-square&logo=html5" alt="Platform">
</div>

<br>

<!-- 开发者联系方式 -->
<div align="center">
    <a href="https://space.bilibili.com/525163001"> 
        <img src="https://img.shields.io/badge/哔哩哔哩-笙箫如夢-FF6D9D?style=flat&logo=bilibili&logoColor=white" alt="哔哩哔哩"> 
    </a>
    <a href="https://u.wechat.com/EPF8WK3pzJRhBUHQa3aqK1k?s=1"> 
        <img src="https://img.shields.io/badge/微信-联系我-95EC69?style=flat&logo=wechat&logoColor=white" alt="微信"> 
    </a>
    <a href="https://qm.qq.com/cgi-bin/qm/qr?k=oig6gaE9LsTQdlHEt8D_Spb_yv8U5B4x"> 
        <img src="https://img.shields.io/badge/QQ-雨中丁香-00B8E6?style=flat&logo=qq&logoColor=white" alt="QQ"> 
    </a>
    <a href="https://github.com/imsyy/SPlayer/tree/v3.0.0-beta.1"> 
        <img src="https://img.shields.io/badge/GitHub-luotao-181717?style=flat&logo=github&logoColor=white" alt="GitHub"> 
    </a>
</div>

*武汉城市学院2025上半年Web课程设计作品* 🎓

[✨ 功能特性](#-核心功能) • [🚀 快速开始](#-部署说明) • [📖 文档](#-项目架构) • [🛠️ 技术栈](#-技术栈)


---

## 📝 项目简介

**FileHostingSystem** 是一个现代化的文件托管与管理系统，采用 **Java Servlet** 技术栈构建，深度集成 **Alist** 作为底层存储服务。系统提供了完整的文件生命周期管理功能，包括上传、存储、预览、搜索和删除等操作，同时具备用户管理、存储统计和数据同步等高级特性。

### 🎯 设计理念

- **🔄 数据同步**: 实现Alist与本地数据库的双向同步
- **🎨 现代UI**: 响应式设计，支持多种设备访问
- **⚡ 高性能**: 异步处理，支持大文件上传
- **🔒 安全可靠**: 完善的权限控制和数据验证
- **📱 用户友好**: 直观的操作界面和流畅的交互体验

## 🛠️ 技术栈

### 后端技术

| 技术 | 版本 | 描述 |
|------|------|------|
| **Java Servlet** | JDK 8+ | 核心Web框架，处理HTTP请求响应 |
| **MySQL** | 8.0+ | 关系型数据库，存储文件元数据 |
| **Jackson** | 2.15.2 | JSON序列化/反序列化库 |
| **OkHttp** | 4.12.0 | HTTP客户端，与Alist API通信 |
| **C3P0** | 0.9.5.5 | 数据库连接池管理 |
| **JSTL** | 3.0.1 | JSP标准标签库 |

### 前端技术

| 技术 | 版本 | 描述 |
|------|------|------|
| **Bootstrap** | 5.x | 响应式UI框架 |
| **jQuery** | 3.x | JavaScript库，DOM操作 |
| **FontAwesome** | 6.x | 图标字体库 |
| **Animate.css** | 4.x | CSS动画库 |
| **NoUISlider** | - | 滑块组件 |

### 存储服务

| 服务 | 描述 |
|------|------|
| **Alist** | 开源文件列表程序，支持多种存储后端 |
| **本地存储** | 临时文件存储和缓存 |

## 项目架构 🏗️

### 详细项目构成说明 🏗️

#### 数据库ER图

![数据库ER图](web/image/ER图.drawio.svg)

#### 项目数据流顶层图

![项目数据流图-第1页](web/image/数据流图-Page-1.drawio.svg)
![项目数据流图-第2页](web/image/数据流图-第%202%20页.drawio.svg)

### 📁 项目目录结构

<details>
<summary><b>🔍 点击展开完整目录结构</b></summary>

```
📦 FileHostingSystemCY/
├── 📂 src/main/
│   ├── 📂 java/
│   │   ├── 📂 controller/           # 🎮 Servlet控制器层
│   │   │   ├── 📄 UploadServlet.java      # 文件上传处理
│   │   │   ├── 📄 FilePreview.java        # 文件预览服务
│   │   │   ├── 📄 FileQuery.java          # 文件查询接口
│   │   │   ├── 📄 ListImage.java          # 图片列表管理
│   │   │   ├── 📄 DeleteFile.java         # 文件删除操作
│   │   │   ├── 📄 StorageServlet.java     # 存储空间管理
│   │   │   └── 📄 StorageSum.java         # 存储统计服务
│   │   ├── 📂 service/              # 🔧 业务服务层
│   │   │   ├── 📄 LoginServlet.java       # 用户登录认证
│   │   │   └── 📄 LogoutServlet.java      # 用户登出处理
│   │   ├── 📂 dao/                  # 💾 数据访问层
│   │   │   ├── 📄 MediaFileDAO.java       # 媒体文件数据访问
│   │   │   └── 📄 MediaTest.java          # DAO层测试
│   │   ├── 📂 model/                # 📋 数据模型层
│   │   │   ├── 📄 MediaFile.java          # 媒体文件实体
│   │   │   └── 📄 User.java               # 用户实体模型
│   │   ├── 📂 db/                   # 🗄️ 数据库工具层
│   │   │   ├── 📄 DBUtil.java             # 数据库连接工具
│   │   │   ├── 📄 MediaFileQuery.java     # 媒体文件查询
│   │   │   ├── 📄 StorageStats.java       # 存储统计查询
│   │   │   └── 📄 TestDB.java             # 数据库连接测试
│   │   ├── 📂 utils/                # 🛠️ 工具类集合
│   │   │   ├── 📄 AlistToken.java         # Alist认证管理
│   │   │   ├── 📄 AlistUploader.java      # 文件上传到Alist
│   │   │   ├── 📄 AlistlistFiles.java     # Alist文件列表API
│   │   │   ├── 📄 AlistDatabaseRefresher.java # 数据同步服务
│   │   │   ├── 📄 AlistRefresher.java     # Alist缓存刷新
│   │   │   ├── 📄 AlistRemove.java        # Alist文件删除
│   │   │   ├── 📄 AddpreUrl.java          # URL前缀处理
│   │   │   ├── 📄 AlistlistFilesTest.java # 文件列表测试
│   │   │   └── 📄 MainTest.java           # 主测试入口
│   │   ├── 📂 filter/               # 🔒 过滤器层（预留扩展）
│   │   └── 📂 test/                 # 🧪 测试类目录
│   └── 📂 resources/
│       └── 📄 db.properties             # 数据库配置文件
├── 📂 web/                          # 🌐 Web资源目录
│   ├── 📂 WEB-INF/
│   │   ├── 📂 lib/                  # 📚 第三方依赖库
│   │   │   ├── 📄 c3p0-0.9.5.5.jar
│   │   │   ├── 📄 fastjson-1.2.83.jar
│   │   │   ├── 📄 jackson-*.jar     # Jackson JSON处理
│   │   │   ├── 📄 mysql-connector-java-8.0.27.jar
│   │   │   ├── 📄 okhttp-4.12.0.jar
│   │   │   └── 📄 jakarta.servlet.jsp.jstl-*.jar
│   │   └── 📄 web.xml               # Web应用配置
│   ├── 📂 assets/                   # 🎨 静态资源
│   │   ├── 📂 css/                  # 样式文件
│   │   │   ├── 📄 bootstrap.css     # Bootstrap框架
│   │   │   ├── 📄 index.css         # 首页样式
│   │   │   ├── 📄 userCen.css       # 用户中心样式
│   │   │   ├── 📄 sign-in.css       # 登录页样式
│   │   │   ├── 📄 modal.css         # 模态框样式
│   │   │   ├── 📄 theme.css         # 主题样式
│   │   │   └── 📄 limestart-search-component.css
│   │   ├── 📂 js/                   # JavaScript文件
│   │   │   ├── 📂 bootstrap/        # Bootstrap JS组件
│   │   │   ├── 📄 theme.js          # 主题脚本
│   │   │   ├── 📄 modal.js          # 模态框脚本
│   │   │   ├── 📄 limestart-search-component.js
│   │   │   └── 📂 vendor/           # 第三方JS库
│   │   ├── 📂 images/               # 图片资源
│   │   │   ├── 📂 backgrounds/      # 背景图片
│   │   │   ├── 📂 brand/            # 品牌图标
│   │   │   ├── 📂 cropping/         # 裁剪图片
│   │   │   ├── 📂 prv/              # 预览图片
│   │   │   └── 📂 slider/           # 轮播图片
│   │   └── 📂 vendor/               # 🔌 第三方前端库
│   │       ├── 📂 animate/          # 动画库
│   │       ├── 📂 bootstrap/        # Bootstrap完整版
│   │       ├── 📂 fontawesome/      # 图标字体
│   │       ├── 📂 jquery/           # jQuery库
│   │       ├── 📂 nouislider/       # 滑块组件
│   │       └── 📂 popper/           # Popper.js
│   ├── 📂 image/                    # 📊 项目文档图片
│   │   ├── 📄 ER图.drawio.svg       # 数据库ER图
│   │   ├── 📄 数据流图-Page-1.drawio.svg
│   │   └── 📄 数据流图-第 2 页.drawio.svg
│   ├── 📂 sql/                      # 🗃️ 数据库脚本
│   │   └── 📄 alist_media.sql       # 数据库初始化脚本
│   ├── 📂 js/                       # 📜 自定义JavaScript
│   │   └── 📄 main.js               # 主要脚本文件
│   ├── 📂 pages/                    # 📄 静态页面（预留）
│   ├── 📄 index.jsp                 # 🏠 文件管理主页
│   ├── 📄 upload.jsp                # ⬆️ 文件上传页面
│   ├── 📄 preview.jsp               # 👁️ 文件预览页面
│   ├── 📄 sign-in.jsp               # 🔐 用户登录页面
│   ├── 📄 userCen.jsp               # 👤 用户中心页面
│   ├── 📄 test-delete.jsp           # 🗑️ 删除测试页面
│   └── 📄 error.jsp                 # ❌ 错误处理页面
└── 📄 README.md                     # 📖 项目说明文档
```

</details>



### 🏗️ 目录结构与模块划分

<details>
<summary><b>📋 点击查看详细模块说明</b></summary>

#### 🎮 1. 控制器层 (Controller)
> 负责处理HTTP请求，协调业务逻辑和视图展示

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `UploadServlet.java` | 📤 文件上传处理 | 多文件上传、格式验证、进度跟踪 |
| `FilePreview.java` | 👁️ 文件预览服务 | 图片/视频预览、缩略图生成 |
| `FileQuery.java` | 🔍 文件查询接口 | 文件搜索、过滤、分页查询 |
| `ListImage.java` | 🖼️ 图片列表管理 | 图片展示、排序、分类管理 |
| `DeleteFile.java` | 🗑️ 文件删除操作 | 安全删除、批量删除、回收站 |
| `StorageServlet.java` | 💾 存储空间管理 | 存储配置、空间分配 |
| `StorageSum.java` | 📊 存储统计服务 | 使用量统计、容量分析 |

#### 🔧 2. 服务层 (Service)
> 处理业务逻辑，提供核心服务功能

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `LoginServlet.java` | 🔐 用户登录认证 | 身份验证、会话管理、权限控制 |
| `LogoutServlet.java` | 🚪 用户登出处理 | 会话清理、安全登出 |

#### 💾 3. 数据访问层 (DAO)
> 封装数据库操作，提供数据持久化服务

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `MediaFileDAO.java` | 🗃️ 媒体文件数据访问 | CRUD操作、查询优化、事务管理 |
| `MediaTest.java` | 🧪 DAO层测试 | 数据访问测试、性能测试 |

#### 📋 4. 数据模型层 (Model)
> 定义数据结构和业务实体

| 文件名 | 功能描述 | 属性说明 |
|--------|----------|----------|
| `MediaFile.java` | 📄 媒体文件实体 | 文件ID、名称、路径、大小、类型、创建时间 |
| `User.java` | 👤 用户实体模型 | 用户ID、用户名、密码、邮箱、权限级别 |

#### 🗄️ 5. 数据库工具层 (Database)
> 提供数据库连接和查询工具

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `DBUtil.java` | 🔌 数据库连接工具 | 连接池管理、连接获取/释放 |
| `MediaFileQuery.java` | 🔍 媒体文件查询 | 复杂查询、条件构建、结果映射 |
| `StorageStats.java` | 📈 存储统计查询 | 统计分析、报表生成 |
| `TestDB.java` | 🧪 数据库连接测试 | 连接测试、性能监控 |

#### 🛠️ 6. 工具类层 (Utils)
> Alist集成工具和通用工具类

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `AlistToken.java` | 🔑 Alist认证管理 | Token获取、刷新、验证 |
| `AlistUploader.java` | ⬆️ 文件上传到Alist | 文件传输、进度监控、错误处理 |
| `AlistlistFiles.java` | 📂 Alist文件列表API | 文件列表获取、目录遍历 |
| `AlistDatabaseRefresher.java` | 🔄 数据同步服务 | 数据库与Alist双向同步 |
| `AlistRefresher.java` | 🔄 Alist缓存刷新 | 缓存更新、数据一致性 |
| `AlistRemove.java` | ❌ Alist文件删除 | 远程文件删除、批量操作 |
| `AddpreUrl.java` | 🔗 URL前缀处理 | URL构建、路径处理 |
| `AlistlistFilesTest.java` | 🧪 文件列表测试 | API测试、功能验证 |
| `MainTest.java` | 🚀 主测试入口 | 集成测试、系统验证 |

#### 🌐 7. Web层 (Web)
> 用户界面和静态资源管理

**📄 JSP页面**
- `index.jsp` - 🏠 文件管理主页
- `upload.jsp` - ⬆️ 文件上传界面
- `preview.jsp` - 👁️ 文件预览页面
- `sign-in.jsp` - 🔐 用户登录页面
- `userCen.jsp` - 👤 用户中心
- `error.jsp` - ❌ 错误处理页面

**🎨 静态资源**
- `assets/css/` - 样式文件（Bootstrap、自定义主题）
- `assets/js/` - JavaScript脚本（交互逻辑、AJAX）
- `assets/images/` - 图片资源（图标、背景、UI元素）
- `assets/vendor/` - 第三方前端库

**⚙️ 配置文件**
- `web.xml` - Web应用配置
- `db.properties` - 数据库连接配置

</details>

#### 2. Builder 相关说明

本项目采用Builder设计思想进行部分对象的构建与初始化，提升代码可读性与扩展性。例如：
- 文件信息（FileInfo）对象通过setter链式调用快速构建。
- 数据库操作、Alist API调用等均采用分层解耦，便于后续扩展和维护。

#### 3. 主要流程说明

- 用户通过`upload.jsp`上传文件，`UploadServlet`接收并保存至服务器临时目录。
- 后端调用`AlistUploader`上传文件到Alist云存储。
- 上传完成后，`AlistRefresher`刷新Alist目录，`AlistlistFiles`获取最新文件列表。
- `AlistDatabaseRefresher`将Alist文件信息同步到本地数据库，自动识别文件类型。
- 前端页面实时展示上传进度与结果，支持预览和下载。

---

### 核心类说明 📚

#### 1. 工具类（utils）

- **AlistToken** 🔑
  - 处理Alist系统的身份认证
  - 实现登录获取token的功能
  - 支持token的自动刷新和管理

- **AlistlistFiles** 📋
  - 实现与Alist API的通信
  - 获取文件列表和目录结构
  - 支持文件信息的解析和封装

- **AlistUploader** ⬆️
  - 处理文件上传到Alist存储
  - 支持大文件分片上传
  - 提供上传进度回调

- **AlistDatabaseRefresher** 🔄
  - 同步Alist文件系统与本地数据库
  - 实现文件类型自动识别
  - 维护文件元数据

#### 2. 数据库（db）

- **DBUtil** 🗃️
  - 数据库连接池管理
  - 提供统一的数据库操作接口
  - 支持事务管理

#### 3. Web界面

- **upload.jsp** 📤
  - 现代化的文件上传界面
  - 支持拖拽上传
  - 实时显示上传进度
  - 文件类型预览

- **index.jsp** 🏠
  - 文件管理主界面
  - 文件列表展示
  - 支持文件搜索和筛选

## 🚀 核心功能

<details>
<summary><b>💡 点击查看功能详情</b></summary>

#### 🔗 1. Alist集成服务
> 与Alist文件管理系统深度集成，提供完整的文件操作能力

| 功能模块 | 描述 | 技术实现 | 特性 |
|----------|------|----------|------|
| 🔑 **Token管理** | 自动获取和刷新访问令牌 | JWT Token + 定时刷新机制 | • 自动续期<br>• 异常重试<br>• 安全存储 |
| ⬆️ **文件上传** | 大文件分片上传到Alist | 分片上传 + 断点续传 | • 支持大文件<br>• 进度监控<br>• 错误恢复 |
| 📂 **文件列表** | 实时获取存储文件列表 | RESTful API + JSON解析 | • 实时同步<br>• 分页加载<br>• 快速检索 |
| 🗑️ **文件删除** | 安全删除Alist文件 | 批量操作 + 事务保证 | • 批量删除<br>• 安全确认<br>• 操作日志 |
| 🔄 **缓存刷新** | 强制刷新目录缓存 | 主动刷新 + 智能缓存 | • 数据一致性<br>• 性能优化<br>• 自动更新 |

#### 🗄️ 2. 数据库管理
> 高效的数据持久化和管理服务

| 功能模块 | 描述 | 技术实现 | 特性 |
|----------|------|----------|------|
| 🔌 **连接池管理** | C3P0连接池优化 | 连接池 + 监控 | • 高并发支持<br>• 自动回收<br>• 性能监控 |
| 📄 **文件元数据** | 完整的文件信息存储 | MySQL + 索引优化 | • 快速查询<br>• 数据完整性<br>• 关系映射 |
| 👤 **用户管理** | 用户认证和权限控制 | Session + 权限矩阵 | • 安全认证<br>• 角色管理<br>• 访问控制 |
| 📊 **存储统计** | 详细的使用情况分析 | 统计查询 + 图表展示 | • 实时统计<br>• 趋势分析<br>• 容量预警 |

#### 🔄 3. 数据同步机制
> 智能的数据同步和一致性保证

| 功能模块 | 描述 | 技术实现 | 特性 |
|----------|------|----------|------|
| 🤖 **自动同步** | 定期同步文件信息 | 定时任务 + 增量同步 | • 定时执行<br>• 智能调度<br>• 异常处理 |
| ⚡ **增量更新** | 只同步变化的文件 | 时间戳比较 + 哈希校验 | • 高效同步<br>• 减少开销<br>• 精确识别 |
| 🏷️ **类型识别** | 自动文件分类存储 | MIME类型 + 扩展名识别 | • 智能分类<br>• 多格式支持<br>• 自动标记 |
| 🔍 **冲突检测** | 数据冲突自动处理 | 版本控制 + 冲突解决 | • 冲突预防<br>• 自动解决<br>• 数据保护 |

#### 🌐 4. Web界面功能
> 现代化的用户交互体验

| 功能模块 | 描述 | 技术实现 | 特性 |
|----------|------|----------|------|
| 🏠 **文件管理** | 直观的文件操作界面 | Bootstrap + AJAX | • 响应式设计<br>• 拖拽操作<br>• 实时更新 |
| 👁️ **文件预览** | 多格式文件预览 | HTML5 + 媒体播放器 | • 图片预览<br>• 视频播放<br>• 文档查看 |
| 🔍 **搜索过滤** | 强大的搜索功能 | 全文检索 + 条件筛选 | • 快速搜索<br>• 多条件过滤<br>• 结果高亮 |
| 📱 **移动适配** | 移动设备友好 | 响应式布局 + 触控优化 | • 移动优先<br>• 触控友好<br>• 性能优化 |

#### 🛡️ 5. 安全特性
> 全方位的安全保障机制

| 安全模块 | 描述 | 实现方式 | 保护级别 |
|----------|------|----------|----------|
| 🔐 **身份认证** | 用户身份验证 | Session + 密码加密 | ⭐⭐⭐⭐⭐ |
| 🛡️ **权限控制** | 细粒度权限管理 | RBAC权限模型 | ⭐⭐⭐⭐⭐ |
| 🔒 **数据加密** | 敏感数据保护 | AES加密 + HTTPS | ⭐⭐⭐⭐⭐ |
| 🚫 **防护机制** | 恶意攻击防护 | XSS防护 + CSRF令牌 | ⭐⭐⭐⭐⭐ |

</details>

## ⚙️ 配置说明

<details>
<summary><b>🔧 点击查看详细配置指南</b></summary>

### 🗄️ 数据库配置

在 <mcfile name="db.properties" path="src/main/resources/db.properties"></mcfile> 中配置数据库连接信息：

```properties
# 🔌 数据库连接配置
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/alist_media?useSSL=false&serverTimezone=UTC&characterEncoding=utf8
db.username=your_username
db.password=your_password

# 🏊 C3P0连接池配置
c3p0.initialPoolSize=5          # 初始连接数
c3p0.maxPoolSize=20             # 最大连接数
c3p0.minPoolSize=5              # 最小连接数
c3p0.acquireIncrement=2         # 连接增长步长
c3p0.maxStatements=100          # 最大缓存语句数
c3p0.maxIdleTime=300            # 最大空闲时间(秒)
c3p0.checkoutTimeout=30000      # 连接超时时间(毫秒)
c3p0.testConnectionOnCheckout=true  # 连接测试
```

### 🔗 Alist服务配置

在相关工具类中配置Alist服务信息：

```java
// 📍 AlistToken.java 中的配置
private static final String ALIST_URL = "http://your-alist-server:5244";
private static final String USERNAME = "admin";              // Alist管理员用户名
private static final String PASSWORD = "your_secure_password"; // Alist管理员密码
private static final String API_PATH = "/api/auth/login";     // 登录API路径

// 🔄 同步配置
private static final int SYNC_INTERVAL = 300;  // 同步间隔(秒)
private static final String STORAGE_PATH = "/"; // 存储根路径
```

### 🌐 Web应用配置

在 <mcfile name="web.xml" path="web/WEB-INF/web.xml"></mcfile> 中的关键配置：

```xml
<!-- 📁 文件上传配置 -->
<multipart-config>
    <max-file-size>104857600</max-file-size>      <!-- 100MB -->
    <max-request-size>209715200</max-request-size> <!-- 200MB -->
    <file-size-threshold>1048576</file-size-threshold> <!-- 1MB -->
</multipart-config>

<!-- 🔒 会话配置 -->
<session-config>
    <session-timeout>30</session-timeout> <!-- 30分钟 -->
</session-config>
```

</details>

## 🚀 部署步骤

<details>
<summary><b>📋 点击查看完整部署指南</b></summary>

### 📋 1. 环境准备

| 组件 | 版本要求 | 推荐版本 | 说明 |
|------|----------|----------|------|
| ☕ **Java** | JDK 8+ | JDK 11 | 运行环境 |
| 🗄️ **MySQL** | 5.7+ | 8.0+ | 数据库服务 |
| 🐱 **Tomcat** | 9.0+ | 10.1+ | Web服务器 |
| 📁 **Alist** | 3.0+ | 最新版 | 文件管理服务 |
| 🛠️ **Maven** | 3.6+ | 3.9+ | 构建工具(可选) |

### 🗃️ 2. 数据库初始化

```sql
-- 📊 创建数据库
CREATE DATABASE alist_media 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci
    COMMENT '文件托管系统数据库';

-- 👤 创建用户(可选)
CREATE USER 'alist_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON alist_media.* TO 'alist_user'@'localhost';
FLUSH PRIVILEGES;

-- 📋 导入表结构
USE alist_media;
SOURCE web/sql/alist_media.sql;
```

### ⚙️ 3. 配置文件修改

**步骤 1**: 数据库配置
```bash
# 📝 编辑数据库配置
cp src/main/resources/db.properties.example src/main/resources/db.properties
vim src/main/resources/db.properties
```

**步骤 2**: Alist服务配置
```java
// 📍 修改 AlistToken.java
private static final String ALIST_URL = "http://192.168.1.100:5244";
private static final String USERNAME = "admin";
private static final String PASSWORD = "your_alist_password";
```

### 🔨 4. 项目构建

**方式一：使用Maven构建**
```bash
# 🧹 清理并编译
mvn clean compile

# 📦 打包WAR文件
mvn package -DskipTests

# 📁 WAR文件位置：target/FileHostingSystemCY.war
```

**方式二：手动构建**
```bash
# 📁 创建构建目录
mkdir -p build/WEB-INF/{classes,lib}

# ☕ 编译Java源码
javac -cp "web/WEB-INF/lib/*" -d build/WEB-INF/classes src/main/java/**/*.java

# 📋 复制资源文件
cp -r src/main/resources/* build/WEB-INF/classes/
cp -r web/* build/

# 📦 打包WAR文件
cd build && jar -cvf ../FileHostingSystemCY.war *
```

### 🚀 5. 部署到Tomcat

**步骤 1**: 部署应用
```bash
# 🛑 停止Tomcat
$CATALINA_HOME/bin/shutdown.sh

# 📁 复制WAR文件
cp FileHostingSystemCY.war $CATALINA_HOME/webapps/

# 🚀 启动Tomcat
$CATALINA_HOME/bin/startup.sh
```

**步骤 2**: 验证部署
```bash
# 📊 检查日志
tail -f $CATALINA_HOME/logs/catalina.out

# 🌐 访问应用
curl http://localhost:8080/FileHostingSystemCY/
```

### 🔍 6. 部署验证

| 检查项 | 验证方法 | 预期结果 |
|--------|----------|----------|
| 🌐 **Web访问** | 浏览器访问主页 | 正常显示文件列表 |
| 🗄️ **数据库连接** | 查看应用日志 | 无连接错误 |
| 🔗 **Alist集成** | 测试文件上传 | 成功上传到Alist |
| 🔄 **数据同步** | 检查数据库记录 | 文件信息正确同步 |

</details>

## ⚠️ 注意事项

<details>
<summary><b>🛡️ 点击查看重要提醒</b></summary>

### 🔒 安全相关
- **🔐 密码安全**: 使用强密码，定期更换数据库和Alist密码
- **🌐 网络安全**: 生产环境建议配置HTTPS和防火墙规则
- **👤 权限控制**: 确保Tomcat运行用户权限最小化
- **📁 文件权限**: 上传目录权限设置为755，避免执行权限

### 🚀 性能优化
- **💾 内存配置**: 根据文件大小调整JVM堆内存
- **🔌 连接池**: 根据并发量调整数据库连接池大小
- **📁 存储空间**: 定期清理临时文件和日志
- **🔄 同步频率**: 根据使用情况调整数据同步间隔

### 🐛 故障排除
- **📊 日志监控**: 定期检查应用和数据库日志
- **🔍 连接测试**: 确保数据库和Alist服务连通性
- **📁 权限检查**: 验证文件读写权限
- **🔄 服务状态**: 监控各服务运行状态

### 🔧 维护建议
- **💾 数据备份**: 定期备份数据库和重要文件
- **🔄 版本更新**: 及时更新依赖库和系统组件
- **📊 性能监控**: 监控系统资源使用情况
- **🛡️ 安全扫描**: 定期进行安全漏洞扫描

</details>

> 开心工作，快乐编码！(〃'▽'〃) 🎉