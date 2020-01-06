package com.my.test.service;

import com.my.test.common.api.CommonResult;
import com.my.test.dto.PasswordResetParamDTO;
import com.my.test.dto.PasswordUpdateParamDTO;
import com.my.test.dto.PayPasswordUpdateParamDTO;
import com.my.test.dto.RegisterParamDTO;
import com.my.test.model.Member;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;

/**
 * 会员管理Service
 */
public interface MemberSV {

    /**
     * 用户注册
     */
    @Transactional
    CommonResult<String> register(RegisterParamDTO registerParam);

    /**
     * 用户登录
     */
    String login(String username, String password);

    /**
     * 获取用户信息
     */
    UserDetails loadUserByPhone(String phone);

    /**
     * 根据手机号获取会员
     */
    Member getByPhone(String phone);

    /**
     * 重置登录密码
     */
    @Transactional
    CommonResult<String> resetPassword(PasswordResetParamDTO passwordResetParam);

    /**
     * 修改登录密码
     */
    @Transactional
    CommonResult<String> updatePassword(PasswordUpdateParamDTO passwordUpdateParam);

    /**
     * 修改支付密码
     */
    @Transactional
    CommonResult<String> updatePayPassword(PayPasswordUpdateParamDTO payPasswordUpdateParam);

    /**
     * 获取当前登录会员
     */
    Member getCurrentMember();

    /**
     * 根据会员编号获取会员
     */
    Member getById(Long id);

}
