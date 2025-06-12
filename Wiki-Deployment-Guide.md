# 🚀 部署指南

本页面详细介绍基于Alist的文件托管系统的部署步骤、环境配置和运维管理。

## 📋 目录

- [部署概述](#部署概述)
- [环境要求](#环境要求)
- [环境准备](#环境准备)
- [数据库配置](#数据库配置)
- [Alist服务配置](#alist服务配置)
- [应用部署](#应用部署)
- [配置文件](#配置文件)
- [启动与验证](#启动与验证)
- [运维管理](#运维管理)
- [故障排除](#故障排除)
- [性能优化](#性能优化)

---

## 🌐 部署概述

### 部署架构

```
┌─────────────────────────────────────────────────────────────┐
│                    🌐 负载均衡层 (可选)                        │
├─────────────────────────────────────────────────────────────┤
│  Nginx/Apache  │  SSL证书  │  域名解析  │  CDN加速  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ HTTP/HTTPS
┌─────────────────────────────────────────────────────────────┐
│                    🎮 应用服务层                              │
├─────────────────────────────────────────────────────────────┤
│  Tomcat 9.0+  │  JVM 1.8+  │  Web应用  │  Session管理  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ JDBC
┌─────────────────────────────────────────────────────────────┐
│                    🗄️ 数据存储层                              │
├─────────────────────────────────────────────────────────────┤
│  MySQL 8.0+  │  连接池  │  数据备份  │  主从复制  │
└─────────────────────────────────────────────────────────────┘
                                ↕️ HTTP API
┌─────────────────────────────────────────────────────────────┐
│                    ☁️ 文件存储层                              │
├─────────────────────────────────────────────────────────────┤
│  Alist服务  │  云存储  │  本地存储  │  文件管理  │
└─────────────────────────────────────────────────────────────┘
```

### 部署模式

| 模式 | 适用场景 | 特点 |
|------|----------|------|
| **单机部署** | 开发测试、小型应用 | 简单快速，资源占用少 |
| **分布式部署** | 生产环境、大型应用 | 高可用，可扩展，性能好 |
| **容器化部署** | 云原生环境 | 易管理，可移植，自动化 |
| **集群部署** | 高并发场景 | 负载均衡，故障转移 |

---

## 💻 环境要求

### 硬件要求

#### 最小配置

| 组件 | 要求 |
|------|------|
| **CPU** | 2核心 2.0GHz |
| **内存** | 4GB RAM |
| **存储** | 50GB 可用空间 |
| **网络** | 100Mbps 带宽 |

#### 推荐配置

| 组件 | 要求 |
|------|------|
| **CPU** | 4核心 2.5GHz+ |
| **内存** | 8GB+ RAM |
| **存储** | 200GB+ SSD |
| **网络** | 1Gbps 带宽 |

#### 生产环境配置

| 组件 | 要求 |
|------|------|
| **CPU** | 8核心 3.0GHz+ |
| **内存** | 16GB+ RAM |
| **存储** | 500GB+ NVMe SSD |
| **网络** | 10Gbps 带宽 |

### 软件要求

#### 操作系统

| 系统 | 版本 | 说明 |
|------|------|------|
| **Ubuntu** | 18.04+ | 推荐LTS版本 |
| **CentOS** | 7.0+ | 稳定可靠 |
| **Windows Server** | 2016+ | 企业环境 |
| **Docker** | 20.0+ | 容器化部署 |

#### 运行环境

| 软件 | 版本 | 必需 | 说明 |
|------|------|------|------|
| **Java JDK** | 1.8+ | ✅ | 应用运行环境 |
| **Apache Tomcat** | 9.0+ | ✅ | Web服务器 |
| **MySQL** | 8.0+ | ✅ | 数据库服务 |
| **Alist** | 3.25+ | ✅ | 文件管理服务 |
| **Nginx** | 1.18+ | ❌ | 反向代理（可选） |

---

## 🛠️ 环境准备

### 1️⃣ Java环境安装

#### Ubuntu/Debian

```bash
# 更新包管理器
sudo apt update

# 安装OpenJDK 8
sudo apt install openjdk-8-jdk

# 验证安装
java -version
javac -version

# 配置JAVA_HOME
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
source ~/.bashrc
```

#### CentOS/RHEL

```bash
# 安装OpenJDK 8
sudo yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel

# 验证安装
java -version
javac -version

# 配置JAVA_HOME
echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
source ~/.bashrc
```

#### Windows

```powershell
# 下载并安装Oracle JDK 8或OpenJDK 8
# 从官网下载：https://www.oracle.com/java/technologies/javase-jdk8-downloads.html

# 配置环境变量
# JAVA_HOME: C:\Program Files\Java\jdk1.8.0_XXX
# PATH: %JAVA_HOME%\bin

# 验证安装
java -version
javac -version
```

### 2️⃣ Tomcat安装配置

#### Linux安装

```bash
# 下载Tomcat 9
cd /opt
sudo wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz

# 解压
sudo tar -xzf apache-tomcat-9.0.75.tar.gz
sudo mv apache-tomcat-9.0.75 tomcat9

# 创建tomcat用户
sudo useradd -r -m -U -d /opt/tomcat9 -s /bin/false tomcat

# 设置权限
sudo chown -R tomcat:tomcat /opt/tomcat9
sudo chmod +x /opt/tomcat9/bin/*.sh

# 配置环境变量
sudo vim /opt/tomcat9/bin/setenv.sh
```

**setenv.sh配置内容**：

```bash
#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export CATALINA_HOME=/opt/tomcat9
export CATALINA_BASE=/opt/tomcat9
export CATALINA_OPTS="-Xms512m -Xmx2048m -XX:PermSize=256m -XX:MaxPermSize=512m"
export JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server"
```

#### 创建系统服务

```bash
# 创建systemd服务文件
sudo vim /etc/systemd/system/tomcat.service
```

**tomcat.service内容**：

```ini
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat9/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat9
Environment=CATALINA_BASE=/opt/tomcat9
Environment="CATALINA_OPTS=-Xms512M -Xmx2048M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat9/bin/startup.sh
ExecStop=/opt/tomcat9/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

```bash
# 启用并启动服务
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo systemctl status tomcat
```

---

## 🗄️ 数据库配置

### 1️⃣ MySQL安装

#### Ubuntu/Debian

```bash
# 更新包管理器
sudo apt update

# 安装MySQL Server
sudo apt install mysql-server

# 安全配置
sudo mysql_secure_installation

# 启动MySQL服务
sudo systemctl start mysql
sudo systemctl enable mysql
```

#### CentOS/RHEL

```bash
# 添加MySQL官方仓库
sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm

# 安装MySQL Server
sudo yum install mysql-community-server

# 启动MySQL服务
sudo systemctl start mysqld
sudo systemctl enable mysqld

# 获取临时密码
sudo grep 'temporary password' /var/log/mysqld.log

# 安全配置
sudo mysql_secure_installation
```

### 2️⃣ 数据库初始化

#### 创建数据库和用户

```sql
-- 登录MySQL
mysql -u root -p

-- 创建数据库
CREATE DATABASE file_hosting_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建用户
CREATE USER 'filehost'@'localhost' IDENTIFIED BY 'StrongPassword123!';
CREATE USER 'filehost'@'%' IDENTIFIED BY 'StrongPassword123!';

-- 授权
GRANT ALL PRIVILEGES ON file_hosting_system.* TO 'filehost'@'localhost';
GRANT ALL PRIVILEGES ON file_hosting_system.* TO 'filehost'@'%';

-- 刷新权限
FLUSH PRIVILEGES;

-- 退出
EXIT;
```

#### 导入数据库结构

```bash
# 使用项目提供的SQL文件初始化数据库
mysql -u filehost -p file_hosting_system < database/init.sql

# 或者手动创建表结构
mysql -u filehost -p file_hosting_system
```

**数据库表结构**：

```sql
-- 用户表
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    is_admin TINYINT(1) DEFAULT 0,
    is_editor TINYINT(1) DEFAULT 0,
    is_regular TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 媒体文件表
CREATE TABLE media_files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    file_size BIGINT NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    mime_type VARCHAR(100),
    file_path VARCHAR(500) NOT NULL,
    download_url VARCHAR(500),
    thumbnail_url VARCHAR(500),
    description TEXT,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_filename (filename),
    INDEX idx_file_type (file_type),
    INDEX idx_uploaded_at (uploaded_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 系统日志表
CREATE TABLE system_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100) NOT NULL,
    details TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 插入默认管理员用户
INSERT INTO users (username, password, email, is_admin, is_editor, is_regular) 
VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@example.com', 1, 1, 1);
-- 密码是 123456 的MD5值
```

### 3️⃣ 数据库优化配置

#### MySQL配置文件优化

```bash
# 编辑MySQL配置文件
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
# 或者
sudo vim /etc/my.cnf
```

**优化配置内容**：

```ini
[mysqld]
# 基本设置
port = 3306
socket = /var/run/mysqld/mysqld.sock
basedir = /usr
datadir = /var/lib/mysql
tmpdir = /tmp
lc-messages-dir = /usr/share/mysql

# 字符集设置
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
init_connect = 'SET NAMES utf8mb4'

# 连接设置
max_connections = 200
max_connect_errors = 10000
connect_timeout = 60
wait_timeout = 28800
interactive_timeout = 28800

# 缓存设置
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
innodb_log_buffer_size = 16M
innodb_flush_log_at_trx_commit = 2

# 查询缓存
query_cache_type = 1
query_cache_size = 128M
query_cache_limit = 2M

# 临时表设置
tmp_table_size = 64M
max_heap_table_size = 64M

# 日志设置
log_error = /var/log/mysql/error.log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2

# 二进制日志
log_bin = /var/log/mysql/mysql-bin.log
binlog_format = ROW
expire_logs_days = 7
max_binlog_size = 100M

[mysql]
default-character-set = utf8mb4

[client]
default-character-set = utf8mb4
```

```bash
# 重启MySQL服务
sudo systemctl restart mysql
```

---

## ☁️ Alist服务配置

### 1️⃣ Alist安装

#### 使用一键脚本安装

```bash
# 下载并运行安装脚本
curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s install

# 或者使用国内镜像
curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s install --mirror
```

#### 手动安装

```bash
# 创建alist目录
sudo mkdir -p /opt/alist
cd /opt/alist

# 下载最新版本
sudo wget https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz

# 解压
sudo tar -zxvf alist-linux-amd64.tar.gz

# 设置权限
sudo chmod +x alist

# 创建alist用户
sudo useradd -r -s /bin/false alist
sudo chown -R alist:alist /opt/alist
```

### 2️⃣ Alist配置

#### 初始化配置

```bash
# 切换到alist目录
cd /opt/alist

# 生成配置文件
sudo -u alist ./alist admin

# 启动alist（首次运行）
sudo -u alist ./alist server
```

#### 创建系统服务

```bash
# 创建systemd服务文件
sudo vim /etc/systemd/system/alist.service
```

**alist.service内容**：

```ini
[Unit]
Description=Alist service
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/alist
ExecStart=/opt/alist/alist server
Restart=on-failure
User=alist
Group=alist

[Install]
WantedBy=multi-user.target
```

```bash
# 启用并启动服务
sudo systemctl daemon-reload
sudo systemctl enable alist
sudo systemctl start alist
sudo systemctl status alist
```

### 3️⃣ Alist Web配置

#### 访问管理界面

1. 打开浏览器访问：`http://your-server-ip:5244`
2. 使用生成的管理员账号登录
3. 进入管理界面进行配置

#### 添加存储

**本地存储配置**：

```json
{
    "mount_path": "/files",
    "driver": "Local",
    "root_folder": "/opt/alist/data/files",
    "order": 0,
    "remark": "本地文件存储"
}
```

**阿里云盘配置**：

```json
{
    "mount_path": "/aliyun",
    "driver": "AliyundriveOpen",
    "refresh_token": "your_refresh_token",
    "order": 1,
    "remark": "阿里云盘存储"
}
```

**腾讯云COS配置**：

```json
{
    "mount_path": "/cos",
    "driver": "TencentCOS",
    "bucket": "your-bucket-name",
    "region": "ap-beijing",
    "secret_id": "your_secret_id",
    "secret_key": "your_secret_key",
    "order": 2,
    "remark": "腾讯云COS存储"
}
```

#### API配置

在Alist管理界面中配置API访问：

1. 进入 **设置** → **其他**
2. 启用 **API签名**
3. 设置 **Token过期时间**
4. 记录 **API地址** 和 **Token**

---

## 🚀 应用部署

### 1️⃣ 项目构建

#### 编译项目

```bash
# 进入项目目录
cd /path/to/FileHostingSystemCY

# 如果使用Maven
mvn clean package

# 如果使用Gradle
./gradlew build

# 手动编译（如果没有构建工具）
javac -cp "lib/*" -d build/classes src/**/*.java
jar -cvf FileHostingSystemCY.war -C build/classes . -C src/main/webapp .
```

#### 准备WAR文件

```bash
# 复制WAR文件到Tomcat webapps目录
sudo cp target/FileHostingSystemCY.war /opt/tomcat9/webapps/

# 或者创建软链接
sudo ln -s /path/to/project/target/FileHostingSystemCY.war /opt/tomcat9/webapps/

# 设置权限
sudo chown tomcat:tomcat /opt/tomcat9/webapps/FileHostingSystemCY.war
```

### 2️⃣ 配置文件部署

#### 数据库配置

```bash
# 创建配置目录
sudo mkdir -p /opt/tomcat9/conf/filehosting

# 复制配置文件
sudo cp src/main/resources/db.properties /opt/tomcat9/conf/filehosting/

# 编辑数据库配置
sudo vim /opt/tomcat9/conf/filehosting/db.properties
```

**db.properties配置**：

```properties
# 数据库连接配置
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/file_hosting_system?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
db.username=filehost
db.password=StrongPassword123!

# 连接池配置
c3p0.initialPoolSize=5
c3p0.maxPoolSize=20
c3p0.minPoolSize=3
c3p0.acquireIncrement=2
c3p0.maxIdleTime=1800
c3p0.checkoutTimeout=3000
c3p0.testConnectionOnCheckout=true
c3p0.testConnectionOnCheckin=true
c3p0.idleConnectionTestPeriod=300
c3p0.preferredTestQuery=SELECT 1
```

#### Alist配置

```bash
# 复制Alist配置文件
sudo cp src/main/resources/alist.properties /opt/tomcat9/conf/filehosting/

# 编辑Alist配置
sudo vim /opt/tomcat9/conf/filehosting/alist.properties
```

**alist.properties配置**：

```properties
# Alist服务配置
alist.url=http://localhost:5244
alist.username=admin
alist.password=your_admin_password
alist.upload.path=/files
alist.api.timeout=30000

# 文件上传配置
upload.max.size=104857600
# 100MB = 100 * 1024 * 1024
upload.allowed.types=jpg,jpeg,png,gif,bmp,pdf,doc,docx,xls,xlsx,ppt,pptx,txt,mp4,avi,mov,mp3,wav,flac
upload.temp.dir=/tmp/filehosting

# 安全配置
security.session.timeout=3600
security.max.login.attempts=5
security.lockout.duration=1800
```

### 3️⃣ 依赖库部署

#### 复制JAR依赖

```bash
# 复制项目依赖到Tomcat lib目录
sudo cp lib/*.jar /opt/tomcat9/lib/

# 或者复制到应用的WEB-INF/lib目录
sudo cp lib/*.jar /opt/tomcat9/webapps/FileHostingSystemCY/WEB-INF/lib/

# 设置权限
sudo chown tomcat:tomcat /opt/tomcat9/lib/*.jar
```

#### 必需的JAR文件

```
lib/
├── mysql-connector-java-8.0.33.jar     # MySQL驱动
├── c3p0-0.9.5.5.jar                    # 连接池
├── mchange-commons-java-0.2.19.jar     # C3P0依赖
├── jackson-core-2.15.2.jar             # JSON处理
├── jackson-databind-2.15.2.jar         # JSON数据绑定
├── jackson-annotations-2.15.2.jar      # JSON注解
├── okhttp-4.10.0.jar                   # HTTP客户端
├── okio-3.0.0.jar                      # OkHttp依赖
├── commons-fileupload-1.4.jar          # 文件上传
├── commons-io-2.11.0.jar               # IO工具
├── jstl-1.2.jar                        # JSTL标签库
└── standard-1.1.2.jar                  # JSTL实现
```

---

## ⚙️ 配置文件

### 1️⃣ Tomcat配置优化

#### server.xml配置

```bash
# 编辑Tomcat主配置文件
sudo vim /opt/tomcat9/conf/server.xml
```

**关键配置项**：

```xml
<!-- 连接器配置 -->
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           maxThreads="200"
           minSpareThreads="10"
           maxSpareThreads="50"
           acceptCount="100"
           compression="on"
           compressionMinSize="2048"
           compressableMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json"
           URIEncoding="UTF-8" />

<!-- 虚拟主机配置 -->
<Host name="localhost" appBase="webapps"
      unpackWARs="true" autoDeploy="true">
      
    <!-- 应用上下文配置 -->
    <Context path="/FileHostingSystemCY" 
             docBase="FileHostingSystemCY"
             reloadable="false"
             crossContext="true">
             
        <!-- 资源配置 -->
        <Resource name="jdbc/FileHostingDB"
                  auth="Container"
                  type="javax.sql.DataSource"
                  driverClassName="com.mysql.cj.jdbc.Driver"
                  url="jdbc:mysql://localhost:3306/file_hosting_system?useUnicode=true&amp;characterEncoding=utf8&amp;useSSL=false&amp;serverTimezone=Asia/Shanghai"
                  username="filehost"
                  password="StrongPassword123!"
                  maxTotal="20"
                  maxIdle="10"
                  maxWaitMillis="10000" />
    </Context>
</Host>
```

#### web.xml配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
         http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">

    <display-name>File Hosting System</display-name>
    <description>基于Alist的文件托管系统</description>

    <!-- 字符编码过滤器 -->
    <filter>
        <filter-name>CharacterEncodingFilter</filter-name>
        <filter-class>com.filehosting.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>CharacterEncodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <!-- 登录验证过滤器 -->
    <filter>
        <filter-name>LoginFilter</filter-name>
        <filter-class>com.filehosting.filter.LoginFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>LoginFilter</filter-name>
        <url-pattern>/dashboard.jsp</url-pattern>
        <url-pattern>/upload.jsp</url-pattern>
        <url-pattern>/files.jsp</url-pattern>
        <url-pattern>/profile.jsp</url-pattern>
        <url-pattern>/upload</url-pattern>
        <url-pattern>/files</url-pattern>
        <url-pattern>/media</url-pattern>
        <url-pattern>/storage/stats</url-pattern>
    </filter-mapping>

    <!-- Servlet配置 -->
    <servlet>
        <servlet-name>LoginServlet</servlet-name>
        <servlet-class>com.filehosting.servlet.LoginServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>LoginServlet</servlet-name>
        <url-pattern>/login</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>UploadServlet</servlet-name>
        <servlet-class>com.filehosting.servlet.UploadServlet</servlet-class>
        <multipart-config>
            <max-file-size>104857600</max-file-size>      <!-- 100MB -->
            <max-request-size>104857600</max-request-size> <!-- 100MB -->
            <file-size-threshold>1048576</file-size-threshold> <!-- 1MB -->
        </multipart-config>
    </servlet>
    <servlet-mapping>
        <servlet-name>UploadServlet</servlet-name>
        <url-pattern>/upload</url-pattern>
    </servlet-mapping>

    <!-- 会话配置 -->
    <session-config>
        <session-timeout>60</session-timeout> <!-- 60分钟 -->
        <cookie-config>
            <http-only>true</http-only>
            <secure>false</secure> <!-- 生产环境设置为true -->
        </cookie-config>
    </session-config>

    <!-- 错误页面配置 -->
    <error-page>
        <error-code>404</error-code>
        <location>/error/404.jsp</location>
    </error-page>
    <error-page>
        <error-code>500</error-code>
        <location>/error/500.jsp</location>
    </error-page>

    <!-- 欢迎页面 -->
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

### 2️⃣ 日志配置

#### logback.xml配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    
    <!-- 控制台输出 -->
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <!-- 文件输出 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/opt/tomcat9/logs/filehosting.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>/opt/tomcat9/logs/filehosting.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
            <totalSizeCap>1GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <!-- 错误日志 -->
    <appender name="ERROR_FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/opt/tomcat9/logs/filehosting-error.log</file>
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>ERROR</level>
            <onMatch>ACCEPT</onMatch>
            <onMismatch>DENY</onMismatch>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>/opt/tomcat9/logs/filehosting-error.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <!-- 根日志级别 -->
    <root level="INFO">
        <appender-ref ref="CONSOLE" />
        <appender-ref ref="FILE" />
        <appender-ref ref="ERROR_FILE" />
    </root>
    
    <!-- 特定包的日志级别 -->
    <logger name="com.filehosting" level="DEBUG" />
    <logger name="org.springframework" level="WARN" />
    <logger name="com.mchange.v2.c3p0" level="WARN" />
    
</configuration>
```

---

## 🚀 启动与验证

### 1️⃣ 服务启动顺序

```bash
# 1. 启动MySQL
sudo systemctl start mysql
sudo systemctl status mysql

# 2. 启动Alist
sudo systemctl start alist
sudo systemctl status alist

# 3. 启动Tomcat
sudo systemctl start tomcat
sudo systemctl status tomcat

# 检查端口占用
sudo netstat -tlnp | grep -E ':(3306|5244|8080)'
```

### 2️⃣ 应用验证

#### 基本功能测试

```bash
# 1. 检查应用是否部署成功
curl -I http://localhost:8080/FileHostingSystemCY/

# 2. 测试登录接口
curl -X POST http://localhost:8080/FileHostingSystemCY/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"123456"}'

# 3. 测试Alist连接
curl http://localhost:5244/api/public/settings

# 4. 检查数据库连接
mysql -u filehost -p file_hosting_system -e "SELECT COUNT(*) FROM users;"
```

#### Web界面测试

1. **访问首页**：`http://your-server-ip:8080/FileHostingSystemCY/`
2. **登录测试**：使用默认账号 `admin/123456`
3. **文件上传测试**：上传一个小文件验证功能
4. **文件列表测试**：查看文件列表是否正常显示
5. **存储统计测试**：查看统计信息是否正确

### 3️⃣ 性能测试

#### 压力测试

```bash
# 使用Apache Bench进行压力测试
# 安装ab工具
sudo apt install apache2-utils  # Ubuntu/Debian
sudo yum install httpd-tools     # CentOS/RHEL

# 测试首页响应
ab -n 1000 -c 10 http://localhost:8080/FileHostingSystemCY/

# 测试登录接口
ab -n 100 -c 5 -p login.json -T application/json http://localhost:8080/FileHostingSystemCY/login

# login.json内容
echo '{"username":"admin","password":"123456"}' > login.json
```

#### 监控指标

```bash
# 监控系统资源
top -p $(pgrep java)
free -h
df -h
iostat 1 5

# 监控Tomcat JVM
jstat -gc $(pgrep java) 1s 10
jmap -histo $(pgrep java) | head -20

# 监控数据库
mysql -u root -p -e "SHOW PROCESSLIST;"
mysql -u root -p -e "SHOW STATUS LIKE 'Threads%';"
```

---

## 🔧 运维管理

### 1️⃣ 日常维护

#### 日志管理

```bash
# 查看应用日志
tail -f /opt/tomcat9/logs/catalina.out
tail -f /opt/tomcat9/logs/filehosting.log

# 查看错误日志
tail -f /opt/tomcat9/logs/filehosting-error.log

# 日志轮转配置
sudo vim /etc/logrotate.d/filehosting
```

**logrotate配置**：

```
/opt/tomcat9/logs/*.log {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    notifempty
    copytruncate
    create 644 tomcat tomcat
}
```

#### 数据备份

```bash
# 创建备份脚本
sudo vim /opt/scripts/backup.sh
```

**backup.sh内容**：

```bash
#!/bin/bash

# 配置变量
BACKUP_DIR="/opt/backups"
DATE=$(date +%Y%m%d_%H%M%S)
DB_NAME="file_hosting_system"
DB_USER="filehost"
DB_PASS="StrongPassword123!"

# 创建备份目录
mkdir -p $BACKUP_DIR

# 数据库备份
mysqldump -u$DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/db_backup_$DATE.sql

# 压缩备份文件
gzip $BACKUP_DIR/db_backup_$DATE.sql

# 应用文件备份
tar -czf $BACKUP_DIR/app_backup_$DATE.tar.gz /opt/tomcat9/webapps/FileHostingSystemCY

# 配置文件备份
tar -czf $BACKUP_DIR/config_backup_$DATE.tar.gz /opt/tomcat9/conf/filehosting

# 删除30天前的备份
find $BACKUP_DIR -name "*backup*" -mtime +30 -delete

echo "Backup completed: $DATE"
```

```bash
# 设置执行权限
sudo chmod +x /opt/scripts/backup.sh

# 添加到定时任务
sudo crontab -e
# 添加以下行（每天凌晨2点备份）
0 2 * * * /opt/scripts/backup.sh >> /var/log/backup.log 2>&1
```

#### 监控脚本

```bash
# 创建监控脚本
sudo vim /opt/scripts/monitor.sh
```

**monitor.sh内容**：

```bash
#!/bin/bash

# 检查服务状态
check_service() {
    local service=$1
    if systemctl is-active --quiet $service; then
        echo "✅ $service is running"
    else
        echo "❌ $service is not running"
        systemctl restart $service
        echo "🔄 Restarted $service"
    fi
}

# 检查端口
check_port() {
    local port=$1
    local service=$2
    if netstat -tlnp | grep -q ":$port "; then
        echo "✅ Port $port ($service) is open"
    else
        echo "❌ Port $port ($service) is not accessible"
    fi
}

# 检查磁盘空间
check_disk() {
    local usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ $usage -gt 80 ]; then
        echo "⚠️ Disk usage is ${usage}% - Consider cleanup"
    else
        echo "✅ Disk usage is ${usage}% - OK"
    fi
}

# 检查内存使用
check_memory() {
    local usage=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}')
    if [ $usage -gt 80 ]; then
        echo "⚠️ Memory usage is ${usage}% - High"
    else
        echo "✅ Memory usage is ${usage}% - OK"
    fi
}

echo "=== System Monitor Report $(date) ==="
check_service mysql
check_service alist
check_service tomcat
check_port 3306 MySQL
check_port 5244 Alist
check_port 8080 Tomcat
check_disk
check_memory
echo "==========================================="
```

```bash
# 设置执行权限
sudo chmod +x /opt/scripts/monitor.sh

# 添加到定时任务（每5分钟检查一次）
sudo crontab -e
# 添加以下行
*/5 * * * * /opt/scripts/monitor.sh >> /var/log/monitor.log 2>&1
```

### 2️⃣ 安全管理

#### 防火墙配置

```bash
# Ubuntu/Debian (UFW)
sudo ufw enable
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 80/tcp      # HTTP
sudo ufw allow 443/tcp     # HTTPS
sudo ufw allow 8080/tcp    # Tomcat
sudo ufw allow from 127.0.0.1 to any port 3306  # MySQL (仅本地)
sudo ufw allow from 127.0.0.1 to any port 5244  # Alist (仅本地)

# CentOS/RHEL (firewalld)
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

#### SSL证书配置

```bash
# 安装Certbot
sudo apt install certbot  # Ubuntu/Debian
sudo yum install certbot  # CentOS/RHEL

# 获取SSL证书
sudo certbot certonly --standalone -d your-domain.com

# 配置Tomcat SSL
sudo vim /opt/tomcat9/conf/server.xml
```

**SSL连接器配置**：

```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeyFile="/etc/letsencrypt/live/your-domain.com/privkey.pem"
                     certificateFile="/etc/letsencrypt/live/your-domain.com/cert.pem"
                     certificateChainFile="/etc/letsencrypt/live/your-domain.com/chain.pem" />
    </SSLHostConfig>
</Connector>
```

---

## 🔍 故障排除

### 常见问题及解决方案

#### 1. 应用无法启动

**症状**：Tomcat启动失败或应用无法访问

**排查步骤**：

```bash
# 1. 检查Tomcat日志
tail -f /opt/tomcat9/logs/catalina.out
tail -f /opt/tomcat9/logs/localhost.*.log

# 2. 检查端口占用
sudo netstat -tlnp | grep 8080

# 3. 检查Java进程
jps -l

# 4. 检查配置文件语法
sudo /opt/tomcat9/bin/catalina.sh configtest
```

**常见解决方案**：

- 检查JAVA_HOME环境变量
- 确认端口未被占用
- 检查web.xml语法错误
- 验证JAR依赖是否完整

#### 2. 数据库连接失败

**症状**：应用报数据库连接错误

**排查步骤**：

```bash
# 1. 测试数据库连接
mysql -u filehost -p file_hosting_system

# 2. 检查MySQL服务状态
sudo systemctl status mysql

# 3. 查看MySQL错误日志
sudo tail -f /var/log/mysql/error.log

# 4. 检查连接数
mysql -u root -p -e "SHOW STATUS LIKE 'Threads_connected';"
```

**常见解决方案**：

- 检查数据库用户权限
- 确认数据库服务正常运行
- 验证连接池配置
- 检查防火墙设置

#### 3. Alist服务异常

**症状**：文件上传失败或Alist API调用错误

**排查步骤**：

```bash
# 1. 检查Alist服务状态
sudo systemctl status alist

# 2. 查看Alist日志
sudo journalctl -u alist -f

# 3. 测试Alist API
curl http://localhost:5244/api/public/settings

# 4. 检查存储配置
curl -H "Authorization: Bearer your_token" http://localhost:5244/api/admin/storage/list
```

**常见解决方案**：

- 重启Alist服务
- 检查存储配置
- 验证API Token
- 确认网络连接

#### 4. 文件上传失败

**症状**：文件上传时报错或上传后无法访问

**排查步骤**：

```bash
# 1. 检查临时目录权限
ls -la /tmp/filehosting/

# 2. 检查磁盘空间
df -h

# 3. 查看上传日志
grep "upload" /opt/tomcat9/logs/filehosting.log

# 4. 测试文件权限
touch /tmp/test && rm /tmp/test
```

**常见解决方案**：

- 检查文件大小限制
- 确认临时目录权限
- 验证磁盘空间
- 检查文件类型限制

---

## ⚡ 性能优化

### 1️⃣ JVM优化

#### 内存配置

```bash
# 编辑Tomcat启动脚本
sudo vim /opt/tomcat9/bin/setenv.sh
```

**JVM优化参数**：

```bash
# 堆内存设置
export CATALINA_OPTS="$CATALINA_OPTS -Xms2g -Xmx4g"

# 新生代设置
export CATALINA_OPTS="$CATALINA_OPTS -XX:NewRatio=3 -XX:SurvivorRatio=8"

# 垃圾回收器
export CATALINA_OPTS="$CATALINA_OPTS -XX:+UseG1GC -XX:MaxGCPauseMillis=200"

# GC日志
export CATALINA_OPTS="$CATALINA_OPTS -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps"
export CATALINA_OPTS="$CATALINA_OPTS -Xloggc:/opt/tomcat9/logs/gc.log -XX:+UseGCLogFileRotation"
export CATALINA_OPTS="$CATALINA_OPTS -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=10M"

# 其他优化
export CATALINA_OPTS="$CATALINA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
export CATALINA_OPTS="$CATALINA_OPTS -XX:HeapDumpPath=/opt/tomcat9/logs/"
export CATALINA_OPTS="$CATALINA_OPTS -Djava.awt.headless=true"
export CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF-8"
```

### 2️⃣ 数据库优化

#### 索引优化

```sql
-- 分析慢查询
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;

-- 查看慢查询
SELECT * FROM mysql.slow_log ORDER BY start_time DESC LIMIT 10;

-- 添加复合索引
CREATE INDEX idx_user_type_time ON media_files(user_id, file_type, uploaded_at);
CREATE INDEX idx_filename_user ON media_files(filename, user_id);

-- 分析表
ANALYZE TABLE users, media_files, system_logs;

-- 优化表
OPTIMIZE TABLE users, media_files, system_logs;
```

#### 查询优化

```sql
-- 使用EXPLAIN分析查询
EXPLAIN SELECT * FROM media_files WHERE user_id = 1 ORDER BY uploaded_at DESC LIMIT 20;

-- 优化分页查询
SELECT * FROM media_files 
WHERE user_id = ? AND id > ? 
ORDER BY id 
LIMIT 20;

-- 使用覆盖索引
SELECT id, filename, file_size, uploaded_at 
FROM media_files 
WHERE user_id = ? 
ORDER BY uploaded_at DESC 
LIMIT 20;
```

### 3️⃣ 应用优化

#### 连接池优化

```properties
# C3P0连接池优化配置
c3p0.initialPoolSize=10
c3p0.maxPoolSize=50
c3p0.minPoolSize=5
c3p0.acquireIncrement=5
c3p0.maxIdleTime=3600
c3p0.checkoutTimeout=5000
c3p0.testConnectionOnCheckout=false
c3p0.testConnectionOnCheckin=true
c3p0.idleConnectionTestPeriod=300
c3p0.preferredTestQuery=SELECT 1
c3p0.maxStatementsPerConnection=20
```

#### 缓存策略

```java
// 实现简单的内存缓存
public class FileCache {
    private static final Map<String, MediaFile> cache = new ConcurrentHashMap<>();
    private static final long CACHE_EXPIRE_TIME = 30 * 60 * 1000; // 30分钟
    
    public static void put(String key, MediaFile file) {
        cache.put(key, file);
        // 设置过期时间
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                cache.remove(key);
            }
        }, CACHE_EXPIRE_TIME);
    }
    
    public static MediaFile get(String key) {
        return cache.get(key);
    }
}
```

---

## 🔗 相关页面

- [首页](Wiki-Home.md) - 项目概述和文档导航
- [系统架构](Wiki-System-Architecture.md) - 详细的系统架构设计
- [API文档](Wiki-API-Documentation.md) - 系统API接口文档
- [项目结构](Wiki-Project-Structure.md) - 项目目录结构说明
- [开发指南](Wiki-Development-Guide.md) - 开发环境搭建和开发规范

---

*最后更新时间：2024年*