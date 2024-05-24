package com.uade.glucare.model;

import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "mood")
public class Mood {

    @Id
    @GeneratedValue
    @Column(name = "mood_id")
    private Long id;

    @Column(name = "fecha")
    private LocalDate fecha;

    @Column(name = "hora")
    private LocalTime hora;

    @Column(name = "estado")    
    private String estado;

    @Column(name = "descripcion")
    private String descripcion;

    public LocalDate getFecha() {
        return fecha;
    }

    public LocalTime getHora() {
        return hora;
    }

    public String getEstado() {
        return estado;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public void setHora(LocalTime hora) {
        this.hora = hora;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }


}
