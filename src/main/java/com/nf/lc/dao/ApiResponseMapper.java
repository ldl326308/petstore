package com.nf.lc.dao;

import com.nf.lc.entity.ApiResponse;
import java.util.List;

public interface ApiResponseMapper {
    int deleteByPrimaryKey(Integer apiResponseCode);

    int insert(ApiResponse record);

    ApiResponse selectByPrimaryKey(Integer apiResponseCode);

    List<ApiResponse> selectAll();

    int updateByPrimaryKey(ApiResponse record);
}