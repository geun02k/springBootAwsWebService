package com.book.spring.boot.aws.web.service.config.auth.dto;

import com.book.spring.boot.aws.web.service.domain.user.User;
import lombok.Getter;

import java.io.Serializable;

@Getter
public class SessionUser implements Serializable {

    private static final long serialVersionUID = 1L;

    private String name;
    private String email;
    private String picture;

    public SessionUser(User user) {
        this.name = user.getName();
        this.email = user.getEmail();
        this.picture = user.getPicture();
    }

}
