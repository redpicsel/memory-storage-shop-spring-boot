package com.services;

import java.util.List;


import com.entities.AccountRole;

public interface AccountRoleService {
	public List<AccountRole> findByRoleId(int id);
	
	//Admin
	public List<AccountRole> findByAccountId(int id);
}
