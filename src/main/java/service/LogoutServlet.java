package main.java.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 用户登出Servlet
 * 
 * 功能描述：
 * - 处理用户登出请求
 * - 销毁用户Session
 * - 重定向到首页
 * 
 * 支持的请求方式：GET、POST
 * 请求路径：/logout
 * 
 * @author 系统开发者
 * @version 1.0
 * @since 2024
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    /**
     * 处理GET请求 - 用户登出
     * 
     * @param request  HTTP请求对象
     * @param response HTTP响应对象
     * @throws ServletException Servlet异常
     * @throws IOException      IO异常
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleLogout(request, response);
    }

    /**
     * 处理POST请求 - 用户登出
     * 
     * @param request  HTTP请求对象
     * @param response HTTP响应对象
     * @throws ServletException Servlet异常
     * @throws IOException      IO异常
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleLogout(request, response);
    }

    /**
     * 处理登出逻辑的核心方法
     * 
     * @param request  HTTP请求对象
     * @param response HTTP响应对象
     * @throws ServletException Servlet异常
     * @throws IOException      IO异常
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 获取当前Session
            HttpSession session = request.getSession(false);
            
            // 如果Session存在，则销毁它
            if (session != null) {
                session.invalidate();
                System.out.println("用户Session已销毁");
            }
            
            // 重定向到首页（使用动态上下文路径）
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/index.jsp");
            
        } catch (Exception e) {
            // 异常处理：记录错误日志
            e.printStackTrace();
            
            // 即使出现异常，也要尝试重定向到首页
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/index.jsp");
        }
    }
}