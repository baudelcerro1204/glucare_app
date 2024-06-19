package com.uade.glucare.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class FoodDTO {
    private String nombre;
    private String calorias;
    private String proteinas;
    private String grasas;
    private String carbohidratos;
    private LocalDate date;
    private LocalTime time;
    private Long userId;
    
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getCalorias() {
        return calorias;
    }
    public void setCalorias(String calorias) {
        this.calorias = calorias;
    }
    public String getProteinas() {
        return proteinas;
    }
    public void setProteinas(String proteinas) {
        this.proteinas = proteinas;
    }
    public String getGrasas() {
        return grasas;
    }
    public void setGrasas(String grasas) {
        this.grasas = grasas;
    }
    public String getCarbohidratos() {
        return carbohidratos;
    }
    public void setCarbohidratos(String carbohidratos) {
        this.carbohidratos = carbohidratos;
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
