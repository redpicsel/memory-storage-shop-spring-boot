package com.validator;


import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.entities.Account;
import com.services.AccountService;
import com.services.BeanUtil;

public class UserValidator implements Validator{
	
	private AccountService accountService = BeanUtil.getBean(AccountService.class);
	
	
	@Override
	public boolean supports(Class<?> clazz) {
		return Account.class.equals(clazz);
	}

	@Override
	public void validate(Object object, Errors errors) 
	{
		Account account = (Account) object;
		if (accountService.findByUsername(account.getUsername())!= null) {
			errors.rejectValue("username", "account.username.exists");
		}
		
		
	}


}
