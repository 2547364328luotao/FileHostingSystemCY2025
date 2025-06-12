package main.java.utils;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * AlistRemove 用于调用 Alist 文件管理系统 REST API，
 * 支持带令牌的 POST 请求删除指定路径下的文件。
 */
public class AlistRemove {

    private final String baseUrl = "https://alist.5888888885.xyz";          // Alist服务器基础URL，例如 "https://alist.example.com"
    AlistToken alistToken = new AlistToken();
    private final String token;            // 访问令牌，API调用时放到 Authorization header

    {
        try {
            token = alistToken.getToken("luotao","20050508luo",baseUrl);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    private final HttpClient httpClient;   // Java HttpClient实例

    public AlistRemove() {
        this.httpClient = HttpClient.newHttpClient();
    }

    /**
     * 删除指定路径下的文件
     * 使用POST请求，Content-Type: application/json，
     * 请求体示例：
     * {
     *     "dir": "/cloudflare",
     *     "names": ["icon.png"]
     * }
     *
     * @param dir   文件所在目录路径
     * @param names 要删除的文件名列表
     * @return 删除成功返回true，失败返回false
     */
    public boolean removeFiles(String dir, List<String> names) {
        try {
            String url = baseUrl + "/api/fs/remove";

            // 构建请求体JSON字符串
            StringBuilder jsonBody = new StringBuilder();
            jsonBody.append("{\n");
            jsonBody.append("    \"dir\": \"").append(dir).append("\",\n");
            jsonBody.append("    \"names\": [");
            
            for (int i = 0; i < names.size(); i++) {
                jsonBody.append("\"").append(names.get(i)).append("\"");
                if (i < names.size() - 1) {
                    jsonBody.append(", ");
                }
            }
            
            jsonBody.append("]\n");
            jsonBody.append("}");

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("authorization", token)                // 令牌放在Authorization头
                    .header("User-Agent", "Apifox/1.0.0 (https://apifox.com)")  // User-Agent
                    .header("content-type", "application/json;charset=UTF-8")   // 请求体类型
                    .header("Accept", "*/*")                       // Accept头
                    // Note: Host and Connection headers are automatically handled by HttpClient
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody.toString(), StandardCharsets.UTF_8))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                System.out.println("删除成功，响应内容：" + response.body());
                return true;
            } else {
                System.err.println("删除请求失败，状态码：" + response.statusCode() + ", 响应内容：" + response.body());
                return false;
            }
        } catch (IOException | InterruptedException e) {
            System.err.println("删除文件时发生异常：" + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 删除单个文件的便捷方法
     *
     * @param dir      文件所在目录路径
     * @param fileName 要删除的文件名
     * @return 删除成功返回true，失败返回false
     */
    public boolean removeFile(String dir, String fileName) {
        return removeFiles(dir, List.of(fileName));
    }



    /**
     * 测试方法
     */
    public static void main(String[] args) {
        AlistRemove alistRemove = new AlistRemove();
        
        // 删除单个文件示例
        boolean result = alistRemove.removeFile("/cloudflare", "local665ad24ec0ad.png");
        System.out.println("删除结果: " + (result ? "成功" : "失败"));
        
        // 删除多个文件示例
        // List<String> filesToDelete = List.of("file1.txt", "file2.jpg");
        // boolean result2 = alistRemove.removeFiles("/cloudflare", filesToDelete);
        // System.out.println("批量删除结果: " + (result2 ? "成功" : "失败"));
    }
}