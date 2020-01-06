package com.my.test.admin.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * MyBatis配置类
 *
 * @author test
 * @since 2019/4/8.
 */
@Configuration
@EnableTransactionManagement
@MapperScan({"com.my.test.mapper", "com.my.test.dao"})
@ComponentScan(value = "com.my.test.service")
@ComponentScan(value = "com.my.test.mapper")
public class MyBatisConfig {
}
