package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.AccountRole;
import com.repository.AccountRoleRepository;
@Service("accountRoleService")
public class AccountRoleServiceImp implements AccountRoleService {
	@Autowired
	private AccountRoleRepository accountRoleRepository;

	@Override
	public List<AccountRole> findByRoleId(int id) {

		return accountRoleRepository.findByRoleId(id);
	}
	
	//Admin
	@Override
	public List<AccountRole> findByAccountId(int id) {
		return accountRoleRepository.findByAccountId(id);
	}

}
