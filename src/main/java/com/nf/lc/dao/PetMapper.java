package com.nf.lc.dao;

import com.nf.lc.entity.Pet;
import java.util.List;

public interface PetMapper {
    int deleteByPrimaryKey(Integer petId);

    int insert(Pet record);

    Pet selectByPrimaryKey(Integer petId);

    List<Pet> selectAll();

    int updateByPrimaryKey(Pet record);

    //通过状态查找宠物
    List<Pet> getPetStatus(String petStatus);

}