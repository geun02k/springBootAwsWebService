package com.book.spring.boot.aws.web.service.web;

import com.book.spring.boot.aws.web.service.service.PostsService;
import com.book.spring.boot.aws.web.service.web.dto.PostsResponseDto;
import com.book.spring.boot.aws.web.service.web.dto.PostsSaveRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
public class PostsApiController {

    private final PostsService postsService;

    @PostMapping("/api/v1/posts")
    public Long save(@RequestBody PostsSaveRequestDto requestDto) {
        return postsService.save(requestDto);
    }

    @GetMapping("/api/v1/posts/{id}")
    public PostsResponseDto findById(@PathVariable Long id) {
        return postsService.findById(id);
    }

}
