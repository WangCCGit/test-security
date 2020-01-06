package com.my.test.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;

/**
 * LoginParamDTO 后台管理系统登录参数
 */
@Data
public class LoginDTO {

    // 手机号
    @ApiModelProperty(value = "手机号码", required = true)
    @NotEmpty(message = "手机号不能为空")
    private String phone;

    // 登录密码
    @ApiModelProperty(value = "登录密码", required = true)
    @NotEmpty(message = "密码不能为空")
    private String password;
}