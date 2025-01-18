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
@Table(name = "promo_code")
public class PromoCode {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="code")
    private String promoCode;
    private String qrCodeImageUrl;

    @ManyToOne
    @JoinColumn(name = "voucher_id", nullable = false)
    private EVoucher eVoucher;
    private Boolean used;
    private String phoneNumber; // To tie the promo code to a specific phone number
}
