/**
 * Limestart 搜索组件
 * 功能：实现文件搜索功能，包括搜索输入、API调用、结果展示等
 * 依赖：jQuery
 */
$(document).ready(function() {
    // ========== DOM 元素选择器定义 ==========
    
    // 搜索输入框元素
    const $searchInput = $('.limestart-search-input');
    
    // 背景模糊效果元素（用于搜索时的视觉效果）
    const $backdropBlurElement = $('.limestart-backdrop-blur');
    
    // 搜索表单容器
    const $searchBox = $('.limestart-search-box');
    
    // 搜索按钮
    const $searchBtn = $('.limestart-search-btn');
    
    // 搜索结果模态框
    const $modal = $('#limestart-search-results-modal');
    
    // 模态框中显示数据的容器
    const $modalData = $('#limestart-modal-data');
    
    // 模态框关闭按钮
    const $closeBtn = $('.limestart-close-btn');
    
    // 注释：这些变量应该在其他地方定义
    // const contextPath = '${pageContext.request.contextPath}'; // 应用上下文路径
    // const baseUrl = window.location.origin; // 基础URL

    // ========== 核心搜索功能函数 ==========
    
    /**
     * 渲染搜索结果为HTML格式
     * 功能：将JSON数据转换为带样式的HTML展示
     * @param {Array} data - 搜索结果数据数组
     * @returns {string} - 格式化的HTML字符串
     */
    function renderSearchResults(data) {
        if (!data || !Array.isArray(data) || data.length === 0) {
            return '<div class="no-results">没有找到相关文件</div>';
        }
        
        let html = '<div class="search-results-container">';
        html += '<style>';
        html += `
            .search-results-container {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                max-height: 500px;
                overflow-y: auto;
                padding: 10px;
            }
            .file-item {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                margin-bottom: 15px;
                padding: 15px;
                background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .file-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            }
            .file-header {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            .file-icon {
                width: 32px;
                height: 32px;
                margin-right: 12px;
                border-radius: 4px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                color: white;
                font-size: 12px;
            }
            .file-icon.image { background: linear-gradient(45deg, #4CAF50, #45a049); }
            .file-icon.video { background: linear-gradient(45deg, #2196F3, #1976D2); }
            .file-icon.audio { background: linear-gradient(45deg, #FF9800, #F57C00); }
            .file-icon.other { background: linear-gradient(45deg, #9E9E9E, #757575); }
            .file-name {
                font-size: 16px;
                font-weight: 600;
                color: #333;
                flex: 1;
                word-break: break-all;
            }
            .file-details {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
                margin-bottom: 10px;
            }
            .detail-item {
                display: flex;
                align-items: center;
            }
            .detail-label {
                font-weight: 500;
                color: #666;
                margin-right: 8px;
                min-width: 60px;
            }
            .detail-value {
                color: #333;
                font-family: monospace;
                background: #f5f5f5;
                padding: 2px 6px;
                border-radius: 3px;
                font-size: 12px;
            }
            .file-path {
                background: #e3f2fd;
                padding: 8px;
                border-radius: 4px;
                font-family: monospace;
                font-size: 12px;
                color: #1976d2;
                margin-bottom: 10px;
                word-break: break-all;
            }
            .preview-link {
                display: inline-block;
                background: linear-gradient(45deg, #007bff, #0056b3);
                color: white;
                padding: 8px 16px;
                text-decoration: none;
                border-radius: 4px;
                font-size: 12px;
                transition: background 0.2s ease;
            }
            .preview-link:hover {
                background: linear-gradient(45deg, #0056b3, #004085);
                color: white;
                text-decoration: none;
            }
            .upload-time {
                color: #888;
                font-size: 11px;
                margin-top: 5px;
            }
            .no-results {
                text-align: center;
                color: #666;
                font-size: 16px;
                padding: 40px;
            }
        `;
        html += '</style>';
        
        data.forEach(file => {
            const uploadDate = new Date(file.uploadedAt).toLocaleString('zh-CN');
            const fileTypeClass = file.image ? 'image' : file.video ? 'video' : file.audio ? 'audio' : 'other';
            const fileTypeText = file.image ? 'IMG' : file.video ? 'VID' : file.audio ? 'AUD' : 'FILE';
            
            html += `
                <div class="file-item">
                    <div class="file-header">
                        <div class="file-icon ${fileTypeClass}">${fileTypeText}</div>
                        <div class="file-name">${file.filename}</div>
                    </div>
                    <div class="file-path">📁 ${file.alistPath}</div>
                    <div class="file-details">
                        <div class="detail-item">
                            <span class="detail-label">类型:</span>
                            <span class="detail-value">${file.fileType}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">大小:</span>
                            <span class="detail-value">${file.formattedSize}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">扩展名:</span>
                            <span class="detail-value">${file.fileExtension}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">用户ID:</span>
                            <span class="detail-value">${file.userId}</span>
                        </div>
                    </div>
                    <a href="${file.previewUrl}" target="_blank" class="preview-link">🔗 预览文件</a>
                    <div class="upload-time">📅 上传时间: ${uploadDate}</div>
                </div>
            `;
        });
        
        html += '</div>';
        return html;
    }
    
    /**
     * 执行搜索操作的核心函数
     * 功能：
     * 1. 获取搜索关键词
     * 2. 构建API请求URL
     * 3. 发送AJAX请求到后端
     * 4. 处理搜索结果并显示在模态框中
     */
    function performLimestartSearch() {
        // 获取搜索输入框的值并去除首尾空格
        const searchTerm = $searchInput.val().trim();
        
        // 只有当搜索词不为空时才执行搜索
        if (searchTerm) {
            // 构建完整的API请求URL
            // 格式：baseUrl + contextPath + '/fileQuery'
            const apiUrl = baseUrl + contextPath + '/fileQuery';

            // 控制台输出搜索信息，用于调试
            console.log('Searching for:', searchTerm, 'via API:', apiUrl);
            
            // 发送AJAX请求到后端搜索API
            $.ajax({
                url: apiUrl,                    // 请求URL
                method: 'GET',                  // 请求方法
                data: { query: searchTerm },    // 请求参数：搜索关键词
                dataType: 'json',              // 期望的响应数据类型
                
                // 请求成功时的回调函数
                success: function(data) {
                    // 输出API响应数据到控制台，用于调试
                    console.log('API Response:', data);
                    
                    // 解析JSON数据并渲染为带样式的HTML
                    const htmlContent = renderSearchResults(data);
                    $modalData.html(htmlContent);
                    
                    // 显示搜索结果模态框
                    $modal.show();
                },
                
                // 请求失败时的回调函数
                error: function(jqXHR, textStatus, errorThrown) {
                    // 输出错误信息到控制台，包含详细的错误信息
                    console.error('Search API Error:', textStatus, errorThrown, jqXHR.responseText);
                }
            });
        }
    }

    // ========== 搜索触发事件绑定 ==========
    
    /**
     * 搜索表单提交事件处理
     * 当用户提交搜索表单时触发搜索
     */
    $searchBox.on('submit', function(e) {
        e.preventDefault();           // 阻止表单默认提交行为
        performLimestartSearch();     // 执行搜索
    });

    /**
     * 搜索按钮点击事件处理
     * 当用户点击搜索按钮时触发搜索
     */
    $searchBtn.on('click', function(e) {
        e.preventDefault();           // 阻止按钮默认行为
        performLimestartSearch();     // 执行搜索
    });

    /**
     * 搜索输入框按键事件处理
     * 当用户在搜索框中按下回车键时触发搜索
     */
    $searchInput.on('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();       // 阻止回车键的默认行为
            performLimestartSearch(); // 执行搜索
        }
    });

    // ========== 搜索框焦点状态视觉效果 ==========
    
    /**
     * 搜索输入框获得焦点时的处理
     * 功能：切换背景模糊效果的CSS类，创建聚焦的视觉效果
     */
    $searchInput.on('focus', function() {
        // 移除未聚焦状态的CSS类，添加聚焦状态的CSS类
        $backdropBlurElement.removeClass('unfocused').addClass('focused');
    });

    /**
     * 搜索输入框失去焦点时的处理
     * 功能：延迟切换背景模糊效果，避免快速切换时的闪烁
     */
    $searchInput.on('blur', function() {
        // 设置150毫秒延迟，确保用户操作的流畅性
        // 这个延迟可以避免用户快速点击其他元素时的视觉闪烁
        setTimeout(() => {
            // 移除聚焦状态的CSS类，添加未聚焦状态的CSS类
            $backdropBlurElement.removeClass('focused').addClass('unfocused');
        }, 150);
    });

    // ========== 模态框关闭事件处理 ==========
    
    /**
     * 关闭模态框的通用函数
     * 功能：隐藏模态框并恢复页面滚动
     */
    function closeModal() {
        $modal.hide();  // 隐藏模态框
        $('body').removeClass('modal-open');  // 恢复页面滚动
    }

    /**
     * 关闭按钮点击事件处理
     * 功能：当用户点击模态框的关闭按钮时，隐藏搜索结果模态框
     */
    $closeBtn.on('click', function() {
        closeModal();
    });

    /**
     * 模态框外部区域点击事件处理
     * 功能：当用户点击模态框外部区域时，自动关闭模态框
     * 这是常见的模态框交互模式，提升用户体验
     */
    $(window).on('click', function(event) {
        // 检查点击的目标是否是模态框本身（而不是模态框内的内容）
        if (event.target == $modal[0]) {
            closeModal();
        }
    });
    
    // ========== 组件初始化完成 ==========
    // 所有事件监听器已绑定，搜索组件准备就绪
    
}); // $(document).ready() 结束