package com.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.entities.Order;
@Repository("orderRepository")
public interface OrderRepository extends CrudRepository<Order, Integer>{
	
	public Order findById(int id);
	public List<Order> findByAccountIdAndStatus(int id, boolean status);
	
	//admin
		public List<Order> findAll();
}
