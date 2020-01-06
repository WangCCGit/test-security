package com.my.test.vo;

import com.my.test.model.SysPermission;
import lombok.Data;

import java.util.List;

/**
 * SysPermissionNodeVO
 */
@Data
public class SysPermissionNodeVO extends SysPermission {

    private static final long serialVersionUID = -3269799006634091806L;
    
    private List<SysPermissionNodeVO> children;
}