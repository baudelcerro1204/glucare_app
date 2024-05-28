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

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User saveUser(User user) {
        user.setContraseña(passwordEncoder.encode(user.getContraseña()));
        return userRepository.save(user);
    }

    public boolean authenticateUser(String correoElectronico, String password) {
        User user = userRepository.findByCorreoElectronico(correoElectronico);
        if (user != null) {
            boolean passwordsMatch = passwordEncoder.matches(password, user.getContraseña());
            System.out.println("Passwords match: " + passwordsMatch);
            return passwordsMatch;
        }
        System.out.println("User not found with email: " + correoElectronico);
        return false;
    }
}

