<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>错误页面 - AlistFHS图床</title>
    <!-- 引入样式文件 -->
    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #E8F6F3 0%, #D5E8F7 50%, #C8E6C9 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .error-container {
            background: white;
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        .error-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            color: white;
            font-size: 2rem;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, #48C9B0 0%, #5DADE2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(72, 201, 176, 0.3);
        }
        
        .btn-secondary {
            background: #6C757D;
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        
        <h2 class="text-danger mb-3">操作失败</h2>
        
        <% 
            String errorMessage = (String) request.getAttribute("error");
            if (errorMessage == null) {
                errorMessage = "发生了未知错误";
            }
        %>
        
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-times-circle mr-2"></i>
            <%= errorMessage %>
        </div>
        
        <div class="mt-4">
            <a href="javascript:history.back()" class="btn btn-secondary mr-3">
                <i class="fas fa-arrow-left mr-2"></i>返回上页
            </a>
            <a href="${pageContext.request.contextPath}/user-center.jsp" class="btn btn-primary">
                <i class="fas fa-home mr-2"></i>返回首页
            </a>
        </div>
        
        <div class="mt-4">
            <small class="text-muted">
                如果问题持续存在，请联系系统管理员
            </small>
        </div>
    </div>
    
    <!-- 引入JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>