package main.java.controller;

import com.alibaba.fastjson.JSON;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.java.db.StorageStats;

import java.io.IOException;

@WebServlet("/storSum")
public class StorageSum extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //响应json格式数据
        resp.setContentType("application/json;charset=utf-8");
        StorageStats storageStats = new StorageStats();
        //获取总存储空间使用量-字节
        long totalStorageUsed = storageStats.getTotalStorageUsed();
        //转换为易读单位
        String formattedSize = storageStats.formatSize(totalStorageUsed);
        //存储情况百分比 - 将 10737418240 明确声明为 long 类型
        // 假设总容量为10GB，计算百分比
        double storagePercentage = ((double) totalStorageUsed / 10737418240L) * 100;
        //转换为百分数字符串
        String storagePercentageStr = String.format("%.2f", storagePercentage) + "%";

        //创建包含三个数据的JSON对象
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        result.put("totalStorageUsed", totalStorageUsed);
        result.put("formattedSize", formattedSize);
        result.put("storagePercentageStr", storagePercentageStr);

        String jsonString = JSON.toJSONString(result);
        resp.getWriter().write(jsonString);
    }

}
