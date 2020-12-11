package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entities.Brand;
import com.entities.Product;
import com.repository.BrandRepository;

@Service("brandService")
public class BrandServiceImp implements BrandService {
	@Autowired
	private BrandRepository brandRepository;

	@Override
	public Iterable<Brand> findAll() {
		return brandRepository.findAll();
	}

	@Override
	public Brand save(Brand brand) {

		return brandRepository.save(brand);
	}

	@Override
	public Brand findByName(String name) {
		return brandRepository.findByName(name);
	}
	
	
	//Admin
	@Override
	public Brand findById(int id) {
		// TODO Auto-generated method stub
		return brandRepository.findById(id);
	}

	@Override
	public void delete(int id) {
		brandRepository.deleteById(id);
	}

	@Override
	public List<Product> sortBrand(int id) {
		// TODO Auto-generated method stub
		return brandRepository.sortBrand(id);
	}

}
