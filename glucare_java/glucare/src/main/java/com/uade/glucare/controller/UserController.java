package com.uade.glucare.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.uade.glucare.model.LoginRequest;
import com.uade.glucare.model.User;
import com.uade.glucare.service.userService;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private userService userService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @PostMapping("/register")
    public User registerUser(@RequestBody User user) {
        return userService.saveUser(user);
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody LoginRequest loginRequest) {
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getCorreoElectronico(), loginRequest.getPassword())
            );
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return ResponseEntity.ok("Inicio de sesión exitoso para el usuario: " + loginRequest.getCorreoElectronico());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales de inicio de sesión incorrectas");
        }
    }

    @DeleteMapping("/delete/{correoElectronico}")
    public String deleteUserByCorreoElectronico(@PathVariable String correoElectronico) {
        return userService.deleteUserByCorreoElectronico(correoElectronico);
    }

    @PutMapping("/update")
    public User updateUser(@RequestBody User user) {
        return userService.updateUser(user);
    }
}
