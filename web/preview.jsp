<%--
  Created by IntelliJ IDEA.
  User: uers
  Date: 2025/6/3
  Time: 22:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%--%>
<%--    //在request中获取文件路径--%>
<%--    String path = request.getParameter("filePath");--%>
<%--%>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图片预览</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f5f5f5;
        }

        .thumbnail {
            width: 200px;
            cursor: pointer;
            border: 2px solid #ddd;
            border-radius: 8px;
            transition: transform 0.2s;
        }

        .thumbnail:hover {
            transform: scale(1.05);
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            max-width: 90%;
            max-height: 90%;
        }

        .close {
            position: absolute;
            top: 20px;
            right: 30px;
            color: white;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 缩略图 -->
<c:choose>
    <c:when test="${fn:endsWith(fn:toLowerCase(filePath), '.jpg') || fn:endsWith(fn:toLowerCase(filePath), '.jpeg') || fn:endsWith(fn:toLowerCase(filePath), '.png') || fn:endsWith(fn:toLowerCase(filePath), '.gif')}">
        <img id="thumbnail" class="thumbnail" src="${filePath}" alt="预览图片">
    </c:when>
    <c:when test="${fn:endsWith(fn:toLowerCase(filePath), '.mp4') || fn:endsWith(fn:toLowerCase(filePath), '.avi') || fn:endsWith(fn:toLowerCase(filePath), '.mov')}">
        <video controls>
            <source src="${filePath}" type="video/mp4">
            您的浏览器不支持 video 标签。
        </video>
    </c:when>
    <c:otherwise>
        <p>不支持的文件类型</p>
    </c:otherwise>
</c:choose>

<!-- 预览模态框 -->
<div id="previewModal" class="modal">
    <span class="close">&times;</span>
    <img class="modal-content" id="previewImage" src="${filePath}" alt="预览图片">
</div>

<script>
    // 获取DOM元素
    const thumbnail = document.getElementById('thumbnail');
    const modal = document.getElementById('previewModal');
    const previewImage = document.getElementById('previewImage');
    const closeBtn = document.querySelector('.close');

    // 点击缩略图打开预览
    thumbnail.addEventListener('click', function() {
        modal.style.display = 'flex';
    });

    // 点击关闭按钮关闭预览
    closeBtn.addEventListener('click', function() {
        modal.style.display = 'none';
    });

    // 点击模态框背景关闭预览
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            modal.style.display = 'none';
        }
    });
</script>
</body>
</html>
