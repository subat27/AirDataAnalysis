package clover.datalab.airdata.configurations.security;

public class SecurityAccess {

    public static String[] ACCESS_PUBLIC = {
        "/",
        "/dust/insert",
        "/assets/**",
        "/vendors/**"
    };

    public static String[] ACCESS_GUEST = {
        "/user/login",
        "/user/register",
    };

    public static String[] ACCESS_ADMIN = {
        "/admin/**"
    };

}
