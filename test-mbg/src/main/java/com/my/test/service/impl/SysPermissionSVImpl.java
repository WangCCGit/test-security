package com.my.test.service.impl;

import com.my.test.dao.SysPermissionDao;
import com.my.test.mapper.SysPermissionMapper;
import com.my.test.mapper.SysRolePermissionMapper;
import com.my.test.model.SysPermission;
import com.my.test.model.SysPermissionExample;
import com.my.test.model.SysRolePermissionExample;
import com.my.test.service.SysPermissionSV;
import com.my.test.vo.SysPermissionNodeVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * SysPermissionSVImpl
 */
@Service
public class SysPermissionSVImpl implements SysPermissionSV {

    @Autowired
    private SysPermissionDao sysPermissionDao;

    @Autowired
    private SysPermissionMapper sysPermissionMapper;

    @Autowired
    private SysRolePermissionMapper sysRolePermissionMapper;

    @Override
    public List<SysPermission> getPermissionByPhoneAndMethod(String phone, String method) {
        List<SysPermission> permission = sysPermissionDao.getByPhoneAndMethod(phone, method.toLowerCase());
        return permission;
    }

    @Override
    public List<SysPermission> getPermissionByUserId(Long userId) {
        return sysPermissionDao.getByUserId(userId);
    }

    @Override
    public List<SysPermission> getPermissionByRoleId(Long roleId) {
        return sysPermissionDao.getByRoleId(roleId);
    }

    @Transactional
    @Override
    public int deleteBatch(List<Long> ids) {
        SysPermissionExample example = new SysPermissionExample();
        SysPermissionExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        int count = sysPermissionMapper.deleteByExample(example);
        if (count > 0) {
            // 删除角色权限关系
            SysRolePermissionExample rpExample = new SysRolePermissionExample();
            SysRolePermissionExample.Criteria rpCriteria = rpExample.createCriteria();
            rpCriteria.andRuleIdIn(ids);
            sysRolePermissionMapper.deleteByExample(rpExample);
        }
        return count;
    }

    @Transactional
    @Override
    public int updatePermission(Long roleId, List<Long> permissionIds) {
        // 删除老权限
        SysRolePermissionExample example = new SysRolePermissionExample();
        SysRolePermissionExample.Criteria criteria = example.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        sysRolePermissionMapper.deleteByExample(example);
        // 添加新权限
        int count = sysPermissionDao.insertBatch(roleId, permissionIds);
        return count;
    }

    @Override
    public List<SysPermissionNodeVO> getTressList() {
        List<SysPermission>  permissionList = sysPermissionMapper.selectByExample(new SysPermissionExample());
        List<SysPermissionNodeVO> result = permissionList.stream()
                .filter(permission -> permission.getParentId().equals(0L))
                .map(permission -> covert(permission, permissionList)).collect(Collectors.toList());
        return result;
    }

    @Override
    public List<SysPermissionNodeVO> getTressListByUserIdAndType(Long userId,Integer type) {
        List<SysPermission> permissionList = getPermissionByUserIdAndType(userId,type);
        List<SysPermissionNodeVO> result = permissionList.stream()
            .filter(permission -> permission.getParentId().equals(0L))
            .map(permission -> covert(permission, permissionList)).collect(Collectors.toList());
        return result;
    }

    @Override
    public List<SysPermission> getPermissionByUserIdAndType(Long userId,Integer type) {
        if(type==null){
            return sysPermissionDao.getByUserId(userId);
        }else{
            return sysPermissionDao.getByUserIdAndType(userId, type);
        }
    }

    /**
     * 将权限转换为带有子级的权限对象 当找不到子级权限的时候map操作不会再递归调用covert
     */
    private SysPermissionNodeVO covert(SysPermission permission, List<SysPermission> permissionList) {
        SysPermissionNodeVO node = new SysPermissionNodeVO();
        BeanUtils.copyProperties(permission, node);
        List<SysPermissionNodeVO> children = permissionList.stream()
                .filter(subPermission -> subPermission.getParentId().equals(permission.getId()))
                .map(subPermission -> covert(subPermission, permissionList)).collect(Collectors.toList());
        node.setChildren(children);
        return node;
    }

}