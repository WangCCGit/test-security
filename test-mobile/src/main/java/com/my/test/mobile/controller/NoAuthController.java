package com.my.test.mobile.controller;

import com.my.test.common.api.CommonResult;
import com.my.test.dto.LoginParamDTO;
import com.my.test.dto.PasswordResetParamDTO;
import com.my.test.dto.RegisterParamDTO;
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

import javax.validation.Valid;

/**
 * NoAuthController
 */

@RestController
@RequestMapping("/noauth")
@Slf4j
@Api(tags = "免认证功能管理")
public class NoAuthController {

    @Value("${jwt.tokenHead}")
    private String tokenHead;

    @Value("${jwt.tokenHeader}")
    private String tokenHeader;

    @Value("${jwt.expiration}")
    private Long expiration;

    @Autowired
    private MemberSV memberSV;

    @ApiOperation("会员注册")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public CommonResult<String> register(@Valid @RequestBody RegisterParamDTO registerParam) {
        log.info("registerParam={}", registerParam);
        return memberSV.register(registerParam);
    }

    @ApiOperation("会员登录")
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public CommonResult<LoginVO> login(@Valid @RequestBody LoginParamDTO loginParam) {
        log.info("loginParam={}", loginParam);
        String token = memberSV.login(loginParam.getPhone(), loginParam.getPassword());
        if (token == null) {
            return CommonResult.validateFailed("用户名或密码错误");
        }
        LoginVO login = new LoginVO();
        login.setToken(token);
        login.setTokenHead(tokenHead);
        log.info("login={}", login);
        return CommonResult.success(login);
    }

    @ApiOperation("忘记密码")
    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public CommonResult<String> resetPassword(@Valid @RequestBody PasswordResetParamDTO passwordResetParam) {
        return memberSV.resetPassword(passwordResetParam);
    }
}