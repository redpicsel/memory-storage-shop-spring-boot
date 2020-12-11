package com.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.entities.Product;

@Repository("productRepository")
public interface ProductRepository extends CrudRepository<Product, Integer>
{
	public List<Product> findAll();
	public Product findById(@Param("id") int id);
	
	@Query("select p from Product p order by p.id desc") //Tim tat ca product sap xep theo id (moi nhat ra truoc)
	public List<Product> findAllDesc();
	
	@Query("select p from Product p where p.productCategory.id = :id order by p.id desc") 
	public List<Product> findByCategoryDesc(@Param("id") int id);
	
	@Query("select distinct p.size from Product p where p.productCategory.id = :id order by p.size asc")
	public List<Integer> findAllSizeByCategory(@Param("id") int id); //Tat ca dung luong(size) cua product theo category
	
	@Query("select distinct p.size from Product p order by p.size asc")
	public List<Integer> findAllSize(); //Tat ca dung luong(size) cua product
	
	@Query("select distinct p.brand.name from Product p where p.productCategory.id = :id order by p.brand.name asc")
	public List<String> findAllBrandByCategory(@Param("id") int id); //Tat ca nhan hieu cua product theo category
	
	@Query("select distinct p.brand.name from Product p order by p.brand.name asc")
	public List<String> findAllBrand(); //Tat ca nhan hieu cua product
	
	@Query("select p from Product p where p.productCategory.id = :id1 or p.productCategory.id = :id2 order by p.id desc")
	public List<Product> findDouble(@Param("id1") int id1, @Param("id2") int id2);
	
	@Query("select p from Product p where p.productCategory.id = :id and p.size = :size order by p.id desc") 
	public List<Product> findByCategorySizeDesc(@Param("id") int id, @Param("size") int size);
	
	@Query("select p from Product p where p.productCategory.id = :id and p.brand.name = :brand order by p.id desc") 
	public List<Product> findByCategoryBrandDesc(@Param("id") int id, @Param("brand") String brand);
	
	@Query("select p from Product p where p.name like %:keyword% order by p.id desc") 
	public List<Product> search(@Param("keyword") String keyword);
	
	@Query("select p from Product p where p.name like %:keyword% and p.productCategory.id = :id order by p.id desc") 
	public List<Product> searchByCategory(@Param("keyword") String keyword, @Param("id") int id);
	
	
	//Admin
	@Query("select p from Product p where p.brand.id = :id")
	public List<Product> searchBrand(@Param("id") Integer id);
}
