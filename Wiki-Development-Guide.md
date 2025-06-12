# 💻 开发指南

本页面详细介绍基于Alist的文件托管系统的开发环境搭建、开发规范和贡献指南。

## 📋 目录

- [开发环境搭建](#开发环境搭建)
- [项目结构说明](#项目结构说明)
- [开发规范](#开发规范)
- [代码风格](#代码风格)
- [测试指南](#测试指南)
- [调试技巧](#调试技巧)
- [版本控制](#版本控制)
- [贡献指南](#贡献指南)
- [常见问题](#常见问题)

---

## 🛠️ 开发环境搭建

### 1️⃣ 基础环境要求

#### 软件要求

| 软件 | 版本 | 必需 | 说明 |
|------|------|------|------|
| **Java JDK** | 1.8+ | ✅ | 开发运行环境 |
| **Apache Tomcat** | 9.0+ | ✅ | Web服务器 |
| **MySQL** | 8.0+ | ✅ | 数据库 |
| **Alist** | 3.25+ | ✅ | 文件管理服务 |
| **IDE** | IntelliJ IDEA/Eclipse | ✅ | 开发工具 |
| **Git** | 2.0+ | ✅ | 版本控制 |
| **Maven/Gradle** | 3.6+/6.0+ | ❌ | 构建工具（可选） |
| **Postman** | 最新版 | ❌ | API测试工具 |

#### 开发工具推荐

**IDE配置**：

- **IntelliJ IDEA Ultimate** (推荐)
  - 支持完整的Java EE开发
  - 内置Tomcat集成
  - 强大的调试功能
  - 数据库工具集成

- **Eclipse IDE for Enterprise Java Developers**
  - 免费开源
  - 丰富的插件生态
  - 良好的Maven/Gradle支持

**浏览器开发工具**：

- **Chrome DevTools** - 前端调试
- **Firefox Developer Tools** - 网络分析
- **Postman** - API测试
- **MySQL Workbench** - 数据库管理

### 2️⃣ 环境安装配置

#### Windows开发环境

```powershell
# 1. 安装Chocolatey包管理器
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# 2. 使用Chocolatey安装开发工具
choco install openjdk8 -y
choco install apache-tomcat -y
choco install mysql -y
choco install git -y
choco install intellijidea-ultimate -y
choco install postman -y

# 3. 配置环境变量
# JAVA_HOME: C:\Program Files\OpenJDK\openjdk-8u312-b07
# CATALINA_HOME: C:\ProgramData\chocolatey\lib\apache-tomcat\tools\apache-tomcat-9.0.65
# PATH: 添加 %JAVA_HOME%\bin 和 %CATALINA_HOME%\bin

# 4. 验证安装
java -version
catalina.bat version
mysql --version
git --version
```

#### macOS开发环境

```bash
# 1. 安装Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. 安装开发工具
brew install openjdk@8
brew install tomcat
brew install mysql
brew install git
brew install --cask intellij-idea
brew install --cask postman

# 3. 配置环境变量
echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)' >> ~/.zshrc
echo 'export CATALINA_HOME=/usr/local/Cellar/tomcat/9.0.65/libexec' >> ~/.zshrc
echo 'export PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# 4. 启动服务
brew services start mysql
brew services start tomcat

# 5. 验证安装
java -version
catalina.sh version
mysql --version
git --version
```

#### Linux开发环境

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-8-jdk tomcat9 mysql-server git curl wget -y

# CentOS/RHEL
sudo yum install java-1.8.0-openjdk tomcat mysql-server git curl wget -y

# 配置环境变量
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.bashrc
echo 'export CATALINA_HOME=/var/lib/tomcat9' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 启动服务
sudo systemctl start mysql
sudo systemctl start tomcat9
sudo systemctl enable mysql
sudo systemctl enable tomcat9

# 安装IDE（可选）
# 下载IntelliJ IDEA或Eclipse
wget https://download.jetbrains.com/idea/ideaIU-2023.2.tar.gz
tar -xzf ideaIU-2023.2.tar.gz
sudo mv idea-IU-232.8660.185 /opt/idea
sudo ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea
```

### 3️⃣ 项目导入配置

#### IntelliJ IDEA配置

1. **导入项目**：
   ```
   File → Open → 选择项目根目录
   ```

2. **配置JDK**：
   ```
   File → Project Structure → Project → Project SDK → 选择JDK 1.8
   ```

3. **配置Tomcat**：
   ```
   Run → Edit Configurations → + → Tomcat Server → Local
   Application Server: 选择Tomcat安装目录
   Deployment: + → Artifact → FileHostingSystemCY:war exploded
   ```

4. **配置数据库连接**：
   ```
   View → Tool Windows → Database
   + → Data Source → MySQL
   Host: localhost, Port: 3306
   Database: file_hosting_system
   User: filehost, Password: your_password
   ```

#### Eclipse配置

1. **导入项目**：
   ```
   File → Import → Existing Projects into Workspace
   ```

2. **配置JRE**：
   ```
   Project → Properties → Java Build Path → Libraries
   Modulepath → Add Library → JRE System Library
   ```

3. **配置Tomcat**：
   ```
   Window → Preferences → Server → Runtime Environments
   Add → Apache Tomcat v9.0 → 选择安装目录
   ```

4. **配置部署**：
   ```
   右键项目 → Properties → Project Facets
   启用 Java 和 Dynamic Web Module
   ```

---

## 📁 项目结构说明

### 源码目录结构

```
FileHostingSystemCY/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── filehosting/
│   │   │           ├── servlet/          # Servlet控制器
│   │   │           │   ├── LoginServlet.java
│   │   │           │   ├── UploadServlet.java
│   │   │           │   ├── FileServlet.java
│   │   │           │   └── MediaServlet.java
│   │   │           ├── dao/              # 数据访问层
│   │   │           │   ├── UserDAO.java
│   │   │           │   ├── MediaFileDAO.java
│   │   │           │   └── SystemLogDAO.java
│   │   │           ├── model/            # 数据模型
│   │   │           │   ├── User.java
│   │   │           │   ├── MediaFile.java
│   │   │           │   └── SystemLog.java
│   │   │           ├── service/          # 业务逻辑层
│   │   │           │   ├── UserService.java
│   │   │           │   ├── FileService.java
│   │   │           │   └── AlistService.java
│   │   │           ├── util/             # 工具类
│   │   │           │   ├── DatabaseUtil.java
│   │   │           │   ├── JsonUtil.java
│   │   │           │   ├── FileUtil.java
│   │   │           │   └── SecurityUtil.java
│   │   │           ├── filter/           # 过滤器
│   │   │           │   ├── CharacterEncodingFilter.java
│   │   │           │   ├── LoginFilter.java
│   │   │           │   └── CorsFilter.java
│   │   │           └── config/           # 配置类
│   │   │               ├── DatabaseConfig.java
│   │   │               └── AlistConfig.java
│   │   ├── resources/
│   │   │   ├── db.properties            # 数据库配置
│   │   │   ├── alist.properties         # Alist配置
│   │   │   └── logback.xml              # 日志配置
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml              # Web应用配置
│   │       │   └── lib/                 # 依赖JAR包
│   │       ├── css/                     # 样式文件
│   │       ├── js/                      # JavaScript文件
│   │       ├── images/                  # 图片资源
│   │       ├── index.jsp                # 首页
│   │       ├── login.jsp                # 登录页面
│   │       ├── dashboard.jsp            # 仪表板
│   │       ├── upload.jsp               # 文件上传
│   │       ├── files.jsp                # 文件列表
│   │       └── profile.jsp              # 用户资料
│   └── test/
│       └── java/
│           └── com/
│               └── filehosting/
│                   ├── dao/             # DAO测试
│                   ├── service/         # 服务测试
│                   └── util/            # 工具类测试
├── lib/                                 # 外部依赖库
├── database/                            # 数据库脚本
│   ├── init.sql                        # 初始化脚本
│   ├── data.sql                        # 测试数据
│   └── migration/                      # 数据库迁移
├── docs/                               # 文档目录
├── scripts/                            # 部署脚本
├── README.md                           # 项目说明
└── pom.xml                             # Maven配置（可选）
```

### 核心模块说明

#### 1. Servlet层 (Controller)

**职责**：处理HTTP请求，调用业务逻辑，返回响应

```java
// 示例：LoginServlet.java
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 1. 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 2. 调用业务逻辑
        User user = userService.authenticate(username, password);
        
        // 3. 处理结果
        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "用户名或密码错误");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
```

#### 2. Service层 (Business Logic)

**职责**：实现业务逻辑，协调DAO层操作

```java
// 示例：FileService.java
public class FileService {
    private MediaFileDAO mediaFileDAO = new MediaFileDAO();
    private AlistService alistService = new AlistService();
    
    public boolean uploadFile(User user, Part filePart) {
        try {
            // 1. 验证文件
            if (!validateFile(filePart)) {
                return false;
            }
            
            // 2. 上传到Alist
            String alistPath = alistService.uploadFile(filePart);
            if (alistPath == null) {
                return false;
            }
            
            // 3. 保存到数据库
            MediaFile mediaFile = createMediaFile(user, filePart, alistPath);
            return mediaFileDAO.insert(mediaFile) > 0;
            
        } catch (Exception e) {
            logger.error("文件上传失败", e);
            return false;
        }
    }
}
```

#### 3. DAO层 (Data Access)

**职责**：数据库操作，CRUD功能实现

```java
// 示例：MediaFileDAO.java
public class MediaFileDAO {
    
    public int insert(MediaFile mediaFile) {
        String sql = "INSERT INTO media_files (user_id, filename, original_filename, " +
                    "file_size, file_type, file_path, uploaded_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, mediaFile.getUserId());
            stmt.setString(2, mediaFile.getFilename());
            stmt.setString(3, mediaFile.getOriginalFilename());
            stmt.setLong(4, mediaFile.getFileSize());
            stmt.setString(5, mediaFile.getFileType());
            stmt.setString(6, mediaFile.getFilePath());
            stmt.setTimestamp(7, new Timestamp(mediaFile.getUploadedAt().getTime()));
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            logger.error("插入媒体文件记录失败", e);
        }
        return 0;
    }
}
```

---

## 📝 开发规范

### 1️⃣ 命名规范

#### Java命名规范

```java
// 类名：大驼峰命名法
public class MediaFileService {}
public class UserDAO {}

// 方法名：小驼峰命名法
public void uploadFile() {}
public User getUserById(int id) {}

// 变量名：小驼峰命名法
private String fileName;
private int maxFileSize;

// 常量：全大写，下划线分隔
public static final String DEFAULT_UPLOAD_PATH = "/uploads";
public static final int MAX_FILE_SIZE = 100 * 1024 * 1024;

// 包名：全小写，点分隔
com.filehosting.servlet
com.filehosting.dao
com.filehosting.util
```

#### 数据库命名规范

```sql
-- 表名：小写，下划线分隔
CREATE TABLE media_files (
    -- 字段名：小写，下划线分隔
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 索引名：idx_表名_字段名
CREATE INDEX idx_media_files_user_id ON media_files(user_id);
CREATE INDEX idx_media_files_file_name ON media_files(file_name);
```

#### 前端命名规范

```javascript
// 变量名：小驼峰命名法
var fileName = 'example.jpg';
var maxFileSize = 100 * 1024 * 1024;

// 函数名：小驼峰命名法
function uploadFile() {}
function validateFileType(file) {}

// 常量：全大写，下划线分隔
const MAX_FILE_SIZE = 100 * 1024 * 1024;
const ALLOWED_FILE_TYPES = ['jpg', 'png', 'pdf'];
```

```css
/* CSS类名：小写，连字符分隔 */
.file-upload-container {}
.upload-progress-bar {}
.error-message {}

/* ID名：小写，连字符分隔 */
#file-input {}
#upload-button {}
#progress-container {}
```

### 2️⃣ 代码结构规范

#### Java类结构

```java
/**
 * 媒体文件服务类
 * 负责处理文件上传、下载、删除等业务逻辑
 * 
 * @author 开发者姓名
 * @version 1.0
 * @since 2024-01-01
 */
public class MediaFileService {
    
    // 1. 静态常量
    private static final Logger logger = LoggerFactory.getLogger(MediaFileService.class);
    private static final String UPLOAD_PATH = "/uploads";
    
    // 2. 实例变量
    private MediaFileDAO mediaFileDAO;
    private AlistService alistService;
    
    // 3. 构造方法
    public MediaFileService() {
        this.mediaFileDAO = new MediaFileDAO();
        this.alistService = new AlistService();
    }
    
    // 4. 公共方法
    public boolean uploadFile(User user, Part filePart) {
        // 方法实现
    }
    
    public List<MediaFile> getFilesByUser(int userId) {
        // 方法实现
    }
    
    // 5. 私有方法
    private boolean validateFile(Part filePart) {
        // 方法实现
    }
    
    private String generateFileName(String originalName) {
        // 方法实现
    }
}
```

#### Servlet结构

```java
@WebServlet("/upload")
public class UploadServlet extends HttpServlet {
    
    private static final Logger logger = LoggerFactory.getLogger(UploadServlet.class);
    private MediaFileService fileService = new MediaFileService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 设置响应类型
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // 2. 验证用户登录
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                sendErrorResponse(response, "用户未登录");
                return;
            }
            
            // 3. 获取上传文件
            Part filePart = request.getPart("file");
            if (filePart == null) {
                sendErrorResponse(response, "未选择文件");
                return;
            }
            
            // 4. 处理业务逻辑
            boolean success = fileService.uploadFile(user, filePart);
            
            // 5. 返回结果
            if (success) {
                sendSuccessResponse(response, "文件上传成功");
            } else {
                sendErrorResponse(response, "文件上传失败");
            }
            
        } catch (Exception e) {
            logger.error("文件上传异常", e);
            sendErrorResponse(response, "系统异常");
        }
    }
    
    private void sendSuccessResponse(HttpServletResponse response, String message) 
            throws IOException {
        // 实现成功响应
    }
    
    private void sendErrorResponse(HttpServletResponse response, String message) 
            throws IOException {
        // 实现错误响应
    }
}
```

### 3️⃣ 注释规范

#### 类注释

```java
/**
 * 用户数据访问对象
 * 提供用户相关的数据库操作方法
 * 
 * <p>主要功能包括：
 * <ul>
 *   <li>用户认证</li>
 *   <li>用户信息查询</li>
 *   <li>用户信息更新</li>
 * </ul>
 * 
 * @author 张三
 * @version 1.2
 * @since 2024-01-01
 * @see User
 * @see DatabaseUtil
 */
public class UserDAO {
    // 类实现
}
```

#### 方法注释

```java
/**
 * 根据用户名和密码验证用户身份
 * 
 * @param username 用户名，不能为空
 * @param password 密码，不能为空
 * @return 验证成功返回用户对象，失败返回null
 * @throws SQLException 数据库操作异常
 * @throws IllegalArgumentException 参数为空时抛出
 * 
 * @since 1.0
 */
public User authenticate(String username, String password) throws SQLException {
    // 方法实现
}
```

#### 复杂逻辑注释

```java
public boolean uploadFile(User user, Part filePart) {
    try {
        // 1. 验证文件大小和类型
        if (!validateFile(filePart)) {
            logger.warn("文件验证失败: {}", filePart.getSubmittedFileName());
            return false;
        }
        
        // 2. 生成唯一文件名，避免重名冲突
        String fileName = generateUniqueFileName(filePart.getSubmittedFileName());
        
        // 3. 上传到Alist存储
        // 使用Alist API将文件上传到配置的存储后端
        String alistPath = alistService.uploadFile(filePart, fileName);
        if (alistPath == null) {
            logger.error("Alist上传失败: {}", fileName);
            return false;
        }
        
        // 4. 保存文件信息到数据库
        // 记录文件元数据，包括用户ID、文件路径、大小等
        MediaFile mediaFile = createMediaFileRecord(user, filePart, fileName, alistPath);
        int fileId = mediaFileDAO.insert(mediaFile);
        
        if (fileId > 0) {
            logger.info("文件上传成功: {} (ID: {})", fileName, fileId);
            return true;
        } else {
            // 数据库保存失败，需要清理Alist中的文件
            alistService.deleteFile(alistPath);
            logger.error("数据库保存失败，已清理Alist文件: {}", alistPath);
            return false;
        }
        
    } catch (Exception e) {
        logger.error("文件上传异常: {}", filePart.getSubmittedFileName(), e);
        return false;
    }
}
```

---

## 🎨 代码风格

### 1️⃣ Java代码风格

#### 缩进和格式

```java
// 使用4个空格缩进，不使用Tab
public class Example {
    private String name;
    
    public void method() {
        if (condition) {
            // 代码块
        } else {
            // 代码块
        }
    }
}

// 方法参数过长时的换行
public void longMethodName(String firstParameter, 
                          String secondParameter, 
                          String thirdParameter) {
    // 方法实现
}

// 链式调用的换行
String result = someObject
    .method1()
    .method2()
    .method3();
```

#### 空行使用

```java
public class Example {
    // 类开始后空一行
    
    private static final String CONSTANT = "value";
    
    private String field;
    
    // 构造方法前空一行
    public Example() {
        // 构造方法实现
    }
    
    // 方法间空一行
    public void method1() {
        // 方法实现
    }
    
    public void method2() {
        // 逻辑块间空一行
        String variable = getValue();
        
        if (variable != null) {
            processVariable(variable);
        }
        
        // 返回前空一行
        return;
    }
}
```

#### 异常处理

```java
// 推荐的异常处理方式
public User getUserById(int id) {
    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
        
        stmt.setInt(1, id);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        }
        
    } catch (SQLException e) {
        logger.error("查询用户失败: id={}", id, e);
        throw new RuntimeException("数据库查询异常", e);
    }
    
    return null;
}

// 避免空的catch块
try {
    riskyOperation();
} catch (Exception e) {
    // 至少要记录日志
    logger.warn("操作失败，但可以继续", e);
}
```

### 2️⃣ 前端代码风格

#### JavaScript风格

```javascript
// 使用const和let，避免var
const API_BASE_URL = '/FileHostingSystemCY';
let currentUser = null;

// 函数声明
function uploadFile(file) {
    // 参数验证
    if (!file) {
        throw new Error('文件不能为空');
    }
    
    // 创建FormData
    const formData = new FormData();
    formData.append('file', file);
    
    // 发送请求
    return fetch(`${API_BASE_URL}/upload`, {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        return response.json();
    })
    .catch(error => {
        console.error('文件上传失败:', error);
        throw error;
    });
}

// 对象字面量
const fileConfig = {
    maxSize: 100 * 1024 * 1024, // 100MB
    allowedTypes: ['jpg', 'jpeg', 'png', 'gif', 'pdf'],
    
    validate(file) {
        if (file.size > this.maxSize) {
            return { valid: false, message: '文件大小超过限制' };
        }
        
        const extension = file.name.split('.').pop().toLowerCase();
        if (!this.allowedTypes.includes(extension)) {
            return { valid: false, message: '不支持的文件类型' };
        }
        
        return { valid: true };
    }
};
```

#### CSS风格

```css
/* 使用类选择器，避免ID选择器 */
.file-upload-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    border: 2px dashed #ddd;
    border-radius: 8px;
    text-align: center;
    transition: border-color 0.3s ease;
}

.file-upload-container:hover {
    border-color: #007bff;
}

/* 使用BEM命名规范 */
.upload-progress {
    width: 100%;
    height: 20px;
    background-color: #f0f0f0;
    border-radius: 10px;
    overflow: hidden;
}

.upload-progress__bar {
    height: 100%;
    background-color: #007bff;
    transition: width 0.3s ease;
}

.upload-progress__text {
    margin-top: 10px;
    font-size: 14px;
    color: #666;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .file-upload-container {
        margin: 10px;
        padding: 15px;
    }
}
```

---

## 🧪 测试指南

### 1️⃣ 单元测试

#### JUnit测试示例

```java
// UserDAOTest.java
public class UserDAOTest {
    
    private UserDAO userDAO;
    private Connection testConnection;
    
    @Before
    public void setUp() throws SQLException {
        // 使用测试数据库
        testConnection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/file_hosting_test",
            "test_user", "test_password"
        );
        userDAO = new UserDAO();
        
        // 清理测试数据
        cleanTestData();
    }
    
    @After
    public void tearDown() throws SQLException {
        cleanTestData();
        if (testConnection != null) {
            testConnection.close();
        }
    }
    
    @Test
    public void testAuthenticate_ValidUser_ReturnsUser() {
        // Arrange
        String username = "testuser";
        String password = "testpass";
        insertTestUser(username, password);
        
        // Act
        User result = userDAO.authenticate(username, password);
        
        // Assert
        assertNotNull("用户不应为空", result);
        assertEquals("用户名应匹配", username, result.getUsername());
        assertTrue("用户应为活跃状态", result.isActive());
    }
    
    @Test
    public void testAuthenticate_InvalidPassword_ReturnsNull() {
        // Arrange
        String username = "testuser";
        String correctPassword = "testpass";
        String wrongPassword = "wrongpass";
        insertTestUser(username, correctPassword);
        
        // Act
        User result = userDAO.authenticate(username, wrongPassword);
        
        // Assert
        assertNull("无效密码应返回null", result);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testAuthenticate_NullUsername_ThrowsException() {
        // Act & Assert
        userDAO.authenticate(null, "password");
    }
    
    private void insertTestUser(String username, String password) {
        // 插入测试用户的辅助方法
    }
    
    private void cleanTestData() {
        // 清理测试数据的辅助方法
    }
}
```

#### Mock测试

```java
// FileServiceTest.java
public class FileServiceTest {
    
    @Mock
    private MediaFileDAO mockMediaFileDAO;
    
    @Mock
    private AlistService mockAlistService;
    
    @InjectMocks
    private FileService fileService;
    
    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }
    
    @Test
    public void testUploadFile_Success_ReturnsTrue() {
        // Arrange
        User user = new User(1, "testuser");
        Part mockFilePart = mock(Part.class);
        when(mockFilePart.getSubmittedFileName()).thenReturn("test.jpg");
        when(mockFilePart.getSize()).thenReturn(1024L);
        
        when(mockAlistService.uploadFile(any(Part.class), anyString()))
            .thenReturn("/uploads/test.jpg");
        when(mockMediaFileDAO.insert(any(MediaFile.class)))
            .thenReturn(1);
        
        // Act
        boolean result = fileService.uploadFile(user, mockFilePart);
        
        // Assert
        assertTrue("文件上传应成功", result);
        verify(mockAlistService).uploadFile(mockFilePart, "test.jpg");
        verify(mockMediaFileDAO).insert(any(MediaFile.class));
    }
    
    @Test
    public void testUploadFile_AlistFails_ReturnsFalse() {
        // Arrange
        User user = new User(1, "testuser");
        Part mockFilePart = mock(Part.class);
        when(mockFilePart.getSubmittedFileName()).thenReturn("test.jpg");
        when(mockFilePart.getSize()).thenReturn(1024L);
        
        when(mockAlistService.uploadFile(any(Part.class), anyString()))
            .thenReturn(null); // 模拟Alist上传失败
        
        // Act
        boolean result = fileService.uploadFile(user, mockFilePart);
        
        // Assert
        assertFalse("Alist上传失败时应返回false", result);
        verify(mockAlistService).uploadFile(mockFilePart, "test.jpg");
        verify(mockMediaFileDAO, never()).insert(any(MediaFile.class));
    }
}
```

### 2️⃣ 集成测试

#### Servlet测试

```java
// UploadServletTest.java
public class UploadServletTest {
    
