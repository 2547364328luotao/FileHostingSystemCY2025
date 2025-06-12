package main.java.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/filePreview")
public class FilePreview extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获取文件名
        String fileName = req.getParameter("fileName");
        //获取文件类型
        String fileType = req.getParameter("fileType");
        // 完整文件路径
        String filePath = "https://alist.5888888885.xyz/d/cloudflare/" + fileName;
        //将文件路径和文件类型写入到request作用域中
        req.setAttribute("filePath", filePath);
        req.setAttribute("fileType", fileType);
        //转发到filePreview.jsp页面
        req.getRequestDispatcher("/preview.jsp").forward(req, resp);
    }
}
