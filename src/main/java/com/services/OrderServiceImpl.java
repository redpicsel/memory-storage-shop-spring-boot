package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.Order;
import com.repository.OrderRepository;


@Service("orderService")
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderRepository orderRepository;
	@Override
	public Order findById(int id) {
		
		return orderRepository.findById(id);
	}
	@Override
	public List<Order> findByAccountIdAndStatus(int id, boolean status) {
		return orderRepository.findByAccountIdAndStatus(id, status);
	}
	@Override
	public List<Order> findAll() {
		return orderRepository.findAll();
	}
	
}
