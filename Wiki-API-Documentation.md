# 📡 API文档

本页面详细介绍基于Alist的文件托管系统的API接口、请求响应格式和使用示例。

## 📋 目录

- [API概述](#api概述)
- [认证机制](#认证机制)
- [通用响应格式](#通用响应格式)
- [用户管理API](#用户管理api)
- [文件管理API](#文件管理api)
- [存储统计API](#存储统计api)
- [Alist集成API](#alist集成api)
- [错误代码](#错误代码)
- [使用示例](#使用示例)

---

## 🌐 API概述

### 基本信息

| 项目               | 值                                            |
| ------------------ | --------------------------------------------- |
| **基础URL**  | `http://localhost:8080/FileHostingSystemCY` |
| **协议**     | HTTP/HTTPS                                    |
| **数据格式** | JSON                                          |
| **字符编码** | UTF-8                                         |
| **认证方式** | Session-based                                 |

### 🔧 技术特点

- 🔒 **安全认证**：基于Session的用户认证机制
- 📊 **JSON通信**：统一的JSON请求和响应格式
- 🛡️ **参数验证**：严格的输入参数验证
- 📝 **错误处理**：统一的错误代码和消息
- 🔄 **异步支持**：支持AJAX异步请求

---

## 🔐 认证机制

### Session认证

系统采用基于Session的认证机制，用户登录后服务器创建Session存储用户信息。

```javascript
// 登录后Session中存储的用户信息
{
    "userInfo": {
        "id": 1,
        "username": "admin",
        "email": "admin@example.com",
        "isAdmin": true,
        "isEditor": true,
        "isRegular": true
    }
}
```

### 权限级别

| 权限级别           | 字段               | 说明                               |
| ------------------ | ------------------ | ---------------------------------- |
| **管理员**   | `is_admin = 1`   | 系统管理权限，可管理所有用户和文件 |
| **编辑者**   | `is_editor = 1`  | 高级文件管理权限，可管理自己的文件 |
| **普通用户** | `is_regular = 1` | 基本文件操作权限，可上传和查看文件 |

---

## 📋 通用响应格式

### 成功响应

```json
{
    "success": true,
    "message": "操作成功",
    "data": {
        // 具体数据内容
    },
    "timestamp": "2024-01-01T12:00:00Z"
}
```

### 错误响应

```json
{
    "success": false,
    "error": {
        "code": "ERROR_CODE",
        "message": "错误描述信息",
        "details": "详细错误信息"
    },
    "timestamp": "2024-01-01T12:00:00Z"
}
```

---

## 👤 用户管理API

### 🔑 用户登录

**接口地址**：`POST /login`

**请求参数**：

```json
{
    "username": "admin",
    "password": "123456"
}
```

**响应示例**：

```json
// 成功响应
{
    "success": true,
    "message": "登录成功",
    "data": {
        "user": {
            "id": 1,
            "username": "admin",
            "email": "admin@example.com",
            "isAdmin": true,
            "isEditor": true,
            "isRegular": true
        },
        "redirectUrl": "/dashboard.jsp"
    }
}

// 失败响应
{
    "success": false,
    "error": {
        "code": "INVALID_CREDENTIALS",
        "message": "用户名或密码错误"
    }
}
```

### 🚪 用户登出

**接口地址**：`POST /logout`

**请求参数**：无

**响应示例**：

```json
{
    "success": true,
    "message": "登出成功",
    "data": {
        "redirectUrl": "/login.jsp"
    }
}
```

### 👤 获取用户信息

**接口地址**：`GET /user/profile`

**请求参数**：无（需要登录）

**响应示例**：

```json
{
    "success": true,
    "data": {
        "id": 1,
        "username": "admin",
        "email": "admin@example.com",
        "createdAt": "2024-01-01T10:00:00Z",
        "lastLoginAt": "2024-01-01T12:00:00Z",
        "permissions": {
            "isAdmin": true,
            "isEditor": true,
            "isRegular": true
        }
    }
}
```

---

## 📁 文件管理API

### 📤 文件上传

**接口地址**：`POST /upload`

**请求类型**：`multipart/form-data`

**请求参数**：

| 参数名          | 类型   | 必填 | 说明         |
| --------------- | ------ | ---- | ------------ |
| `file`        | File   | 是   | 要上传的文件 |
| `description` | String | 否   | 文件描述     |

**响应示例**：

```json
// 成功响应
{
    "success": true,
    "message": "文件上传成功",
    "data": {
        "fileId": 123,
        "filename": "example.jpg",
        "fileSize": 1024000,
        "fileType": "image",
        "uploadTime": "2024-01-01T12:00:00Z",
        "downloadUrl": "https://alist.example.com/d/files/example.jpg",
        "thumbnailUrl": "https://alist.example.com/d/files/example.jpg?thumb"
    }
}

// 失败响应
{
    "success": false,
    "error": {
        "code": "UPLOAD_FAILED",
        "message": "文件上传失败",
        "details": "文件大小超过限制"
    }
}
```

### 📋 文件查询

**接口地址**：`GET /files`

**请求参数**：

| 参数名      | 类型    | 必填 | 说明             |
| ----------- | ------- | ---- | ---------------- |
| `page`    | Integer | 否   | 页码，默认1      |
| `size`    | Integer | 否   | 每页大小，默认20 |
| `type`    | String  | 否   | 文件类型过滤     |
| `keyword` | String  | 否   | 搜索关键词       |

**响应示例**：

```json
{
    "success": true,
    "data": {
        "files": [
            {
                "id": 1,
                "filename": "example.jpg",
                "fileSize": 1024000,
                "fileType": "image",
                "uploadTime": "2024-01-01T12:00:00Z",
                "downloadUrl": "https://alist.example.com/d/files/example.jpg",
                "thumbnailUrl": "https://alist.example.com/d/files/example.jpg?thumb",
                "description": "示例图片"
            }
        ],
        "pagination": {
            "currentPage": 1,
            "totalPages": 5,
            "totalFiles": 100,
            "pageSize": 20
        }
    }
}
```

### 🎬 媒体文件查询

**接口地址**：`GET /media`

**请求参数**：

| 参数名    | 类型    | 必填 | 说明                        |
| --------- | ------- | ---- | --------------------------- |
| `type`  | String  | 否   | 媒体类型：image/video/audio |
| `limit` | Integer | 否   | 返回数量限制，默认50        |

**响应示例**：

```json
{
    "success": true,
    "data": {
        "mediaFiles": [
            {
                "id": 1,
                "filename": "vacation.mp4",
                "fileType": "video",
                "fileSize": 52428800,
                "duration": "00:05:30",
                "resolution": "1920x1080",
                "uploadTime": "2024-01-01T12:00:00Z",
                "downloadUrl": "https://alist.example.com/d/videos/vacation.mp4",
                "thumbnailUrl": "https://alist.example.com/d/videos/vacation.mp4?thumb"
            }
        ],
        "summary": {
            "totalFiles": 25,
            "totalSize": 1073741824,
            "typeDistribution": {
                "image": 15,
                "video": 8,
                "audio": 2
            }
        }
    }
}
```

### 🗑️ 文件删除

**接口地址**：`DELETE /files/{fileId}`

**请求参数**：

| 参数名     | 类型    | 必填 | 说明               |
| ---------- | ------- | ---- | ------------------ |
| `fileId` | Integer | 是   | 文件ID（路径参数） |

**响应示例**：

```json
// 成功响应
{
    "success": true,
    "message": "文件删除成功",
    "data": {
        "deletedFileId": 123,
        "filename": "example.jpg"
    }
}

// 失败响应
{
    "success": false,
    "error": {
        "code": "FILE_NOT_FOUND",
        "message": "文件不存在或已被删除"
    }
}
```

---

## 📊 存储统计API

### 📈 存储统计信息

**接口地址**：`GET /storage/stats`

**请求参数**：无（需要登录）

**响应示例**：

```json
{
    "success": true,
    "data": {
        "userStats": {
            "totalFiles": 156,
            "totalSize": 2147483648,
            "usedSpace": "2.0 GB",
            "fileTypes": {
                "image": {
                    "count": 89,
                    "size": 524288000,
                    "percentage": 24.4
                },
                "video": {
                    "count": 23,
                    "size": 1610612736,
                    "percentage": 75.0
                },
                "audio": {
                    "count": 12,
                    "size": 12582912,
                    "percentage": 0.6
                },
                "other": {
                    "count": 32,
                    "size": 0,
                    "percentage": 0.0
                }
            }
        },
        "systemStats": {
            "totalUsers": 25,
            "totalFiles": 3890,
            "totalSize": 53687091200,
            "averageFileSize": 13803520
        },
        "recentActivity": {
            "uploadsToday": 12,
            "uploadsThisWeek": 89,
            "uploadsThisMonth": 356
        }
    }
}
```

---

## ☁️ Alist集成API

### 🔗 Alist连接测试

**接口地址**：`GET /alist/test`

**请求参数**：无（需要管理员权限）

**响应示例**：

```json
// 连接成功
{
    "success": true,
    "message": "Alist连接正常",
    "data": {
        "alistUrl": "https://alist.example.com",
        "version": "v3.25.1",
        "status": "online",
        "responseTime": 156,
        "lastChecked": "2024-01-01T12:00:00Z"
    }
}

// 连接失败
{
    "success": false,
    "error": {
        "code": "ALIST_CONNECTION_FAILED",
        "message": "无法连接到Alist服务",
        "details": "连接超时"
    }
}
```

### 🔄 目录刷新

**接口地址**：`POST /alist/refresh`

**请求参数**：

```json
{
    "path": "/files"
}
```

**响应示例**：

```json
{
    "success": true,
    "message": "目录刷新成功",
    "data": {
        "path": "/files",
        "refreshedAt": "2024-01-01T12:00:00Z",
        "fileCount": 156
    }
}
```

### 🔑 Token管理

**接口地址**：`POST /alist/token/refresh`

**请求参数**：无（需要管理员权限）

**响应示例**：

```json
{
    "success": true,
    "message": "Token刷新成功",
    "data": {
        "tokenUpdated": true,
        "expiresAt": "2024-01-02T12:00:00Z"
    }
}
```

---

## ❌ 错误代码

### 认证相关错误

| 错误代码                | HTTP状态码 | 说明               |
| ----------------------- | ---------- | ------------------ |
| `UNAUTHORIZED`        | 401        | 未登录或登录已过期 |
| `INVALID_CREDENTIALS` | 401        | 用户名或密码错误   |
| `ACCESS_DENIED`       | 403        | 权限不足           |
| `SESSION_EXPIRED`     | 401        | 会话已过期         |

### 文件操作错误

| 错误代码              | HTTP状态码 | 说明             |
| --------------------- | ---------- | ---------------- |
| `FILE_NOT_FOUND`    | 404        | 文件不存在       |
| `FILE_TOO_LARGE`    | 413        | 文件大小超过限制 |
| `INVALID_FILE_TYPE` | 400        | 不支持的文件类型 |
| `UPLOAD_FAILED`     | 500        | 文件上传失败     |
| `DELETE_FAILED`     | 500        | 文件删除失败     |

### 系统错误

| 错误代码                    | HTTP状态码 | 说明              |
| --------------------------- | ---------- | ----------------- |
| `INTERNAL_ERROR`          | 500        | 服务器内部错误    |
| `DATABASE_ERROR`          | 500        | 数据库操作失败    |
| `ALIST_CONNECTION_FAILED` | 502        | Alist服务连接失败 |
| `INVALID_PARAMETERS`      | 400        | 请求参数无效      |

### 业务逻辑错误

| 错误代码                   | HTTP状态码 | 说明         |
| -------------------------- | ---------- | ------------ |
| `DUPLICATE_FILENAME`     | 409        | 文件名已存在 |
| `STORAGE_QUOTA_EXCEEDED` | 413        | 存储配额已满 |
| `OPERATION_NOT_ALLOWED`  | 403        | 操作不被允许 |

---

## 💡 使用示例

### JavaScript/AJAX示例

#### 1. 用户登录

```javascript
// 用户登录
function login(username, password) {
    $.ajax({
        url: '/FileHostingSystemCY/login',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            username: username,
            password: password
        }),
        success: function(response) {
            if (response.success) {
                alert('登录成功');
                window.location.href = response.data.redirectUrl;
            } else {
                alert('登录失败：' + response.error.message);
            }
        },
        error: function(xhr, status, error) {
            alert('请求失败：' + error);
        }
    });
}
```

#### 2. 文件上传

```javascript
// 文件上传
function uploadFile(fileInput, description) {
    const formData = new FormData();
    formData.append('file', fileInput.files[0]);
    formData.append('description', description);
  
    $.ajax({
        url: '/FileHostingSystemCY/upload',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        xhr: function() {
            const xhr = new window.XMLHttpRequest();
            // 上传进度
            xhr.upload.addEventListener('progress', function(evt) {
                if (evt.lengthComputable) {
                    const percentComplete = evt.loaded / evt.total * 100;
                    $('#uploadProgress').css('width', percentComplete + '%');
                }
            }, false);
            return xhr;
        },
        success: function(response) {
            if (response.success) {
                alert('文件上传成功');
                loadFileList(); // 刷新文件列表
            } else {
                alert('上传失败：' + response.error.message);
            }
        },
        error: function(xhr, status, error) {
            alert('上传失败：' + error);
        }
    });
}
```

#### 3. 文件列表查询

```javascript
// 获取文件列表
function loadFileList(page = 1, type = '', keyword = '') {
    $.ajax({
        url: '/FileHostingSystemCY/files',
        type: 'GET',
        data: {
            page: page,
            size: 20,
            type: type,
            keyword: keyword
        },
        success: function(response) {
            if (response.success) {
                displayFileList(response.data.files);
                updatePagination(response.data.pagination);
            } else {
                alert('获取文件列表失败：' + response.error.message);
            }
        },
        error: function(xhr, status, error) {
            alert('请求失败：' + error);
        }
    });
}

// 显示文件列表
function displayFileList(files) {
    const fileListContainer = $('#fileList');
    fileListContainer.empty();
  
    files.forEach(function(file) {
        const fileItem = `
            <div class="file-item" data-file-id="${file.id}">
                <div class="file-info">
                    <h5>${file.filename}</h5>
                    <p>大小：${formatFileSize(file.fileSize)}</p>
                    <p>上传时间：${formatDate(file.uploadTime)}</p>
                </div>
                <div class="file-actions">
                    <a href="${file.downloadUrl}" class="btn btn-primary" target="_blank">下载</a>
                    <button class="btn btn-danger" onclick="deleteFile(${file.id})">删除</button>
                </div>
            </div>
        `;
        fileListContainer.append(fileItem);
    });
}
```

#### 4. 存储统计

```javascript
// 获取存储统计
function loadStorageStats() {
    $.ajax({
        url: '/FileHostingSystemCY/storage/stats',
        type: 'GET',
        success: function(response) {
            if (response.success) {
                updateStorageChart(response.data.userStats.fileTypes);
                updateStorageInfo(response.data.userStats);
            } else {
                alert('获取统计信息失败：' + response.error.message);
            }
        },
        error: function(xhr, status, error) {
            alert('请求失败：' + error);
        }
    });
}

// 更新存储图表
function updateStorageChart(fileTypes) {
    const ctx = document.getElementById('storageChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: Object.keys(fileTypes),
            datasets: [{
                data: Object.values(fileTypes).map(type => type.percentage),
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });
}
```

### cURL示例

#### 1. 用户登录

```bash
# 用户登录
curl -X POST http://localhost:8080/FileHostingSystemCY/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "123456"
  }' \
  -c cookies.txt
```

#### 2. 文件上传

```bash
# 文件上传（需要先登录获取Session）
curl -X POST http://localhost:8080/FileHostingSystemCY/upload \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/path/to/your/file.jpg" \
  -F "description=测试图片" \
  -b cookies.txt
```

#### 3. 文件查询

```bash
# 获取文件列表
curl -X GET "http://localhost:8080/FileHostingSystemCY/files?page=1&size=10&type=image" \
  -H "Accept: application/json" \
  -b cookies.txt
```

#### 4. 存储统计

```bash
# 获取存储统计
curl -X GET http://localhost:8080/FileHostingSystemCY/storage/stats \
  -H "Accept: application/json" \
  -b cookies.txt
```

### Python示例

```python
import requests
import json

# 创建Session保持登录状态
session = requests.Session()

# 1. 用户登录
def login(username, password):
    login_data = {
        'username': username,
        'password': password
    }
  
    response = session.post(
        'http://localhost:8080/FileHostingSystemCY/login',
        json=login_data,
        headers={'Content-Type': 'application/json'}
    )
  
    if response.status_code == 200:
        result = response.json()
        if result['success']:
            print('登录成功')
            return True
        else:
            print(f'登录失败：{result["error"]["message"]}')
            return False
    else:
        print(f'请求失败：{response.status_code}')
        return False

# 2. 文件上传
def upload_file(file_path, description=''):
    with open(file_path, 'rb') as f:
        files = {'file': f}
        data = {'description': description}
      
        response = session.post(
            'http://localhost:8080/FileHostingSystemCY/upload',
            files=files,
            data=data
        )
      
        if response.status_code == 200:
            result = response.json()
            if result['success']:
                print(f'文件上传成功：{result["data"]["filename"]}')
                return result['data']
            else:
                print(f'上传失败：{result["error"]["message"]}')
                return None
        else:
            print(f'请求失败：{response.status_code}')
            return None

# 3. 获取文件列表
def get_file_list(page=1, size=20, file_type='', keyword=''):
    params = {
        'page': page,
        'size': size,
        'type': file_type,
        'keyword': keyword
    }
  
    response = session.get(
        'http://localhost:8080/FileHostingSystemCY/files',
        params=params
    )
  
    if response.status_code == 200:
        result = response.json()
        if result['success']:
            return result['data']
        else:
            print(f'获取文件列表失败：{result["error"]["message"]}')
            return None
    else:
        print(f'请求失败：{response.status_code}')
        return None

# 使用示例
if __name__ == '__main__':
    # 登录
    if login('admin', '123456'):
        # 上传文件
        upload_result = upload_file('/path/to/file.jpg', '测试图片')
      
        # 获取文件列表
        file_list = get_file_list(page=1, file_type='image')
        if file_list:
            print(f'共找到 {file_list["pagination"]["totalFiles"]} 个文件')
            for file in file_list['files']:
                print(f'- {file["filename"]} ({file["fileSize"]} bytes)')
```

---

## 🔗 相关页面

- [首页](Wiki-Home.md) - 项目概述和文档导航
- [系统架构](Wiki-System-Architecture.md) - 详细的系统架构设计
- [项目结构](Wiki-Project-Structure.md) - 项目目录结构说明
- [部署指南](Wiki-Deployment-Guide.md) - 系统部署和配置指南
- [开发指南](Wiki-Development-Guide.md) - 开发环境搭建和开发规范

---

*最后更新时间：2024年*
