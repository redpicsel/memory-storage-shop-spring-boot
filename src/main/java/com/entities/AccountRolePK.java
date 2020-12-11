package com.entities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the account_role database table.
 * 
 */
@Embeddable
public class AccountRolePK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="account_id", insertable=false, updatable=false)
	private int accountId;

	@Column(name="role_id", insertable=false, updatable=false)
	private int roleId;

	public AccountRolePK() {
	}
	public int getAccountId() {
		return this.accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public int getRoleId() {
		return this.roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof AccountRolePK)) {
			return false;
		}
		AccountRolePK castOther = (AccountRolePK)other;
		return 
			(this.accountId == castOther.accountId)
			&& (this.roleId == castOther.roleId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.accountId;
		hash = hash * prime + this.roleId;
		
		return hash;
	}
}