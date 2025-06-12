<%@ page import="main.java.model.User" %>
<%@ page import="main.java.dao.MediaFileDAO" %>
<%@ page import="main.java.model.MediaFile" %>
<%@ page import="main.java.utils.AddpreUrl" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  // 获取对象属性
  User user = (User) session.getAttribute("userInfo");
  // 为JSTL准备数据
  if (user != null) {
    MediaFileDAO mediaFileDAO = new MediaFileDAO();
    List<MediaFile> mediaFiles = mediaFileDAO.getMediaFilesByUserId(user.getId());
    request.setAttribute("mediaFiles", mediaFiles);
    request.setAttribute("user", user);
  }
%>
<html lang="zh-CN">
<head>
    <title>用户主页</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/assets/css/userCen.css" rel="stylesheet" type="text/css">
    <!-- 引入Google字体 - Nunito和Roboto字体系列 -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800|Roboto:400,500,700" rel="stylesheet">
    <!-- 引入动画库 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/animate/animate.min.css" type="text/css">
     <link type="text/css" href="${pageContext.request.contextPath}/assets/css/theme.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modal.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/limestart-search-component.css">
</head>
<body>
<%-- 导航栏 --%>
<nav class="navbar navbar-expand-lg navbar-dark navbar-transparent py-4">
    <div class="container">
        <a class="navbar-brand" href="./"><strong>AlistFHS</strong> Cloud SU</a>

        <button class="navbar-toggler" type="button" data-action="offcanvas-open" data-target="#navbar_main" aria-controls="navbar_main" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

            <div id="limestart-search-component-wrapper">
                <div class="limestart-search-box">
                    <input type="text" class="limestart-search-input" placeholder="搜索或输入文件名">
                    <button class="limestart-search-btn" aria-label="搜索">
                        <svg class="limestart-search-icon" focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path>
                        </svg>
                    </button>
                </div>
            </div>
            <!-- This div is separate and fixed, it's controlled by JS -->
            <div class="limestart-backdrop-blur"></div>

        <div class="navbar-collapse offcanvas-collapse mr-auto" id="navbar_main" style="position: relative; right: -250px;">
            <ul class="navbar-nav ml-auto align-items-lg-center">
                <h6 class="dropdown-header font-weight-600 d-lg-none px-0">Menu</h6>

                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Overview</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbar_main_dropdown_1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pages</a>
                    <div class="dropdown-menu" aria-labelledby="navbar_1_dropdown_1">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/homepage.jsp">Homepage</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/about.jsp">About us</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/sign-in.jsp">Sign in</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a>
                    </div>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/docs/introduction.jsp">Docs</a>
                </li>

                <li class="nav-item ml-lg-4">
                    <% if (user != null) { %>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm bg-white btn-icon mr-2 text-success">
                        <span class="btn-inner--icon"><i class="fa-solid fa-door-open"></i></span>
                        <span class="btn-inner--text">退出登录</span>
                    </a>
                    <% } %>
                </li>

                <li class="nav-item">
                    <a href="#" class="nav-link nav-link-icon nav-icon-red"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10a4 4 0 0 1 4-4h10a4 4 0 0 1 4 4v6a4 4 0 0 1-4 4H7a4 4 0 0 1-4-4zm5-7l2 3m6-3l-2 3m-5 7v-2m6 0v2"/></svg></a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link nav-link-icon nav-icon-cyan"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><g fill="none"><path d="m12.593 23.258l-.011.002l-.071.035l-.02.004l-.014-.004l-.071-.035q-.016-.005-.024.005l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427q-.004-.016-.017-.018m.265-.113l-.013.002l-.185.093l-.01.01l-.003.011l.018.43l.005.012l.008.007l.201.093q.019.005.029-.008l.004-.014l-.034-.614q-.005-.018-.02-.022m-.715.002a.02.02 0 0 0-.027.006l-.006.014l-.034.614q.001.018.017.024l.015-.002l.201-.093l.01-.008l.004-.011l.017-.43l-.003-.012l-.01-.01z"/><path fill="currentColor" d="M10 3c4.071 0 7.7 2.67 7.982 6.368c2.304.862 4.018 2.81 4.018 5.26c0 1.867-1.026 3.472-2.52 4.493a2.3 2.3 0 0 0-.022.439l.014.44a1 1 0 0 1-1 1c-.758 0-1.46-.247-2.054-.71a8 8 0 0 1-1.105.078c-2.767 0-5.322-1.491-6.284-3.751a9 9 0 0 1-.454-.058c-.716.567-1.54.885-2.464.885a1 1 0 0 1-1-1l.005-.203l.018-.41a2.1 2.1 0 0 0-.058-.608C3.248 14.004 2 12.073 2 9.833C2 5.896 5.76 3 10 3m5.313 7.889c-2.768 0-4.688 1.837-4.688 3.74c0 1.902 1.92 3.74 4.688 3.74a6 6 0 0 0 1.078-.101c.434-.082.819.1 1.15.36c.099-.433.324-.842.706-1.088C19.363 16.82 20 15.753 20 14.629c0-1.903-1.92-3.74-4.687-3.74M10 5C6.508 5 4 7.327 4 9.833c0 1.477.837 2.858 2.264 3.777c.531.343.76.957.83 1.559l.482-.342c.308-.208.63-.366 1.05-.288c.056-3.286 3.203-5.65 6.687-5.65q.288 0 .573.021C15.362 6.784 13.059 5 10 5m3.62 8a1 1 0 1 1 0 2a1 1 0 0 1 0-2M17 13a1 1 0 1 1 0 2a1 1 0 0 1 0-2M8 7a1 1 0 1 1 0 2a1 1 0 0 1 0-2m4 0a1 1 0 1 1 0 2a1 1 0 0 1 0-2"/></g></svg></a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link nav-link-icon nav-icon-blue"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"><path stroke-dasharray="20" stroke-dashoffset="20" d="M21 5l-2.5 15M21 5l-12 8.5"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.4s" values="20;0"/></path><path stroke-dasharray="24" stroke-dashoffset="24" d="M21 5l-19 7.5"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.4s" values="24;0"/></path><path stroke-dasharray="14" stroke-dashoffset="14" d="M18.5 20l-9.5 -6.5"><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.4s" dur="0.3s" values="14;0"/></path><path stroke-dasharray="10" stroke-dashoffset="10" d="M2 12.5l7 1"><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.4s" dur="0.3s" values="10;0"/></path><path stroke-dasharray="8" stroke-dashoffset="8" d="M12 16l-3 3M9 13.5l0 5.5"><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.7s" dur="0.3s" values="8;0"/></path></g></svg></a>
                </li>
                <li class="nav-item">
                    <a href="https://github.com/2547364328luotao/FileHostingSystemCY" class="nav-link nav-link-icon nav-icon-green"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><mask id="IconifyId1971632191cd242eb3" width="24" height="24" x="0" y="0"><g fill="#fff"><ellipse cx="9.5" cy="9" rx="1.5" ry="1"/><ellipse cx="14.5" cy="9" rx="1.5" ry="1"/></g></mask><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"><path stroke-dasharray="32" stroke-dashoffset="32" d="M12 4c1.67 0 2.61 0.4 3 0.5c0.53 -0.43 1.94 -1.5 3.5 -1.5c0.34 1 0.29 2.22 0 3c0.75 1 1 2 1 3.5c0 2.19 -0.48 3.58 -1.5 4.5c-1.02 0.92 -2.11 1.37 -3.5 1.5c0.65 0.54 0.5 1.87 0.5 2.5c0 0.73 0 3 0 3M12 4c-1.67 0 -2.61 0.4 -3 0.5c-0.53 -0.43 -1.94 -1.5 -3.5 -1.5c-0.34 1 -0.29 2.22 0 3c-0.75 1 -1 2 -1 3.5c0 2.19 0.48 3.58 1.5 4.5c1.02 0.92 2.11 1.37 3.5 1.5c-0.65 0.54 -0.5 1.87 -0.5 2.5c0 0.73 0 3 0 3"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.7s" values="32;0"/></path><path stroke-dasharray="10" stroke-dashoffset="10" d="M9 19c-1.406 0-2.844-.563-3.688-1.188C4.47 17.188 4.22 16.157 3 15.5"><animate attributeName="d" dur="3s" repeatCount="indefinite" values="M9 19c-1.406 0-2.844-.563-3.688-1.188C4.47 17.188 4.22 16.157 3 15.5;M9 19c-1.406 0-3-.5-4-.5-.532 0-1 0-2-.5;M9 19c-1.406 0-2.844-.563-3.688-1.188C4.47 17.188 4.22 16.157 3 15.5"/><animate fill="freeze" attributeName="stroke-dashoffset" begin="0.8s" dur="0.2s" values="10;0"/></path></g><rect width="8" height="4" x="8" y="11" fill="currentColor" mask="url(#IconifyId1971632191cd242eb3)"><animate attributeName="y" dur="10s" keyTimes="0;0.45;0.46;0.54;0.55;1" repeatCount="indefinite" values="11;11;7;7;11;11"/></rect></svg></a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%--搜索弹窗--%>
