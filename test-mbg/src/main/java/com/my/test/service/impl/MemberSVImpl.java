package com.my.test.service.impl;

import com.my.test.common.api.CommonResult;
import com.my.test.domain.MemberDetails;
import com.my.test.dto.PasswordResetParamDTO;
import com.my.test.dto.PasswordUpdateParamDTO;
import com.my.test.dto.PayPasswordUpdateParamDTO;
import com.my.test.dto.RegisterParamDTO;
import com.my.test.mapper.MemberMapper;
import com.my.test.model.Member;
import com.my.test.model.MemberExample;
import com.my.test.security.util.JwtTokenUtil;
import com.my.test.service.MemberSV;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * 用户管理Service实现类
 *
 * @author test
 * @since 2019/11/19.
 */
@Service
public class MemberSVImpl implements MemberSV {

    private static final Logger LOGGER = LoggerFactory.getLogger(MemberSVImpl.class);

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private MemberMapper memberMapper;


   /* @Autowired
    private SmsPortalService smsService;*/

    @Override
    public CommonResult<String> register(RegisterParamDTO registerParam) {
        // 验证验证码
      /*  boolean verifyResult = smsService.verify(registerParam.getPhone(),
                TencentSmsTemplateConstant.REGISTRY_TEMPLATE_ID, registerParam.getAuthCode());
        if (!verifyResult) {
            return CommonResult.failed("验证码错误");
        }*/
        // 查询是否已有该用户
        MemberExample example = new MemberExample();
        MemberExample.Criteria criteria = example.createCriteria();
        criteria.andPhoneEqualTo(registerParam.getPhone());
        if (!StringUtils.isEmpty(registerParam.getUsername())) {
            example.or(criteria.andUsernameEqualTo(registerParam.getUsername()));
        }
        List<Member> Members = memberMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(Members)) {
            return CommonResult.failed("该用户已经存在");
        }
        // 判断邀请码
        /*String inviteCode = registerParam.getInviteCode();
        InviteRecord inviteRecord = null;
        SpeedUp speedUp = null;
        if (!StringUtils.isEmpty(inviteCode)) {
            SpeedUpExample speedUpExample = new SpeedUpExample();
            speedUpExample.createCriteria().andLinkedIdEqualTo(inviteCode);
            List<SpeedUp> speedUps = speedUpMapper.selectByExample(speedUpExample);
            if (speedUps != null && speedUps.size() > 0) {
                speedUp = speedUps.get(0);
                //
                if (new Date().after(speedUp.getEndTime())) {
                    speedUp.setStatus(1);
                    speedUpMapper.updateByPrimaryKeySelective(speedUp);
                    return CommonResult.failed("邀请码:" + inviteCode + "已过期");
                } else {
                    // 生成邀请记录
                    inviteRecord = new InviteRecord();
                    inviteRecord.setCreateTime(new Date());
                    inviteRecord.setInviteMemberId(speedUp.getInviteMemberId());
                    inviteRecord.setInviteMemberPhone(String.valueOf(speedUp.getInviteMemberPhone()));
                    inviteRecord.setLinkedId(inviteCode);
                    speedUp.setNumber(speedUp.getNumber() + 1);
                }
            } else {
                return CommonResult.failed("邀请码" + inviteCode + "已过期");
            }
        }*/
        // 没有该用户进行添加操作
        Member member = new Member();
        member.setUsername(registerParam.getUsername());
        member.setPhone(registerParam.getPhone());
        member.setPassword(passwordEncoder.encode(registerParam.getPassword()));
        member.setCreateTime(new Date());
        member.setStatus(0);
        int count = memberMapper.insert(member);
        /*if (count > 0) {
            // TODO 注册环信接口 不需要环信功能
            // easemobRegisterService.registerEasemobUser(member);
            if (!StringUtils.isEmpty(inviteCode) && inviteRecord != null && speedUp != null) {
                inviteRecord.setMemberId(String.valueOf(member.getId()));
                inviteRecord.setMemberPhone(registerParam.getPhone());
                inviteRecordMapper.insertSelective(inviteRecord);
                speedUpMapper.updateByPrimaryKeySelective(speedUp);
            }
            return CommonResult.success(null, "注册成功");
        }
        return CommonResult.failed("注册失败");*/
        return CommonResult.success(null, "注册成功");
    }

    @Override
    public String login(String phone, String password) {
        String token = null;
        // 密码需要客户端加密后传递
        try {
            UserDetails userDetails = loadUserByPhone(phone);
            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                throw new BadCredentialsException("密码不正确");
            }
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails,
                    null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            token = jwtTokenUtil.generateToken(userDetails);
        } catch (AuthenticationException e) {
            LOGGER.warn("登录异常:{}", e.getMessage());
        }
        return token;
    }

    @Override
    public UserDetails loadUserByPhone(String phone) {
        Member member = getByPhone(phone);
        if (member != null) {
            return new MemberDetails(member);
        }
        throw new UsernameNotFoundException("用户名或密码错误");
    }

    @Override
    public Member getByPhone(String phone) {
        MemberExample example = new MemberExample();
        MemberExample.Criteria criteria = example.createCriteria();
        criteria.andPhoneEqualTo(phone);
        List<Member> memberList = memberMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(memberList)) {
            return memberList.get(0);
        }
        return null;
    }

    @Override
    public CommonResult<String> resetPassword(PasswordResetParamDTO passwordResetParam) {
        MemberExample example = new MemberExample();
        example.createCriteria().andPhoneEqualTo(passwordResetParam.getPhone());
        List<Member> memberList = memberMapper.selectByExample(example);
        if (CollectionUtils.isEmpty(memberList)) {
            return CommonResult.failed("该账号不存在");
        }
        // 验证验证码
        /*boolean verifyResult = smsService.verify(passwordResetParam.getPhone(),
                TencentSmsTemplateConstant.FORGET_PASSWORD_TEMPLATE_ID, passwordResetParam.getAuthCode());
        if (!verifyResult) {
            return CommonResult.failed("验证码错误");
        }*/
        Member member = memberList.get(0);
        member.setPassword(passwordEncoder.encode(passwordResetParam.getNewPassword()));
        memberMapper.updateByPrimaryKeySelective(member);
        return CommonResult.success(null, "密码修改成功");
    }

    @Override
    public CommonResult<String> updatePassword(PasswordUpdateParamDTO passwordUpdateParam) {
        // 获取当前用户信息
        Member member = getCurrentMember();
        // 判断老密码是否正确
        if (!passwordEncoder.matches(passwordUpdateParam.getOldPassword(), member.getPassword())) {
            return CommonResult.failed("密码错误");
        }
        Member newMember = new Member();
        newMember.setId(member.getId());
        newMember.setPassword(passwordEncoder.encode(passwordUpdateParam.getNewPassword()));
        memberMapper.updateByPrimaryKeySelective(newMember);
        return CommonResult.success(null, "密码修改成功");
    }

    @Override
    public CommonResult<String> updatePayPassword(PayPasswordUpdateParamDTO payPasswordUpdateParam) {
        // 获取当前用户信息
        Member member = getCurrentMember();
        // 判断短信验证码是否正确
       /* boolean verifyResult = smsService.verify(member.getPhone(),
                TencentSmsTemplateConstant.UPDATE_PAY_PASSWORD_TEMPLATE_ID, payPasswordUpdateParam.getAuthCode());
        if (!verifyResult) {
            return CommonResult.failed("验证码错误");
        }*/
        Member newMember = new Member();
        newMember.setId(member.getId());
        newMember.setPayPassword(passwordEncoder.encode(payPasswordUpdateParam.getNewPassword()));
        memberMapper.updateByPrimaryKeySelective(newMember);
        return CommonResult.success(null, "密码修改成功");
    }

    @Override
    public Member getCurrentMember() {
        SecurityContext ctx = SecurityContextHolder.getContext();
        Authentication auth = ctx.getAuthentication();
        MemberDetails memberDetails = (MemberDetails) auth.getPrincipal();
        return memberDetails.getMember();
    }

    @Override
    public Member getById(Long id) {
        return memberMapper.selectByPrimaryKey(id);
    }
}
