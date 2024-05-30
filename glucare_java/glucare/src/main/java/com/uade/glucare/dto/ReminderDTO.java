package com.uade.glucare.dto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class ReminderDTO {
    private Long id;  // Añadir este campo
    private String title;
    private String description;
    private LocalDate date;
    private LocalTime time;
    private List<Boolean> repeatDays;
    private String etiqueta;

    // Getters y Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public List<Boolean> getRepeatDays() {
        return repeatDays;
    }

    public void setRepeatDays(List<Boolean> repeatDays) {
        this.repeatDays = repeatDays;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }
}
