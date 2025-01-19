package com.example.estore.models;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
public class PurchaseRequest {
    private Boolean used;
    private List<Long> eVoucherId;
}
