package com.services;

import java.util.List;

import com.entities.Product;
import com.entities.ProductCategory;

public interface ProductCategoryService
{
	public Iterable<ProductCategory> findAll();
	public ProductCategory findByName(String name);
	public ProductCategory findById(int id);
	
	//Admin
	public void delete(int id);
	public List<Product> sortCategory(int id);
}
