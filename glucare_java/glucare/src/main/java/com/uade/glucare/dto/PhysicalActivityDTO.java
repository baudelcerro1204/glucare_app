package com.uade.glucare.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class PhysicalActivityDTO {
    private String nombre;
    private LocalDate date;
    private LocalTime time;
    private Long userId;
    
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public LocalDate getDate() {
        return date;
    }
    public void setDate(LocalDate date) {
        this.date = date;
    }
    public LocalTime getTime() {
        return time;
    }
    public void setTime(LocalTime time) {
        this.time = time;
    }
    public Long getUserId() {
        return userId;
    }
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    
}
