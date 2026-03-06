package com.oceanview.model;

import java.time.LocalDateTime;

public class Guest {
    private int guestId;
    private String reservationNumber;
    private String fullName;
    private String address;
    private String contactNumber;
    private String email;
    private String idProofType; // passport, nic, driving_license
    private String idProofNumber;
    private String nationality;
    private LocalDateTime createdAt;
    
    public Guest() {}
    
    public Guest(String fullName, String email, String contactNumber) {
        this.fullName = fullName;
        this.email = email;
        this.contactNumber = contactNumber;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getGuestId() { return guestId; }
    public void setGuestId(int guestId) { this.guestId = guestId; }
    
    public String getReservationNumber() { return reservationNumber; }
    public void setReservationNumber(String reservationNumber) { this.reservationNumber = reservationNumber; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getIdProofType() { return idProofType; }
    public void setIdProofType(String idProofType) { this.idProofType = idProofType; }
    
    public String getIdProofNumber() { return idProofNumber; }
    public void setIdProofNumber(String idProofNumber) { this.idProofNumber = idProofNumber; }
    
    public String getNationality() { return nationality; }
    public void setNationality(String nationality) { this.nationality = nationality; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}