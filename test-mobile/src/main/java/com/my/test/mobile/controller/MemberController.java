package com.my.test.mobile.controller;

import com.my.test.common.api.CommonResult;
import com.my.test.common.config.RedisService;
import com.my.test.dto.DeviceTokenDTO;
import com.my.test.dto.PasswordUpdateParamDTO;
import com.my.test.mapper.MemberMapper;
import com.my.test.model.Member;
import com.my.test.security.util.JwtTokenUtil;
import com.my.test.service.MemberSV;
import com.my.test.vo.LoginVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Api(tags = "会员管理")
@Slf4j
@RestController
@RequestMapping("/member")
public class MemberController {

    @Value("${jwt.tokenHead}")
    private String tokenHead;

    @Value("${jwt.tokenHeader}")
    private String tokenHeader;

    @Value("${jwt.expiration}")
    private Long expiration;

    @Autowired
    private RedisService redisService;

    @Autowired
    private MemberSV memberSV;

    @Autowired
    private MemberMapper mapper;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private MemberMapper memberMapper;



    @ApiOperation("会员登出")
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public CommonResult<String> logout(HttpServletRequest request) {
        delToken(request);
        return CommonResult.success(null);
    }

    @ApiOperation("更新登录密码")
    @RequestMapping(value = "/password", method = RequestMethod.POST)
    public CommonResult<String> password(@Valid @RequestBody PasswordUpdateParamDTO passwordUpdateParam,
            HttpServletRequest request) {
        log.info("passwordUpdateParam={}", passwordUpdateParam);
        CommonResult<String> cr = memberSV.updatePassword(passwordUpdateParam);
        return cr;
    }




    @ApiOperation("查询个人信息")
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public CommonResult<Member> getMemberDetail() {
        Member member = memberSV.getCurrentMember();
        try {
            if (member == null) {
                return CommonResult.failed("参数有误");
            }
            return CommonResult.success(member);
        } catch (Exception e) {
            log.error("根据用户ID获取权限列表异常！", e);
            throw e;
        }
    }

    @ApiOperation("刷新令牌信息")
    @RequestMapping(value = "/refresh", method = RequestMethod.GET)
    public CommonResult<LoginVO> refreshToken(HttpServletRequest request) {
        String authHeader = request.getHeader(this.tokenHeader);
        String jwtToken = jwtTokenUtil.refreshHeadToken(authHeader);
        if (jwtToken != null) {
            LoginVO login = new LoginVO();
            login.setToken(jwtToken);
            login.setTokenHead(tokenHead);
            log.info("token={}", login);
            return CommonResult.success(login);
        }
        return CommonResult.success(null);
    }

    @ApiOperation("更新个人信息")
    @RequestMapping(value = "", method = RequestMethod.PATCH)
    public CommonResult<Member> updateInfo(@Valid @RequestBody Member member) {
        Member currentMember = memberSV.getCurrentMember();
        Member updateMember = new Member();
        updateMember.setId(currentMember.getId());
        updateMember.setPersonalizedSignature(member.getPersonalizedSignature());
        updateMember.setUsername(member.getUsername());
        updateMember.setGender(member.getGender());
        updateMember.setIcon(member.getIcon());
        int count = mapper.updateByPrimaryKeySelective(updateMember);
        if (count > 0) {
            currentMember = mapper.selectByPrimaryKey(currentMember.getId());
        }
        return CommonResult.success(currentMember);
    }

    @ApiOperation("刷新device_token")
    @RequestMapping(value = "/device_token", method = RequestMethod.PATCH)
    public CommonResult<String> refreshDeviceToken(@RequestBody DeviceTokenDTO deviceTokenDTO) {
        Member member = memberSV.getCurrentMember();
        member.setDeviceToken(deviceTokenDTO.getDeviceToken());
        member.setAppCate(deviceTokenDTO.getAppCate());
        int i = memberMapper.updateByPrimaryKeySelective(member);
        if (i > 0) {
            return CommonResult.success("操作成功");
        }
        return CommonResult.failed("操作失败");
    }

    /**
     * 删除jwt令牌信息（添加黑名单）
     *
     * @param request
     */
    private void delToken(HttpServletRequest request) {
        String authHeader = request.getHeader(tokenHeader);
        String authToken = authHeader.substring(tokenHead.length());
        redisService.set(authToken, "1");
        redisService.expire(authToken, expiration * 1000);
    }

}