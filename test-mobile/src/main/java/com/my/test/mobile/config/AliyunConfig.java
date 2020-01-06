package com.my.test.mobile.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Setter
@Getter
@Configuration
@ConfigurationProperties("aliyun")
public class AliyunConfig {

    private String accessKeyId;

    private String accessKeySecret;

}
