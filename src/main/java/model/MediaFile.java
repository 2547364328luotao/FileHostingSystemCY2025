package main.java.model;

import java.sql.Timestamp;
import java.util.Objects;

/**
 * MediaFile实体类 - 对应数据库media_files表
 * 
 * 表结构：
 * - id: 文件唯一标识（主键，自增）
 * - user_id: 用户ID（外键，关联users表）
 * - filename: 文件名（非空）
 * - file_type: 文件类型（枚举：image, video, audio, other）
 * - size: 文件大小（字节）
 * - alist_path: Alist文件路径（非空）
 * - preview_url: 预览URL（可为空）
 * - uploaded_at: 上传时间（默认当前时间）
 * 
 * @author 系统开发者
 * @version 1.0
 * @since 2024
 */
public class MediaFile {
    
    /**
     * 文件ID - 主键，自增
     */
    private Integer id;
    
    /**
     * 用户ID - 外键，关联users表
     */
    private Integer userId;
    
    /**
     * 文件名 - 最大长度255字符
     */
    private String filename;
    
    /**
     * 文件类型 - 枚举值：image, video, audio, other
     */
    private String fileType;
    
    /**
     * 文件大小 - 以字节为单位
     */
    private Long size;
    
    /**
     * Alist文件路径 - 完整的文件路径
     */
    private String alistPath;
    
    /**
     * 预览URL - 用于直接访问文件的URL
     */
    private String previewUrl;
    
    /**
     * 上传时间 - 记录文件上传时间
     */
    private Timestamp uploadedAt;
    
    /**
     * 默认构造函数
     */
    public MediaFile() {
    }
    
    /**
     * 带参数的构造函数（不包含ID和时间戳，用于新文件上传）
     * 
     * @param userId 用户ID
     * @param filename 文件名
     * @param fileType 文件类型
     * @param size 文件大小
     * @param alistPath Alist路径
     * @param previewUrl 预览URL
     */
    public MediaFile(Integer userId, String filename, String fileType, Long size, String alistPath, String previewUrl) {
        this.userId = userId;
        this.filename = filename;
        this.fileType = fileType;
        this.size = size;
        this.alistPath = alistPath;
        this.previewUrl = previewUrl;
    }
    
    /**
     * 完整的构造函数
     * 
     * @param id 文件ID
     * @param userId 用户ID
     * @param filename 文件名
     * @param fileType 文件类型
     * @param size 文件大小
     * @param alistPath Alist路径
     * @param previewUrl 预览URL
     * @param uploadedAt 上传时间
     */
    public MediaFile(Integer id, Integer userId, String filename, String fileType, Long size, 
                     String alistPath, String previewUrl, Timestamp uploadedAt) {
        this.id = id;
        this.userId = userId;
        this.filename = filename;
        this.fileType = fileType;
        this.size = size;
        this.alistPath = alistPath;
        this.previewUrl = previewUrl;
        this.uploadedAt = uploadedAt;
    }
    
    // ==================== Getter 和 Setter 方法 ====================
    
    /**
     * 获取文件ID
     * 
     * @return 文件ID
     */
    public Integer getId() {
        return id;
    }
    
    /**
     * 设置文件ID
     * 
     * @param id 文件ID
     */
    public void setId(Integer id) {
        this.id = id;
    }
    
    /**
     * 获取用户ID
     * 
     * @return 用户ID
     */
    public Integer getUserId() {
        return userId;
    }
    
    /**
     * 设置用户ID
     * 
     * @param userId 用户ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    /**
     * 获取文件名
     * 
     * @return 文件名
     */
    public String getFilename() {
        return filename;
    }
    
    /**
     * 设置文件名
     * 
     * @param filename 文件名
     */
    public void setFilename(String filename) {
        this.filename = filename;
    }
    
    /**
     * 获取文件类型
     * 
     * @return 文件类型
     */
    public String getFileType() {
        return fileType;
    }
    
    /**
     * 设置文件类型
     * 
     * @param fileType 文件类型（image, video, audio, other）
     */
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
    
    /**
     * 获取文件大小
     * 
     * @return 文件大小（字节）
     */
    public Long getSize() {
        return size;
    }
    
