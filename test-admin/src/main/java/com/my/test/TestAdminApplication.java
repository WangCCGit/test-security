package com.my.test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

//import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * 应用启动入口
 *
 * @author test
 * @since 2019/11/19.
 */
//@EnableDiscoveryClient
@SpringBootApplication
public class TestAdminApplication {
    public static void main(String[] args) {
        SpringApplication.run(TestAdminApplication.class, args);
    }

    @Bean
    public RestTemplate get(){
        return new RestTemplate();
    }

}
