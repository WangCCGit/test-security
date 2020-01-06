package com.my.test.service.impl;

import com.my.test.dao.SysRoleDao;
import com.my.test.mapper.SysRoleMapper;
import com.my.test.mapper.SysRolePermissionMapper;
import com.my.test.mapper.SysUserRoleMapper;
import com.my.test.model.SysRole;
import com.my.test.model.SysRoleExample;
import com.my.test.model.SysRolePermissionExample;
import com.my.test.model.SysUserRoleExample;
import com.my.test.service.SysRoleSV;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * SysRoleSVImpl
 */
@Service
public class SysRoleSVImpl implements SysRoleSV {

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Autowired
    private SysRoleDao sysRoleDao;

    @Autowired
    private SysUserRoleMapper sysUserRoleMapper;

    @Autowired
    private SysRolePermissionMapper sysRolePermissionMapper;

    @Transactional
    @Override
    public int deleteBatch(List<Long> ids) {
        SysRoleExample example = new SysRoleExample();
        SysRoleExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        int count = sysRoleMapper.deleteByExample(example);
        if (count > 0) {
            SysRolePermissionExample rpExample = new SysRolePermissionExample();
            SysRolePermissionExample.Criteria rpCriteria = rpExample.createCriteria();
            rpCriteria.andRoleIdIn(ids);
            sysRolePermissionMapper.deleteByExample(rpExample);
        }
        return count;
    }

    @Override
    public List<SysRole> getRoleList(Long userId) {
        return sysRoleDao.getByUserId(userId);
    }
    @Transactional
    @Override
    public int updateRole(Long userId, List<Long> roleIds) {
        // 删除老的权限
        SysUserRoleExample example = new SysUserRoleExample();
        SysUserRoleExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(userId);
        sysUserRoleMapper.deleteByExample(example);
        return sysRoleDao.insertBatch(userId, roleIds);
    }
}