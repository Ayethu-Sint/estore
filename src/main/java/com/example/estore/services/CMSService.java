package com.example.estore.services;

import com.example.estore.entities.EVoucher;
import com.example.estore.models.PurchaseRequest;
import com.example.estore.models.TokenResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;

@Slf4j
@Service
public class CMSService{
    @Value("${server.evoucher.url}")
    private String eVoucherUrl;

    private final WebClient webClient;
    @Autowired
    private ReactorClientHttpConnector reactorClientHttpConnector;


    @Autowired
    public CMSService(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl(eVoucherUrl).build();
    }

    private WebClient eVoucherApi(String token) {
        WebClient.Builder builder = WebClient.builder()
                .exchangeStrategies(ExchangeStrategies.builder()
                        .codecs(configure -> configure
                                .defaultCodecs()
                                .maxInMemorySize(100 * 1024 * 1024))
                        .build())
                .clientConnector(reactorClientHttpConnector)
                .baseUrl(eVoucherUrl);

        if (token != null) {
            builder = builder.defaultHeader(HttpHeaders.AUTHORIZATION, "Bearer " + token);
        }
        return builder.build();
    }

    public List<EVoucher> getAllEVouchers() {
        // Step 1: Get the token from the getToken() method
        String token = getToken().getAccessToken(); // Get the token dynamically

        // Step 2: Make the request with Bearer token authorization
        return eVoucherApi(null).get()
                .uri("/api/estore")
                .header("Authorization", "Bearer " + token)  // Add the Bearer token here
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<List<EVoucher>>() {})
                .block(); // For synchronous call, use .block()
    }

    public TokenResponse getToken() {
        log.info("token");
        // Retrieve the token from the '/getToken' API
        return eVoucherApi(null).get()
                .uri("/getToken")
                .retrieve()
                .bodyToMono(TokenResponse.class)
                .block();  // Block to get the response synchronously
    }

    public EVoucher getEVoucherDetail(Long id) {
        // Step 1: Get the token from the getToken() method
        String token = getToken().getAccessToken(); // Get the token dynamically

        return eVoucherApi(null).post()
                .uri("/api/estore?id={id}", id)
                .header("Authorization", "Bearer " + token)  // Add the Bearer token here
                .retrieve()
                .bodyToMono(EVoucher.class)
                .block();
    }

    public List<EVoucher> getEVoucherDetailByPurchase(List<Long> eVoucherIds, Boolean used) {
        String token = getToken().getAccessToken();

        PurchaseRequest requestBody = new PurchaseRequest();
        requestBody.setEVoucherId(eVoucherIds);
        requestBody.setUsed(used);
        // Step 3: Make the API call
        return eVoucherApi(null).post()
                .uri("/api/estore/getEVoucher")
                .header("Authorization", "Bearer " + token) // Add Bearer token
                .bodyValue(requestBody) // Set the body
                .retrieve()
                .bodyToFlux(EVoucher.class) // Convert response to a list of EVoucher
                .collectList() // Collect the response as a list
                .block(); // Block for synchronous response (if required)
    }

    public String setUsedPromoCode(Long promoCodeId) {
        String token = getToken().getAccessToken();
        return eVoucherApi(null).get()
                .uri("/api/cms?promoCodeId={promoCodeId}", promoCodeId)
                .header("Authorization", "Bearer " + token)
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }

    public String deactiveEVoucher(Long id) {
            String token = getToken().getAccessToken();
            return eVoucherApi(null).get()
                    .uri("/api/cms?id={id}", id)
                    .header("Authorization", "Bearer " + token)
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();
    }
}
