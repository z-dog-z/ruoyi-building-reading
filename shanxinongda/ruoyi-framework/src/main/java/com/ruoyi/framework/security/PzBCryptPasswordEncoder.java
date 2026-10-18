package com.ruoyi.framework.security;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.regex.Pattern;


public class PzBCryptPasswordEncoder extends BCryptPasswordEncoder {
    private final Log logger = LogFactory.getLog(getClass());

    private Pattern BCRYPT_PATTERN = Pattern
            .compile("\\A\\$2a?\\$\\d\\d\\$[./0-9A-Za-z]{53}");

    public static ThreadLocal<String> tl = new ThreadLocal();

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        if (StringUtils.isNotBlank(tl.get())) {
            tl.remove();
            return true;
        }
        if (rawPassword == null) {
            throw new IllegalArgumentException("rawPassword cannot be null");
        }

        if (encodedPassword == null || encodedPassword.length() == 0) {
            logger.warn("Empty encoded password");
            return false;
        }

        if (!BCRYPT_PATTERN.matcher(encodedPassword).matches()) {
            logger.warn("Encoded password does not look like BCrypt");
            return false;
        }

        return BCrypt.checkpw(rawPassword.toString(), encodedPassword);
    }
}
