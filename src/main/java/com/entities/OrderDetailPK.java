package com.entities;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the order_detail database table.
 * 
 */
@Embeddable
public class OrderDetailPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	@Column(name = "product_id", insertable = false, updatable = false)
	private int productId;

	@Column(name = "order_id", insertable = false, updatable = false)
	private int orderId;

	public OrderDetailPK() {
	}
	public int getProductId() {
		return this.productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getOrderId() {
		return this.orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof OrderDetailPK)) {
			return false;
		}
		OrderDetailPK castOther = (OrderDetailPK)other;
		return 
			(this.productId == castOther.productId)
			&& (this.orderId == castOther.orderId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.productId;
		hash = hash * prime + this.orderId;
		
		return hash;
	}
}