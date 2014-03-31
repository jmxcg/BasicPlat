package com.gmteam.framework.utils;

import java.io.File;

public abstract class FileNameUtil {
    /**
     * 用系统文件分割符号连接文件路径
     * @param path1 第一个路径
     * @param path2 第二个路径
     * @return 连接好的路径
     */
    public static String concatPath(String path1, String path2) {
        String firstPath = path1.replace("/", File.separator);
        firstPath = firstPath.replace("\\", File.separator);
        String secondPath = path2.replace("/", File.separator);
        secondPath = secondPath.replace("\\", File.separator);

        if (!firstPath.endsWith(File.separator)) firstPath+=File.separator;
        if (secondPath.startsWith(File.separator)) secondPath = secondPath.substring(1);

        return firstPath+secondPath;
    }

    /**
     * 
     * @param strPath
     * @return
     */
    public static String toUnixFormat(String strPath){
        return strPath.replaceAll("\\", "/");
    }
    
    /**
     * 根据当前日期 生成文件路径
     * @param filePrefix 欲生成的路径的文件前缀
     * @return 日期路径
     */
    public static String getDateRulePath(String filePrefix) {
        String strRulePath = "";
        strRulePath = DateUtil.getDateValue(new java.util.Date());
        String[] tmpArr = strRulePath.split("-");
        strRulePath = "";
        for (String tmp: tmpArr) strRulePath += tmp + File.separator;
        return concatPath(filePrefix, strRulePath);
    }

    /**
     * 得到文件的路径，默认认为，文件的最后一个分割符前是文件路径
     * @param localFullPath 文件名称
     * @return 文件路径
     */
    public static String getFilePath(String localFullPath){
        int lastDirPos = localFullPath.lastIndexOf(File.separator);
        if (lastDirPos!=-1) return localFullPath.substring(0, lastDirPos);
        else return "";
    }

    /**
     * 得到文件的路径，默认认为，文件的最后一个分割符前是文件路径
     * @param localFullPath 文件名称
     * @return 文件路径
     */
    public static String getFileName(String localFullPath){
        int lastDirPos = localFullPath.lastIndexOf(File.separator);
        if (lastDirPos!=-1) return localFullPath.substring(lastDirPos + 1);
        return localFullPath;
    }

    /**
     * 得到文件的路径，默认认为，文件的最后一个分割符前是文件路径
     * @param localFullPath 文件名称
     * @return 文件路径
     */
    public static String getPureFileName(String localFullPath){
        String fileName = FileNameUtil.getFileName(localFullPath);
        int lastDirPos = fileName.lastIndexOf(".");
        if (lastDirPos!=-1) return fileName.substring(0, lastDirPos);
        else return fileName;
    }

    /**
     * 得到文件的扩展名
     * @param localFullPath 文件名称
     * @return 文件扩展名
     */
    public static String getExt(String localFullPath){
        int lastDirPos = localFullPath.lastIndexOf(".");
        if (lastDirPos!=-1) return localFullPath.substring(lastDirPos);
        else return "";
    }
}