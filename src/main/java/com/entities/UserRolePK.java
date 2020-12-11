package com.entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class UserRolePK implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Column(insertable = false, updatable = false)
	private int userid;

	@Column(insertable = false, updatable = false)
	private int roleid;

	public UserRolePK() {
	}

	public int getUserid() {
		return this.userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getRoleid() {
		return this.roleid;
	}

	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof UserRolePK)) {
			return false;
		}
		UserRolePK castOther = (UserRolePK) other;
		return (this.userid == castOther.userid) && (this.roleid == castOther.roleid);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.userid;
		hash = hash * prime + this.roleid;
		return hash;
	}
}