package com.oceanview.model;

public class Room {
    private int roomId;
    private String roomNumber;
    private RoomType roomType;
    private int floor;
    private String status; // available, occupied, maintenance, reserved
    private String notes;
    
    public Room() {}
    
    public Room(String roomNumber, RoomType roomType, int floor) {
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.floor = floor;
        this.status = "available";
    }
    
    // Getters and Setters
    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }
    
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    
    public RoomType getRoomType() { return roomType; }
    public void setRoomType(RoomType roomType) { this.roomType = roomType; }
    
    public int getFloor() { return floor; }
    public void setFloor(int floor) { this.floor = floor; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    
    @Override
    public String toString() {
        return "Room " + roomNumber + " (" + roomType.getTypeName() + ")";
    }
}