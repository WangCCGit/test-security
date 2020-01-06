package com.my.test.dao;

import com.my.test.mallDto.PermissionDto;
import com.my.test.model.SysPermission;

import java.util.List;

/**
 * SysUserDao
 */
public interface SysPermissionDao {

    List<SysPermission> getByPhoneAndMethod(String phone, String method);

    List<SysPermission> getByRoleId(Long roleId);

    List<SysPermission> getByUserId(Long userId);

    List<SysPermission> getByUserIdAndType(Long userId, Integer type);

    int insertBatch(Long roleId, List<Long> permissionIds);

    List<SysPermission> findAll();

    /**
     * 返回所有角色资源
     *
     * @return
     */
    List<PermissionDto> findAllUrl();

}