package com.repository;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.entities.Role;
@Repository("roleRepositoy")
public interface RoleRepository extends CrudRepository<Role, Integer> {
	public Role findByName(String name);
}
