package com.services;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.stereotype.Service;

import com.entities.Account;
import com.entities.AccountRole;
import com.repository.AccountRepository;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Autowired
	private AccountRepository accountRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Account account = accountRepository.findByUsername(username);

		if (account == null) {
			throw new UsernameNotFoundException("Username not found");
		}
		List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
		for (AccountRole accountRole : account.getAccountRoles()) {
			grantedAuthorities.add(new SimpleGrantedAuthority(accountRole.getRole().getName()));
		}
		return new User(account.getUsername(), account.getPassword(), grantedAuthorities);

	}

	@Override
	public Account findByUsername(String username) {
		return accountRepository.findByUsername(username);
	}


}
