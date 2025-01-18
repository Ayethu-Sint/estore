package com.example.estore.repositories;

import com.example.estore.entities.PaymentHeader;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentHeaderRepository extends JpaRepository<PaymentHeader, Long> {
}
