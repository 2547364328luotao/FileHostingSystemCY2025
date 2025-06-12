// 图片库弹窗功能
class ImageGallery {
    constructor() {
        this.images = [];
        this.currentImageIndex = 0;
        this.init();
    }

    loadImagesWithJQuery() {
        this.showLoading(true);
        
        // 动态获取上下文路径
        const contextPath = this.getContextPath();
        const baseUrl = window.location.origin;
        const apiUrl = `${baseUrl}${contextPath}/listimage`;
        
        console.log('上下文路径:', contextPath);
        console.log('发送AJAX请求到:', apiUrl);
        
        $.ajax({
            url: apiUrl,
            method: 'GET',
            dataType: 'json',
            timeout: 10000,
            success: (data) => {
                console.log('AJAX请求成功，返回数据:', data);
                if (Array.isArray(data) && data.length > 0) {
                    this.images = data.filter(url => 
                        typeof url === 'string' && 
                        url.trim() !== '' && 
                        this.isValidImageUrl(url)
                    );
                    console.log(`成功加载 ${this.images.length} 个媒体文件`);
                } else {
                    this.images = [];
                    console.warn('返回的数据为空或格式不正确');
                }
                this.showLoading(false);
            },
            error: (xhr, status, error) => {
                this.showLoading(false);
                
                console.error('AJAX请求失败:', {
                    url: apiUrl,
                    status: xhr.status,
                    statusText: xhr.statusText,
                    error: error,
                    responseText: xhr.responseText
                });
                
                if (status === 'timeout') {
                    console.error('请求超时，请检查网络连接');
                } else {
                    console.error('AJAX 错误:', {
                        status: xhr.status,
                        statusText: xhr.statusText,
                        error: error
                    });
                }
                
                this.loadDefaultImages();
            }
        });
    }

    // 显示加载状态
    showLoading(show) {
        // 可以在这里添加加载动画的显示/隐藏逻辑
        if (show) {
            console.log('开始加载图片...');
        } else {
            console.log('图片加载完成');
        }
    }

    // 验证图片URL
    isValidImageUrl(url) {
        const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
        return imageExtensions.some(ext => url.toLowerCase().includes(ext));
    }

    // 加载默认图片
    loadDefaultImages() {
        console.log('加载默认图片...');
        this.images = [];
    }

