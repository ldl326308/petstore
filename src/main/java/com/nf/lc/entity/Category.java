package com.nf.lc.entity;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

public class Category {

    @Min(value = 1)
    private Integer categoryId;

    @NotBlank
    private String categoryName;

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName == null ? null : categoryName.trim();
    }
}