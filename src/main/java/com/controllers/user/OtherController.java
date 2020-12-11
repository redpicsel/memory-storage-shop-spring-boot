package com.controllers.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.services.ProductCategoryService;
import com.services.ProductService;

@Controller()
@RequestMapping("other")
public class OtherController {
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@RequestMapping(value="payment", method= RequestMethod.GET)
	public String payment(ModelMap modelMap)
	{
		loadMenu(modelMap);
		return "other.payment";
	}
	@RequestMapping(value="shipping", method= RequestMethod.GET)
	public String shipping(ModelMap modelMap)
	{
		loadMenu(modelMap);
		return "other.shipping";
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
