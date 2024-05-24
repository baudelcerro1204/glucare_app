package com.uade.glucare.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;

@Entity
@Table(name = "virtual_pet")
public class VirtualPet {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "estado")
    private String estado;

    @Column(name = "nivel_hambre")
    private int nivelHambre;

    @Column(name = "nivel_felicidad")
    private int nivelFelicidad;

    @Column(name = "nivel_energia")
    private int nivelEnergia;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public String getNombre() {
        return nombre;
    }

    public String getEstado() {
        return estado;
    }

    public int getNivelHambre() {
        return nivelHambre;
    }

    public int getNivelFelicidad() {
        return nivelFelicidad;
    }

    public int getNivelEnergia() {
        return nivelEnergia;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setNivelHambre(int nivelHambre) {
        this.nivelHambre = nivelHambre;
    }

    public void setNivelFelicidad(int nivelFelicidad) {
        this.nivelFelicidad = nivelFelicidad;
    }

    public void setNivelEnergia(int nivelEnergia) {
        this.nivelEnergia = nivelEnergia;
    }

}
