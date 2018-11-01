package com.nf.lc.valid;

import com.nf.lc.entity.User;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

public class UserValid implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        if (clazz == User.class) {
            return true;
        }
        return false;
    }

    @Override
    public void validate(Object target, Errors errors) {
        if (target == null) {
            errors.reject("对象不能为空");
        }

        User user = (User) target;

        if (user.getUserName() == null || user.getUserName() == "" || user.getUserName().length() > 20) {
            errors.rejectValue("userName", null, "用户名格式错误！");
        }

        if (user.getUserFirstName().length() > 5 || user.getUserFirstName() == "" || user.getUserFirstName() == null) {
            errors.rejectValue("userFirstName", null, "格式错误");
        }

    }
}
