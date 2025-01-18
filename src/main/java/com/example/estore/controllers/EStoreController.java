package com.example.estore.controllers;

import com.example.estore.entities.EVoucher;
import com.example.estore.entities.PaymentHeader;
import com.example.estore.entities.PaymentType;
import com.example.estore.repositories.PaymentTypeRepository;
import com.example.estore.services.CMSService;
import com.example.estore.services.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/estore")
public class EStoreController {
    @Autowired
    private PaymentTypeRepository pRepository;

    @Autowired
    private CMSService eVoucherService;

    @Autowired
    private PaymentService paymentService;

    @GetMapping
    public List<EVoucher> getAllEVouchers() {
        return eVoucherService.getAllEVouchers();
    }

    @GetMapping("/{id}")
    public EVoucher getEVoucherDetail(@RequestParam Long id) {
        return eVoucherService.getEVoucherDetail(id);
    }

    @PostMapping("/savePaymentType")
    public ResponseEntity<?> savePaymentType(@RequestBody PaymentType p) {
        pRepository.save(p);
        return ResponseEntity.status(HttpStatus.CREATED).body(p);
    }

    @GetMapping("/getAllPaymentTypes")
    public ResponseEntity<?> getAllPaymentTypes() {
        List<PaymentType> list = pRepository.findAll();
        return ResponseEntity.ok(list);
    }

    @PostMapping("/savePayment")
    public ResponseEntity<?> savePayment(@RequestBody PaymentHeader payment) {
        paymentService.savePayment(payment);
        return ResponseEntity.ok(payment);
    }
}
