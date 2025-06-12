# FileHostingSystem - 基于 Alist 的文件托管系统 🚀

> 武汉城市学院 2025 上半年 Web 课程设计 🎓

---

## 项目简介 📝

这是一个基于 Alist 的文件托管系统，提供文件上传、存储和管理功能。系统采用 Java Servlet 技术构建，集成 Alist 作为底层存储服务。

---

## 技术栈 🛠️

- **Java Servlet** 🍵
- **MySQL 数据库** 🗄️
- **Jackson JSON 处理库** 📦
- **OkHttp 客户端** 🌐

---

## 项目架构 🏗️

### 数据库 ER 图

![数据库ER图](web/image/ER图.drawio.svg)

### 项目数据流顶层图

<div align="center">
  <img src="web/image/数据流图-Page-1.drawio.svg" width="45%" />
  <img src="web/image/数据流图-第%202%20页.drawio.svg" width="45%" />
</div>

### 目录结构

```text
src/main/java/
├── controller/          # Servlet 控制器层
│   ├── UploadServlet.java      # 文件上传处理
│   ├── FilePreview.java        # 文件预览
│   ├── FileQuery.java          # 文件查询
│   ├── ListImage.java          # 图片列表
│   ├── DeleteFile.java         # 文件删除
│   ├── StorageServlet.java     # 存储管理
│   └── StorageSum.java         # 存储统计
├── service/             # 业务服务层
│   ├── LoginServlet.java       # 用户登录
│   └── LogoutServlet.java      # 用户登出
├── dao/                 # 数据访问层
│   ├── MediaFileDAO.java       # 媒体文件数据访问
│   └── MediaTest.java          # 数据访问测试
├── model/               # 数据模型层
│   ├── MediaFile.java          # 媒体文件实体
│   └── User.java               # 用户实体
├── db/                  # 数据库工具层
│   ├── DBUtil.java             # 数据库连接工具
│   ├── MediaFileQuery.java     # 媒体文件查询
│   ├── StorageStats.java       # 存储统计
│   └── TestDB.java             # 数据库测试
├── utils/               # 工具类层
│   ├── AlistToken.java         # Alist 认证管理
│   ├── AlistUploader.java      # 文件上传到 Alist
│   ├── AlistlistFiles.java     # Alist 文件列表
│   ├── AlistDatabaseRefresher.java # 数据同步
│   ├── AlistRefresher.java     # Alist 缓存刷新
│   ├── AlistRemove.java        # Alist 文件删除
│   ├── AddpreUrl.java          # URL 前缀处理
│   └── MainTest.java           # 主测试类
└── filter/              # 过滤器层（预留）

web/
├── WEB-INF/
│   ├── lib/                    # 第三方依赖库
│   └── web.xml                 # Web 应用配置
├── assets/                     # 静态资源
│   ├── css/                    # 样式文件
│   ├── js/                     # JavaScript 文件
│   ├── images/                 # 图片资源
│   └── vendor/                 # 第三方前端库
├── image/                      # 项目文档图片
│   ├── ER图.drawio.svg         # 数据库 ER 图
│   ├── 数据流图-Page-1.drawio.svg # 数据流图第 1 页
│   └── 数据流图-第 2 页.drawio.svg # 数据流图第 2 页
├── pages/                      # 静态页面
│   ├── homepage.html           # 主页
│   ├── about.html              # 关于页面
│   ├── contact.html            # 联系页面
│   └── sign-in.html            # 登录页面
├── index.jsp                   # 文件管理主页
├── upload.jsp                  # 文件上传页面
├── preview.jsp                 # 文件预览页面
├── sign-in.jsp                 # 用户登录页面
├── userCen.jsp                 # 用户中心
└── error.jsp                   # 错误页面
```

---

## 模块划分与主要流程

### 1. 目录结构与模块说明

- `controller/`：Servlet 控制器类，处理前端请求、文件上传、文件列表刷新等核心业务流程。
- `db/`：数据库操作相关类，如 `DBUtil`，提供数据库连接池、SQL 执行、事务管理等功能。
- `filter/`：过滤器相关类，用于权限校验、请求拦截等。
- `model/`：数据模型类，定义文件、用户等实体的数据结构。
- `service/`：业务逻辑层，封装如文件同步、用户管理等核心服务。
- `utils/`：工具类集合，包括 Alist API 对接、Token 管理、文件上传、数据库同步等。
  - `AlistToken.java`：实现 Alist 登录与 Token 获取。
  - `AlistlistFiles.java`：封装 Alist 文件列表 API，支持目录内容获取与解析。
  - `AlistUploader.java`：实现文件上传到 Alist 存储，支持大文件分片、进度回调。
  - `AlistDatabaseRefresher.java`：负责 Alist 与本地数据库的数据同步，自动识别文件类型并批量写入。
  - `AlistRefresher.java`：用于强制刷新 Alist 目录缓存，确保数据实时性。
  - `MainTest.java`、`AlistlistFilesTest.java`：测试与演示主类，便于开发调试。