    private UploadServlet servlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    
    @Before
    public void setUp() {
        servlet = new UploadServlet();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
    }
    
    @Test
    public void testDoPost_ValidFile_ReturnsSuccess() throws Exception {
        // Arrange
        User testUser = new User(1, "testuser");
        MockHttpSession session = new MockHttpSession();
        session.setAttribute("user", testUser);
        request.setSession(session);
        
        // 模拟文件上传
        MockMultipartFile file = new MockMultipartFile(
            "file", "test.jpg", "image/jpeg", "test content".getBytes()
        );
        request.addFile(file);
        
        // Act
        servlet.doPost(request, response);
        
        // Assert
        assertEquals("应返回200状态码", 200, response.getStatus());
        assertEquals("应返回JSON格式", "application/json", response.getContentType());
        
        String responseContent = response.getContentAsString();
        assertTrue("响应应包含成功信息", responseContent.contains("success"));
    }
    
    @Test
    public void testDoPost_NotLoggedIn_ReturnsError() throws Exception {
        // Arrange
        // 不设置session中的用户信息
        
        // Act
        servlet.doPost(request, response);
        
        // Assert
        assertEquals("应返回401状态码", 401, response.getStatus());
        
        String responseContent = response.getContentAsString();
        assertTrue("响应应包含错误信息", responseContent.contains("用户未登录"));
    }
}
```

### 3️⃣ 前端测试

#### JavaScript单元测试

```javascript
// fileUtils.test.js
describe('FileUtils', () => {
    
    describe('validateFile', () => {
        
        it('should return valid for supported file types', () => {
            // Arrange
            const file = new File(['content'], 'test.jpg', { type: 'image/jpeg' });
            
            // Act
            const result = FileUtils.validateFile(file);
            
            // Assert
            expect(result.valid).toBe(true);
        });
        
        it('should return invalid for unsupported file types', () => {
            // Arrange
            const file = new File(['content'], 'test.exe', { type: 'application/exe' });
            
            // Act
            const result = FileUtils.validateFile(file);
            
            // Assert
            expect(result.valid).toBe(false);
            expect(result.message).toContain('不支持的文件类型');
        });
        
        it('should return invalid for files exceeding size limit', () => {
            // Arrange
            const largeContent = new Array(101 * 1024 * 1024).fill('a').join(''); // 101MB
            const file = new File([largeContent], 'large.jpg', { type: 'image/jpeg' });
            
            // Act
            const result = FileUtils.validateFile(file);
            
            // Assert
            expect(result.valid).toBe(false);
            expect(result.message).toContain('文件大小超过限制');
        });
    });
    
    describe('formatFileSize', () => {
        
        it('should format bytes correctly', () => {
            expect(FileUtils.formatFileSize(1024)).toBe('1.00 KB');
            expect(FileUtils.formatFileSize(1048576)).toBe('1.00 MB');
            expect(FileUtils.formatFileSize(1073741824)).toBe('1.00 GB');
        });
        
        it('should handle zero size', () => {
            expect(FileUtils.formatFileSize(0)).toBe('0 B');
        });
    });
});
```

---

## 🐛 调试技巧

### 1️⃣ 后端调试

#### 日志调试

```java
// 使用SLF4J进行日志记录
public class FileService {
    private static final Logger logger = LoggerFactory.getLogger(FileService.class);
    
