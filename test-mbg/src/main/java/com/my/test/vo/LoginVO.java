package com.my.test.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * LoginVO
 */
@Data
public class LoginVO {

    @ApiModelProperty(value = "Token信息")
    private String token;

    @ApiModelProperty(value = "Token头标识")
    private String tokenHead;

}