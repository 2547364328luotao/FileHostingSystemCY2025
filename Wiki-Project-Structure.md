# 📁 项目结构

本页面详细介绍基于Alist的文件托管系统的项目结构和各个模块的功能。

## 🌳 目录结构

```
FileHostingSystemCY/
├── 📁 src/
│   └── 📁 main/
│       ├── 📁 java/
│       │   ├── 📁 controller/          # 控制器层
│       │   │   ├── 📄 FileQuery.java
│       │   │   ├── 📄 LoginServlet.java
│       │   │   ├── 📄 LogoutServlet.java
│       │   │   ├── 📄 MediaFileQuery.java
│       │   │   ├── 📄 StorageStats.java
│       │   │   └── 📄 UploadServlet.java
│       │   ├── 📁 dao/                 # 数据访问层
│       │   │   ├── 📄 MediaFileDAO.java
│       │   │   └── 📄 MediaTest.java
│       │   ├── 📁 db/                  # 数据库工具
│       │   │   ├── 📄 DBUtil.java
│       │   │   ├── 📄 MediaFileQuery.java
│       │   │   ├── 📄 StorageStats.java
│       │   │   └── 📄 TestDB.java
│       │   ├── 📁 filter/              # 过滤器
│       │   ├── 📁 model/               # 数据模型
│       │   │   ├── 📄 MediaFile.java
│       │   │   └── 📄 User.java
│       │   ├── 📁 service/             # 业务服务层
│       │   │   ├── 📄 LoginServlet.java
│       │   │   └── 📄 LogoutServlet.java
│       │   ├── 📁 test/                # 测试文件
│       │   └── 📁 utils/               # 工具类
│       │       ├── 📄 AlistRefresher.java
│       │       ├── 📄 AlistTest.java
│       │       ├── 📄 AlistUploader.java
│       │       ├── 📄 AlistUtils.java
│       │       ├── 📄 FileTypeMapper.java
│       │       └── 📄 TokenManager.java
│       └── 📁 webapp/                  # Web资源
│           ├── 📁 css/                 # 样式文件
│           ├── 📁 js/                  # JavaScript文件
│           ├── 📁 images/              # 图片资源
│           ├── 📁 WEB-INF/             # Web配置
│           │   └── 📄 web.xml
│           └── 📄 *.jsp                # JSP页面
├── 📄 pom.xml                          # Maven配置
├── 📄 README.md                        # 项目说明
└── 📄 课程设计模板.md                   # 课程设计文档
```

## 📦 模块详细说明

### 🎮 Controller层（控制器层）

控制器层负责处理HTTP请求和响应，是Web层的核心组件。

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `FileQuery.java` | 文件查询控制器 | 处理文件搜索和查询请求 |
| `LoginServlet.java` | 用户登录控制器 | 处理用户登录验证 |
| `LogoutServlet.java` | 用户登出控制器 | 处理用户登出操作 |
| `MediaFileQuery.java` | 媒体文件查询 | 专门处理媒体文件的查询 |
| `StorageStats.java` | 存储统计控制器 | 提供存储使用情况统计 |
| `UploadServlet.java` | 文件上传控制器 | 处理文件上传请求 |

### 🗄️ DAO层（数据访问层）

数据访问层封装了所有数据库操作，提供数据持久化服务。

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `MediaFileDAO.java` | 媒体文件数据访问 | 媒体文件的CRUD操作 |
| `MediaTest.java` | 数据访问测试 | 测试数据库连接和操作 |

### 🔧 DB层（数据库工具）

数据库工具层提供数据库连接管理和通用数据库操作。

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `DBUtil.java` | 数据库连接工具 | 管理数据库连接池 |
| `MediaFileQuery.java` | 媒体文件查询工具 | 提供媒体文件查询方法 |
| `StorageStats.java` | 存储统计工具 | 计算存储使用统计 |
| `TestDB.java` | 数据库测试工具 | 测试数据库连接 |

### 📊 Model层（数据模型）

数据模型层定义了系统中的核心数据结构。

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `MediaFile.java` | 媒体文件模型 | 定义媒体文件的数据结构 |
| `User.java` | 用户模型 | 定义用户的数据结构 |

### 🔧 Service层（业务服务层）

业务服务层实现核心业务逻辑，协调各个组件完成业务功能。

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `LoginServlet.java` | 登录业务服务 | 实现用户登录业务逻辑 |
| `LogoutServlet.java` | 登出业务服务 | 实现用户登出业务逻辑 |

### 🛠️ Utils层（工具类）

工具类层提供各种通用工具和Alist集成功能。

| 文件名 | 功能描述 | 主要职责 |
|--------|----------|----------|
| `AlistRefresher.java` | Alist刷新工具 | 刷新Alist目录缓存 |
| `AlistTest.java` | Alist测试工具 | 测试Alist API连接 |
| `AlistUploader.java` | Alist上传工具 | 处理文件上传到Alist |
| `AlistUtils.java` | Alist通用工具 | 提供Alist API通用方法 |
| `FileTypeMapper.java` | 文件类型映射 | 识别和映射文件类型 |
| `TokenManager.java` | Token管理工具 | 管理Alist API Token |

## 🌐 Web资源结构

### 📁 webapp目录

