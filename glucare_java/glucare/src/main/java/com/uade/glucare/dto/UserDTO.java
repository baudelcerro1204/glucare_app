package com.uade.glucare.dto;

public class UserDTO {
        private final String nombre;
        private final String correoElectronico;
        private final int edad;
    
        public UserDTO(String nombre, String correoElectronico, int edad) {
            this.nombre = nombre;
            this.correoElectronico = correoElectronico;
            this.edad = edad;
        }
    
        public String getNombre() {
            return nombre;
        }
    
        public String getCorreoElectronico() {
            return correoElectronico;
        }
    
        public int getEdad() {
            return edad;
        }
}
