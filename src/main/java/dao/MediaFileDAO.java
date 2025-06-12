package main.java.dao;

import main.java.db.DBUtil;
import main.java.model.MediaFile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * MediaFileDAO - 媒体文件数据访问对象
 * 负责处理 media_files 表的数据库操作
 */
public class MediaFileDAO {

    /**
     * 新增媒体文件记录
     * @param mediaFile 媒体文件对象
     * @return 新增记录的ID，失败返回-1
     */
    public static int addMediaFile(MediaFile mediaFile) {
        String sql = "INSERT INTO media_files (user_id, filename, file_type, size, alist_path, preview_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, mediaFile.getUserId());
            stmt.setString(2, mediaFile.getFilename());
            stmt.setString(3, mediaFile.getFileType());
            stmt.setLong(4, mediaFile.getSize());
            stmt.setString(5, mediaFile.getAlistPath());
            stmt.setString(6, mediaFile.getPreviewUrl());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("新增媒体文件记录失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        return -1;
    }
    
    /**
     * 批量新增媒体文件记录
     * @param mediaFiles 媒体文件列表
     * @return 成功新增的记录数
     */
    public static int addMediaFiles(List<MediaFile> mediaFiles) {
        if (mediaFiles == null || mediaFiles.isEmpty()) {
            return 0;
        }
        
        String sql = "INSERT INTO media_files (user_id, filename, file_type, size, alist_path, preview_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (MediaFile mediaFile : mediaFiles) {
                stmt.setInt(1, mediaFile.getUserId());
                stmt.setString(2, mediaFile.getFilename());
                stmt.setString(3, mediaFile.getFileType());
                stmt.setLong(4, mediaFile.getSize());
                stmt.setString(5, mediaFile.getAlistPath());
                stmt.setString(6, mediaFile.getPreviewUrl());
                stmt.addBatch();
            }
            
            int[] results = stmt.executeBatch();
            conn.commit();
            
            int successCount = 0;
            for (int result : results) {
                if (result > 0) {
                    successCount++;
                }
            }
            
            System.out.println("批量新增媒体文件记录成功: " + successCount + "/" + mediaFiles.size());
            return successCount;
            
        } catch (SQLException e) {
            System.err.println("批量新增媒体文件记录失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * 根据用户ID查询媒体文件列表
     * @param userId 用户ID
     * @return 媒体文件列表
     */
    public static List<MediaFile> getMediaFilesByUserId(int userId) {
        List<MediaFile> mediaFiles = new ArrayList<>();
        String sql = "SELECT * FROM media_files WHERE user_id = ? ORDER BY uploaded_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MediaFile mediaFile = new MediaFile();
                    mediaFile.setId(rs.getInt("id"));
                    mediaFile.setUserId(rs.getInt("user_id"));
                    mediaFile.setFilename(rs.getString("filename"));
                    mediaFile.setFileType(rs.getString("file_type"));
                    mediaFile.setSize(rs.getLong("size"));
                    mediaFile.setAlistPath(rs.getString("alist_path"));
                    mediaFile.setPreviewUrl(rs.getString("preview_url"));
                    mediaFile.setUploadedAt(rs.getTimestamp("uploaded_at"));
                    
                    mediaFiles.add(mediaFile);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("查询媒体文件列表失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        return mediaFiles;
    }
    
    /**
     * 检查文件是否已存在
     * @return 是否存在
     */
    public static boolean isFileExists(String filename) {
        String sql = "SELECT COUNT(*) FROM media_files WHERE filename = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, filename);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("检查文件是否存在失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * 根据ID删除媒体文件记录
     * @param filename 文件名
     * @return 是否删除成功
     */
    public static boolean deleteMediaFile(String filename) {
        String sql = "DELETE FROM media_files WHERE filename = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, filename);
            int affectedRows = stmt.executeUpdate();
            
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("删除媒体文件记录失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    /**
     * 根据文件名进行模糊搜索
     * @param filenameQuery 文件名查询字符串 (部分或完整)
     * @return 匹配的媒体文件列表
     */
    public static List<MediaFile> searchMediaFilesByName(String filenameQuery) {
        List<MediaFile> mediaFiles = new ArrayList<>();
        String sql = "SELECT * FROM media_files WHERE filename LIKE ? ORDER BY uploaded_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + filenameQuery + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MediaFile mediaFile = new MediaFile();
                    mediaFile.setId(rs.getInt("id"));
                    mediaFile.setUserId(rs.getInt("user_id"));
                    mediaFile.setFilename(rs.getString("filename"));
                    mediaFile.setFileType(rs.getString("file_type"));
                    mediaFile.setSize(rs.getLong("size"));
                    mediaFile.setAlistPath(rs.getString("alist_path"));
                    mediaFile.setPreviewUrl(rs.getString("preview_url"));
                    mediaFile.setUploadedAt(rs.getTimestamp("uploaded_at"));
                    mediaFiles.add(mediaFile);
                }
            }

        } catch (SQLException e) {
            System.err.println("根据文件名模糊搜索媒体文件失败: " + e.getMessage());
            e.printStackTrace();
        }

        return mediaFiles;
    }
    
    /**
     * 获取用户的文件统计信息
     * @param userId 用户ID
     * @return 文件统计数组 [总数, 图片数, 视频数, 音频数, 其他数]
     */
    public static int[] getFileStatistics(int userId) {
        String sql = "SELECT file_type, COUNT(*) as count FROM media_files WHERE user_id = ? GROUP BY file_type";
        int[] stats = new int[5]; // [总数, 图片数, 视频数, 音频数, 其他数]
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String fileType = rs.getString("file_type");
                    int count = rs.getInt("count");
                    stats[0] += count; // 总数
                    
                    switch (fileType) {
                        case "image":
                            stats[1] = count;
                            break;
                        case "video":
                            stats[2] = count;
                            break;
                        case "audio":
                            stats[3] = count;
                            break;
                        case "other":
                            stats[4] = count;
                            break;
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("获取文件统计信息失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        return stats;
    }
}