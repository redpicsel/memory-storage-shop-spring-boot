package com.services;

import java.util.List;

import com.entities.OrderDetail;

public interface OrderDetailService {
	public List<OrderDetail> findByOrderId(int id);
}