Web应用的根目录，包含所有前端资源和配置文件。

```
webapp/
├── 📁 css/                    # 样式文件目录
│   ├── 📄 bootstrap.min.css   # Bootstrap框架样式
│   ├── 📄 custom.css          # 自定义样式
│   └── 📄 main.css            # 主要样式文件
├── 📁 js/                     # JavaScript文件目录
│   ├── 📄 bootstrap.min.js    # Bootstrap框架脚本
│   ├── 📄 jquery.min.js       # jQuery库
│   ├── 📄 upload.js           # 文件上传脚本
│   └── 📄 main.js             # 主要脚本文件
├── 📁 images/                 # 图片资源目录
│   ├── 📄 logo.png            # 系统Logo
│   ├── 📄 icons/              # 图标文件
│   └── 📄 backgrounds/        # 背景图片
├── 📁 WEB-INF/                # Web配置目录
│   ├── 📄 web.xml             # Web应用配置文件
│   └── 📁 lib/                # 依赖库文件
├── 📄 index.jsp               # 首页
├── 📄 login.jsp               # 登录页面
├── 📄 dashboard.jsp           # 仪表板页面
├── 📄 upload.jsp              # 文件上传页面
├── 📄 files.jsp               # 文件管理页面
└── 📄 profile.jsp             # 用户资料页面
```

## 🔄 数据流向

### 📤 文件上传流程

```
用户界面 (JSP) 
    ↓ HTTP请求
UploadServlet (Controller)
    ↓ 业务处理
AlistUploader (Utils)
    ↓ API调用
Alist服务器
    ↓ 存储确认
MediaFileDAO (DAO)
    ↓ 数据持久化
MySQL数据库
```

### 📥 文件查询流程

```
用户界面 (JSP)
    ↓ AJAX请求
FileQuery (Controller)
    ↓ 查询处理
MediaFileDAO (DAO)
    ↓ 数据查询
MySQL数据库
    ↓ 结果返回
JSON响应
```

### 👤 用户认证流程

```
登录页面 (login.jsp)
    ↓ 表单提交
LoginServlet (Controller)
    ↓ 验证处理
User (Model)
    ↓ 数据库查询
DBUtil (DB)
    ↓ 会话创建
HttpSession
```

## 🔧 配置文件说明

### 📄 pom.xml

Maven项目配置文件，定义了项目依赖和构建配置：

- **项目信息**：groupId、artifactId、version
- **依赖管理**：Servlet API、MySQL驱动、JSON处理库等
- **构建配置**：编译插件、打包配置
- **属性设置**：Java版本、编码格式等

### 📄 web.xml

Web应用配置文件，定义了Servlet映射和应用参数：

- **Servlet配置**：Servlet类和URL映射
- **过滤器配置**：字符编码过滤器等
- **会话配置**：会话超时时间
- **错误页面**：自定义错误页面配置

## 🚀 部署结构

### 📦 WAR包结构

编译后的WAR包结构如下：

```
FileHostingSystem.war
├── 📁 WEB-INF/
│   ├── 📄 web.xml
│   ├── 📁 classes/            # 编译后的Java类
│   │   ├── 📁 controller/
│   │   ├── 📁 dao/
│   │   ├── 📁 model/
│   │   ├── 📁 service/
│   │   └── 📁 utils/
│   └── 📁 lib/                # 依赖JAR文件
├── 📁 css/                    # 样式文件
├── 📁 js/                     # JavaScript文件
├── 📁 images/                 # 图片资源
└── 📄 *.jsp                   # JSP页面文件
```

### 🔧 运行时结构

在Tomcat服务器中的运行时结构：

```
Tomcat/
├── 📁 webapps/
│   └── 📁 FileHostingSystem/  # 部署的应用
├── 📁 work/                   # JSP编译缓存
├── 📁 logs/                   # 日志文件
└── 📁 conf/                   # 配置文件
```

## 📋 开发规范

### 🎯 命名规范

- **类名**：使用PascalCase，如`MediaFileDAO`
- **方法名**：使用camelCase，如`uploadFile()`
- **变量名**：使用camelCase，如`fileName`
- **常量名**：使用UPPER_SNAKE_CASE，如`MAX_FILE_SIZE`
- **包名**：使用小写，如`com.example.controller`

### 📁 目录规范

- **controller**：存放控制器类
- **dao**：存放数据访问对象
- **model**：存放数据模型类
- **service**：存放业务服务类
- **utils**：存放工具类
- **filter**：存放过滤器类

### 📝 代码规范

- **注释**：每个类和方法都应有清晰的注释
- **异常处理**：统一的异常处理机制
- **资源管理**：及时关闭数据库连接等资源
- **日志记录**：重要操作应记录日志
- **安全性**：防范SQL注入、XSS等安全威胁

---

## 🔗 相关页面

- [首页](Wiki-Home.md) - 项目概述和文档导航
- [系统架构](Wiki-System-Architecture.md) - 详细的系统架构设计
- [API文档](Wiki-API-Documentation.md) - 系统API接口文档
- [部署指南](Wiki-Deployment-Guide.md) - 系统部署和配置指南
- [开发指南](Wiki-Development-Guide.md) - 开发环境搭建和开发规范

---

*最后更新时间：2024年*