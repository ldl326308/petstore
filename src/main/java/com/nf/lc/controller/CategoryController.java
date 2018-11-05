package com.nf.lc.controller;

import com.nf.lc.dao.CategoryMapper;
import com.nf.lc.entity.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    private CategoryMapper categoryMapper;

    /**
     * 获得所有数据
     */
    @RequestMapping(value = "/category" , method = RequestMethod.GET)
    @ResponseBody
    public List<Category> listAllCategory(){
        return categoryMapper.selectAll();
    }

}
