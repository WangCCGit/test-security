package com.my.test.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.github.pagehelper.PageHelper;
import com.my.test.bo.SysUserDetails;
import com.my.test.dao.SysPermissionDao;
import com.my.test.dto.SysUserQueryDTO;
import com.my.test.mapper.SysDepartmentMapper;
import com.my.test.mapper.SysUserMapper;
import com.my.test.mapper.SysUserRoleMapper;
import com.my.test.model.*;
import com.my.test.security.util.JwtTokenUtil;
import com.my.test.service.SysRoleSV;
import com.my.test.service.SysUserSV;
import com.my.test.vo.SysUserVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * SysUserSVImpl
 */
@Slf4j
@Service
public class SysUserSVImpl implements SysUserSV {

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private SysUserRoleMapper sysUserRoleMapper;

    @Autowired
    private SysDepartmentMapper sysDepartmentMapper;

    @Autowired
    private SysRoleSV sysRoleSV;

    @Autowired
    private SysPermissionDao sysPermissionDao;



    @Override
    public SysUser getByPhone(String phone) {
        SysUserExample example = new SysUserExample();
        SysUserExample.Criteria criteria = example.createCriteria();
        criteria.andPhoneEqualTo(phone);
        List<SysUser> sysUserList = sysUserMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(sysUserList)) {
            return sysUserList.get(0);
        }
        return null;
    }


    @Override
    public SysUser getCurrentSysUser() {
        SecurityContext ctx = SecurityContextHolder.getContext();
        Authentication auth = ctx.getAuthentication();
        SysUserDetails sysUserDetails = (SysUserDetails) auth.getPrincipal();
        return sysUserDetails.getSysUser();
    }

    @Override
    public List<SysUser> getByPage(SysUserQueryDTO user) {
        SysUserExample example = new SysUserExample();
        SysUserExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(user.getPhone())) {
            criteria.andPhoneEqualTo(user.getPhone());
        }
        if (!StringUtils.isEmpty(user.getUserName())) {
            criteria.andUsernameEqualTo(user.getUserName());
        }
        PageHelper.startPage(user.getPageNum(),user.getPageSize());
        return sysUserMapper.selectByExample(example);
    }

    @Transactional
    @Override
    public int delete(Long userId) {
        int count = sysUserMapper.deleteByPrimaryKey(userId);
        if (count > 0) {
            // 删除用户角色绑定
            SysUserRoleExample example = new SysUserRoleExample();
            SysUserRoleExample.Criteria criteria = example.createCriteria();
            criteria.andUserIdEqualTo(userId);
            sysUserRoleMapper.deleteByExample(example);
        }
        return count;
    }

    @Override
    public int deleteBatch(List<Long> ids) {
        SysUserExample example = new SysUserExample();
        SysUserExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        int count = sysUserMapper.deleteByExample(example);
        if(count>0){
            SysUserRoleExample urExample = new SysUserRoleExample();
            SysUserRoleExample.Criteria urCriteria = urExample.createCriteria();
            urCriteria.andUserIdIn(ids);
            sysUserRoleMapper.deleteByExample(urExample);
        }
        return count;
    }

    @Override
    public List<SysUserVO> getSysUserVOByPage(SysUserQueryDTO user) {
        SysUserExample example = new SysUserExample();
        SysUserExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(user.getPhone())) {
            criteria.andPhoneEqualTo(user.getPhone());
        }
        if (!StringUtils.isEmpty(user.getUserName())) {
            criteria.andUsernameEqualTo(user.getUserName());
        }
        PageHelper.startPage(user.getPageNum(),user.getPageSize());
        List<SysUser> sysUsers = sysUserMapper.selectByExample(example);
        List<SysUserVO> sysUserVOs = new ArrayList<>(sysUsers.size());
        for(SysUser su:sysUsers){
            SysUserVO vo = new SysUserVO();
            BeanUtil.copyProperties(su, vo);
            // 查询部门信息
            SysDepartment sd = sysDepartmentMapper.selectByPrimaryKey(su.getDepartmentId());
            if(sd!=null){
                vo.setDepartmentName(sd.getName());
            }
            // 查询角色名
            List<SysRole> roles = sysRoleSV.getRoleList(su.getId());
            if(roles!=null&&!roles.isEmpty()){
                vo.setRoleName(roles.get(0).getRole());
            }
            sysUserVOs.add(vo);
        }
        return sysUserVOs;
    }



    @Override
    public String login(String phone, String password) {
        String token = null;
        try {
            UserDetails userDetails = loadUserByPhone(phone);
            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                throw new BadCredentialsException("密码不正确");
            }
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails,
                    userDetails.getPassword(), userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            token = jwtTokenUtil.generateToken(userDetails);
        } catch (AuthenticationException e) {
            log.warn("登录异常:{}", e.getMessage());
        }
        return token;
    }

    @Override
    public UserDetails loadUserByPhone(String phone) {
        SysUser sysUser = getByPhone(phone);
        if (sysUser != null) {
            return new SysUserDetails(sysUser);
        }
        throw new UsernameNotFoundException("用户名或密码错误");
    }



    @Override
    public String login2(String phone, String password) {
        String token = null;
        try {
            UserDetails userDetails = loadUserByPhone2(phone);
            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                throw new BadCredentialsException("密码不正确");
            }
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails,
                    null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            token = jwtTokenUtil.generateToken(userDetails);
        } catch (AuthenticationException e) {
            log.warn("登录异常:{}", e.getMessage());
        }
            return token;
    }

    @Override
    public UserDetails loadUserByPhone2(String phone) {
        SysUser user = getByPhone(phone);
        if (user != null) {
            List<SysPermission> permissions = sysPermissionDao.getByUserId(user.getId());
            List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
            for (SysPermission permission : permissions) {
                if (permission != null && permission.getUrl() != null) {
                    GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(permission.getUrl());
                    //1：此处将权限信息添加到 GrantedAuthority 对象中，在后面进行全权限验证时会使用GrantedAuthority 对象。
                    grantedAuthorities.add(grantedAuthority);
                }
            }
            return new User(user.getUsername(), user.getPassword(), grantedAuthorities);
        }
        throw new UsernameNotFoundException("用户名或密码错误");
    }


}