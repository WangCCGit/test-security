package com.my.test.common.api;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

/**
 * @description: BaseQueryDTO
 */
@Setter
@Getter
public class BaseQueryDTO {

    @ApiModelProperty(value = "页数",required = true)
    @NotNull(message = "分页信息错误")
    private Integer pageNum;

    @ApiModelProperty(value = "每页显示条数",required = true)
    @NotNull(message = "分页信息错误")
    private Integer pageSize;

}
