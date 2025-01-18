package com.example.estore.entities;
import com.example.estore.BuyType;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "e_voucher")
public class EVoucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String description;
    private LocalDate expiryDate; // Use LocalDate if time is not needed
    private double amount;
    private String imageUrl;
    private String paymentMethod;
    private int paymentDiscountPercentage; // Changed to int
    private int quantity;
    @Enumerated(EnumType.STRING)
    private BuyType buyType;
    private String name;
    private String phoneNumber;
    private int maxLimitPerUser;
    private int giftLimitPerUser;
    @Column(name = "created_at", columnDefinition = "TIMESTAMP")
    private LocalDateTime createdAt;
    @Column(name = "updated_at", columnDefinition = "TIMESTAMP")
    private LocalDateTime updatedAt;
    @JsonProperty("is_active") // Map JSON field to entity field
    private Boolean isActive;
}