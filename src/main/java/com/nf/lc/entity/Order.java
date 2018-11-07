package com.nf.lc.entity;

import javax.validation.constraints.Future;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;
import java.util.Date;

public class Order {
    @Min(value = 1)

    private Integer orderId;

    @Min(value = 1)
    private Integer petId;

    @Min(value = 1)
    private Integer orderQuantity;

    @Future
    private Date orderShipDate;

    @Pattern(regexp = "('放置'|'批准'|'交付')")
    private String orderStatus;

    @Pattern(regexp = "(0|1)")
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