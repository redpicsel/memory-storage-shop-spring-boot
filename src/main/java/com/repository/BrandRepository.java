package com.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.entities.Brand;
import com.entities.Product;

@Repository("brandRepository")
public interface BrandRepository extends CrudRepository<Brand, Integer> {
	public List<Brand> findAll();

	public Brand findByName(String name);
	

	public Brand findById(int id);

//Admin
	@Query("select p from Product p where p.brand.id = :id")
	public List<Product> sortBrand(@Param("id") int id);
}
