package com.uade.glucare.service;

import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class userService {

    @Autowired
    private userRepository userRepository;


    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public boolean authenticateUser(String correoElectronico, String password) {
        User user = userRepository.findByCorreoElectronico(correoElectronico);
        System.out.println("User not found with email: " + correoElectronico);
        return false;
    }
}

