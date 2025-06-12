package main.java.dao;

import main.java.model.MediaFile;

public class MediaTest {
    public static void main(String[] args) {
        MediaFile mediaFile = new MediaFile();
//        mediaFile.setUserId(2);
//        mediaFile.setFilename("test.mp4");
//        mediaFile.setFileType("video");
//        mediaFile.setSize(11324L);
//        mediaFile.setAlistPath("/cloud/test.mp4");
//        mediaFile.setPreviewUrl("http://localhost:8080/preview/test.mp4");
//        // 更新数据库信息
//        MediaFileDAO mediaFileDAO = new MediaFileDAO();
//        mediaFileDAO.addMediaFile(mediaFile);

        MediaFileDAO mediaFileDAO = new MediaFileDAO();
        for (MediaFile media : mediaFileDAO.getMediaFilesByUserId(4)) {
            System.out.println(media.getFilename());
        }
    }
}
