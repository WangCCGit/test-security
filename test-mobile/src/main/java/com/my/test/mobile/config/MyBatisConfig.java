package com.my.test.mobile.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * MyBatis配置类
 *
 * @author test
 * @since 2019/9/19.
 */
@Configuration
@EnableTransactionManagement
@MapperScan({"com.my.test.mapper", "com.my.test.dao"})
@ComponentScan(value = "com.my.test.service")
public class MyBatisConfig {
}
