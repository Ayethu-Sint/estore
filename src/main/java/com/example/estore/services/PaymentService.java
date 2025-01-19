package com.example.estore.services;

import com.example.estore.entities.Payment;
import com.example.estore.entities.PaymentDetails;
import com.example.estore.entities.PaymentHeader;
import com.example.estore.repositories.PaymentDetailsRepository;
import com.example.estore.repositories.PaymentHeaderRepository;
import com.example.estore.repositories.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PaymentService {
    @Autowired
    private PaymentHeaderRepository headerRepository;
    @Autowired
    private PaymentDetailsRepository detailsRepository;
    @Autowired
    private PaymentRepository paymentRepository;
    @Autowired
    private CMSService cmsService;

    @Transactional
    public PaymentHeader savePayment(PaymentHeader payment) {
        // Save the PaymentHeader and get the generated ID
        PaymentHeader savedHeader = headerRepository.save(payment);

        // Set header_id for each PaymentDetails record
        if (payment.getDetails() != null) {
            for (PaymentDetails details : payment.getDetails()) {
                details.setHeaderId(savedHeader.getId());
                //cmsService.deactiveEVoucher(details.getEvoucherId());
                cmsService.setUsedPromoCode(details.getPromoCodeId());
            }
            detailsRepository.saveAll(payment.getDetails());
        }

        // Set header_id for each Payment record
        if (payment.getPayment() != null) {
            for (Payment paymentItem : payment.getPayment()) {
                paymentItem.setHeaderId(savedHeader.getId());
            }
            paymentRepository.saveAll(payment.getPayment());
        }
        return savedHeader;
    }

    public List<Long> getEVoucherIdsByPaymentHeaderId(Long headerId) {
        return detailsRepository.findEVoucherIdsByPaymentHeaderId(headerId);
    }

    public List<PaymentHeader> getAllPayments() {
        return headerRepository.findAll();
    }
}
