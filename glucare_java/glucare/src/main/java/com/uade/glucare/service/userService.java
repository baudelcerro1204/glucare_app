package com.uade.glucare.service;

import java.util.ArrayList;
import org.hibernate.mapping.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.userRepository;
import com.uade.glucare.model.User;


@Service
public class userService {

    @Autowired
    private userRepository userRepository;
    
    public User getUserByCorreoElectronico(String correoElectronico) {
        return userRepository.findByCorreoElectronico(correoElectronico);
    }

    public User getUserByNombre(String nombre) {
        return userRepository.findByNombre(nombre);
    }

    public ArrayList<User> getUsers() {
        return userRepository.findAll();
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public User updateUser(User user) {
        User usuarioExistente = userRepository.findByCorreoElectronico(user.getCorreoElectronico());
        usuarioExistente.setNombre(user.getNombre());
        usuarioExistente.setEdad(user.getEdad());
        usuarioExistente.setDiabetesTipo(user.getDiabetesTipo());
        usuarioExistente.setCorreoElectronico(user.getCorreoElectronico());
        return userRepository.save(usuarioExistente);
    }

    public String deleteUser(User user) {
        userRepository.delete(user);
        return "User deleted";
    }

    public String deleteUserByCorreoElectronico(String correoElectronico) {
        userRepository.deleteByCorreoElectronico(correoElectronico);
        return "User " + correoElectronico + " deleted";
    }

    public boolean authenticateUser(String correoElectronico, String contraseña) {
        // Buscar al usuario por correo electrónico en la base de datos
        User user = userRepository.findByCorreoElectronico(correoElectronico);
        
        // Verificar si el usuario existe y si la contraseña coincide
        if (user != null && user.getContraseña().equals(contraseña)) {
            return true; // Credenciales válidas
        } else {
            return false; // Credenciales inválidas
        }
    }
}
