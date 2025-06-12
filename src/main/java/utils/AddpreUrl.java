package main.java.utils;

public class AddpreUrl {
    public static String addUrl(String file_name) {
        String pre_url = "https://alist.5888888885.xyz/d/cloudflare/" + file_name;
        String img_tag = "<img src=\"" + pre_url + "\" alt=\"" + file_name + "\" width=\"50\" height=\"50\">";
        return img_tag;
    }
}
