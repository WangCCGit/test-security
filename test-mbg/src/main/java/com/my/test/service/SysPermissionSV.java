package com.my.test.service;

import com.my.test.model.SysPermission;
import com.my.test.vo.SysPermissionNodeVO;

import java.util.List;

/**
 * SysPermissionSV
 */
public interface SysPermissionSV {

    /**
     * 根据手机号和方法加载用户权限
     * @param phone
     * @param method
     * @return
     */
    public List<SysPermission> getPermissionByPhoneAndMethod(String phone, String method);

    /**
     * 根据用户ID加载用户权限
     * @param userId
     * @return
     */
    public List<SysPermission> getPermissionByUserId(Long userId);

    /**
     * 根据角色ID加载用户权限
     * @param roleId
     * @return
     */
    public List<SysPermission> getPermissionByRoleId(Long roleId);

    /**
     * 批量删除权限
     * @param ids
     * @return
     */
    public int deleteBatch(List<Long> ids);

    /**
     * 根据角色ID更新权限
     *
     * @param roleId
     * @param permissionIds
     * @return
     */
    public int updatePermission(Long roleId, List<Long> permissionIds);


    /**
     * 加载所有权限树形结构
     * @param userId
     * @return
     */
    public List<SysPermissionNodeVO> getTressList();

    /**
     * 根据用户ID和类型加载权限树形结构
     * @param userId
     * @return
     */
    public List<SysPermissionNodeVO> getTressListByUserIdAndType(Long userId, Integer type);

    /**
     * 根据用户ID和类型加载用户权限
     * @param userId
     * @param type
     * @return
     */
    public List<SysPermission> getPermissionByUserIdAndType(Long userId, Integer type);


}