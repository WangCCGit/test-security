package com.my.test.security.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.ArrayList;
import java.util.List;

/**
 * 用于配置不需要保护的资源路径
 *
 * @author test
 * @since 2019/11/19.
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "ignored")
public class IgnoreUrlsConfig {

    private List<String> urls = new ArrayList<>();

}
