package com.uade.glucare.model.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChangePasswordRequest {
    private String correoElectronico;
    private String oldPassword;
    private String newPassword;
}