<div id="limestart-search-results-modal" class="limestart-modal">
    <div class="limestart-modal-content">
        <span class="limestart-close-btn">&times;</span>
        <h2>搜索结果</h2>
        <pre id="limestart-modal-data"></pre>
    </div>
</div>

<%--主体内容--%>
<main class="main py-5">

    <div class="container">
        <!-- 用户欢迎区域 -->
        <section class="hero-section mb-5">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-4 text-white mb-3">欢迎回来，<%= user != null ? user.getUsername() : "访客" %>！</h1>
                    <p class="lead text-white-50">管理您的文件，分享您的创意</p>
                </div>
                <div class="col-lg-4 text-lg-right">
                    <div class="stats-card bg-white rounded p-4 shadow">
                        <h5 class="text-muted mb-2">存储使用情况</h5>
                        <div class="progress mb-2" style="height: 8px;">
                            <div class="progress-bar bg-success" style="width: 65%"></div>
                        </div>
                        <small class="text-muted"><span class="sotr_sum">6.5GB</span> / 10GB</small>
                    </div>
                </div>
            </div>
        </section>

        <!-- 快速操作区域 -->
        <section class="quick-actions mb-5">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="icon-circle bg-primary text-white mb-3 mx-auto">
                                <i class="fas fa-upload fa-2x"></i>
                            </div>
                            <h5 class="card-title">上传文件</h5>
                            <p class="card-text text-muted">快速上传您的图片和文档</p>
                            <a href="${pageContext.request.contextPath}/upload.jsp" class="btn btn-primary btn-sm">开始上传</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="icon-circle bg-success text-white mb-3 mx-auto">
                                <i class="fas fa-folder fa-2x"></i>
                            </div>
                            <h5 class="card-title">文件管理</h5>
                            <p class="card-text text-muted">查看和管理您的所有文件</p>
                            <div class="gallery-container">
                                <button id="openGallery" class="gallery-btn btn btn-success btn-sm">浏览全部图片</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 图片库弹窗 -->
                <div id="galleryModal" class="modal">
                    <div class="modal-overlay"></div>
                    <div class="modal-wrapper">
                        <span class="close" aria-label="关闭">&times;</span>
                        <div id="imageContainer" class="image-container"></div>
                    </div>
                </div>

                <!-- 大图预览弹窗 -->
                <div id="imageModal" class="modal image-modal">
                    <div class="modal-overlay"></div>
                    <div class="modal-wrapper">
                        <span class="close" aria-label="关闭">&times;</span>
                        <img class="modal-content" src="" alt="预览图片">
                        <div class="nav-buttons">
                            <button class="nav-btn prev-btn" aria-label="上一张">&lt;</button>
                            <button class="nav-btn next-btn" aria-label="下一张">&gt;</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-3">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="icon-circle bg-info text-white mb-3 mx-auto">
                                <i class="fas fa-share-alt fa-2x"></i>
                            </div>
                            <h5 class="card-title">分享链接</h5>
                            <p class="card-text text-muted">生成分享链接给朋友</p>
                            <a href="#" class="btn btn-info btn-sm">创建链接</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body text-center">
                            <div class="icon-circle bg-warning text-white mb-3 mx-auto">
                                <i class="fas fa-cog fa-2x"></i>
                            </div>
                            <h5 class="card-title">账户设置</h5>
                            <p class="card-text text-muted">管理您的个人信息</p>
                            <a href="${pageContext.request.contextPath}/user-center.jsp" class="btn btn-warning btn-sm">设置</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
