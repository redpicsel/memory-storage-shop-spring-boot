package com.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.Role;
import com.repository.RoleRepository;
@Service("roleService")
public class RoleServiceImpl implements RoleService{

	@Autowired
	private RoleRepository roleRepository;
	@Override
	public Role findByName(String name) {
		return roleRepository.findByName(name);
	}

}
