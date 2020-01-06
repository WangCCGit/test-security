package com.my.test.service;

import com.my.test.dto.SysUserQueryDTO;
import com.my.test.model.SysUser;
import com.my.test.vo.SysUserVO;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

/**
 * SysUserSV
 */
public interface SysUserSV {

    /**
     * 根据手机号查询用户
     * 
     * @param phone
     * @return
     */
    public UserDetails loadUserByPhone(String phone);

    /**
     * 根据手机号查询用户
     * 
     * @param phone
     * @return
     */
    public SysUser getByPhone(String phone);

    /**
     * 用户登录
     */
    public String login(String username, String password);

    /**
     * 获取当前登录用户
     * 
     * @return
     */
    public SysUser getCurrentSysUser();

    /**
     * 根据条件查询用户信息
     * 
     * @param user
     * @return
     */
    public List<SysUser> getByPage(SysUserQueryDTO user);

    /**
     * 删除指定用户
     * 
     * @param userId
     * @return
     */
    public int delete(Long userId);

    /**
     * 删除用户
     * 
     * @param ids
     * @return
     */
    public int deleteBatch(List<Long> ids);

    /**
     * 根据条件查询用户信息
     * 
     * @param user
     * @return
     */
    public List<SysUserVO> getSysUserVOByPage(SysUserQueryDTO user);


    String login2(String phone, String password);

    UserDetails loadUserByPhone2(String phone);
}