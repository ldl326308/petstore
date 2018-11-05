package com.nf.lc.controller;

import com.nf.lc.dao.PetMapper;
import com.nf.lc.entity.Pet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class PetController {

    @Autowired
    private PetMapper petMapper;


    /**
     * 获得所有宠物
     */
    @RequestMapping(value = "/pet", method = RequestMethod.GET)
    @ResponseBody
    public List<Pet> selectAll() {
        return petMapper.selectAll();
    }

    /**
     * 添加宠物的方法
     *
     * @param pet 新宠物  post 请求
     */
    @RequestMapping(value = "/pet", method = RequestMethod.POST , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String insertPet(Pet pet) {
        int sta = petMapper.insert(pet);
        if (sta > 0) {
            return "{\"msg\":\"添加成功！\"}";
        } else {
            return "{\"msg\":\"添加失败！\"}";
        }
    }

    /**
     * 更新宠物信息的方法
     *
     * @param pet 修改宠物信息 put 请求
     */
    @RequestMapping(value = "/pet", method = RequestMethod.PUT)
    public String updatePet(Pet pet, Model model) {
        if (petMapper.updateByPrimaryKey(pet) > 0) {
            model.addAttribute("err", "修改成功！");
        } else {
            model.addAttribute("err", "修改失败！");
        }
        return "pet";
    }

    /**
     * 按状态查找宠物
     * pet_status 宠物状态 get 请求
     */
    @RequestMapping(value = "/pet/finByStatus", method = RequestMethod.GET)
    public String getPetStatus(String pet_status, Model model) {
        List<Pet> petList = petMapper.getPetStatus(pet_status);
        model.addAttribute("list", petList);
        return "pet";
    }

    /**
     * 通过id查找宠物
     *
     * @param pet_id 宠物id get 请求
     */
    @RequestMapping(value = "/pet/{petId}", method = RequestMethod.GET)
    public String getByPrimaryKey(@PathVariable("petId") int pet_id, Model model) {
        Pet pet = petMapper.selectByPrimaryKey(pet_id);
        model.addAttribute("pet", pet);
        return "pet";

    }

    /**
     * 使用表单数据更新到宠物商店中的方法
     *
     * @param petId 宠物id post 请求
     * @param pet   要修改的宠物
     */
    @RequestMapping(value = "/pet/{petId}", method = RequestMethod.POST)
    public String updatePetByForm(@PathVariable("petId") int petId, Pet pet, Model model) {
        pet.setPetId(petId);
        if (petMapper.updateByPrimaryKey(pet) > 0) {
            model.addAttribute("err", "修改成功！");
        } else {
            model.addAttribute("err", "修改失败！");
        }
        return "pet";
    }

    /**
     * 根据id删除宠物的方法
     *
     * @param petId 要删除的宠物id  delete 请求
     */
    @RequestMapping(value = "/pet/{petId}", method = RequestMethod.DELETE, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String deletePetPrimaryKey(@PathVariable("petId") int petId) {
        String message = "{\"msg\":\"删除失败！\"}";
        try {
            if (petMapper.deleteByPrimaryKey(petId) > 0) {
                message = "{\"msg\":\"删除成功！\"}";
            }
        } catch (Exception e) {
            return message;
        }
        return message;
    }

    /**
     * 上传图片的方法
     *
     * @param petId     宠物的id
     * @param petImgSrc 图片路径
     */
    @RequestMapping(value = "/pet/{petId}/uploadImage", method = RequestMethod.POST)
    public String uploadPetImage(@PathVariable("petId") int petId, String petImgSrc, Model model) {
        Pet pet = petMapper.selectByPrimaryKey(petId);  //获得对象
        pet.setPetPhotoUrls(petImgSrc);
        if (petMapper.updateByPrimaryKey(pet) > 0) {  //数据库修改
            model.addAttribute("err", "修改成功！");
        } else {
            model.addAttribute("err", "修改失败！");
        }
        return "pet";
    }

    @RequestMapping(value = "/petStart", method = RequestMethod.GET)
    public String start() {
        return "pet";
    }

}
