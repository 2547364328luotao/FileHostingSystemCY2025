package main.java.controller;

import com.alibaba.fastjson.JSON;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import main.java.dao.MediaFileDAO;
import main.java.model.MediaFile;
import main.java.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/listimage")
public class ListImage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //响应json格式数据
        resp.setContentType("application/json;charset=utf-8");
        MediaFileDAO mediaFileDAO = new MediaFileDAO();
        // 获取对象属性
        HttpSession session = req.getSession(false);
        User user =(User) session.getAttribute("userInfo");
        List<MediaFile> mediaFilesByUserId = mediaFileDAO.getMediaFilesByUserId(user.getId());

        //定义图片url数组
        String[] previewUrls = new String[mediaFilesByUserId.size()];
        //for遍历mediaFilesByUserId，将MediaFile中的previewUrl,用foreach循环赋值给previewUrls数组
        for (int i = 0; i < mediaFilesByUserId.size(); i++) {
            if("image".equals(mediaFilesByUserId.get(i).getFileType())){
                previewUrls[i] = mediaFilesByUserId.get(i).getPreviewUrl();
            }

        }
        String jsonString = JSON.toJSONString(previewUrls);
        resp.getWriter().write(jsonString);
    }
}
