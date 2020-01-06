package com.my.test.admin.component;

import com.my.test.model.SysPermission;
import com.my.test.service.SysPermissionSV;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * MyRbacService
 */
@Slf4j
@Component
public class MyRbacAuthority {

    private AntPathMatcher antPathMatcher=new AntPathMatcher();

    @Autowired
    private SysPermissionSV sysPermissionSV;

    //此方法是根据 匹配路径判断请求者是否有权限
    public boolean findAuthority(HttpServletRequest request, Authentication authentication) {
        boolean authority=false;
        String requestURI = request.getRequestURI();
        String method = request.getMethod();
        log.info("requestURI={}",requestURI);
        log.info("method={}", method);
        if (authentication.getPrincipal() instanceof UserDetails){
            String username = ((UserDetails) authentication.getPrincipal()).getUsername();
            //根据username去缓存查询对应的url
            List<SysPermission> list = sysPermissionSV.getPermissionByPhoneAndMethod(username,method);
            for (SysPermission sp:list){
                if (antPathMatcher.match(sp.getUrl(),requestURI)){
                    authority=true;
                    log.info("phone={}授权通过！", username);
                    break;
                }
            }
        }
        return authority;
    }
}