package com.nf.lc.entity;

import java.util.Date;

public class Order {
    private Integer orderId;

    private Integer petId;

    private Integer orderQuantity;

    private Date orderShipDate;

    private String orderStatus;

    private Integer orderComplete;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getPetId() {
        return petId;
    }

    public void setPetId(Integer petId) {
        this.petId = petId;
    }

    public Integer getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(Integer orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public Date getOrderShipDate() {
        return orderShipDate;
    }

    public void setOrderShipDate(Date orderShipDate) {
        this.orderShipDate = orderShipDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus == null ? null : orderStatus.trim();
    }

    public Integer getOrderComplete() {
        return orderComplete;
    }

    public void setOrderComplete(Integer orderComplete) {
        this.orderComplete = orderComplete;
    }
}