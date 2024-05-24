package com.uade.glucare.model;

import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.util.List;

@Entity
@Table(name = "diary_entry")
public class DiaryEntry {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "fecha")
    private LocalDate fecha;

    @Column(name = "hora")
    private LocalTime hora;

    @ManyToOne
    @JoinColumn(name = "mood_id")
    private Mood estadoAnimo;

    @Column(name = "medicamentos_tomados")
    @ManyToMany
    private List<Medicine> medicamentosTomados;

    @Column(name = "alimentos_consumidos")
    @ManyToMany
    private List<FoodItem> alimentosConsumidos;

    @ManyToOne
    @JoinColumn(name = "physical_activity_id")
    private PhysicalActivity actividadFisicaRealizada;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    //Getters y setters
    public Long getId() {
        return id;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public LocalTime getHora() {
        return hora;
    }

    public void setHora(LocalTime hora) {
        this.hora = hora;
    }

    public Mood getEstadoAnimo() {
        return estadoAnimo;
    }

    public void setEstadoAnimo(Mood estadoAnimo) {
        this.estadoAnimo = estadoAnimo;
    }

    public List<Medicine> getMedicamentosTomados() {
        return medicamentosTomados;
    }

    public void setMedicamentosTomados(List<Medicine> medicamentosTomados) {
        this.medicamentosTomados = medicamentosTomados;
    }

    public List<FoodItem> getAlimentosConsumidos() {
        return alimentosConsumidos;
    }

    public void setAlimentosConsumidos(List<FoodItem> alimentosConsumidos) {
        this.alimentosConsumidos = alimentosConsumidos;
    }

    public PhysicalActivity getActividadFisicaRealizada() {
        return actividadFisicaRealizada;
    }

    public void setActividadFisicaRealizada(PhysicalActivity actividadFisicaRealizada) {
        this.actividadFisicaRealizada = actividadFisicaRealizada;
    }


   
}
