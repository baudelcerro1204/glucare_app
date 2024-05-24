package com.uade.glucare.model;

import jakarta.annotation.Generated;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "medicine")
public class Medicine {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "dosis")
    private double dosis;

    @Column(name = "frecuencia")
    private String frecuencia;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public double getDosis() {
        return dosis;
    }

    public String getFrecuencia() {
        return frecuencia;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDosis(double dosis) {
        this.dosis = dosis;
    }

    public void setFrecuencia(String frecuencia) {
        this.frecuencia = frecuencia;
    }
    
}