    /**
     * 设置文件大小
     * 
     * @param size 文件大小（字节）
     */
    public void setSize(Long size) {
        this.size = size;
    }
    
    /**
     * 获取Alist路径
     * 
     * @return Alist路径
     */
    public String getAlistPath() {
        return alistPath;
    }
    
    /**
     * 设置Alist路径
     * 
     * @param alistPath Alist路径
     */
    public void setAlistPath(String alistPath) {
        this.alistPath = alistPath;
    }
    
    /**
     * 获取预览URL
     * 
     * @return 预览URL
     */
    public String getPreviewUrl() {
        return previewUrl;
    }
    
    /**
     * 设置预览URL
     * 
     * @param previewUrl 预览URL
     */
    public void setPreviewUrl(String previewUrl) {
        this.previewUrl = previewUrl;
    }
    
    /**
     * 获取上传时间
     * 
     * @return 上传时间
     */
    public Timestamp getUploadedAt() {
        return uploadedAt;
    }
    
    /**
     * 设置上传时间
     * 
     * @param uploadedAt 上传时间
     */
    public void setUploadedAt(Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
    
    // ==================== 工具方法 ====================
    
    /**
     * 获取格式化的文件大小
     * 
     * @return 格式化的文件大小字符串
     */
    public String getFormattedSize() {
        if (size == null) {
            return "未知";
        }
        
        if (size < 1024) {
            return size + " B";
        } else if (size < 1024 * 1024) {
            return String.format("%.2f KB", size / 1024.0);
        } else if (size < 1024 * 1024 * 1024) {
            return String.format("%.2f MB", size / (1024.0 * 1024.0));
        } else {
            return String.format("%.2f GB", size / (1024.0 * 1024.0 * 1024.0));
        }
    }
    
    /**
     * 获取文件扩展名
     * 
     * @return 文件扩展名（小写）
     */
    public String getFileExtension() {
        if (filename == null || filename.isEmpty()) {
            return "";
        }
        
        int dotIndex = filename.lastIndexOf('.');
        if (dotIndex >= 0 && dotIndex < filename.length() - 1) {
            return filename.substring(dotIndex + 1).toLowerCase();
        }
        
        return "";
    }
    
    /**
     * 检查是否为图片文件
     * 
     * @return 是否为图片
     */
    public boolean isImage() {
        return "image".equals(fileType);
    }
    
    /**
     * 检查是否为视频文件
     * 
     * @return 是否为视频
     */
    public boolean isVideo() {
        return "video".equals(fileType);
    }
    
    /**
     * 检查是否为音频文件
     * 
     * @return 是否为音频
     */
    public boolean isAudio() {
        return "audio".equals(fileType);
    }
    
    /**
     * 检查文件信息是否有效
     * 
     * @return 是否有效
     */
    public boolean isValid() {
        return userId != null && userId > 0 &&
               filename != null && !filename.trim().isEmpty() &&
               fileType != null && !fileType.trim().isEmpty() &&
               size != null && size >= 0 &&
               alistPath != null && !alistPath.trim().isEmpty();
    }
    
    // ==================== Object 方法重写 ====================
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        MediaFile mediaFile = (MediaFile) obj;
        return Objects.equals(id, mediaFile.id) &&
               Objects.equals(userId, mediaFile.userId) &&
               Objects.equals(filename, mediaFile.filename) &&
               Objects.equals(fileType, mediaFile.fileType) &&
               Objects.equals(size, mediaFile.size) &&
               Objects.equals(alistPath, mediaFile.alistPath) &&
               Objects.equals(previewUrl, mediaFile.previewUrl) &&
               Objects.equals(uploadedAt, mediaFile.uploadedAt);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, userId, filename, fileType, size, alistPath, previewUrl, uploadedAt);
    }
    
    @Override
    public String toString() {
        return "MediaFile{" +
                "id=" + id +
                ", userId=" + userId +
                ", filename='" + filename + '\'' +
                ", fileType='" + fileType + '\'' +
                ", size=" + size +
                ", alistPath='" + alistPath + '\'' +
                ", previewUrl='" + previewUrl + '\'' +
                ", uploadedAt=" + uploadedAt +
                '}';
    }
}