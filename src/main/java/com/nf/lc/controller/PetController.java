package com.nf.lc.controller;

import com.nf.lc.dao.PetMapper;
import com.nf.lc.entity.Pet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
public class PetController {

    @Autowired
    private PetMapper petMapper;

    /**
     * 添加宠物的方法
     * @param pet 新宠物  post 请求
     */
    @RequestMapping(value = "/pet" ,method = RequestMethod.POST)
    @ResponseBody
    public String insertPet(@RequestBody Pet pet){
        if(petMapper.insert(pet)>0){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 更新宠物信息的方法
     * @param pet 修改宠物信息 put 请求
     */
    @RequestMapping(value = "/pet" ,method = RequestMethod.PUT)
    @ResponseBody
    public String updatePet(@RequestBody Pet pet){
        if(petMapper.updateByPrimaryKey(pet)>0){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 按状态查找宠物
     * pet_status 宠物状态 get 请求
     */
    @RequestMapping(value = "/pet/finByStatus" , method = RequestMethod.GET)
    @ResponseBody
    public List<Pet> getPetStatus(String pet_status){
        return petMapper.getPetStatus(pet_status);
    }

    /**
     * 通过id查找宠物
     * @param pet_id 宠物id get 请求
     */
    @RequestMapping(value = "/pet/{petId}" ,method = RequestMethod.GET)
    @ResponseBody
    public Pet getByPrimaryKey(@PathVariable("petId") int pet_id){
        return petMapper.selectByPrimaryKey(pet_id);
    }

    /**
     * 使用表单数据更新到宠物商店中的方法
     * @param petId 宠物id post 请求
     * @param pet 要修改的宠物
     */
    @RequestMapping(value = "/pet/{petId}" ,method = RequestMethod.POST)
    @ResponseBody
    public String updatePetByForm(@PathVariable("petId") int petId ,Pet pet){
       Pet newPet = new Pet();
       newPet.setPetName(pet.getPetName());
       newPet.setCategoryId(pet.getCategoryId());
       newPet.setPetPhotoUrls(pet.getPetPhotoUrls());
       newPet.setPetStatus(pet.getPetStatus());
       newPet.setTagId(pet.getTagId());
       if(petMapper.updateByPrimaryKey(newPet)>0){
           return "{\"msg\":\"ok\"}";
       }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 根据id删除宠物的方法
     * @param petId 要删除的宠物id  delete 请求
     */
    @RequestMapping(value = "/pet/{petId}" , method = RequestMethod.DELETE)
    @ResponseBody
    public String deletePetPrimaryKey(@PathVariable("petId") int petId){
        if(petMapper.deleteByPrimaryKey(petId)>0){
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

    /**
     * 上传图片的方法
     * @param petId 宠物的id
     * @param petImgSrc 图片路径
     */
    @RequestMapping(value = "/pet/{petId}/uploadImage",method = RequestMethod.POST)
    @ResponseBody
    public String uploadPetImage(@PathVariable("petId") int petId,String petImgSrc){
        Pet pet = petMapper.selectByPrimaryKey(petId);  //获得对象
        pet.setPetPhotoUrls(petImgSrc);
        if(petMapper.updateByPrimaryKey(pet)>0){  //数据库修改
            return "{\"msg\":\"ok\"}";
        }
        return "{\"msg\":\"no\"}";
    }

}
