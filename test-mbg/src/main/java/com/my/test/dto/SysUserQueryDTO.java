package com.my.test.dto;

import com.my.test.common.api.BaseQueryDTO;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * SysUserQueryDTO
 */
@Setter
@Getter
@ToString
public class SysUserQueryDTO extends BaseQueryDTO {

    @ApiModelProperty(value = "用户名")
    private String userName;

    @ApiModelProperty(value = "用户手机号")
    private String phone;
}