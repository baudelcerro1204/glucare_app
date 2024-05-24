package com.uade.glucare.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue
    @Column(name = "user_id")
    private Long id;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "correoElectronico")
    private String correoElectronico;

    @Column(name = "contraseña")
    private String contraseña;

    @Column(name = "edad")
    private int edad;

    @Column(name = "diabetesTipo")
    private int diabetesTipo;

    @OneToOne(mappedBy = "user", fetch = FetchType.LAZY)
    @PrimaryKeyJoinColumn
    private VirtualPet mascotaVirtual;

    @OneToMany(mappedBy = "user")
    private List<DiaryEntry> historialDiario;

    @OneToMany(mappedBy = "user")
    private List<Medicine> medicamentos;

    @OneToMany(mappedBy = "user")
    private List<FoodItem> alimentacion;

    @OneToMany(mappedBy = "user")
    private List<PhysicalActivity> actividadFisica;

    @OneToMany(mappedBy = "user")
    private List<Reminder> recordatorios;

    //Getter y setters

    public Long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public String getContraseña() {
        return contraseña;
    }

    public int getEdad() {
        return edad;
    }

    public int getDiabetesTipo() {
        return diabetesTipo;
    }

    public VirtualPet getMascotaVirtual() {
        return mascotaVirtual;
    }

    public List<DiaryEntry> getHistorialDiario() {
        return historialDiario;
    }

    public List<Medicine> getMedicamentos() {
        return medicamentos;
    }

    public List<FoodItem> getAlimentacion() {
        return alimentacion;
    }

    public List<PhysicalActivity> getActividadFisica() {
        return actividadFisica;
    }

    public List<Reminder> getRecordatorios() {
        return recordatorios;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setDiabetesTipo(int diabetesTipo) {
        this.diabetesTipo = diabetesTipo;
    }

    public void setMascotaVirtual(VirtualPet mascotaVirtual) {
        this.mascotaVirtual = mascotaVirtual;
    }

    public void setHistorialDiario(List<DiaryEntry> historialDiario) {
        this.historialDiario = historialDiario;
    }

    public void setMedicamentos(List<Medicine> medicamentos) {
        this.medicamentos = medicamentos;
    }

    public void setAlimentacion(List<FoodItem> alimentacion) {
        this.alimentacion = alimentacion;
    }

    public void setActividadFisica(List<PhysicalActivity> actividadFisica) {
        this.actividadFisica = actividadFisica;
    }

    public void setRecordatorios(List<Reminder> recordatorios) {
        this.recordatorios = recordatorios;
    }

}
