package com.uade.glucare.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Column;

@Entity
@Table(name = "food_item")
public class FoodItem {

//     Atributos:
// nombre: String
// cantidadCarbohidratos: double
// cantidadProteinas: double
// cantidadGrasas: double

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "descripcion")
    private String descripcion;

    @Column(name = "cantidad_calorias")
    private double cantidadCalorias;

    @Column(name = "cantidad_carbohidratos")
    private double cantidadCarbohidratos;

    @Column(name = "cantidad_fibra")
    private double cantidadFibra;

    @Column(name = "cantidad_proteinas")
    private double cantidadProteinas;

    @Column(name = "cantidad_grasas")
    private double cantidadGrasas;

    @Column(name = "vitamina")
    private String vitamina;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;


    public Long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public double getCantidadCalorias() {
        return cantidadCalorias;
    }

    public double getCantidadCarbohidratos() {
        return cantidadCarbohidratos;
    }

    public double getCantidadFibra() {
        return cantidadFibra;
    }

    public double getCantidadProteinas() {
        return cantidadProteinas;
    }
 
    public String getVitamina() {
        return vitamina;
    }

    public double getCantidadGrasas() {
        return cantidadGrasas;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCantidadCalorias(double cantidadCalorias) {
        this.cantidadCalorias = cantidadCalorias;
    }

    public void setCantidadFibra(double cantidadFibra) {
        this.cantidadFibra = cantidadFibra;
    }


    public void setCantidadCarbohidratos(double cantidadCarbohidratos) {
        this.cantidadCarbohidratos = cantidadCarbohidratos;
    }

    public void setCantidadProteinas(double cantidadProteinas) {
        this.cantidadProteinas = cantidadProteinas;
    }

    public void setCantidadGrasas(double cantidadGrasas) {
        this.cantidadGrasas = cantidadGrasas;
    }

    public void setVitamina(String vitamina) {
        this.vitamina = vitamina;
    }
    
}
