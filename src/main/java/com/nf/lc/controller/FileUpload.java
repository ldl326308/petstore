package com.nf.lc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class FileUpload {

    @RequestMapping( value = "/uploadImg" , method = RequestMethod.POST ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String fileUpload(@RequestPart("multipartFile") MultipartFile multipartFile , HttpServletRequest req){
        String src="";
        if(!multipartFile.isEmpty()){  //不能为空
            String contentType = multipartFile.getContentType();
            //效验为图片
            if(!contentType.contains("image/")){
                return "{\"false\":\"请选择图片！\"}";
            }

            //文件大小验证
            if(multipartFile.getSize() > 1024 * 1024 * 1024 * 5){
                return "{\"false\":\"图片太大，无法上传！\"}";
            }

            //路径
            String savePath = req.getServletContext().getRealPath("");
            savePath = savePath +"images\\";
            File file = new File(savePath);
            if(!file.exists()){
                file.mkdirs();
            }

            //图片名：upload_原名字_日期.后缀名
            String fileName = multipartFile.getOriginalFilename();
            String firstName = fileName.substring(0,fileName.lastIndexOf('.'));
            String dateString = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            String lastName = fileName.substring(fileName.lastIndexOf(".") , fileName.length());
            String path = savePath+"upload_"+firstName+"_"+dateString+ lastName;
            src = "/images/upload_"+firstName+"_"+dateString+ lastName;

            try {
                multipartFile.transferTo(new File(path));
            } catch (IOException e) {
                e.printStackTrace();
                return "{\"false\":\"上传失败！\"}";
            }

        }else{
            return "{\"false\":\"上传失败llll！\"}";
        }
        return "{\"true\":\""+src+"\"}";
    }




}
