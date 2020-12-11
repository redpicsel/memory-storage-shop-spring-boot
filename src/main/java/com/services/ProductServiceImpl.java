package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.Product;
import com.repository.ProductRepository;

@Service("productService")
public class ProductServiceImpl implements ProductService
{
	@Autowired
	private ProductRepository productRepository;
	@Override
	public Iterable<Product> findAll()
	{
		return productRepository.findAll();
	}
	@Override
	public Iterable<Product> findAllDesc()
	{
		return productRepository.findAllDesc();
	}
	@Override
	public List<Integer> findAllSizeByCategory(int id)
	{
		return productRepository.findAllSizeByCategory(id);
	}
	@Override
	public List<Product> findByCategoryDesc(int id)
	{
		return productRepository.findByCategoryDesc(id);
	}
	@Override
	public List<String> findAllBrandByCategory(int id)
	{
		return productRepository.findAllBrandByCategory(id);
	}
	@Override
	public Product findById(int id)
	{
		return productRepository.findById(id);
	}
	@Override
	public List<Product> findDouble(int id1, int id2)
	{
		return productRepository.findDouble(id1, id2);
	}
	@Override
	public List<Product> findByCategorySizeDesc(int id, int size) {
		return productRepository.findByCategorySizeDesc(id, size);
	}
	@Override
	public List<Product> findByCategoryBrandDesc(int id, String brand) {
		return productRepository.findByCategoryBrandDesc(id, brand);
	}
	@Override
	public List<Product> search(String keyword) {
		return productRepository.search(keyword);
	}
	@Override
	public List<Product> searchByCategory(String keyword, int id) {
		return productRepository.searchByCategory(keyword, id);
	}
	
	
	//Admin
	@Override
	public Product save(Product product) {

		return productRepository.save(product);
	}

	@Override
	public void delete(int id) {
		productRepository.deleteById(id);

	}

	@Override
	public List<Integer> findAllSize() {
		return productRepository.findAllSize();
	}
	@Override
	public List<String> findAllBrand() {
		return productRepository.findAllBrand();
	}
}
