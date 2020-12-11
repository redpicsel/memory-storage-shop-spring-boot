package com.entities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the account_role database table.
 * 
 */
@Entity
@Table(name="account_role")
@NamedQuery(name="AccountRole.findAll", query="SELECT a FROM AccountRole a")
public class AccountRole implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private AccountRolePK id;

	private boolean status;

	//bi-directional many-to-one association to Account
	@ManyToOne
	@JoinColumn(name = "account_id", insertable = false, updatable = false)
	private Account account;

	//bi-directional many-to-one association to Role
	@ManyToOne
	@JoinColumn(name = "role_id", insertable = false, updatable = false)
	private Role role;

	public AccountRole() {
	}

	public AccountRolePK getId() {
		return this.id;
	}

	public void setId(AccountRolePK id) {
		this.id = id;
	}

	public boolean getStatus() {
		return this.status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public Account getAccount() {
		return this.account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

}