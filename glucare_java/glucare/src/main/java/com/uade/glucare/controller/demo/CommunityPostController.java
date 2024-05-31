package com.uade.glucare.controller.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.glucare.model.CommunityPost;
import com.uade.glucare.service.CommunityPostService;

@RestController
@RequestMapping("/posts")
public class CommunityPostController {
    @Autowired
    private CommunityPostService postService;

    @GetMapping("/getAll")
    public List<CommunityPost> getAllPosts() {
        return postService.getAllPosts();
    }

    @PostMapping("/create")
    public CommunityPost createPost(@RequestBody CommunityPost post) {
        return postService.createPost(post);
    }
}