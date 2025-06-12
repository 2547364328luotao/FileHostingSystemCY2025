package main.java.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.java.dao.MediaFileDAO;
import main.java.utils.AlistRemove;

import java.io.IOException;

@WebServlet("/deleteFile")
public class DeleteFile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fileName");
        //查询文件是否存在，若存在则删除
        MediaFileDAO mediaFileDAO = new MediaFileDAO();
        if(mediaFileDAO.isFileExists(fileName)){
            AlistRemove alistRemove = new AlistRemove();
            boolean result = alistRemove.removeFile("/cloudflare", fileName);
            //如果删除成功，则删除数据库中的记录
            if(result){
                mediaFileDAO.deleteMediaFile(fileName);
                req.setAttribute("success", "文件删除成功");
            }else {
                req.setAttribute("error", "文件删除失败");
            }
        }else{
            //若不存在，则返回错误信息
            req.setAttribute("error", "文件不存在");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
        //转发到result.jsp
        req.getRequestDispatcher("/userCen.jsp").forward(req, resp);
    }
}
