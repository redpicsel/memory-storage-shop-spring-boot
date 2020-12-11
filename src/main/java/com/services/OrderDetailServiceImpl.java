package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.OrderDetail;
import com.repository.OrderDetailRepository;

@Service("orderDetailService")
public class OrderDetailServiceImpl implements OrderDetailService{

	@Autowired
	private OrderDetailRepository orderDetailRepository;
	@Override
	public List<OrderDetail> findByOrderId(int id) {
		return orderDetailRepository.findByOrderId(id);
	}

}
