<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.java.model.User" %>
<%
    // 获取用户信息
    User user = (User) session.getAttribute("userInfo");
    if (user == null) {
        response.sendRedirect("sign-in.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文件删除测试 - AlistFHS图床</title>
    <!-- 引入Google字体 -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800|Roboto:400,500,700" rel="stylesheet">
    <!-- 引入样式文件 -->
    <link type="text/css" href="${pageContext.request.contextPath}/assets/css/theme.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-blue: #4A90E2;
            --secondary-teal: #5DADE2;
            --accent-turquoise: #48C9B0;
            --light-gray: #F8F9FA;
            --dark-gray: #2C3E50;
            --mountain-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --water-gradient: linear-gradient(90deg, #48C9B0 0%, #5DADE2 100%);
        }

        body {
            background: linear-gradient(135deg, #E8F6F3 0%, #D5E8F7 50%, #C8E6C9 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .hero-section {
            background: var(--mountain-gradient);
            color: white;
            padding: 3rem 0 2rem;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><path d="M0,300 Q300,200 600,300 T1200,300 L1200,600 L0,600 Z" fill="rgba(255,255,255,0.1)"/></svg>') no-repeat center bottom;
            background-size: cover;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .test-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: none;
            margin-bottom: 2rem;
        }

        .form-control {
            border-radius: 10px;
            border: 2px solid #E9ECEF;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.25);
        }

        .btn-test {
            background: var(--water-gradient);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-test:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(72, 201, 176, 0.3);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
            color: white;
        }

        .result-area {
            background: #F8F9FA;
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
            min-height: 100px;
            border: 2px dashed #DEE2E6;
        }

        .result-success {
            background: #D4EDDA;
            border-color: #C3E6CB;
            color: #155724;
        }

        .result-error {
            background: #F8D7DA;
            border-color: #F5C6CB;
            color: #721C24;
        }

        .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
        }

        .icon-delete {
            background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
            color: white;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/user-center.jsp">
                <i class="fas fa-cloud-upload-alt text-primary"></i>
                <span class="ml-2 font-weight-bold">AlistFHS</span>
            </a>
            <div class="navbar-nav ml-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/user-center.jsp">
                    <i class="fas fa-arrow-left"></i> 返回用户中心
                </a>
            </div>
        </div>
    </nav>

    <!-- 主要内容区域 -->
    <div style="padding-top: 80px;">
        <!-- Hero区域 -->
        <section class="hero-section">
            <div class="container">
                <div class="hero-content text-center">
                    <div class="icon-box icon-delete mx-auto">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                    <h1 class="display-4 font-weight-bold mb-3">文件删除测试</h1>
                    <p class="lead mb-0">测试 DeleteFile Servlet 的文件删除功能</p>
                </div>
            </div>
        </section>

        <!-- 测试表单区域 -->
        <section class="py-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="test-card">
                            <h3 class="text-center mb-4">
                                <i class="fas fa-vial text-primary mr-2"></i>
                                删除文件测试
                            </h3>
                            
                            <form id="deleteForm">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="fileName" class="font-weight-bold">
                                                <i class="fas fa-file mr-2"></i>文件名
                                            </label>
                                            <input type="text" 
                                                   class="form-control" 
                                                   id="fileName" 
                                                   name="fileName" 
                                                   placeholder="请输入要删除的文件名（如：example.jpg）"
                                                   required>
                                            <small class="form-text text-muted">
                                                请输入完整的文件名，包括扩展名
                                            </small>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="font-weight-bold">&nbsp;</label>
                                            <div>
                                                <button type="submit" class="btn btn-danger btn-block">
                                                    <i class="fas fa-trash-alt mr-2"></i>删除文件
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <!-- 结果显示区域 -->
                            <div class="result-area" id="resultArea">
                                <div class="text-center text-muted">
                                    <i class="fas fa-info-circle mr-2"></i>
                                    测试结果将在这里显示...
                                </div>
                            </div>
                        </div>

                        <!-- 使用说明 -->
                        <div class="test-card">
                            <h4 class="mb-3">
                                <i class="fas fa-info-circle text-info mr-2"></i>
                                使用说明
                            </h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="font-weight-bold text-success">
                                        <i class="fas fa-check-circle mr-2"></i>功能说明
                                    </h6>
                                    <ul class="list-unstyled ml-3">
                                        <li><i class="fas fa-dot-circle text-primary mr-2"></i>测试 /deleteFile 接口</li>
                                        <li><i class="fas fa-dot-circle text-primary mr-2"></i>检查文件是否存在</li>
                                        <li><i class="fas fa-dot-circle text-primary mr-2"></i>调用 AlistRemove 删除文件</li>
                                        <li><i class="fas fa-dot-circle text-primary mr-2"></i>处理错误情况</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="font-weight-bold text-warning">
                                        <i class="fas fa-exclamation-triangle mr-2"></i>注意事项
                                    </h6>
                                    <ul class="list-unstyled ml-3">
                                        <li><i class="fas fa-dot-circle text-warning mr-2"></i>请输入完整文件名</li>
                                        <li><i class="fas fa-dot-circle text-warning mr-2"></i>删除操作不可撤销</li>
                                        <li><i class="fas fa-dot-circle text-warning mr-2"></i>仅删除 /cloudflare 目录下的文件</li>
                                        <li><i class="fas fa-dot-circle text-warning mr-2"></i>需要文件在数据库中存在</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- 快速测试按钮 -->
                        <div class="test-card">
                            <h4 class="mb-3">
                                <i class="fas fa-rocket text-success mr-2"></i>
                                快速测试
                            </h4>
                            <div class="row">
                                <div class="col-md-4">
                                    <button type="button" class="btn btn-test btn-block" onclick="quickTest('test.jpg')">
                                        <i class="fas fa-image mr-2"></i>测试 test.jpg
                                    </button>
                                </div>
                                <div class="col-md-4">
                                    <button type="button" class="btn btn-test btn-block" onclick="quickTest('sample.png')">
                                        <i class="fas fa-file-image mr-2"></i>测试 sample.png
                                    </button>
                                </div>
                                <div class="col-md-4">
                                    <button type="button" class="btn btn-test btn-block" onclick="quickTest('nonexistent.txt')">
                                        <i class="fas fa-question-circle mr-2"></i>测试不存在文件
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- 引入JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 表单提交处理
        document.getElementById('deleteForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const fileName = document.getElementById('fileName').value.trim();
            if (!fileName) {
                showResult('请输入文件名！', 'error');
                return;
            }
            
            // 确认删除
            if (!confirm('确定要删除文件 "' + fileName + '" 吗？')) {
                return;
            }
            
            deleteFile(fileName);
        });
        
        // 删除文件函数
        function deleteFile(fileName) {
            showResult('正在删除文件: ' + fileName + '...', 'info');
            
            // 构建请求URL
            const url = '${pageContext.request.contextPath}/deleteFile?fileName=' + encodeURIComponent(fileName);
            
            // 发送GET请求
            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else if (response.status === 404) {
                    throw new Error('文件不存在或已被删除');
                } else {
                    throw new Error('删除失败，状态码: ' + response.status);
                }
            })
            .then(data => {
                if (data.includes('error') || data.includes('错误')) {
                    showResult('删除失败: ' + data, 'error');
                } else {
                    showResult('文件删除成功: ' + fileName, 'success');
                    document.getElementById('fileName').value = '';
                }
            })
            .catch(error => {
                showResult('删除失败: ' + error.message, 'error');
            });
        }
        
        // 快速测试函数
        function quickTest(fileName) {
            document.getElementById('fileName').value = fileName;
            deleteFile(fileName);
        }
        
        // 显示结果函数
        function showResult(message, type) {
            const resultArea = document.getElementById('resultArea');
            let icon = '';
            let className = 'result-area';
            
            switch(type) {
                case 'success':
                    icon = '<i class="fas fa-check-circle text-success mr-2"></i>';
                    className += ' result-success';
                    break;
                case 'error':
                    icon = '<i class="fas fa-times-circle text-danger mr-2"></i>';
                    className += ' result-error';
                    break;
                case 'info':
                default:
                    icon = '<i class="fas fa-info-circle text-info mr-2"></i>';
                    break;
            }
            
            resultArea.className = className;
            resultArea.innerHTML = '<div class="font-weight-bold">' + icon + message + '</div>' +
                                  '<small class="text-muted">测试时间: ' + new Date().toLocaleString() + '</small>';
            
            // 滚动到结果区域
            resultArea.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    </script>
</body>
</html>