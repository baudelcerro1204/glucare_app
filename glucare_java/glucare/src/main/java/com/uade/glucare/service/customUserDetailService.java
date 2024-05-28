package com.uade.glucare.service;

import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import java.util.Collections;

@Service
public class customUserDetailService implements UserDetailsService {

    @Autowired
    private userRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String correoElectronico) throws UsernameNotFoundException {
        User user = userRepository.findByCorreoElectronico(correoElectronico);

        return new org.springframework.security.core.userdetails.User(user.getCorreoElectronico(), user.getContraseña(), Collections.emptyList());
    }
}