    public boolean uploadFile(User user, Part filePart) {
        logger.debug("开始上传文件: user={}, filename={}", 
                    user.getUsername(), filePart.getSubmittedFileName());
        
        try {
            // 业务逻辑
            String result = processFile(filePart);
            logger.info("文件上传成功: filename={}, path={}", 
                       filePart.getSubmittedFileName(), result);
            return true;
            
        } catch (Exception e) {
            logger.error("文件上传失败: filename={}, error={}", 
                        filePart.getSubmittedFileName(), e.getMessage(), e);
            return false;
        }
    }
}
```

#### IDE调试

```java
// 在关键位置设置断点
public User authenticate(String username, String password) {
    // 断点1: 检查输入参数
    if (username == null || password == null) {
        return null;
    }
    
    try (Connection conn = DatabaseUtil.getConnection()) {
        // 断点2: 检查数据库连接
        String sql = "SELECT * FROM users WHERE username = ? AND password = MD5(?)"; 
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            // 断点3: 检查SQL执行
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // 断点4: 检查查询结果
                    User user = mapResultSetToUser(rs);
                    return user;
                }
            }
        }
    } catch (SQLException e) {
        // 断点5: 检查异常信息
        logger.error("数据库查询异常", e);
    }
    
    return null;
}
```

#### 数据库调试

```sql
-- 启用查询日志
SET GLOBAL general_log = 'ON';
SET GLOBAL general_log_file = '/var/log/mysql/query.log';

