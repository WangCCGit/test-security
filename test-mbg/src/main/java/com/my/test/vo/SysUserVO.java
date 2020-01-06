package com.my.test.vo;

import com.my.test.model.SysUser;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * SysUserVO
 */
@Setter
@Getter
@ToString
public class SysUserVO extends SysUser {
    
    private static final long serialVersionUID = 8686322781281172902L;

    private String departmentName;

    private String roleName;
    
}