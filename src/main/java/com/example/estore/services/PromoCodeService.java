package com.example.estore.services;

import com.example.estore.common.RandomStringGenerator;
import com.example.estore.entities.EVoucher;
import com.example.estore.entities.PromoCode;
import com.example.estore.repositories.PromoCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PromoCodeService {
    @Autowired
    private PromoCodeRepository promoCodeRepository;

    // Generate Promo Codes for the eVoucher
    public void generatePromoCodes(EVoucher evoucher, int quantity) {
        for (int i = 0; i < quantity; i++) {
            String promoCode = generatePromoCode();
            PromoCode promo = new PromoCode();
            promo.setPromoCode(promoCode);
            promo.setEVoucher(evoucher);
            promo.setPhoneNumber(evoucher.getPhoneNumber());
            promo.setQrCodeImageUrl(generateQRCode(promoCode));
            promoCodeRepository.save(promo);
        }
    }

    // Generate a unique Promo Code (11 AlphaNumeric)
    private String generatePromoCode() {
        String promoCode = RandomStringGenerator.generateRandomAlphanumeric(6) +
                RandomStringGenerator.generateRandomAlphabetic(5);
        while (promoCodeRepository.existsByPromoCode(promoCode)) {
            promoCode = RandomStringGenerator.generateRandomAlphanumeric(6) +
                    RandomStringGenerator.generateRandomAlphabetic(5);
        }
        return promoCode;
    }

    // Generate QR Code image URL for the promo code
    private String generateQRCode(String promoCode) {
        // Use a library to generate QR code
        return "http://example.com/qr-codes/" + promoCode + ".png";
    }
}
