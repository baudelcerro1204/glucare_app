package com.uade.glucare.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.uade.glucare.model.CommunityPost;
import com.uade.glucare.model.User;
import com.uade.glucare.repository.userRepository;
import com.uade.glucare.repository.CommunityPostRepository;

@Service
public class CommunityPostService {

    @Autowired
    private CommunityPostRepository communityPostRepository;

    @Autowired
    private userRepository userRepository;

    public List<CommunityPost> getAllPosts() {
        return communityPostRepository.findAllByOrderByDateDesc();
    }

    public CommunityPost createPost(CommunityPost post) {
        // Obtener el usuario autenticado
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User authenticatedUser;

        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            authenticatedUser = userRepository.findByCorreoElectronico(username);
        } else {
            throw new UsernameNotFoundException("User not authenticated");
        }

        // Asigna el usuario a la publicación
        post.setUser(authenticatedUser);
        post.setUserName(authenticatedUser.getNombre());
        post.setDate(new Date());

        // Guarda la publicación en el repositorio
        return communityPostRepository.save(post);
    }
    
}
