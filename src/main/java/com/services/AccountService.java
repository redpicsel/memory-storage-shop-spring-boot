package com.services;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.entities.Account;

public interface AccountService extends UserDetailsService{
	public Account findByUsername(String username);
}
