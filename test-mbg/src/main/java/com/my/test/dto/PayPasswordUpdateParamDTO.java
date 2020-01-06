package com.my.test.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotEmpty;

/**
 * 支付密码更新
 *
 * @author steven
 * @since 2019/11/19.
 */
@Data
public class PayPasswordUpdateParamDTO {

    /**
     * 手机号
     */
    private String phone;

    /**
     * 新密码
     */
    @ApiModelProperty(value = "新密码")
    @NotEmpty(message = "新密码不能为空")
    @Length(min = 6, message = "密码长度不能低于6位")
    private String newPassword;

    /**
     * 短信验证码
     */
    @ApiModelProperty(value = "短信验证码")
    @NotEmpty(message = "短信验证码不能为空")
    @Length(min = 6, max=6, message = "短信验证码错误")
    private String authCode;
}