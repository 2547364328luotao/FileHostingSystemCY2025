# 🏗️ 系统架构

本页面详细介绍基于Alist的文件托管系统的技术架构、设计模式和核心组件。

## 📋 目录

- [整体架构](#整体架构)
- [技术栈](#技术栈)
- [架构层次](#架构层次)
- [核心组件](#核心组件)
- [设计模式](#设计模式)
- [数据流向](#数据流向)
- [安全架构](#安全架构)
- [性能优化](#性能优化)

---

## 🏛️ 整体架构

系统采用经典的**三层B/S架构**，结合现代Web开发技术栈，确保系统的可扩展性、可维护性和高性能。

```
┌─────────────────────────────────────────────────────────────┐
│                    🌐 表现层 (Presentation Layer)              │
├─────────────────────────────────────────────────────────────┤
│  📱 Web浏览器  │  📄 JSP页面  │  🎨 Bootstrap UI  │  ⚡ AJAX  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ HTTP/HTTPS
┌─────────────────────────────────────────────────────────────┐
│                    🎮 控制层 (Control Layer)                   │
├─────────────────────────────────────────────────────────────┤
│  🔧 Servlet容器  │  📡 Controller  │  🔒 Filter  │  📊 JSON  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ 方法调用
┌─────────────────────────────────────────────────────────────┐
│                   💼 业务逻辑层 (Business Layer)                │
├─────────────────────────────────────────────────────────────┤
│  🔧 Service  │  🛠️ Utils  │  📦 Model  │  🔐 Security  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ 数据访问
┌─────────────────────────────────────────────────────────────┐
│                   🗄️ 数据访问层 (Data Access Layer)            │
├─────────────────────────────────────────────────────────────┤
│  📊 DAO  │  🔗 DBUtil  │  🏊 连接池  │  📋 SQL  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ JDBC
┌─────────────────────────────────────────────────────────────┐
│                    💾 数据存储层 (Storage Layer)               │
├─────────────────────────────────────────────────────────────┤
│  🗃️ MySQL数据库  │  ☁️ Alist云存储  │  📁 文件系统  │
└─────────────────────────────────────────────────────────────┘
```

## 🛠️ 技术栈

### 后端技术栈

| 技术 | 版本 | 用途 | 说明 |
|------|------|------|------|
| **Java** | 1.8+ | 核心开发语言 | 提供稳定的运行环境和丰富的生态 |
| **Servlet** | 4.0 | Web容器技术 | 处理HTTP请求和响应 |
| **JSP** | 2.3 | 页面模板技术 | 动态生成HTML页面 |
| **JSTL** | 1.2 | 标签库 | 简化JSP页面开发 |
| **MySQL** | 8.0 | 关系型数据库 | 存储用户和文件元数据 |
| **C3P0** | 0.9.5 | 数据库连接池 | 管理数据库连接，提高性能 |
| **OkHttp** | 4.10.0 | HTTP客户端 | 与Alist API通信 |
| **Jackson** | 2.15.2 | JSON处理 | 序列化和反序列化JSON数据 |
| **Commons FileUpload** | 1.4 | 文件上传 | 处理multipart/form-data请求 |

### 前端技术栈

| 技术 | 版本 | 用途 | 说明 |
|------|------|------|------|
| **HTML5** | - | 页面结构 | 现代Web标准 |
| **CSS3** | - | 样式设计 | 响应式布局和动画效果 |
| **JavaScript** | ES6+ | 前端逻辑 | 用户交互和动态效果 |
| **jQuery** | 3.6.0 | DOM操作 | 简化JavaScript开发 |
| **Bootstrap** | 5.1.3 | UI框架 | 响应式组件和样式 |
| **AJAX** | - | 异步通信 | 无刷新数据交互 |

### 外部服务

| 服务 | 用途 | 说明 |
|------|------|------|
| **Alist** | 云存储管理 | 统一管理多种云存储服务 |
| **云存储** | 文件存储 | 阿里云OSS、腾讯云COS等 |
| **Tomcat** | Web服务器 | 部署和运行Web应用 |

## 🏗️ 架构层次

### 1️⃣ 表现层 (Presentation Layer)

**职责**：用户界面展示和用户交互处理

```
表现层组件
├── 📄 JSP页面
│   ├── index.jsp          # 首页
│   ├── login.jsp          # 登录页面
│   ├── dashboard.jsp      # 仪表板
│   ├── upload.jsp         # 文件上传
│   ├── files.jsp          # 文件管理
│   └── profile.jsp        # 用户资料
├── 🎨 静态资源
│   ├── CSS样式文件
│   ├── JavaScript脚本
│   └── 图片资源
└── 🔧 前端框架
    ├── Bootstrap UI组件
    ├── jQuery库
    └── AJAX异步通信
```

**特点**：
- 📱 响应式设计，支持多设备访问
- 🎨 现代化UI界面，用户体验友好
- ⚡ AJAX异步交互，页面无刷新更新
- 🔒 前端数据验证，提高安全性

### 2️⃣ 控制层 (Control Layer)

**职责**：处理HTTP请求，协调业务逻辑和视图渲染

```
控制层组件
├── 🎮 Servlet控制器
│   ├── LoginServlet       # 用户登录
│   ├── LogoutServlet      # 用户登出
│   ├── UploadServlet      # 文件上传
│   ├── FileQuery          # 文件查询
│   ├── MediaFileQuery     # 媒体文件查询
│   └── StorageStats       # 存储统计
├── 🔒 过滤器 (Filter)
│   ├── 字符编码过滤器
│   ├── 登录验证过滤器
│   └── 跨域请求过滤器
└── 📡 请求处理
    ├── 参数验证
    ├── 异常处理
    └── 响应格式化
```

**设计原则**：
- 🎯 单一职责：每个Servlet只处理特定功能
- 🔄 统一处理：统一的异常处理和响应格式
- 📊 JSON通信：前后端采用JSON格式交互
- 🔒 安全验证：统一的权限验证机制

### 3️⃣ 业务逻辑层 (Business Layer)

**职责**：实现核心业务逻辑，处理业务规则和数据转换

```
业务逻辑层组件
├── 💼 Service服务
│   ├── UserService        # 用户管理服务
│   ├── FileService        # 文件管理服务
│   ├── UploadService      # 文件上传服务
│   └── AlistService       # Alist集成服务
├── 📦 Model模型
│   ├── User.java          # 用户模型
│   ├── MediaFile.java     # 媒体文件模型
│   └── StorageInfo.java   # 存储信息模型
├── 🛠️ Utils工具
│   ├── AlistUtils         # Alist工具类
│   ├── FileTypeMapper     # 文件类型映射
│   ├── TokenManager       # Token管理
│   └── AlistUploader      # 文件上传工具
└── 🔐 Security安全
    ├── 权限验证
    ├── 数据加密
    └── 输入验证
```

**核心特性**：
- 🔧 模块化设计：功能模块独立，便于维护
- 🔄 事务管理：确保数据一致性
- 🛡️ 安全控制：完善的权限和安全机制
- 🔌 接口抽象：便于扩展和测试

### 4️⃣ 数据访问层 (Data Access Layer)

**职责**：封装数据库操作，提供数据持久化服务

```
数据访问层组件
├── 📊 DAO对象
│   ├── UserDAO            # 用户数据访问
│   ├── MediaFileDAO       # 媒体文件数据访问
│   └── LogDAO             # 日志数据访问
├── 🔗 数据库工具
│   ├── DBUtil             # 数据库连接工具
│   ├── ConnectionPool     # 连接池管理
│   └── SQLBuilder         # SQL构建器
└── 📋 数据操作
    ├── CRUD操作
    ├── 事务管理
    └── 批量操作
```

**技术特点**：
- 🏊 连接池技术：C3P0连接池提高性能
- 🔒 SQL防注入：预编译语句防范SQL注入
- 📊 ORM映射：对象关系映射简化开发
- 🔄 事务支持：确保数据操作的原子性

## 🧩 核心组件

### 🔐 认证与授权组件

```java
// 用户认证流程
User Authentication Flow:
1. 用户提交登录信息
2. LoginServlet验证用户名密码
3. 创建Session存储用户信息
4. 返回登录结果

// 权限控制
Authorization Levels:
- 普通用户 (is_regular = 1): 基本文件操作
- 编辑者 (is_editor = 1): 高级文件管理
- 管理员 (is_admin = 1): 系统管理权限
```

### 📤 文件上传组件

```java
// 文件上传处理流程
File Upload Process:
1. 前端选择文件 → MultipartConfig接收
2. 临时存储 → 文件验证和处理
3. Alist API上传 → 云端存储
4. 数据库记录 → 元数据持久化
5. 清理临时文件 → 返回结果

// 核心组件
UploadServlet + AlistUploader + MediaFileDAO
```

### ☁️ Alist集成组件

```java
// Alist API集成架构
Alist Integration:
├── TokenManager      # Token获取和管理
├── AlistUploader     # 文件上传到Alist
├── AlistUtils        # Alist API通用方法
├── AlistRefresher    # 目录刷新和同步
└── AlistTest         # API连接测试

// API调用流程
1. 获取Token → 2. 上传文件 → 3. 刷新目录 → 4. 返回结果
```

### 🗄️ 数据库连接组件

```java
// 数据库连接池配置
C3P0 Configuration:
- initialPoolSize: 5     # 初始连接数
- maxPoolSize: 20        # 最大连接数
- checkoutTimeout: 3000  # 获取连接超时
- maxIdleTime: 1800      # 最大空闲时间

// 连接管理
DBUtil.getConnection() → 获取连接
DBUtil.close() → 释放资源
```

## 🎨 设计模式

### 1. MVC模式 (Model-View-Controller)

```
🎮 Controller (Servlet)
    ↕️ 控制流程
📦 Model (JavaBean)
    ↕️ 数据传递  
📄 View (JSP)
```

**优势**：
- 🔄 分离关注点，提高代码可维护性
- 🔧 模块化开发，便于团队协作
- 🧪 便于单元测试和调试

### 2. DAO模式 (Data Access Object)

```java
// DAO接口定义
public interface MediaFileDAO {
    void save(MediaFile mediaFile);
    MediaFile findById(int id);
    List<MediaFile> findByUserId(int userId);
    void update(MediaFile mediaFile);
    void delete(int id);
}

// 实现类
public class MediaFileDAOImpl implements MediaFileDAO {
    // 具体的数据库操作实现
}
```

**优势**：
- 🔒 封装数据访问逻辑
- 🔄 便于切换数据源
- 🧪 便于单元测试

### 3. 单例模式 (Singleton)

```java
// 数据库连接池单例
public class DBUtil {
    private static final ComboPooledDataSource dataSource = new ComboPooledDataSource();
    
    // 私有构造函数
    private DBUtil() {}
    
    // 获取连接
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
```

**优势**：
- 💾 节省系统资源
- 🔒 确保全局唯一实例
- ⚡ 提高性能

### 4. 工厂模式 (Factory)

```java
// 文件类型工厂
public class FileTypeMapper {
    public static String mapFileType(String fileName) {
        String extension = getFileExtension(fileName);
        switch (extension.toLowerCase()) {
            case "jpg": case "png": case "gif":
                return "image";
            case "mp4": case "avi": case "mov":
                return "video";
            case "mp3": case "wav": case "flac":
                return "audio";
            default:
                return "other";
        }
    }
}
```

## 🔄 数据流向

### 📤 文件上传数据流

```
1. 用户选择文件
   ↓ multipart/form-data
2. UploadServlet接收
   ↓ 文件处理
3. 临时存储验证
   ↓ API调用
4. AlistUploader上传
   ↓ HTTP PUT
5. Alist云存储
   ↓ 响应确认
6. MediaFileDAO保存
   ↓ SQL INSERT
7. MySQL数据库
   ↓ 结果返回
8. JSON响应用户
```

### 📥 文件查询数据流

```
1. 用户发起查询
   ↓ AJAX请求
2. FileQuery处理
   ↓ 参数解析
3. MediaFileDAO查询
   ↓ SQL SELECT
4. MySQL数据库
   ↓ 结果集返回
5. 数据转换处理
   ↓ JSON序列化
6. 响应返回前端
   ↓ DOM更新
7. 页面展示结果
```

### 👤 用户认证数据流

```
1. 用户提交登录
   ↓ POST请求
2. LoginServlet验证
   ↓ 密码校验
3. 数据库查询用户
   ↓ 权限检查
4. 创建Session
   ↓ 用户信息存储
5. 返回登录结果
   ↓ 页面重定向
6. 进入系统主页
```

## 🔒 安全架构

### 🛡️ 多层安全防护

```
┌─────────────────────────────────────┐
│           🌐 网络层安全                │
├─────────────────────────────────────┤
│  HTTPS加密  │  防火墙  │  DDoS防护   │
└─────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────┐
│           🎮 应用层安全                │
├─────────────────────────────────────┤
│  身份认证  │  权限控制  │  会话管理    │
└─────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────┐
│           💾 数据层安全                │
├─────────────────────────────────────┤
│  SQL防注入  │  数据加密  │  访问控制   │
└─────────────────────────────────────┘
```

### 🔐 安全机制详解

#### 1. 身份认证安全

```java
// Session管理
HttpSession session = request.getSession();
User user = (User) session.getAttribute("userInfo");
if (user == null) {
    // 重定向到登录页面
    response.sendRedirect("login.jsp");
    return;
}
```

#### 2. SQL注入防护

```java
// 使用预编译语句
String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, username);
stmt.setString(2, password);
```

#### 3. XSS攻击防护

```java
// 输入验证和转义
public static String escapeHtml(String input) {
    return input.replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("&", "&amp;");
}
```

#### 4. 文件上传安全

```java
// 文件类型验证
private boolean isValidFileType(String fileName) {
    String[] allowedTypes = {".jpg", ".png", ".gif", ".pdf", ".doc"};
    String extension = getFileExtension(fileName);
    return Arrays.asList(allowedTypes).contains(extension.toLowerCase());
}
```

## ⚡ 性能优化

### 🏊 数据库优化

```sql
-- 索引优化
CREATE INDEX idx_user_id ON media_files(user_id);
CREATE INDEX idx_filename ON media_files(filename);
CREATE INDEX idx_upload_time ON media_files(uploaded_at);

-- 查询优化
SELECT * FROM media_files 
WHERE user_id = ? 
ORDER BY uploaded_at DESC 
LIMIT 20;
```

### 🔗 连接池优化

```java
// C3P0连接池配置
dataSource.setInitialPoolSize(5);        // 初始连接数
dataSource.setMaxPoolSize(20);           // 最大连接数
dataSource.setMinPoolSize(3);            // 最小连接数
dataSource.setAcquireIncrement(2);       // 连接增长步长
dataSource.setMaxIdleTime(1800);         // 最大空闲时间
dataSource.setCheckoutTimeout(3000);     // 获取连接超时
```

### 📦 缓存策略

```java
// 文件信息缓存
public class FileCache {
    private static final Map<String, MediaFile> cache = new ConcurrentHashMap<>();
    
    public static MediaFile get(String key) {
        return cache.get(key);
    }
    
    public static void put(String key, MediaFile file) {
        cache.put(key, file);
    }
}
```

### 🔄 异步处理

```java
// 异步文件上传
@WebServlet(value = "/upload", asyncSupported = true)
public class AsyncUploadServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        AsyncContext asyncContext = request.startAsync();
        
        // 异步处理文件上传
        CompletableFuture.runAsync(() -> {
            try {
                // 文件上传逻辑
                processFileUpload(request, response);
            } finally {
                asyncContext.complete();
            }
        });
    }
}
```

## 📊 监控与日志

### 📈 性能监控

```java
// 性能监控切面
public class PerformanceMonitor {
    
    public void monitorMethod(String methodName, long startTime) {
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;
        
        if (duration > 1000) { // 超过1秒记录警告
            logger.warn("Method {} took {} ms", methodName, duration);
        }
    }
}
```

### 📝 日志管理

```java
// 统一日志记录
public class LogUtil {
    private static final Logger logger = LoggerFactory.getLogger(LogUtil.class);
    
    public static void logUserAction(String username, String action, String details) {
        logger.info("User: {}, Action: {}, Details: {}", username, action, details);
    }
    
    public static void logError(String operation, Exception e) {
        logger.error("Error in {}: {}", operation, e.getMessage(), e);
    }
}
```

---

## 🔗 相关页面

- [首页](Wiki-Home.md) - 项目概述和文档导航
- [项目结构](Wiki-Project-Structure.md) - 详细的项目目录结构
- [API文档](Wiki-API-Documentation.md) - 系统API接口文档
- [部署指南](Wiki-Deployment-Guide.md) - 系统部署和配置指南
- [开发指南](Wiki-Development-Guide.md) - 开发环境搭建和开发规范

---

*最后更新时间：2024年*