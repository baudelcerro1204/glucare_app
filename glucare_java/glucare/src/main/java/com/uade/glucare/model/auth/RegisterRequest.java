package com.uade.glucare.model.auth;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {
    private String nombre;
    private String correoElectronico;
    private String password;
    private int edad;
    private int diabetesTipo;
}