<%--out.println(addpreUrl.addUrl(media.getFilename()));--%>
        <!-- 最近文件和统计信息 -->
        <div class="row">
            <!-- 最近上传的文件 -->
            <div class="col-lg-8 mb-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-bottom-0">
                        <h5 class="mb-0">最近上传的文件</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="thead-light">
                                    <tr>
                                        <th>文件名</th>
                                        <th>类型</th>
                                        <th>大小</th>
                                        <th>上传时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- JSTL<cforEach>标签 -->
                                    <c:forEach var="media" items="${mediaFiles}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${media.fileType == 'image'}">
                                                        <i class="fas fa-image text-primary mr-2"></i>
                                                    </c:when>
                                                    <c:when test="${media.fileType == 'video'}">
                                                        <i class="fas fa-video text-success mr-2"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-file-pdf text-danger mr-2"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="${pageContext.request.contextPath}/filePreview?fileName=${media.filename}&fileType=${media.fileType}" class="stretched-link" alt="点击跳转预览">${media.filename}</a>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${media.fileType == 'image'}">
                                                        <span class="badge badge-primary">图片</span>
                                                    </c:when>
                                                    <c:when test="${media.fileType == 'video'}">
                                                        <span class="badge badge-success">视频</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">文档</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatNumber value="${media.size / 1024 / 1024}" pattern="#.##"/>MB</td>
                                            <td>${media.uploadedAt}</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-secondary" onclick="window.location.href='https://alist.5888888885.xyz/d/cloudflare/${media.filename}'" title="下载">
                                                    <i class="fas fa-download"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" onclick="if(confirm('确认删除吗？')){window.location.href='${pageContext.request.contextPath}//deleteFile?fileName=${media.filename}'}" title="删除">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 统计信息侧边栏 -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white border-bottom-0">
                        <h5 class="mb-0">使用统计</h5>
                    </div>
                    <div class="card-body">
                        <div class="stat-item mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted">总文件数</span>
                                <span class="font-weight-bold">156</span>
                            </div>
                        </div>
                        <div class="stat-item mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted">本月上传</span>
                                <span class="font-weight-bold text-success">23</span>
                            </div>
                        </div>
                        <div class="stat-item mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted">分享次数</span>
                                <span class="font-weight-bold text-info">89</span>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted">下载次数</span>
                                <span class="font-weight-bold text-warning">234</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>


<!-- 先引入jQuery，再引入modal.js -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>

<script>
// 修改后的代码
const contextPath = '${pageContext.request.contextPath}';
const baseUrl = window.location.origin;

$.ajax({
    url: baseUrl + contextPath + '/storSum',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        console.log(data);
        // 修改宽度
        $('.progress-bar[style*="width: 65%"]').css({
            "width": data.storagePercentageStr
        });
        // 若需包含标签（如加粗）
        $(".sotr_sum").html("<strong>" + data.formattedSize + "</strong>");

    },
    error: function(xhr, status, error) {
        console.error('请求失败:', error);
    }
});
</script>
<script src="assets/js/limestart-search-component.js"></script>
</body>
</html>
