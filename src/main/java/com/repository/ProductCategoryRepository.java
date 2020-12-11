package com.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.entities.Product;
import com.entities.ProductCategory;
@Repository("productCategoryRepository")
public interface ProductCategoryRepository extends CrudRepository<ProductCategory, Integer>
{
	public List<ProductCategory> findAll();
	public ProductCategory findByName(String name);
	public ProductCategory findById(int id);
	
//Admin
	@Query("select p from Product p where p.productCategory.id = :id")
	public List<Product> sortCategory(@Param("id") int id);
}
