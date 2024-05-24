package com.uade.glucare.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "reminder")
public class Reminder {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "fecha_hora_recordatorio")
    private LocalDateTime fechaHoraRecordatorio;

    @Column(name = "tipo")
    private String tipo;

    @Column(name = "descripcion")
    private String descripcion;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Long getId() {
        return id;
    }

    public LocalDateTime getFechaHoraRecordatorio() {
        return fechaHoraRecordatorio;
    }

    public String getTipo() {
        return tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setFechaHoraRecordatorio(LocalDateTime fechaHoraRecordatorio) {
        this.fechaHoraRecordatorio = fechaHoraRecordatorio;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

}
