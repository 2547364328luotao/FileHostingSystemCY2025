package main.java.model;

import java.sql.Timestamp;
import java.util.Objects;

/**
 * 用户实体类 - 对应数据库users表
 *
 * 表结构：
 * - id: 用户唯一标识（主键，自增）
 * - username: 用户名（唯一，非空）
 * - password: 密码（非空）
 * - email: 邮箱地址（可为空）
 * - created_at: 创建时间（默认当前时间）
 * - is_regular: 普通用户标识（默认true）
 * - is_editor: 编辑者标识（默认false）
 * - is_admin: 管理员标识（默认false）
 *
 * @author 系统开发者
 * @version 2.0
 * @since 2024
 */
public class User {

    /**
     * 用户ID - 主键，自增
     */
    private Integer id;

    /**
     * 用户名 - 唯一标识，最大长度50字符
     */
    private String username;

    /**
     * 密码 - 最大长度255字符（建议存储加密后的密码）
     */
    private String password;

    /**
     * 邮箱地址 - 最大长度100字符，可为空
     */
    private String email;

    /**
     * 创建时间 - 记录用户注册时间
     */
    private Timestamp createdAt;

    /**
     * 普通用户标识 - 默认true
     */
    private Boolean isRegular;

    /**
     * 编辑者标识 - 默认false
     */
    private Boolean isEditor;

    /**
     * 管理员标识 - 默认false
     */
    private Boolean isAdmin;

    /**
     * 默认构造函数
     */
    public User() {
        this.isRegular = true;
        this.isEditor = false;
        this.isAdmin = false;
    }

    /**
     * 带参数的构造函数（不包含ID，用于新用户注册）
     *
     * @param username 用户名
     * @param password 密码
     * @param email 邮箱地址
     */
    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.isRegular = true;
        this.isEditor = false;
        this.isAdmin = false;
    }

    /**
     * 完整的构造函数
     *
     * @param id 用户ID
     * @param username 用户名
     * @param password 密码
     * @param email 邮箱地址
     * @param createdAt 创建时间
     * @param isRegular 普通用户标识
     * @param isEditor 编辑者标识
     * @param isAdmin 管理员标识
     */
    public User(Integer id, String username, String password, String email,
                Timestamp createdAt, Boolean isRegular, Boolean isEditor, Boolean isAdmin) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.createdAt = createdAt;
        this.isRegular = isRegular != null ? isRegular : true;
        this.isEditor = isEditor != null ? isEditor : false;
        this.isAdmin = isAdmin != null ? isAdmin : false;
    }

    // ==================== Getter 和 Setter 方法 ====================

    /**
     * 获取用户ID
     *
     * @return 用户ID
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置用户ID
     *
     * @param id 用户ID
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取用户名
     *
     * @return 用户名
     */
    public String getUsername() {
        return username;
    }

    /**
     * 设置用户名
     *
     * @param username 用户名
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * 获取密码
     *
     * @return 密码
     */
    public String getPassword() {
        return password;
    }

    /**
     * 设置密码
     *
     * @param password 密码
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * 获取邮箱地址
     *
     * @return 邮箱地址
     */
    public String getEmail() {
        return email;
    }

    /**
     * 设置邮箱地址
     *
     * @param email 邮箱地址
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * 获取创建时间
     *
     * @return 创建时间
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * 设置创建时间
     *
     * @param createdAt 创建时间
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * 获取普通用户标识
     *
     * @return 普通用户标识
     */
    public Boolean getIsRegular() {
        return isRegular;
    }

    /**
     * 设置普通用户标识
     *
     * @param isRegular 普通用户标识
     */
    public void setIsRegular(Boolean isRegular) {
        this.isRegular = isRegular;
    }

    /**
     * 获取编辑者标识
     *
     * @return 编辑者标识
     */
    public Boolean getIsEditor() {
        return isEditor;
    }

    /**
     * 设置编辑者标识
     *
     * @param isEditor 编辑者标识
     */
    public void setIsEditor(Boolean isEditor) {
        this.isEditor = isEditor;
    }

    /**
     * 获取管理员标识
     *
     * @return 管理员标识
     */
    public Boolean getIsAdmin() {
        return isAdmin;
    }

    /**
     * 设置管理员标识
     *
     * @param isAdmin 管理员标识
     */
    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    // ==================== 角色相关的便捷方法 ====================

    /**
     * 检查用户是否为普通用户
     *
     * @return 如果是普通用户返回true
     */
    public boolean isRegularUser() {
        return Boolean.TRUE.equals(isRegular);
    }

    /**
     * 检查用户是否为编辑者
     *
     * @return 如果是编辑者返回true
     */
    public boolean isEditorUser() {
        return Boolean.TRUE.equals(isEditor);
    }

    /**
     * 检查用户是否为管理员
     *
     * @return 如果是管理员返回true
     */
    public boolean isAdminUser() {
        return Boolean.TRUE.equals(isAdmin);
    }

    /**
     * 获取用户角色描述
     *
     * @return 角色描述字符串
     */
    public String getRoleDescription() {
        if (isAdminUser()) {
            return "管理员";
        } else if (isEditorUser()) {
            return "编辑者";
        } else if (isRegularUser()) {
            return "普通用户";
        } else {
            return "未知角色";
        }
    }

    /**
     * 设置用户为普通用户
     */
    public void setAsRegularUser() {
        this.isRegular = true;
        this.isEditor = false;
        this.isAdmin = false;
    }

    /**
     * 设置用户为编辑者
     */
    public void setAsEditor() {
        this.isRegular = true;
        this.isEditor = true;
        this.isAdmin = false;
    }

    /**
     * 设置用户为管理员
     */
    public void setAsAdmin() {
        this.isRegular = true;
        this.isEditor = true;
        this.isAdmin = true;
    }

    // ==================== 工具方法 ====================

    /**
     * 判断两个User对象是否相等
     * 主要基于ID和用户名进行比较
     *
     * @param obj 要比较的对象
     * @return 如果相等返回true，否则返回false
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        User user = (User) obj;
        return Objects.equals(id, user.id) &&
                Objects.equals(username, user.username);
    }

    /**
     * 生成对象的哈希码
     *
     * @return 哈希码
     */
    @Override
    public int hashCode() {
        return Objects.hash(id, username);
    }

    /**
     * 返回对象的字符串表示
     * 注意：不包含密码信息，保护用户隐私
     *
     * @return 字符串表示
     */
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", createdAt=" + createdAt +
                ", isRegular=" + isRegular +
                ", isEditor=" + isEditor +
                ", isAdmin=" + isAdmin +
                ", role='" + getRoleDescription() + '\'' +
                '}';
    }

    /**
     * 验证用户数据的有效性
     *
     * @return 如果数据有效返回true，否则返回false
     */
    public boolean isValid() {
        return username != null && !username.trim().isEmpty() &&
                password != null && !password.trim().isEmpty() &&
                username.length() <= 50 &&
                password.length() <= 255 &&
                (email == null || email.length() <= 100) &&
                isRegular != null && isEditor != null && isAdmin != null;
    }

    /**
     * 检查是否为新用户（ID为空）
     *
     * @return 如果是新用户返回true，否则返回false
     */
    public boolean isNewUser() {
        return id == null;
    }

    /**
     * 获取用户显示名称（用于前端显示）
     *
     * @return 显示名称
     */
    public String getDisplayName() {
        return username != null ? username : "未知用户";
    }

    /**
     * 获取完整的用户显示信息（包含角色）
     *
     * @return 完整显示信息
     */
    public String getFullDisplayName() {
        return getDisplayName() + " (" + getRoleDescription() + ")";
    }
}