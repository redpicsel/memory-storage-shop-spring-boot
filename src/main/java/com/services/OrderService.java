package com.services;

import java.util.List;

import com.entities.Order;

public interface OrderService {
	public Order findById(int id);
	public List<Order> findByAccountIdAndStatus(int id, boolean status);
	public List<Order> findAll();
}
