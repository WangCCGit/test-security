/*
package com.my.test.admin.component;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.test.tea.common.config.RedisService;
import cn.test.tea.sms.service.SmsService;
import com.my.test.common.config.RedisService;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

*/
/**
 * SmsPortalService
 *//*

@Component
public class SmsAdminService {

    @Autowired
    private RedisService redisService;

    */
/*@Autowired
    private SmsService smsService;*//*


    private static final String SMS_CODE_PRE = "sms-";

    private static final Long SMS_CODE_TIMEOUT = 600L;

    */
/**
     * 短信下发功能
     * 
     * @throws TencentCloudSDKException
     *//*

    public boolean send(String phone, String templateId) throws TencentCloudSDKException {
        String cacheKey = SMS_CODE_PRE + templateId + ":" + phone;
        // 查看是否已经下发
        String code = redisService.get(cacheKey);
        if (StrUtil.isNotBlank(code)) {
            return false;
        }
        String smsCode = RandomUtil.randomNumbers(6);
        // boolean sendResult = smsService.sendSmsForOne("+86" + phone, templateId, new String[] { smsCode });
        boolean sendResult = true; // TODO 测试使用
        if(sendResult){
            redisService.set(cacheKey, smsCode);
            redisService.expire(cacheKey, SMS_CODE_TIMEOUT);
        }
        return sendResult;
    }

    */
/**
     * 短信校验功能
     *//*

    public boolean verify(String phone, String templateId,String smsCode){
        String cacheKey = SMS_CODE_PRE + templateId + ":" + phone;
        // 查看是否已经下发
        String code = redisService.get(cacheKey);
        if (StrUtil.isBlank(smsCode)|| StrUtil.isBlank(code)) {
            return false;
        }
        // return smsCode.equals(code);
        return true; // TODO 测试使用
    }
}*/
