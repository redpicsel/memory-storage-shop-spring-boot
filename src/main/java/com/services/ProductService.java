package com.services;

import java.util.List;


import com.entities.Product;

public interface ProductService
{
	public Iterable<Product> findAll();
	public Iterable<Product> findAllDesc();
	public List<Integer> findAllSizeByCategory(int id);
	public List<Integer> findAllSize();
	public List<String> findAllBrandByCategory(int id);
	public List<String> findAllBrand();
	public List<Product> findByCategoryDesc(int id);
	public Product findById(int id);
	public List<Product> findDouble(int id1, int id2);
	public List<Product> findByCategorySizeDesc(int id, int size);
	public List<Product> findByCategoryBrandDesc(int id, String brand);
	public List<Product> search(String keyword);
	public List<Product> searchByCategory(String keyword, int id);
	
	
	//Admin
	public Product save(Product product);

	public void delete(int id);
}
