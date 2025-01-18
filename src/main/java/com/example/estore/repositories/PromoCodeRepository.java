package com.example.estore.repositories;


import com.example.estore.entities.PromoCode;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PromoCodeRepository extends JpaRepository<PromoCode, Long> {
    boolean existsByPromoCode(String promoCode);
}
