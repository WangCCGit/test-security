package com.my.test.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

/**
 * RegisterParam
 *
 * @author steven
 * @since 2019/11/19.
 */
@Data
public class RegisterParamDTO {

    /**
     * 用户名
     */
    @ApiModelProperty(value = "用户名")
    private String username;

    /**
     * 手机号
     */
    @ApiModelProperty(value = "手机号码")
    @NotEmpty(message = "手机号不能为空")
    private String phone;

    /**
     * 登录密码
     */
    @ApiModelProperty(value = "登录密码")
    @NotEmpty(message = "密码不能为空")
    @Size(min = 6, message = "密码长度不能低于6位")
    private String password;

    /**
     * 短信验证码
     */
    @ApiModelProperty(value = "短信验证码")
    //@NotEmpty(message = "短信验证码不能为空")
    @Size(min = 6, max = 6, message = "短信验证码错误")
    private String authCode;

    /**
     * 邀请码
     */
    @ApiModelProperty(value = "邀请码")
    private String inviteCode;

}