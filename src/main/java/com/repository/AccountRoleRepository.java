package com.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.entities.AccountRole;
import com.entities.AccountRolePK;
@Repository("accountRoleRepository")
public interface AccountRoleRepository extends CrudRepository<AccountRole, AccountRolePK>{
	public List<AccountRole> findByRoleId(int id);
	
	//Admin
	public List<AccountRole> findByAccountId(int id);

	public void deleteByAccountId(int id);
}
