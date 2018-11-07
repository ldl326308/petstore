package com.nf.lc.controller;

import com.nf.lc.dao.UserMapper;
import com.nf.lc.entity.User;
import com.nf.lc.formbean.FormBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserMapper userMapper;

    /**
     * 获得所有用户信息
     */
    @RequestMapping(value = "/user", method = RequestMethod.GET)
    @ResponseBody
    public List<User> selectAll() {
        return userMapper.selectAll();
    }

    /**
     * 添加用户的方法
     *
     * @param user 新用户 post 请求
     */
    @RequestMapping(value = "/user", method = RequestMethod.POST)
    public String insertUser(User user) {
        if (userMapper.insert(user) > 0) {
            return "{\"msg\":\"添加成功！\"}";
        } else {
            return "{\"msg\":\"添加失败！\"}";
        }
    }

    /**
     * 批量添加用户  createWithArray
     */
    @RequestMapping(value = "/user/createWithArray", method = RequestMethod.POST)
    public String createBatch(FormBean<User> list) {
        for (User user : list.getObjList()) {
            userMapper.insert(user);
        }
        return "{\"msg\":\"添加成功！\"}";
    }


    /**
     * 批量添加用户 createWithList
     */


    /**
     * 登入验证的方法
     *
     * @param username 用户名
     * @param password 用户密码
     */
    @RequestMapping(value = "/user/login", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String loginUser(String username, String password) {
        int i = userMapper.selectLogin(username, password);
        if (i > 0) {
            return "{\"msg\":\"success\"}";
        } else {
            return "{\"msg\":\"fail\"}";
        }
    }

    /**
     * 注销登入 get 请求
     */

    /**
     * 通过用户名获取用户
     *
     * @param username 用户名 get请求
     */
    @RequestMapping(value = "/user/{username}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public User selectByUserName(@PathVariable("username") String username) {
        return userMapper.selectByUserName(username);
    }

    /**
     * 更新用户的方法
     *
     * @param username 更新的用户 put 请求
     */
    @RequestMapping(value = "/user/{username}", method = RequestMethod.PUT, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String updateByUserName(@PathVariable("username") String username ,User user) {
        user.setUserName(username);
        if (userMapper.updateByUserName(user) > 0) {
            return "{\"msg\":\"success\"}";
        } else {
            return "{\"msg\":\"fail\"}";
        }
    }

    /**
     * 通过username删除用户
     *
     * @param username
     */
    @RequestMapping(value = "/user/{username}", method = RequestMethod.DELETE, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String deleteUserName(@PathVariable("username") String username) {
        if (userMapper.deleteByUserName(username) > 0) {
            return "{\"msg\":\"success\"}";
        } else {
            return "{\"msg\":\"fail\"}";
        }
    }


    @RequestMapping(value = "/loginStart", method = RequestMethod.GET)
    public String start() {
        return "login";
    }

    @RequestMapping(value = "/userStart", method = RequestMethod.GET)
    public String userStart() {
        return "user";
    }

}