    // 动态获取上下文路径
    getContextPath() {
        // 方法1: 从当前页面的script标签src属性中提取
        const scripts = document.getElementsByTagName('script');
        for (let script of scripts) {
            if (script.src && script.src.includes('/assets/js/modal.js')) {
                const srcPath = script.src;
                const pathMatch = srcPath.match(/^https?:\/\/[^/]+(\/[^/]*)\/assets\/js\/modal\.js/);
                if (pathMatch) {
                    return pathMatch[1];
                }
            }
        }
        
        // 方法2: 从当前URL路径中推断
        const pathname = window.location.pathname;
        const pathSegments = pathname.split('/').filter(segment => segment);
        
        // 如果路径包含常见的JSP文件，取第一个路径段作为上下文
        if (pathSegments.length > 0 && 
            (pathname.includes('.jsp') || pathname.includes('/pages/') || pathname.includes('/assets/'))) {
            return '/' + pathSegments[0];
        }
        
        // 方法3: 从页面中的其他链接推断上下文路径
        const links = document.querySelectorAll('link[href*="/assets/"], script[src*="/assets/"]');
        for (let link of links) {
            const href = link.href || link.src;
            if (href) {
                const match = href.match(/^https?:\/\/[^/]+(\/[^/]*)\/assets\//); 
                if (match) {
                    return match[1];
                }
            }
        }
        
        // 方法4: 尝试从meta标签获取（如果页面设置了的话）
        const contextMeta = document.querySelector('meta[name="context-path"]');
        if (contextMeta) {
            return contextMeta.getAttribute('content');
        }
        
        // 默认返回空字符串（根目录部署）
        console.warn('无法自动检测上下文路径，使用默认值');
        return '';
    }

    init() {
        this.bindEvents();
        this.preloadImages();
    }

    // 绑定事件
    bindEvents() {
        // 打开画廊按钮
        const openBtn = document.getElementById('openGallery');
        if (openBtn) {
            openBtn.addEventListener('click', () => this.openGallery());
        }

        // 关闭按钮事件
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('close')) {
                this.closeModal(e.target.closest('.modal'));
            }
        });

        // 点击遮罩层关闭
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('modal-overlay')) {
                this.closeModal(e.target.closest('.modal'));
            }
        });

        // 键盘事件
        document.addEventListener('keydown', (e) => this.handleKeydown(e));

        // 导航按钮事件
        const prevBtn = document.querySelector('.prev-btn');
        const nextBtn = document.querySelector('.next-btn');
        
        if (prevBtn) {
            prevBtn.addEventListener('click', () => this.showPrevImage());
        }
        
        if (nextBtn) {
            nextBtn.addEventListener('click', () => this.showNextImage());
        }
    }

    // 预加载图片
    preloadImages() {
        this.images.forEach(src => {
            const img = new Image();
            img.src = src;
        });
    }

    // 打开画廊
    openGallery() {
        const modal = document.getElementById('galleryModal');
        const container = document.getElementById('imageContainer');

        if (!modal || !container) {
            console.error('画廊元素未找到');
            return;
        }

        // 如果还没有加载图片，先加载图片
        if (this.images.length === 0) {
            console.log('开始加载图片...');
            this.loadImagesWithJQuery();
            // 延迟打开画廊，等待图片加载
            setTimeout(() => {
                this.displayGallery(modal, container);
            }, 1000);
        } else {
            this.displayGallery(modal, container);
        }
    }

    // 显示画廊内容
    displayGallery(modal, container) {
        // 清空容器
        container.innerHTML = '';

        if (this.images.length === 0) {
            container.innerHTML = '<p style="text-align: center; color: #666; padding: 20px;">暂无图片</p>';
        } else {
            // 生成图片元素
            this.images.forEach((src, index) => {
                const img = document.createElement('img');
                img.src = src;
                img.alt = `图片 ${index + 1}`;
                img.loading = 'lazy';
                img.addEventListener('click', () => this.expandImage(index));

                // 图片加载错误处理
                img.addEventListener('error', () => {
                    img.style.display = 'none';
                    console.warn(`图片加载失败: ${src}`);
                });

                container.appendChild(img);
            });
        }

        this.showModal(modal);
    }

    // 展开大图
    expandImage(index) {
        this.currentImageIndex = index;
        const modal = document.getElementById('imageModal');
        const img = modal.querySelector('.modal-content');
        
        if (!modal || !img) {
            console.error('大图预览元素未找到');
            return;
        }

        img.src = this.images[index];
        img.alt = `图片 ${index + 1}`;
        
        // 图片加载错误处理
        img.addEventListener('error', () => {
            img.alt = '图片加载失败';
            console.warn(`大图加载失败: ${this.images[index]}`);
        });

        this.showModal(modal);
        
        // 关闭画廊模态框
        const galleryModal = document.getElementById('galleryModal');
        if (galleryModal) {
            this.closeModal(galleryModal);
        }
    }

    // 显示上一张图片
    showPrevImage() {
        this.currentImageIndex = (this.currentImageIndex - 1 + this.images.length) % this.images.length;
        this.updateCurrentImage();
    }

    // 显示下一张图片
    showNextImage() {
        this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
        this.updateCurrentImage();
    }

    // 更新当前显示的图片
    updateCurrentImage() {
        const img = document.querySelector('#imageModal .modal-content');
        if (img) {
            img.src = this.images[this.currentImageIndex];
            img.alt = `图片 ${this.currentImageIndex + 1}`;
        }
    }

    // 显示模态框
    showModal(modal) {
        if (modal) {
            modal.style.display = 'flex';
            modal.classList.add('show');
            document.body.style.overflow = 'hidden';
            
            // 添加动画延迟
            setTimeout(() => {
                modal.style.opacity = '1';
            }, 10);
        }
    }

    // 关闭模态框
    closeModal(modal) {
        if (modal) {
            modal.style.opacity = '0';
            
            setTimeout(() => {
                modal.style.display = 'none';
                modal.classList.remove('show');
                document.body.style.overflow = 'auto';
            }, 300);
        }
    }

    // 键盘事件处理
    handleKeydown(e) {
        const imageModal = document.getElementById('imageModal');
        const galleryModal = document.getElementById('galleryModal');
        
        // ESC键关闭模态框
        if (e.key === 'Escape') {
            if (imageModal && imageModal.classList.contains('show')) {
                this.closeModal(imageModal);
            } else if (galleryModal && galleryModal.classList.contains('show')) {
                this.closeModal(galleryModal);
            }
        }
        
        // 在大图预览模式下的导航
        if (imageModal && imageModal.classList.contains('show')) {
            if (e.key === 'ArrowLeft') {
                e.preventDefault();
                this.showPrevImage();
            } else if (e.key === 'ArrowRight') {
                e.preventDefault();
                this.showNextImage();
            }
        }
    }

    // 添加新图片到画廊
    addImage(src) {
        if (src && !this.images.includes(src)) {
            this.images.push(src);
            this.preloadImages();
        }
    }

    // 移除图片
    removeImage(index) {
        if (index >= 0 && index < this.images.length) {
            this.images.splice(index, 1);
            
            // 调整当前图片索引
            if (this.currentImageIndex >= this.images.length) {
                this.currentImageIndex = this.images.length - 1;
            }
        }
    }

    // 获取当前图片信息
    getCurrentImageInfo() {
        return {
            index: this.currentImageIndex,
            src: this.images[this.currentImageIndex],
            total: this.images.length
        };
    }
}

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', () => {
    window.imageGallery = new ImageGallery();
});

// 导出供外部使用
if (typeof module !== 'undefined' && module.exports) {
    module.exports = ImageGallery;
}

