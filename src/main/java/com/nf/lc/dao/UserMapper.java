package com.nf.lc.dao;

import com.nf.lc.entity.User;
import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userId);

    int deleteByUserName(String username);

    int insert(User record);

    User selectByPrimaryKey(Integer userId);

    List<User> selectAll();

    int updateByPrimaryKey(User record);

    int selectLogin(String userName,String userPassword);

    User selectByUserName(String username);

    int updateByUserName(User user);

}