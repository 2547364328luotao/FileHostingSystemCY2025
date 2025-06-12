package main.java.db;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static final ComboPooledDataSource dataSource = new ComboPooledDataSource();

    static {
        try {
            // 配置数据源（实际项目中应改为读取配置文件）
            dataSource.setDriverClass("com.mysql.cj.jdbc.Driver");
            dataSource.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/alist_media?useSSL=false&serverTimezone=UTC");
            dataSource.setUser("root");
            dataSource.setPassword("mysql_FrKS2a");

            // 连接池参数配置
            dataSource.setInitialPoolSize(5);      // 初始连接数
            dataSource.setMaxPoolSize(20);         // 最大连接数
            dataSource.setCheckoutTimeout(3000);   // 获取连接超时时间（毫秒）
        } catch (Exception e) {
            throw new ExceptionInInitializerError("C3P0初始化失败: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection(); // 从连接池获取连接
    }

    public static void close(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) {
                try {
                    res.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