- `src/main/resources/`
  - `db.properties`：数据库连接配置文件。

- `web/`
  - `WEB-INF/`：Web 应用配置与依赖库目录。
    - `web.xml`：Servlet 与过滤器等 Web 应用配置。
    - `lib/`：第三方依赖库（如 Jackson、OkHttp 等）。
  - `index.jsp`：文件管理主页面，展示文件列表、支持搜索与筛选。
  - `upload.jsp`：文件上传页面，支持拖拽上传、进度显示、类型预览，前端交互体验友好。

### 2. Builder 设计思想

- 文件信息（FileInfo）对象通过 setter 链式调用快速构建。
- 数据库操作、Alist API 调用等均采用分层解耦，便于后续扩展和维护。

### 3. 主要业务流程

1. 用户通过 `upload.jsp` 上传文件，`UploadServlet` 接收并保存至服务器临时目录。
2. 后端调用 `AlistUploader` 上传文件到 Alist 云存储。
3. 上传完成后，`AlistRefresher` 刷新 Alist 目录，`AlistlistFiles` 获取最新文件列表。
4. `AlistDatabaseRefresher` 将 Alist 文件信息同步到本地数据库，自动识别文件类型。
5. 前端页面实时展示上传进度与结果，支持预览和下载。

---

## 核心类说明 📚

### 工具类（utils）

- **AlistToken** 🔑
  - 处理 Alist 系统的身份认证
  - 实现登录获取 token 的功能
  - 支持 token 的自动刷新和管理
- **AlistlistFiles** 📋
  - 实现与 Alist API 的通信
  - 获取文件列表和目录结构
  - 支持文件信息的解析和封装
- **AlistUploader** ⬆️
  - 处理文件上传到 Alist 存储
  - 支持大文件分片上传
  - 提供上传进度回调
- **AlistDatabaseRefresher** 🔄
  - 同步 Alist 文件系统与本地数据库
  - 实现文件类型自动识别
  - 维护文件元数据

### 数据库（db）

- **DBUtil** 🗃️
  - 数据库连接池管理
  - 提供统一的数据库操作接口
  - 支持事务管理

### Web 界面

- **upload.jsp** 📤
  - 现代化的文件上传界面
  - 支持拖拽上传
  - 实时显示上传进度
  - 文件类型预览
- **index.jsp** 🏠
  - 文件管理主界面
  - 文件列表展示
  - 支持文件搜索和筛选

---

## 核心功能 ⭐

### 1. Alist 集成 🔗

- **文件列表获取**：通过 AlistlistFiles 类实现与 Alist 服务的通信，获取文件列表 📋
- **文件上传**：AlistUploader 类提供文件上传功能 ⬆️
- **认证管理**：AlistToken 类处理 Alist 的 token 获取和管理 🔑

### 2. 数据库管理 💾

- **连接管理**：DBUtil 类提供数据库连接池和资源管理 🔌
- **文件信息查询**：MediaFileQuery 类实现文件信息的查询功能 🔍
- **存储统计**：StorageStats 类提供存储使用量统计功能 📊

### 3. 数据同步 🔄

- 支持全量数据刷新 🔄
- 文件类型自动识别（图片、视频、音频等） 🎯
- 批量数据处理 📦

---

## 配置说明 ⚙️

### 数据库配置 🗄️

数据库连接信息在 `DBUtil.java` 中配置：

```java
private static final String URL = "jdbc:mysql://[host]:[port]/[database]";
private static final String USERNAME = "[username]";
private static final String PASSWORD = "[password]";
```

### Alist 配置 🛠️

Alist 服务配置示例：

```java
String baseUrl = "https://your-alist-domain";
String alistPath = "/your-storage-path";
```

---

## 部署说明 🚀

1. 配置数据库连接信息 📝
2. 配置 Alist 服务地址和认证信息 🔧
3. 部署到 Servlet 容器（如 Tomcat） 🌐
4. 访问系统首页进行文件管理 ✨

---

## 注意事项 ⚠️

1. 确保 Alist 服务可用且配置正确 ✅
2. 定期同步 Alist 与数据库数据 🔄
3. 监控存储使用量 📊
4. 注意 token 的有效期管理 ⏰

> 开心工作，快乐编码！(〃'▽'〃) 🎉