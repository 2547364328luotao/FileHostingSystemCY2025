package main.java.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import main.java.db.DBUtil;
import main.java.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 用户登录验证Servlet
 * 
 * 功能描述：
 * - 处理用户登录请求
 * - 验证用户名和密码
 * - 返回JSON格式的登录结果
 * 
 * 请求方式：POST
 * 请求路径：/login
 * 请求参数：
 *   - username: 用户名
 *   - password: 密码
 * 
 * 响应格式：JSON
 * 响应示例：
 *   成功：{"status":"success","message":"登录成功"}
 *   失败：{"status":"fail","message":"用户名或密码错误"}
 *   错误：{"status":"error","message":"错误信息"}
 * 
 * @author 系统开发者
 * @version 1.0
 * @since 2024
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //转到POST请求处理方法
        doPost(req, resp);
    }

    /**
     * 处理POST请求 - 用户登录验证
     * 
     * @param request  HTTP请求对象，包含用户提交的登录信息
     * @param response HTTP响应对象，用于返回登录结果
     * @throws ServletException Servlet异常
     * @throws IOException      IO异常
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 设置字符编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        // 设置响应内容类型为JSON格式，编码为UTF-8
        response.setContentType("application/json;charset=UTF-8");
        // 获取输出流，用于向客户端发送响应数据
        PrintWriter out = response.getWriter();

        // 从请求中获取用户提交的登录参数
        String username = request.getParameter("username");  // 用户名
        String password = request.getParameter("password");  // 密码

        // 参数有效性校验：检查用户名和密码是否为空
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            // 返回错误信息：参数不能为空
            out.print("{\"status\":\"error\",\"message\":\"用户名或密码不能为空\"}");
            return;  // 结束方法执行
        }

        // 数据库相关变量初始化
        Connection conn = null;          // 数据库连接对象
        PreparedStatement stmt = null;   // 预编译SQL语句对象
        ResultSet rs = null;            // 查询结果集对象

        try {
            // 获取数据库连接
            conn = DBUtil.getConnection();
            
            // 构建SQL查询语句：根据用户名和密码查询用户信息
            // 使用参数化查询防止SQL注入攻击
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            
            // 创建预编译语句对象
            stmt = conn.prepareStatement(sql);
            
            // 设置SQL参数值
            stmt.setString(1, username);  // 设置第一个参数：用户名
            stmt.setString(2, password);  // 设置第二个参数：密码（注意：生产环境应使用加密密码！）

            // 执行查询语句
            rs = stmt.executeQuery();

            // 判断查询结果：如果有记录则登录成功
            if (rs.next()) {
                // 登录成功：返回成功状态和消息
                out.print("{\"status\":\"success\",\"message\":\"登录成功\"}");
                // 提取用户
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setIsRegular(rs.getBoolean("is_regular"));
                user.setIsEditor(rs.getBoolean("is_editor"));
                user.setIsAdmin(rs.getBoolean("is_admin"));

                // 存储用户user信息到Session
                HttpSession session = request.getSession();
                session.setAttribute("userInfo", user);
            } else {
                // 登录失败：用户名或密码错误
                out.print("{\"status\":\"fail\",\"message\":\"用户名或密码错误\"}");
            }
            
        } catch (Exception e) {
            // 异常处理：记录错误日志并返回服务器异常信息
            e.printStackTrace();  // 打印异常堆栈信息到控制台
            out.print("{\"status\":\"error\",\"message\":\"服务器异常\"}");
            
        } finally {
            // 资源清理：关闭数据库连接和相关对象
            // 按照ResultSet -> PreparedStatement -> Connection的顺序关闭
            DBUtil.close(rs, stmt, conn);
        }
    }


}