-- 查看慢查询
SELECT * FROM mysql.slow_log 
WHERE start_time > DATE_SUB(NOW(), INTERVAL 1 HOUR)
ORDER BY start_time DESC;

-- 分析查询执行计划
EXPLAIN SELECT * FROM media_files 
WHERE user_id = 1 
ORDER BY uploaded_at DESC 
LIMIT 20;

-- 查看表状态
SHOW TABLE STATUS LIKE 'media_files';

-- 查看索引使用情况
SHOW INDEX FROM media_files;
```

### 2️⃣ 前端调试

#### 浏览器开发者工具

```javascript
// 使用console进行调试
function uploadFile(file) {
    console.log('开始上传文件:', file.name, file.size);
    
    // 检查文件验证
    const validation = validateFile(file);
    console.log('文件验证结果:', validation);
    
    if (!validation.valid) {
        console.warn('文件验证失败:', validation.message);
        return Promise.reject(new Error(validation.message));
    }
    
    const formData = new FormData();
    formData.append('file', file);
    
    // 使用console.time测量性能
    console.time('文件上传耗时');
    
    return fetch('/FileHostingSystemCY/upload', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        console.timeEnd('文件上传耗时');
        console.log('上传响应:', response.status, response.statusText);
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}`);
        }
        
        return response.json();
    })
    .then(data => {
        console.log('上传成功:', data);
        return data;
    })
    .catch(error => {
        console.error('上传失败:', error);
        throw error;
    });
}

// 使用debugger语句
function processUploadResponse(response) {
    debugger; // 浏览器会在此处暂停
    
    if (response.success) {
        showSuccessMessage(response.message);
    } else {
        showErrorMessage(response.error);
    }
}
```

#### 网络请求调试

```javascript
// 拦截和记录所有fetch请求
const originalFetch = window.fetch;
window.fetch = function(...args) {
    console.log('Fetch请求:', args[0], args[1]);
    
    return originalFetch.apply(this, args)
        .then(response => {
            console.log('Fetch响应:', response.status, response.url);
            return response;
        })
        .catch(error => {
            console.error('Fetch错误:', error);
            throw error;
        });
};

// 监听AJAX错误
window.addEventListener('error', function(e) {
    console.error('全局错误:', e.error);
});

window.addEventListener('unhandledrejection', function(e) {
    console.error('未处理的Promise拒绝:', e.reason);
});
```

---

## 📚 版本控制

### 1️⃣ Git工作流

#### 分支策略

```bash
# 主要分支
main/master     # 生产环境代码
develop         # 开发环境代码

# 功能分支
feature/user-management     # 用户管理功能
feature/file-upload         # 文件上传功能
feature/alist-integration   # Alist集成功能

# 修复分支
hotfix/security-patch       # 安全补丁
hotfix/upload-bug          # 上传bug修复

# 发布分支
release/v1.0.0             # 版本发布
```

#### 提交规范

```bash
# 提交消息格式
<type>(<scope>): <subject>

<body>

<footer>

# 类型说明
feat:     新功能
fix:      bug修复
docs:     文档更新
style:    代码格式调整
refactor: 代码重构
test:     测试相关
chore:    构建过程或辅助工具的变动

# 示例
feat(upload): 添加文件上传进度显示

- 实现上传进度条组件
- 添加上传速度计算
- 支持上传取消功能

Closes #123

fix(auth): 修复登录状态检查bug

修复用户登录后session过期检查不准确的问题

Fixes #456

docs(api): 更新API文档

- 添加文件上传接口说明
- 更新错误码定义
- 补充使用示例
```

#### 常用Git命令

```bash
# 克隆项目
git clone https://github.com/username/FileHostingSystemCY.git
cd FileHostingSystemCY

# 创建功能分支
git checkout -b feature/new-feature develop

# 提交更改
git add .
git commit -m "feat(upload): 添加文件类型验证"

# 推送分支
git push origin feature/new-feature

# 合并到develop
git checkout develop
git merge feature/new-feature
git push origin develop

# 删除功能分支
git branch -d feature/new-feature
git push origin --delete feature/new-feature

# 创建发布分支
git checkout -b release/v1.0.0 develop

# 合并到main并打标签
git checkout main
git merge release/v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin main --tags

# 热修复
git checkout -b hotfix/critical-bug main
# 修复bug后
git checkout main
git merge hotfix/critical-bug
git checkout develop
git merge hotfix/critical-bug
```

### 2️⃣ 代码审查

#### Pull Request模板

```markdown
## 变更说明

### 变更类型
- [ ] 新功能
- [ ] Bug修复
- [ ] 文档更新
- [ ] 代码重构
- [ ] 性能优化
- [ ] 其他

### 变更描述
简要描述本次变更的内容和目的。

### 相关Issue
- Closes #123
- Fixes #456

### 测试说明
- [ ] 已添加单元测试
- [ ] 已添加集成测试
- [ ] 已进行手动测试
- [ ] 测试覆盖率 >= 80%

### 检查清单
- [ ] 代码符合项目规范
- [ ] 已添加必要的注释
- [ ] 已更新相关文档
- [ ] 无安全漏洞
- [ ] 性能无明显下降

### 截图/演示
如果有UI变更，请提供截图或演示视频。

### 部署说明
如果需要特殊的部署步骤，请在此说明。
```

#### 代码审查要点

```java
// 审查要点示例

// 1. 安全性检查
public void uploadFile(HttpServletRequest request) {
    // ❌ 直接使用用户输入，存在安全风险
    String filename = request.getParameter("filename");
    File file = new File("/uploads/" + filename);
    
    // ✅ 验证和清理用户输入
    String filename = sanitizeFilename(request.getParameter("filename"));
    if (!isValidFilename(filename)) {
        throw new IllegalArgumentException("无效的文件名");
    }
    File file = new File("/uploads/" + filename);
}

// 2. 资源管理检查
public List<User> getUsers() {
    // ❌ 没有正确关闭资源
    Connection conn = DatabaseUtil.getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users");
    ResultSet rs = stmt.executeQuery();
    return mapResultSet(rs);
    
    // ✅ 使用try-with-resources
    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users");
         ResultSet rs = stmt.executeQuery()) {
        return mapResultSet(rs);
    } catch (SQLException e) {
        logger.error("查询用户失败", e);
        throw new RuntimeException("数据库查询异常", e);
    }
}

// 3. 性能检查
public List<MediaFile> getFilesByUser(int userId) {
    // ❌ N+1查询问题
    List<MediaFile> files = mediaFileDAO.getByUserId(userId);
    for (MediaFile file : files) {
        User user = userDAO.getById(file.getUserId()); // 每次都查询数据库
        file.setUser(user);
    }
    return files;
    
    // ✅ 使用JOIN查询
    return mediaFileDAO.getByUserIdWithUser(userId);
}
```

---

## 🤝 贡献指南

### 1️⃣ 如何贡献

#### 报告问题

1. **搜索现有Issue**：确认问题是否已被报告
2. **创建新Issue**：使用Issue模板描述问题
3. **提供详细信息**：
   - 问题描述
   - 重现步骤
   - 期望行为
   - 实际行为
   - 环境信息（操作系统、浏览器、Java版本等）
   - 错误日志

#### 提交代码

1. **Fork项目**：在GitHub上fork项目到自己的账户
2. **创建分支**：基于develop分支创建功能分支
3. **编写代码**：遵循项目的代码规范
4. **添加测试**：为新功能添加相应的测试
5. **提交变更**：使用规范的提交消息
6. **创建PR**：向原项目提交Pull Request

#### 代码贡献流程

```bash
# 1. Fork并克隆项目
git clone https://github.com/your-username/FileHostingSystemCY.git
cd FileHostingSystemCY

# 2. 添加上游仓库
git remote add upstream https://github.com/original-owner/FileHostingSystemCY.git

# 3. 创建功能分支
git checkout -b feature/your-feature-name develop

# 4. 进行开发
# ... 编写代码 ...

# 5. 运行测试
mvn test  # 或者 gradle test

# 6. 提交变更
git add .
git commit -m "feat(scope): 添加新功能描述"

# 7. 同步上游更改
git fetch upstream
git rebase upstream/develop

# 8. 推送分支
git push origin feature/your-feature-name

# 9. 创建Pull Request
# 在GitHub上创建PR
```

### 2️⃣ 开发环境设置

#### 首次设置

```bash
# 1. 克隆项目
git clone https://github.com/your-username/FileHostingSystemCY.git
cd FileHostingSystemCY

# 2. 安装依赖
# 如果使用Maven
mvn clean install

# 如果使用Gradle
./gradlew build

# 3. 配置数据库
mysql -u root -p < database/init.sql

# 4. 配置Alist
# 按照部署指南安装和配置Alist

# 5. 启动开发服务器
# 在IDE中配置Tomcat并启动
# 或者使用命令行
catalina.sh run
```

#### 开发工具配置

**IntelliJ IDEA配置文件**：

```xml
<!-- .idea/codeStyles/Project.xml -->
<component name="ProjectCodeStyleConfiguration">
  <code_scheme name="Project" version="173">
    <option name="RIGHT_MARGIN" value="120" />
    <JavaCodeStyleSettings>
      <option name="IMPORT_LAYOUT_TABLE">
        <value>
          <package name="java" withSubpackages="true" static="false" />
          <package name="javax" withSubpackages="true" static="false" />
          <emptyLine />
          <package name="" withSubpackages="true" static="false" />
        </value>
      </option>
    </JavaCodeStyleSettings>
    <codeStyleSettings language="JAVA">
      <option name="KEEP_LINE_BREAKS" value="false" />
      <option name="KEEP_FIRST_COLUMN_COMMENT" value="false" />
      <option name="BRACE_STYLE" value="END_OF_LINE" />
      <option name="CLASS_BRACE_STYLE" value="END_OF_LINE" />
      <option name="METHOD_BRACE_STYLE" value="END_OF_LINE" />
      <indentOptions>
        <option name="INDENT_SIZE" value="4" />
        <option name="TAB_SIZE" value="4" />
        <option name="USE_TAB_CHARACTER" value="false" />
      </indentOptions>
    </codeStyleSettings>
  </code_scheme>
</component>
```

**Eclipse配置文件**：

```xml
<!-- .settings/org.eclipse.jdt.core.prefs -->
eclipse.preferences.version=1
org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.8
org.eclipse.jdt.core.compiler.compliance=1.8
org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
org.eclipse.jdt.core.compiler.source=1.8
org.eclipse.jdt.core.formatter.tabulation.char=space
org.eclipse.jdt.core.formatter.tabulation.size=4
```

### 3️⃣ 社区准则

#### 行为准则

我们致力于为所有人提供友好、安全和欢迎的环境，无论性别、性取向、能力、种族、社会经济地位和宗教信仰如何。

**我们期望的行为**：

- 使用友好和包容的语言
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 关注对社区最有利的事情
- 对其他社区成员表示同理心

**不可接受的行为**：

- 使用性化的语言或图像
- 人身攻击或政治攻击
- 公开或私下骚扰
- 未经明确许可发布他人的私人信息
- 其他在专业环境中可能被认为不当的行为

#### 沟通指南

**Issue讨论**：

- 保持讨论专注于技术问题
- 提供具体的重现步骤和环境信息
- 使用清晰的标题和描述
- 及时回复相关问题

**代码审查**：

- 专注于代码而非个人
- 提供建设性的反馈
- 解释为什么需要更改
- 认可好的代码和改进

**文档贡献**：

- 使用清晰、简洁的语言
- 提供实际的示例
- 保持文档的时效性
- 考虑不同技能水平的读者

---

## ❓ 常见问题

### 1️⃣ 开发环境问题

**Q: Tomcat启动失败，提示端口被占用**

A: 检查端口占用情况并释放端口：

```bash
# Windows
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# macOS/Linux
lsof -i :8080
kill -9 <PID>

# 或者修改Tomcat端口
# 编辑 $CATALINA_HOME/conf/server.xml
<Connector port="8081" protocol="HTTP/1.1" />
```

**Q: 数据库连接失败**

A: 检查数据库配置和连接：

```bash
# 检查MySQL服务状态
# Windows
net start mysql

# macOS
brew services start mysql

# Linux
sudo systemctl start mysql

# 测试连接
mysql -u filehost -p -h localhost file_hosting_system
```

**Q: 编译错误，找不到依赖包**

A: 检查依赖库配置：

```bash
# 检查lib目录下的JAR包
ls -la lib/

# 在IDE中刷新项目依赖
# IntelliJ IDEA: File -> Reload Gradle Project
# Eclipse: 右键项目 -> Refresh
```

### 2️⃣ 运行时问题

**Q: 文件上传失败，返回500错误**

A: 检查以下几个方面：

1. **检查Alist服务状态**：
   ```bash
   curl http://localhost:5244/ping
   ```

2. **检查上传目录权限**：
   ```bash
   ls -la /path/to/upload/directory
   chmod 755 /path/to/upload/directory
   ```

3. **查看应用日志**：
   ```bash
   tail -f $CATALINA_HOME/logs/catalina.out
   tail -f $CATALINA_HOME/logs/localhost.log
   ```

**Q: 用户登录后立即退出**

A: 检查Session配置：

```xml
<!-- web.xml -->
<session-config>
    <session-timeout>30</session-timeout> <!-- 30分钟 -->
    <cookie-config>
        <http-only>true</http-only>
        <secure>false</secure> <!-- 开发环境设为false -->
    </cookie-config>
</session-config>
```

**Q: 前端AJAX请求跨域错误**

A: 配置CORS过滤器：

```java
@WebFilter("/*")
public class CorsFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, 
                        FilterChain chain) throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        httpResponse.setHeader("Access-Control-Allow-Origin", "*");
        httpResponse.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        httpResponse.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        chain.doFilter(request, response);
    }
}
```

### 3️⃣ 性能问题

**Q: 文件列表加载缓慢**

A: 优化数据库查询：

```sql
-- 添加索引
CREATE INDEX idx_media_files_user_uploaded ON media_files(user_id, uploaded_at DESC);

-- 使用分页查询
SELECT * FROM media_files 
WHERE user_id = ? 
ORDER BY uploaded_at DESC 
LIMIT ? OFFSET ?;
```

**Q: 大文件上传超时**

A: 调整超时配置：

```xml
<!-- web.xml -->
<multipart-config>
    <max-file-size>104857600</max-file-size> <!-- 100MB -->
    <max-request-size>104857600</max-request-size>
    <file-size-threshold>1048576</file-size-threshold> <!-- 1MB -->
</multipart-config>
```

```xml
<!-- server.xml -->
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="300000"
           maxPostSize="104857600" />
```

### 4️⃣ 部署问题

**Q: WAR包部署后无法访问**

A: 检查部署配置：

```bash
# 检查WAR包是否正确解压
ls -la $CATALINA_HOME/webapps/FileHostingSystemCY/

# 检查应用上下文
cat $CATALINA_HOME/conf/Catalina/localhost/FileHostingSystemCY.xml

# 检查日志
tail -f $CATALINA_HOME/logs/catalina.out
```

**Q: 生产环境数据库连接池耗尽**

A: 优化连接池配置：

```properties
# db.properties
db.pool.initialSize=5
db.pool.maxActive=20
db.pool.maxIdle=10
db.pool.minIdle=5
db.pool.maxWait=10000
db.pool.testOnBorrow=true
db.pool.testWhileIdle=true
db.pool.validationQuery=SELECT 1
```

---

## 📖 相关资源

### 📚 学习资源

- [Java Servlet 官方文档](https://docs.oracle.com/javaee/7/tutorial/servlets.htm)
- [MySQL 官方文档](https://dev.mysql.com/doc/)
- [Alist 官方文档](https://alist.nn.ci/)
- [Bootstrap 官方文档](https://getbootstrap.com/docs/)
- [jQuery 官方文档](https://api.jquery.com/)

### 🛠️ 开发工具

- [IntelliJ IDEA](https://www.jetbrains.com/idea/)
- [Eclipse IDE](https://www.eclipse.org/ide/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [MySQL Workbench](https://www.mysql.com/products/workbench/)
- [Postman](https://www.postman.com/)

### 📋 Wiki页面导航

- [🏠 项目首页](Wiki-Home.md)
- [📁 项目结构](Wiki-Project-Structure.md)
- [🏗️ 系统架构](Wiki-System-Architecture.md)
- [📡 API文档](Wiki-API-Documentation.md)
- [🚀 部署指南](Wiki-Deployment-Guide.md)
- [💻 开发指南](Wiki-Development-Guide.md)

---

**最后更新**: 2024年1月

**维护者**: FileHostingSystem开发团队

如有问题或建议，请在GitHub上创建Issue或联系开发团队。