package main.java.db;

import java.sql.Connection;
import java.sql.SQLException;


public class TestDB {
    public static void main(String[] args) {
        System.out.println("开始测试数据库连接...");

        // 测试1：基础连接测试
        testConnection();

        // 测试2：连接池复用测试（可选）
        testConnectionPoolReuse();
    }


    private static void testConnection() {
        System.out.println("\n=== 测试1：基础连接 ===");

        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ 数据库连接成功！");
                System.out.println("连接信息: " + conn.getMetaData().getURL());
            } else {
                System.out.println("❌ 数据库连接失败：连接为null或已关闭");
            }
        } catch (SQLException e) {
            System.err.println("❌ 数据库连接异常：");
            e.printStackTrace();
        }
    }

    private static void testConnectionPoolReuse() {
        System.out.println("\n=== 测试2：连接池复用 ===");

        try {
            // 第一次获取连接
            Connection conn1 = DBUtil.getConnection();
            System.out.println("第一次获取连接: " + conn1.hashCode());

            // 关闭连接（实际归还到连接池）
            conn1.close();

            // 第二次获取连接（应复用）
            Connection conn2 = DBUtil.getConnection();
            System.out.println("第二次获取连接: " + conn2.hashCode());

            if (conn1.hashCode() == conn2.hashCode()) {
                System.out.println("✅ 连接池复用成功（相同连接实例）");
            } else {
                System.out.println("⚠️ 连接实例不同（可能因连接池配置导致）");
            }

            conn2.close();
        } catch (Exception e) {
            System.err.println("❌ 连接池测试异常：");
            e.printStackTrace();
        }
    }
}