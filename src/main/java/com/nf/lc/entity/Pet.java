package com.nf.lc.entity;

public class Pet {
    private Integer petId;

    private Integer categoryId;

    private String petName;

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