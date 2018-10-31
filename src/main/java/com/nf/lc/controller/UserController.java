package com.nf.lc.controller;

import com.nf.lc.dao.UserMapper;
import com.nf.lc.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.Path;

@Controller
public class UserController {

    @Autowired
    private UserMapper userMapper;

    /**
     * 添加用户的方法
     * @param user 新用户 post 请求
     */
    @RequestMapping(value = "/user" ,method = RequestMethod.POST)
    @ResponseBody
    public String insertUser(@RequestBody User user){
        if(userMapper.insert(user)>0){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 批量添加用户  createWithArray
     *
     */


    /**
     * 批量添加用户 createWithList
     */


    /**
     * 登入验证的方法
     * @param userName 用户名
     * @param userPassword 密码
     */
    @RequestMapping(value = "/user/login" ,method = RequestMethod.GET)
    @ResponseBody
    public String loginUser(@RequestBody String userName,@RequestBody String userPassword){
        User user = userMapper.selectLogin(userName, userPassword);
        if(user != null){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 注销登入 get 请求
     */

    /**
     * 通过用户名获取用户
     * @param  username 用户名 get请求
     */
    @RequestMapping(value = "/user/{username}" , method = RequestMethod.GET)
    public User selectByUserName(@PathVariable("username") String username){
        return userMapper.selectByUserName(username);
    }

    /**
     * 更新用户的方法
     * @param username 更新的用户 put 请求
     */
    @RequestMapping(value = "/user/{username}",method = RequestMethod.PUT)
    @ResponseBody
    public String updateByUserName(@PathVariable("username") String username,User user){
        user.setUserName(username);
        if(userMapper.updateByUserName(user) > 0){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 通过username删除用户
     * @param username
     */
    @RequestMapping(value = "/user/{username}",method = RequestMethod.DELETE)
    @ResponseBody
    public String deleteUserName(@PathVariable("username") String username){
        if(userMapper.deleteByUserName(username) >0 ){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }


}
