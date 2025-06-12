package main.java.controller;

import com.alibaba.fastjson.JSON;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.java.dao.MediaFileDAO;
import main.java.model.MediaFile;

import java.io.IOException;
import java.util.List;

@WebServlet("/fileQuery")
public class FileQuery extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //响应json格式
        resp.setContentType("application/json;charset=utf-8");
        //获取查询参数
        String query = req.getParameter("query");
        //查询数据库
        MediaFileDAO mediaFileDAO = new MediaFileDAO();
        List<MediaFile> dsad = mediaFileDAO.searchMediaFilesByName(query);

        //将数据转换为json格式
        String jsonString = JSON.toJSONString(dsad);
        //输出json格式数据
        resp.getWriter().write(jsonString);

    }
}
