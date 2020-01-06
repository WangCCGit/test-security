package com.my.test.admin.controller;

import com.my.test.common.api.CommonPage;
import com.my.test.common.api.CommonResult;
import com.my.test.common.config.RedisService;
import com.my.test.dto.LoginDTO;
import com.my.test.dto.SysUserQueryDTO;
import com.my.test.mapper.SysUserMapper;
import com.my.test.model.SysUser;
import com.my.test.security.util.JwtTokenUtil;
import com.my.test.service.SysUserSV;
import com.my.test.vo.LoginVO;
import com.my.test.vo.SysUserVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

/**
 * SysUserController
 */
@Api( tags = "系统用户管理")
@Slf4j
@RestController
@RequestMapping("/sys-users")
public class SysUserController {

    @Value("${jwt.tokenHead}")
    private String tokenHead;

    @Value("${jwt.tokenHeader}")
    private String tokenHeader;

    @Value("${jwt.expiration}")
    private Long expiration;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private RedisService redisService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private SysUserSV sysUserSV;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Transactional
    @ApiOperation("添加用户")
    @RequestMapping(value = "", method = RequestMethod.POST)
    public CommonResult<SysUser> insert(@RequestBody SysUser user) {
        SysUser byPhone = sysUserSV.getByPhone(user.getPhone());
        if (byPhone!=null){
            return CommonResult.failed("该手机号已存在");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        log.info("user={}", user);
        int count = sysUserMapper.insert(user);
        if (count > 0) {
            return CommonResult.success(user);
        }
        return CommonResult.failed();
    }

    /**
     * 使用过滤 缓存中实时判断
     * @param loginParam
     * @return
     */
    @ApiOperation("会员登录")
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public CommonResult<LoginVO> login(@Valid @RequestBody LoginDTO loginParam) {
        log.info("loginParam={}", loginParam);
        String token = sysUserSV.login(loginParam.getPhone(), loginParam.getPassword());
        if (token == null) {
            return CommonResult.validateFailed("用户名或密码错误");
        }
        LoginVO login = new LoginVO();
        login.setToken(token);
        login.setTokenHead(tokenHead);
        log.info("login={}", login);
        return CommonResult.success(login);
    }


    @ApiOperation("用户登出")
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public CommonResult<String> logout(HttpServletRequest request) {
        delToken(request);
        return CommonResult.success(null);
    }

    @ApiOperation(value = "刷新token")
    @RequestMapping(value = "/token", method = RequestMethod.GET)
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

    @ApiOperation(value = "获取当前登录用户信息")
    @RequestMapping(value = "/current-user", method = RequestMethod.GET)
    public CommonResult<SysUser> getAdminInfo() {
        SysUser sysUser = sysUserSV.getCurrentSysUser();
        sysUser.setPassword(null);
        return CommonResult.success(sysUser);
    }

    @ApiOperation("分页获取用户列表")
    @RequestMapping(value = "/page", method = RequestMethod.POST)
    public CommonResult<CommonPage<SysUserVO>> list(@Valid @RequestBody SysUserQueryDTO user) {
        List<SysUserVO> userList = sysUserSV.getSysUserVOByPage(user);
        return CommonResult.success(CommonPage.restPage(userList));
    }

    @ApiOperation("获取指定用户信息")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public CommonResult<SysUser> getSysUser(@ApiParam(value = "用户ID", required = true) @PathVariable("id") Long id) {
        SysUser user = sysUserMapper.selectByPrimaryKey(id);
        return CommonResult.success(user);
    }


    @ApiOperation("修改自己的密码")
    @RequestMapping(value = "/password", method = RequestMethod.PUT)
    public CommonResult<Integer> updatePassword(
            @ApiParam(value = "新密码", required = true) @RequestParam String newPassword, HttpServletRequest request) {
        SysUser currentUser = sysUserSV.getCurrentSysUser();
        SysUser user = new SysUser();
        user.setId(currentUser.getId());
        user.setPassword(passwordEncoder.encode(newPassword));
        int count = sysUserMapper.updateByPrimaryKeySelective(user);
        if (count > 0) {
            // 自动登出
            delToken(request);
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @ApiOperation("删除用户")
    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public CommonResult<Integer> delete(@ApiParam(value = "用户ID集合", required = true) @RequestParam("ids") List<Long> ids) {
        log.info("ids={}", ids);
        int count = sysUserSV.deleteBatch(ids);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
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


    /**
     * 使用功能权限测试
     * @param loginParam
     * @return
     */
    @ApiOperation("会员登录")
    @RequestMapping(value = "/login2", method = RequestMethod.POST)
    public CommonResult<LoginVO> login2(@Valid @RequestBody LoginDTO loginParam) {
        log.info("loginParam={}", loginParam);
        String token = sysUserSV.login2(loginParam.getPhone(), loginParam.getPassword());
        if (token == null) {
            return CommonResult.validateFailed("用户名或密码错误");
        }
        LoginVO login = new LoginVO();
        login.setToken(token);
        login.setTokenHead(tokenHead);
        log.info("login={}", login);
        return CommonResult.success(login);
    }

}