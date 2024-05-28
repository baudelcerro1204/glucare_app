package com.uade.glucare.service;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.uade.glucare.repository.userRepository;
import com.uade.glucare.model.User;


@Service
public class userService {

    @Autowired
    private userRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
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
        user.setContraseña(passwordEncoder.encode(user.getContraseña()));
        return userRepository.save(user);
    }

    public boolean authenticateUser(String correoElectronico, String password) {
        User user = userRepository.findByCorreoElectronico(correoElectronico);
        if (user != null) {
            return passwordEncoder.matches(password, user.getContraseña());
        }
        return false;
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
}
