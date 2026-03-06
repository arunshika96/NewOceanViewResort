package com.oceanview.model;

import java.math.BigDecimal;

public class RoomType {
    private int roomTypeId;
    private String typeCode; // STD, DLX, STE
    private String typeName;
    private String description;
    private BigDecimal baseRate;
    private int capacity;
    private String amenities;
    private String imagePath;
    private boolean isActive;
    
    public RoomType() {}
    
    public RoomType(String typeCode, String typeName, BigDecimal baseRate, int capacity) {
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.baseRate = baseRate;
        this.capacity = capacity;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }
    
    public String getTypeCode() { return typeCode; }
    public void setTypeCode(String typeCode) { this.typeCode = typeCode; }
    
    public String getTypeName() { return typeName; }
    public void setTypeName(String typeName) { this.typeName = typeName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getBaseRate() { return baseRate; }
    public void setBaseRate(BigDecimal baseRate) { this.baseRate = baseRate; }
    
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    
    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    @Override
    public String toString() {
        return typeName + " - LKR " + baseRate;
    }
}