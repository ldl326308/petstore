package com.nf.lc.controller;

import com.nf.lc.dao.TagMapper;
import com.nf.lc.entity.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class TagController {

    @Autowired
    private TagMapper tagMapper;

    /**
     * 获得所有标签
     */
    @RequestMapping(value = "/tag" ,method = RequestMethod.GET)
    @ResponseBody
    public List<Tag> selectAll(){
        return tagMapper.selectAll();
    }

}
