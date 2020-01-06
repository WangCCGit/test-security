package com.my.test.admin.component;

import com.my.test.common.api.CommonResult;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * ExceptionHadlers
 */
@RestControllerAdvice
public class ExceptionHadlers {

    /**
     * 接口参数验证
     *
     * @param ex
     * @return
     */
    @ExceptionHandler(value = {BindException.class, MethodArgumentNotValidException.class})
    public CommonResult<String> handleBindException(MethodArgumentNotValidException ex) {
        FieldError fieldError = ex.getBindingResult().getFieldError();
        return CommonResult.validateFailed(fieldError.getDefaultMessage());
    }
}