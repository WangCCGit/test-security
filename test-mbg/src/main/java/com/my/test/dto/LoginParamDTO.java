package com.my.test.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * LoginParamDTO
 */
@Data
public class LoginParamDTO {

    /**
     * 手机号
     */
    @ApiModelProperty(value = "手机号码")
    @NotNull
    private String phone;

    /**
     * 登录密码
     */
    @ApiModelProperty(value = "登录密码")
    @NotNull
    private String password;
}