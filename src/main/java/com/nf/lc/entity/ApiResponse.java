package com.nf.lc.entity;

import javax.validation.constraints.NotBlank;

public class ApiResponse {
    @NotBlank
    private Integer apiResponseCode;

    @NotBlank
    private String apiResponseType;

    @NotBlank
    private String apiResponseMessage;

    public Integer getApiResponseCode() {
        return apiResponseCode;
    }

    public void setApiResponseCode(Integer apiResponseCode) {
        this.apiResponseCode = apiResponseCode;
    }

    public String getApiResponseType() {
        return apiResponseType;
    }

    public void setApiResponseType(String apiResponseType) {
        this.apiResponseType = apiResponseType == null ? null : apiResponseType.trim();
    }

    public String getApiResponseMessage() {
        return apiResponseMessage;
    }

    public void setApiResponseMessage(String apiResponseMessage) {
        this.apiResponseMessage = apiResponseMessage == null ? null : apiResponseMessage.trim();
    }
}