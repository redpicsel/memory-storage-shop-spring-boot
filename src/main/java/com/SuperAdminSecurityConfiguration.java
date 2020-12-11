package com;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.context.SecurityContextPersistenceFilter;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter;

import com.services.AccountService;

@EnableWebSecurity
@Configuration
@Order(1)
public class SuperAdminSecurityConfiguration extends WebSecurityConfigurerAdapter {
	@Autowired
	private AccountService accountService;

	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {

		httpSecurity.cors().and().csrf().disable();

		httpSecurity.antMatcher("/superadmin/**").authorizeRequests().antMatchers("/superadmin/**")
				.access("hasRole('ROLE_SUPER_ADMIN')").and().formLogin().loginPage("/admin-panel/login")
				.loginProcessingUrl("/admin-panel/process-login").defaultSuccessUrl("/dashboard/welcome")
				.failureUrl("/admin-panel/login?error").and().logout().logoutUrl("/admin-panel/process-logout")
				.logoutSuccessUrl("/admin-panel/login?logout").deleteCookies("JSESSIONID").and().exceptionHandling()
				.accessDeniedPage("/admin-panel/accessDenied");

	}

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder builder) throws Exception {
		builder.userDetailsService(accountService);
	}

	@Bean
	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public SecurityContextHolderAwareRequestFilter awareRequestFilter() {
		return new SecurityContextHolderAwareRequestFilter();
	}

	@Bean
	public SecurityContextPersistenceFilter persistenceFilter() {
		return new SecurityContextPersistenceFilter();
	}
}
