package com.uade.glucare.controller;

import org.springframework.web.bind.annotation.RestController;

import com.uade.glucare.model.auth.AuthResponse;
import com.uade.glucare.model.auth.LoginRequest;
import com.uade.glucare.model.auth.RegisterRequest;
import com.uade.glucare.service.auth.AuthService;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;



@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    
    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest loginRequest) {
        AuthResponse authResponse = authService.login(loginRequest);
        return ResponseEntity.ok(authResponse);
    }

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@RequestBody RegisterRequest request) {
        AuthResponse authResponse = authService.register(request);
        return ResponseEntity.ok(authResponse);
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestHeader("Authorization") String token) {
        // Extraer el token sin el prefijo "Bearer"
        String actualToken = token.replace("Bearer ", "");
        authService.logout(actualToken);
        return ResponseEntity.ok().build();
    }
}
