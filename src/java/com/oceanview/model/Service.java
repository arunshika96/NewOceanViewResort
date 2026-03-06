package com.oceanview.model;

import java.math.BigDecimal;

public class Service {
    private int serviceId;
    private String serviceCode;
    private String serviceName;
    private String description;
    private BigDecimal price;
    private String category; // food, spa, transport, entertainment
    private boolean isActive;
    
    public Service() {}
    
    public Service(String serviceCode, String serviceName, BigDecimal price, String category) {
        this.serviceCode = serviceCode;
        this.serviceName = serviceName;
        this.price = price;
        this.category = category;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }
    
    public String getServiceCode() { return serviceCode; }
    public void setServiceCode(String serviceCode) { this.serviceCode = serviceCode; }
    
    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    @Override
    public String toString() {
        return serviceName + " - LKR " + price;
    }
}