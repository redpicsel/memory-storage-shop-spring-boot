package com.controllers.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entities.Brand;
import com.entities.Product;
import com.entities.ProductCategory;
import com.entities.Response;
import com.services.ProductCategoryService;
import com.services.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductCategoryService productCategoryService;

	private List<Product> products;

	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap modelMap) {
		products = (List<Product>) productService.findAll();
		for (Product product : products) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		modelMap.addAttribute("products", products);
		modelMap.addAttribute("sizes", productService.findAllSize());
		modelMap.addAttribute("brands", productService.findAllBrand());
		modelMap.addAttribute("cate", "All");
		loadMenu(modelMap);
		return "product.products";
	}

	@RequestMapping(value = "detail", params = "id", method = RequestMethod.GET)
	public String productDetail(@RequestParam(value = "id") int id, ModelMap modelMap) {

		
		Product product =   productService.findById(id);
		String[] photos = product.getPhoto().split(",");
		modelMap.addAttribute("product", product);
		modelMap.addAttribute("photos", photos);
		loadMenu(modelMap);
		return "product.detail";
	}


	@RequestMapping(value = "/**", method = RequestMethod.GET)
	public String products(HttpServletRequest request, @RequestParam(value = "size") Optional<Integer> size,
			@RequestParam(value = "brand") Optional<String> brand, ModelMap modelMap) {
		// Tim ten category theo request
		Iterable<ProductCategory> categories = productCategoryService.findAll();

		String nameCategory = request.getServletPath().substring(9).toString();
		modelMap.addAttribute("cate", nameCategory);
		for (ProductCategory productCategory : categories) {
			if (productCategory.getName().replace(" ", "").equalsIgnoreCase(nameCategory)) {
				nameCategory = productCategory.getName();
				break;
			}
		}
		ProductCategory category = productCategoryService.findByName(nameCategory);
		// Tim theo category va size
		if (size.isPresent()) 
			products = productService.findByCategorySizeDesc(category.getId(), size.get());
		
		// Tim theo category va brand
		else if (brand.isPresent())	
			products = productService.findByCategoryBrandDesc(category.getId(), brand.get());
		
		else 

			// Tim theo categoy
			products = productService.findByCategoryDesc(category.getId());
		
		for (Product product : products) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		modelMap.addAttribute("products", products);
		modelMap.addAttribute("sizes", productService.findAllSizeByCategory(category.getId()));
		modelMap.addAttribute("brands", productService.findAllBrandByCategory(category.getId()));
		loadMenu(modelMap);
		return "product.products";
	}

	@RequestMapping(value = "filters", params = { "names", "prices" }, method = RequestMethod.GET)
	@ResponseBody
	public Response filters(@RequestParam("names") List<String> names, @RequestParam("prices") List<String> prices) {
		List<Product> result = new ArrayList<Product>();
		double minPrice = Double.parseDouble(prices.get(0).replace("$", ""));
		double maxPrice = Double.parseDouble(prices.get(1).replace("$", ""));
		for (Product product : products) {
			if (names.size() == 0) {
				if (product.getPrice() >= minPrice && product.getPrice() <= maxPrice)
					result.add(getset(product));
			} else {
				for (String name : names) {
					if (product.getBrand().getName().equalsIgnoreCase(name)
							&& (product.getPrice() >= minPrice && product.getPrice() <= maxPrice)) {
						result.add(getset(product));
						break;
					}
				}
			}

		}

		if (result.isEmpty()) {
			for (Product product : products) {
				for (String name : names)
					if (name.chars().allMatch(Character::isDigit)) {
						if (product.getSize() == Integer.parseInt(name)
								&& (product.getPrice() >= minPrice && product.getPrice() <= maxPrice)) {
							result.add(getset(product));
							break;
						}
					}
			}
		} else {
			List<Product> stack = new ArrayList<Product>();
			boolean yes = false;
			for (Product product : result) {
				for (String name : names)
					if (name.chars().allMatch(Character::isDigit)) {
						if (product.getSize() == Integer.parseInt(name)
								&& (product.getPrice() >= minPrice && product.getPrice() <= maxPrice)) {
							stack.add(getset(product));
							break;
						}
						yes = true;
					}
			}
			if (!stack.isEmpty() || (stack.isEmpty() && yes))
				result = stack;
		}
		for (Product product : result) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		for (Product product : result) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		Response response = new Response("Done", result);
		return response;
	}

	@RequestMapping(value = "search", params="keyword" ,method = RequestMethod.GET)
	public String search(@RequestParam("keyword") String keyword,  @RequestParam(value = "id") Optional<Integer> id,  ModelMap modelMap) {
		if (id.isPresent()) {
			products = productService.searchByCategory(keyword,id.get());
			modelMap.addAttribute("catesearch", productCategoryService.findById(id.get()));
			modelMap.addAttribute("sizes", productService.findAllSizeByCategory(id.get()));
			modelMap.addAttribute("brands", productService.findAllBrandByCategory(id.get()));
		} else {
			products = productService.search(keyword);
			List<String> brands = new ArrayList<String>();
			List<Integer> sizes = new ArrayList<Integer>();
			for (Product product : products) {
				if(!brands.contains(product.getBrand().getName()))
					brands.add(product.getBrand().getName());
				if(!sizes.contains(product.getSize()))
					sizes.add(product.getSize());
			}
			modelMap.addAttribute("sizes", sizes);
			modelMap.addAttribute("brands",brands);
		}
		for (Product product : products) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		modelMap.addAttribute("products", products);
		modelMap.addAttribute("keyword", keyword);
		loadMenu(modelMap);
		return "product.products";
	}

	private Product getset(Product product) {
		Product test = new Product();
		test.setId(product.getId());
		test.setDescription(product.getDescription());
		test.setInformation(product.getInformation());
		test.setName(product.getName());
		test.setPhoto(product.getPhoto());
		test.setPrice(product.getPrice());
		test.setQuantity(product.getQuantity());
		test.setSize(product.getSize());
		test.setStatus(product.getStatus());

		Brand brand = new Brand();
		brand.setId(product.getBrand().getId());
		brand.setName(product.getBrand().getName());
		brand.setPhoto(product.getBrand().getPhoto());
		test.setBrand(brand);

		ProductCategory category = new ProductCategory();
		category.setId(product.getProductCategory().getId());
		category.setName(product.getProductCategory().getName());
		test.setProductCategory(category);
		return test;
	}
	public ModelMap loadMenu(ModelMap modelMap) {
		// Load menu
		modelMap.addAttribute("productCategories", productCategoryService.findAll());
		modelMap.addAttribute("SDCardSizes", productService.findAllSizeByCategory(1));
		modelMap.addAttribute("USBSizes", productService.findAllSizeByCategory(2));
		modelMap.addAttribute("SSDSizes", productService.findAllSizeByCategory(3));
		modelMap.addAttribute("LapMemSizes", productService.findAllSizeByCategory(5));
		modelMap.addAttribute("DeskMemSizes", productService.findAllSizeByCategory(6));
		modelMap.addAttribute("HDDSizes", productService.findAllSizeByCategory(8));
		modelMap.addAttribute("SDCardBrands", productService.findAllBrandByCategory(1));
		modelMap.addAttribute("USBBrands", productService.findAllBrandByCategory(2));
		modelMap.addAttribute("SSDBrands", productService.findAllBrandByCategory(3));
		modelMap.addAttribute("LapMemBrands", productService.findAllBrandByCategory(5));
		modelMap.addAttribute("DeskMemBrands", productService.findAllBrandByCategory(6));
		modelMap.addAttribute("HDDBrands", productService.findAllBrandByCategory(8));
		return modelMap;
	}

}
