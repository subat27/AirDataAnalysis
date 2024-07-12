package clover.datalab.airdata.configurations;

import clover.datalab.airdata.configurations.security.SecurityAccessDenied;
import clover.datalab.airdata.configurations.security.SecurityLoginFailure;
import jakarta.servlet.DispatcherType;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import static clover.datalab.airdata.configurations.security.SecurityAccess.*;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {
    
	@Bean
	@ConditionalOnProperty(name = "spring.h2.console.enabled", havingValue = "true")
	public WebSecurityCustomizer configureH2ConsoleEnable() {
		return web -> web.ignoring().requestMatchers(PathRequest.toH2Console());
	}
	
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http.authorizeHttpRequests(request -> {
            request.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                   .dispatcherTypeMatchers(DispatcherType.INCLUDE).permitAll()
                   .dispatcherTypeMatchers(DispatcherType.REQUEST).permitAll()
                   .requestMatchers(ACCESS_PUBLIC).permitAll()
                   .requestMatchers(ACCESS_GUEST).anonymous()
                   .requestMatchers(ACCESS_ADMIN).hasAuthority("ADMIN")
                   .requestMatchers("/dust/pm").permitAll() // "/dust/pm" 허용
                   .requestMatchers("/dust/pm-avg").permitAll() // "/dust/pm-avg" 허용
                   .anyRequest().authenticated();
        }).formLogin(login -> {
            login.loginPage("/user/login")
                 .loginProcessingUrl("/user/login")
                 .usernameParameter("username")
                 .passwordParameter("password")
                 .defaultSuccessUrl("/admin")
                 .successHandler(customAuthenticationSuccessHandler())
                 .failureHandler(new SecurityLoginFailure());
        }).logout(logout -> {
            logout.logoutRequestMatcher(new AntPathRequestMatcher("/user/logout"))
                  .logoutSuccessUrl("/")
                  .invalidateHttpSession(true)
                  .clearAuthentication(true);
        }).exceptionHandling(exception -> {
            exception.accessDeniedHandler(new SecurityAccessDenied());
        }).build();
    }

    @Bean
    protected AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        SimpleUrlAuthenticationSuccessHandler successHandler = new SimpleUrlAuthenticationSuccessHandler();
        successHandler.setDefaultTargetUrl("/");
        successHandler.setAlwaysUseDefaultTargetUrl(true);
        return successHandler;
    }

}
