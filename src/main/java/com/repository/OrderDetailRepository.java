package com.repository;


import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.entities.OrderDetail;
import com.entities.OrderDetailPK;
@Repository("orderDetailRepository")
public interface OrderDetailRepository  extends CrudRepository<OrderDetail, OrderDetailPK >{
	public List<OrderDetail> findByOrderId(int id);
	public List<OrderDetail> findAll();
}
