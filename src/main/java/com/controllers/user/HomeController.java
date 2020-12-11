package com.controllers.user;






import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.entities.Product;
import com.services.ProductCategoryService;
import com.services.ProductService;


@Controller
@RequestMapping("home")
public class HomeController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap modelMap, HttpSession session) {
		loadMenu(modelMap);
		// Load SSD
		List<Product> SSD =  productService.findByCategoryDesc(3);
		for (Product product : SSD) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		modelMap.addAttribute("SSDProducts",SSD);
		// Load Memory
		List<Product> Memories = productService.findDouble(5, 6);
		for (Product product : Memories) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		
		modelMap.addAttribute("Memories", Memories);

		// Load USB & Sd card
		List<Product> UsbSdcard = productService.findDouble(1, 2);
		for (Product product : UsbSdcard) 
		{
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
		}
		modelMap.addAttribute("UsbSdCards", UsbSdcard);
		
		return "home.index";

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
