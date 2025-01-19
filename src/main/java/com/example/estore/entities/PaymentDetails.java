package com.example.estore.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "payment_details")
public class PaymentDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long headerId;
    private Long evoucherId;
    private Long promoCodeId;
    private Double price;
    private int quantity;
    private Double amount;
    private Double disAmount;
}
