package com.nf.lc.entity;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

public class Pet {

    @Min(1)
    private Integer petId;

    @Min(1)
    private Integer categoryId;

    @NotBlank
    private String petName;

    @NotBlank
    private String petPhotoUrls;

    private Integer tagId;

    private String petStatus;

    public Integer getPetId() {
        return petId;
    }

    public void setPetId(Integer petId) {
        this.petId = petId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName == null ? null : petName.trim();
    }

    public String getPetPhotoUrls() {
        return petPhotoUrls;
    }

    public void setPetPhotoUrls(String petPhotoUrls) {
        this.petPhotoUrls = petPhotoUrls == null ? null : petPhotoUrls.trim();
    }

    public Integer getTagId() {
        return tagId;
    }

    public void setTagId(Integer tagId) {
        this.tagId = tagId;
    }

    public String getPetStatus() {
        return petStatus;
    }

    public void setPetStatus(String petStatus) {
        this.petStatus = petStatus == null ? null : petStatus.trim();
    }
}