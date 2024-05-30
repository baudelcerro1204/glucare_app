package com.uade.glucare.service;

import com.uade.glucare.dto.UserDTO;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class userService {

    @Autowired
    private userRepository userRepository;


    public User saveUser(User user) {
        return userRepository.save(user);
    }

    @Transactional
    public void updateUser(Long id, UserDTO user) {
        User userToUpdate = userRepository.findUserById(id);
        userToUpdate.setNombre(user.getNombre());
        userToUpdate.setCorreoElectronico(user.getCorreoElectronico());
        userToUpdate.setEdad(user.getEdad());
        userRepository.save(userToUpdate);
    }

    public boolean authenticateUser(String correoElectronico, String password) {
        User user = userRepository.findByCorreoElectronico(correoElectronico);
        System.out.println("User not found with email: " + correoElectronico);
        return false;
    }
}

