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
@Order(3)
public class UserSecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	private AccountService accountService;

	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {
		
		httpSecurity.cors().and().csrf().disable();
		
					httpSecurity.authorizeRequests().antMatchers("/cart**").access("hasRole('ROLE_USER')")
					.antMatchers("/cart/checkout").access("hasRole('ROLE_USER')").antMatchers("/cart/orderdetail")
					.access("hasRole('ROLE_USER')").antMatchers("/cart/add").access("hasRole('ROLE_USER')")
					.antMatchers("/account/updateinfo").access("hasRole('ROLE_USER')")
					.and()
					.formLogin().loginPage("/account-panel/login")
					.loginProcessingUrl("/account/process-login")
					.defaultSuccessUrl("/account-panel/home")
					.failureUrl("/account-panel/login?error")
					.and()
					.logout().logoutUrl("/account-panel/process-logout")
					.logoutSuccessUrl("/home")
					.deleteCookies("JSESSIONID")
					.and()
					.exceptionHandling().accessDeniedPage("/account-panel/accessDenied");
		
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
