package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.Product;
import com.entities.ProductCategory;
import com.repository.ProductCategoryRepository;
@Service("productCategoryService")
public class ProductCategoryImpl implements ProductCategoryService
{
	@Autowired
	private ProductCategoryRepository productCategoryRepository;
	@Override
	public Iterable<ProductCategory> findAll()
	{
		return productCategoryRepository.findAll();
	}
	@Override
	public ProductCategory findByName(String name) {
		return productCategoryRepository.findByName(name);
	}
	@Override
	public ProductCategory findById(int id) {
		return productCategoryRepository.findById(id);
	}
	
	
	//Admin

	@Override
	public void delete(int id) {
		productCategoryRepository.deleteById(id);
		
	}

	@Override
	public List<Product> sortCategory(int id) {
		// TODO Auto-generated method stub
		return productCategoryRepository.sortCategory(id);
	}

}
