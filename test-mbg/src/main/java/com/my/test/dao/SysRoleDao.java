package com.my.test.dao;

import com.my.test.model.SysRole;

import java.util.List;

/**
 * SysRoleDao
 */
public interface SysRoleDao {

    List<SysRole> getByUserId(Long userId);

    int insertBatch(Long userId, List<Long> roleIds);
}