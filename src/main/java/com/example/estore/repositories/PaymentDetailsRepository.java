package com.example.estore.repositories;

import com.example.estore.entities.PaymentDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentDetailsRepository extends JpaRepository<PaymentDetails, Long> {
    @Query("SELECT pd.evoucherId FROM PaymentDetails pd WHERE pd.headerId = :headerId")
    List<Long> findEVoucherIdsByPaymentHeaderId(@Param("headerId") Long headerId);
}
