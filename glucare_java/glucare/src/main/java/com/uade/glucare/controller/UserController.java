package com.uade.glucare.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import com.uade.glucare.model.LoginRequest;
import com.uade.glucare.model.User;
import com.uade.glucare.service.userService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;


@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private userService userService;

    @PostMapping("/register")
    public User registerUser(@RequestBody User user) {
        return userService.saveUser(user);
    }

     @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody LoginRequest loginRequest) {
        // Verificar las credenciales y autenticar al usuario
        boolean user = userService.authenticateUser(loginRequest.getCorreoElectronico(), loginRequest.getPassword());
        
        if (user) {
            // Si las credenciales son válidas, devolver una respuesta de éxito
            return ResponseEntity.ok("Inicio de sesión exitoso para el usuario: " + loginRequest.getCorreoElectronico());
        } else {
            // Si las credenciales no son válidas, devolver una respuesta de error
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
