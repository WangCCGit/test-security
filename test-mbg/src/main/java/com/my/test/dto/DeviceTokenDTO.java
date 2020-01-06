package com.my.test.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeviceTokenDTO {

    @ApiModelProperty(value = "APP类型0-安卓1-IOS")
    private Integer appCate;

    /**
     * 当前登录设备deviceToken
     *
     * @mbg.generated
     */
    @ApiModelProperty(value = "当前登录设备deviceToken")
    private String deviceToken;

}
