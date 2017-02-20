package com.kabuda.util;

import java.io.File;

public class FileHelper {

    public static void deleteFile(String filePath){
        File file = new File(filePath);
        if(file.isFile() && file.exists()){
            file.delete();
        }
    }
}
