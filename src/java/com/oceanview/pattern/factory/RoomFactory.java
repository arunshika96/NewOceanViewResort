package com.oceanview.pattern.factory;

import com.oceanview.model.Room;
import com.oceanview.model.RoomType;
import java.math.BigDecimal;

/**
 * FACTORY PATTERN
 * Creates different types of rooms without specifying concrete classes
 * Benefits: Encapsulates object creation, easy to add new room types
 */
public class RoomFactory {
    
    // Room type constants
    public static final String STANDARD = "STD";
    public static final String DELUXE = "DLX";
    public static final String SUITE = "STE";
    
    public Room createRoom(String roomType, String roomNumber, int floor) {
        Room room = new Room();
        room.setRoomNumber(roomNumber);
        room.setFloor(floor);
        room.setStatus("available");
        
        // Create appropriate room type based on factory pattern
        RoomType type = createRoomType(roomType);
        room.setRoomType(type);
        
        return room;
    }
    
    private RoomType createRoomType(String typeCode) {
        RoomType roomType = new RoomType();
        roomType.setTypeCode(typeCode);
        
        switch(typeCode) {
            case STANDARD:
                roomType.setTypeName("Standard Room");
                roomType.setBaseRate(new BigDecimal("7500.00"));
                roomType.setCapacity(2);
                roomType.setAmenities("TV, AC, WiFi, Attached Bathroom");
                roomType.setDescription("Comfortable room with garden view");
                break;
                
            case DELUXE:
                roomType.setTypeName("Deluxe Room");
                roomType.setBaseRate(new BigDecimal("12500.00"));
                roomType.setCapacity(3);
                roomType.setAmenities("TV, AC, WiFi, Mini Bar, Balcony");
                roomType.setDescription("Spacious room with partial sea view");
                break;
                
            case SUITE:
                roomType.setTypeName("Executive Suite");
                roomType.setBaseRate(new BigDecimal("18500.00"));
                roomType.setCapacity(4);
                roomType.setAmenities("TV, AC, WiFi, Jacuzzi, Living Area");
                roomType.setDescription("Luxury suite with panoramic sea view");
                break;
                
            default:
                throw new IllegalArgumentException("Unknown room type: " + typeCode);
        }
        
        return roomType;
    }
    
    // Additional factory methods
    public Room createStandardRoom(String roomNumber, int floor) {
        return createRoom(STANDARD, roomNumber, floor);
    }
    
    public Room createDeluxeRoom(String roomNumber, int floor) {
        return createRoom(DELUXE, roomNumber, floor);
    }
    
    public Room createSuite(String roomNumber, int floor) {
        return createRoom(SUITE, roomNumber, floor);
    }
    
    // Get room rate based on type
    public BigDecimal getRoomRate(String roomType) {
        switch(roomType) {
            case STANDARD: return new BigDecimal("7500.00");
            case DELUXE: return new BigDecimal("12500.00");
            case SUITE: return new BigDecimal("18500.00");
            default: return BigDecimal.ZERO;
        }
    }
}