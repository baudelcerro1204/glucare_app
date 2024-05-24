package com.uade.glucare.model;

import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
@Table(name = "physical_activity")
public class PhysicalActivity {


    @Id
    @GeneratedValue
    @Column(name = "physical_activity_id")
    private Long id;

    @Column(name = "tipo")
    private String tipo;

    @Column(name = "intensidad")
    private String intensidad;

    @Column(name = "duracion")
    private int duracion;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Long getId() {
        return id;
    }

    public String getTipo() {
        return tipo;
    }

    public String getIntensidad() {
        return intensidad;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setIntensidad(String intensidad) {
        this.intensidad = intensidad;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }
}
