package com.uade.glucare.model;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.persistence.Entity;

@Entity
@Table(name = "prediction")
public class Prediction {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "fecha")
    private LocalDate fecha;

    @Column(name = "hora")
    private LocalTime hora;

    @Column(name = "prediccion")
    private String prediccion;

    public Long getId() {
        return id;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public LocalTime getHora() {
        return hora;
    }

    public String getPrediccion() {
        return prediccion;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public void setHora(LocalTime hora) {
        this.hora = hora;
    }

    public void setPrediccion(String prediccion) {
        this.prediccion = prediccion;
    }

}
