package com.my.test.service;

import com.my.test.model.SysRole;

import java.util.List;

/**
 * SysRoleSV
 */
public interface SysRoleSV {

    /**
     * 批量删除角色
     * 
     * @param ids
     * @return
     */
    public int deleteBatch(List<Long> ids);

    /**
     * 查询用户角色信息
     * 
     * @param userId
     * @return
     */
    public List<SysRole> getRoleList(Long userId);

   /* *
     * 更新用户的角色
     * 
     * @param updateRole
     * @return*/

    public int updateRole(Long userId, List<Long> roleIds);
}