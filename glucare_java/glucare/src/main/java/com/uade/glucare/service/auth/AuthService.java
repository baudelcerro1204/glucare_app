package com.uade.glucare.service.auth;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.uade.glucare.model.Role;
import com.uade.glucare.model.User;
import com.uade.glucare.model.auth.AuthResponse;
import com.uade.glucare.model.auth.LoginRequest;
import com.uade.glucare.model.auth.RegisterRequest;
import com.uade.glucare.repository.userRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {
    
    private final userRepository userRepository;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;

    public AuthResponse login(LoginRequest request) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getCorreoElectronico(), request.getPassword()));
        UserDetails user = userRepository.findByCorreoElectronico(request.getCorreoElectronico());
        String token = jwtService.getToken(user);
        return AuthResponse.builder()
            .token(token)
            .build();
    }

    public AuthResponse register(RegisterRequest request) {
        String encodedPassword = passwordEncoder.encode(request.getPassword());
        User user = User.builder()
            .nombre(request.getNombre())
            .correoElectronico(request.getCorreoElectronico())
            .password(encodedPassword)
            .edad(request.getEdad())
            .diabetesTipo(request.getDiabetesTipo())
            .role(Role.USER)
            .build();
        userRepository.save(user);

        return AuthResponse.builder()
            .token(jwtService.getToken(user))
            .build();
    }
}