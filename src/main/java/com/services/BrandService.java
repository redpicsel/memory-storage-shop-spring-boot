package com.services;

import java.util.List;

import com.entities.Brand;
import com.entities.Product;

public interface BrandService {
	public Iterable<Brand> findAll();

	public Brand findByName(String name);

	public Brand save(Brand brand);
	
	
	//Admin



	public Brand findById(int id);

	public void delete(int id);

	public List<Product> sortBrand(int id);
}
