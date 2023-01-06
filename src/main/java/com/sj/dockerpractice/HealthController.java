package com.sj.dockerpractice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    @GetMapping("ping")
    public String healthCheck() {
        return "pong!";
    }

    @GetMapping("")
    public String hello() {
        return "Success";
    }

}
