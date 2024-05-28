package com.uade.glucare.service;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private userRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String correoElectronico) throws UsernameNotFoundException {
        User user = userRepository.findByCorreoElectronico(correoElectronico);
        if (user == null) {
            throw new UsernameNotFoundException("User not found with email: " + correoElectronico);
        }
        return new org.springframework.security.core.userdetails.User(user.getCorreoElectronico(), user.getContraseña(), new ArrayList<>());
    }
}
