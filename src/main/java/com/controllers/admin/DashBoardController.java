package com.controllers.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import com.entities.Account;
import com.entities.AccountRole;
import com.entities.Brand;
import com.entities.Order;
import com.entities.OrderDetail;
import com.entities.Product;
import com.entities.ProductCategory;
import com.entities.Response;
import com.repository.AccountRepository;
import com.repository.BrandRepository;
import com.repository.OrderDetailRepository;
import com.repository.OrderRepository;
import com.repository.ProductCategoryRepository;
import com.repository.ProductRepository;
import com.services.AccountRoleService;
import com.services.AccountService;
import com.services.BrandService;
import com.services.OrderDetailService;
import com.services.OrderService;
import com.services.ProductCategoryService;
import com.services.ProductService;
import com.services.RoleService;

@Controller
@RequestMapping("/dashboard**")
public class DashBoardController implements ServletContextAware {

	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderRepository orderRepository;
	@Autowired
	private OrderDetailRepository orderDetailRepository;
	@Autowired
	private AccountService accountService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private BrandRepository brandRepository;
	@Autowired
	private ProductRepository productRepository;
	private ServletContext servletContext;
	@Autowired
	private ProductCategoryRepository productCategoryRepository;
	@Autowired
	private AccountRoleService accountRoleService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private AccountRepository accountRepository;

//WELCOME
	@RequestMapping(value = { "", "welcome" }, method = RequestMethod.GET)
	public String index(ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		List<Product> products = (List<Product>) productService.findAll();
		int sizeP = products.size();
		double totalP = 0;
		for (Product product : products) {

			totalP = totalP + (product.getPrice() * product.getQuantity());
		}
		List<Order> ordersAll = orderService.findAll();
		int sizes = ordersAll.size();
		modelMap.addAttribute("numbersorders", sizes);
		modelMap.addAttribute("totalP", totalP);
		modelMap.addAttribute("sizeP", sizeP);
		modelMap.addAttribute("orders", ordersAll);

		return "admin.dashboard.welcome";
	}

//VIEW ALL
	@RequestMapping(value = "viewall", method = RequestMethod.GET)
	public String viewall(ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "admin.dashboard.viewall";
	}

//	VIEW ALL ACCOUNT USER
	@RequestMapping(value = "viewalluser", method = RequestMethod.GET)
	public String viewadminaccount(ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		List<AccountRole> accountRoles = accountRoleService.findByRoleId(roleService.findByName("ROLE_USER").getId());
		List<Account> accounts = new ArrayList<Account>();
		for (AccountRole accountRole : accountRoles) {
			accounts.add(accountRole.getAccount());
		}
		modelMap.addAttribute("accounts", accounts);
		return "admin.dashboard.viewalluser";
	}

//	VIEW/Edit PROFILE 
	@RequestMapping(value = "updateprofile", method = RequestMethod.GET)
	public String updateprofile(ModelMap modelMap, Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("account", account);
		modelMap.addAttribute("nameaccount", account.getFullName());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "admin.dashboard.viewprofile";
	}

	@RequestMapping(value = "updateprofile", method = RequestMethod.POST)
	public String updateprofile(@ModelAttribute("account") Account account,
			@RequestParam(value = "files") MultipartFile[] files, ModelMap modelMap, Principal principal) {
		Account accountUpdate = accountService.findByUsername(principal.getName());
		accountUpdate.setFullName(account.getFullName());
		accountUpdate.setPhone(account.getPhone());
		accountUpdate.setAddress(account.getAddress());
		if (!(files[0].getOriginalFilename().isEmpty())) {
			saveImage(files[0]);
			accountUpdate.setPhoto(files[0].getOriginalFilename());
		}
		accountRepository.save(accountUpdate);
		return "redirect:/dashboard";
	}
//BRAND 

//	VIEW ALL BRAND
	@RequestMapping(value = "viewallbrand", method = RequestMethod.GET)
	public String viewallbrand(ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "admin.dashboard.viewallbrand";
	}

	// LOAD FORM ADD BRAND
	@RequestMapping(value = "addnewbrand", method = RequestMethod.GET)
	public String addFormBrand(ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("brand", new Brand());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "admin.dashboard.addnewbrand";
	}

	// SAVE BRAND
	@RequestMapping(value = "savebrand", method = RequestMethod.POST)
	public String savebrand(@ModelAttribute("brand") Brand brand, @RequestParam(value = "files") MultipartFile[] files,
			ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		List<String> photos = new ArrayList<String>();
		for (MultipartFile file : files) {
			String fileName = saveImageBrand(file);
			photos.add(fileName);
		}
		String photo = String.join(",", photos);
		brand.setPhoto(photo);
		brandService.save(brand);
		modelMap.put("brand", brand);
		return "redirect:/dashboard/viewallbrand";
	}

	// SAVE IMAGE
	private String saveImageBrand(MultipartFile multipartFile) {
		try {
			byte[] bytes = multipartFile.getBytes();
			Path path = Paths
					.get(servletContext.getRealPath("WEB-INF/images/brand" + multipartFile.getOriginalFilename()));
			Files.write(path, bytes);
			return multipartFile.getOriginalFilename();
		} catch (IOException e) {
			return null;
		}
	}

	// DELETE BRAND
	@RequestMapping(value = "deletebrand", params = "id", method = RequestMethod.GET)
	public String delete_brand(@RequestParam("id") int id) {
		brandRepository.deleteById(id);
		return "redirect:/dashboard/viewallbrand";
	}

	// EDIT BRAND
	@RequestMapping(value = "editbrand", params = "id", method = RequestMethod.GET)
	public String editbrand(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		modelMap.addAttribute("brand", brandRepository.findById(id));
		return "admin.dashboard.addnewbrand";
	}

	// !BRAND
	@RequestMapping(value = "editbrand", method = RequestMethod.POST)
	public String edit_brand(@ModelAttribute("brand") Brand brand, @RequestParam(value = "files") MultipartFile[] files,
			ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());

		Brand brandUpdate = new Brand();
		brandUpdate = brandService.findById(brand.getId());
		brandUpdate.setName(brand.getName());
		if (!(files[0].getOriginalFilename().isEmpty())) {
			List<String> photos = new ArrayList<String>();
			for (MultipartFile file : files) {
				String fileName = saveImage(file);
				photos.add(fileName);
			}
			String photo = String.join(",", photos);
			brandUpdate.setPhoto(photo);
		}

		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "admin.dashboard.addnewbrand";
	}

	// CATEGORY

//	VIEW ALL CATEGORY
	@RequestMapping(value = "viewallcategory", method = RequestMethod.GET)
	public String viewallcategory(ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "admin.dashboard.viewallcategory";
	}

	// LOAD FORM ADD CATEGORY
	@RequestMapping(value = "addnewcategory", method = RequestMethod.GET)
	public String addFormCategory(ModelMap modelMap, Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());

		modelMap.addAttribute("category", new ProductCategory());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		modelMap.put("category", new ProductCategory());

		return "admin.dashboard.addnewcategory";
	}

	// SAVE CATEGORY
	@RequestMapping(value = "savecategory", method = RequestMethod.POST)
	public String savebrand(@ModelAttribute("category") ProductCategory productCategory, ModelMap modelMap) {

		productCategoryRepository.save(productCategory);
		return "redirect:/dashboard/viewallcategory";
	}

	// DELETE CATEGORY
	@RequestMapping(value = "deletecategory", params = "id", method = RequestMethod.GET)
	public String delete_category(@RequestParam("id") int id, ModelMap modelMap) {
		productCategoryService.delete(id);
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		return "redirect:/dashboard/viewallcategory";
	}

	// EDIT CATEGORY
	@RequestMapping(value = "editcategory", method = RequestMethod.POST)
	public String editcategory(@ModelAttribute("category") ProductCategory category, ModelMap modelMap,
			Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		ProductCategory categoryUpdate = productCategoryService.findById(category.getId());
		categoryUpdate.setName(category.getName());
		productCategoryRepository.save(categoryUpdate);

		return "redirect:/dashboard/viewallcategory";
	}

	@RequestMapping(value = "editcategory", params = "id", method = RequestMethod.GET)
	public String editcategory(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("category", productCategoryService.findById(id));
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		return "admin.dashboard.addnewcategory";
	}

	// !CATEGORY
//LOAD FORM ADD
	@RequestMapping(value = "addnewproduct", method = RequestMethod.GET)
	public String addForm(ModelMap modelMap, Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		modelMap.put("product", new Product());

		return "admin.dashboard.addproduct";
	}

//SAVE PRODUCT
	@RequestMapping(value = "saveproduct", method = RequestMethod.POST)
	public String save(@ModelAttribute("product") Product product, @RequestParam(value = "files") MultipartFile[] files,
			@RequestParam(value = "information") String information,
			@RequestParam(value = "description") String description, ModelMap modelMap) {
		List<String> photos = new ArrayList<String>();
		for (MultipartFile file : files) {
			String fileName = saveImage(file);
			photos.add(fileName);
		}
		String photo = String.join(",", photos);
		product.setPhoto(photo);
		product.setInformation(information);
		product.setDescription(description);

		productService.save(product);
		modelMap.put("product", product);
		return "redirect:/dashboard/viewall";
	}

//SAVE IMAGE
	private String saveImage(MultipartFile multipartFile) {
		try {
			byte[] bytes = multipartFile.getBytes();
			Path path = Paths.get(servletContext.getRealPath("WEB-INF/images/" + multipartFile.getOriginalFilename()));
			Files.write(path, bytes);
			return multipartFile.getOriginalFilename();
		} catch (IOException e) {
			return null;
		}
	}

//DELETE PRODUCT
	@RequestMapping(value = "delete", params = "id", method = RequestMethod.GET)
	public String delete(@RequestParam("id") int id) {

		productService.delete(id);
		return "redirect:/dashboard/viewall";
	}

//EDIT PRODUCT
	@RequestMapping(value = "editproduct", params = "id", method = RequestMethod.GET)
	public String load_edit(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		Product product = productRepository.findById(id);
		if (product.getPhoto() == null) {
			String photo = "";
			product.setPhoto(photo);
		}
		modelMap.addAttribute("files", product.getPhoto());
		modelMap.put("product", product);

		return "admin.dashboard.editproduct";
	}

	// UPDATE PRODUCT
	@RequestMapping(value = "updateproduct", method = RequestMethod.POST)
	public String updateproduct(@ModelAttribute("product") Product product,
			@RequestParam(value = "files") MultipartFile[] files,
			@RequestParam(value = "information") String information,
			@RequestParam(value = "description") String description, ModelMap modelMap) {
		Product productUpdate = new Product();
		productUpdate = productService.findById(product.getId());
		productUpdate.setName(product.getName());
		productUpdate.setPrice(product.getPrice());
		productUpdate.setQuantity(product.getQuantity());
		if (!(files[0].getOriginalFilename().isEmpty())) {
			List<String> photos = new ArrayList<String>();
			for (MultipartFile file : files) {
				String fileName = saveImage(file);
				photos.add(fileName);
			}
			String photo = String.join(",", photos);
			productUpdate.setPhoto(photo);
		}
		productUpdate.setProductCategory(product.getProductCategory());
		productUpdate.setBrand(product.getBrand());
		productUpdate.setSize(product.getSize());
		productUpdate.setStatus(product.getStatus());

		productUpdate.setInformation(information);
		productUpdate.setDescription(description);

		productRepository.save(productUpdate);

		return "redirect:/dashboard/viewall";
	}

//SEARCH by BRAND NAme
	@RequestMapping(value = "searchbybrand", params = "id", method = RequestMethod.GET)
	public String search_brand(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		modelMap.addAttribute("products", brandService.sortBrand(id));

		return "admin.dashboard.viewall";
	}

	// SEARCH by CATEGORY NAME
	@RequestMapping(value = "searchbycategory", params = "id", method = RequestMethod.GET)
	public String search_category(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		modelMap.addAttribute("products", productCategoryService.sortCategory(id));

		return "admin.dashboard.viewall";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;

	}

//DETAIL ORDER
	@RequestMapping(value = "detailorderbyId", params = "id", method = RequestMethod.GET)
	public String detailorderbyId(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		modelMap.addAttribute("details", orderDetailService.findByOrderId(id));

		return "admin.dashboard.vieworderDetail";
	}

	// CHANGE STATUS ORDER
	@RequestMapping(value = "changestatus", params = "id", method = RequestMethod.GET)
	public String changestatusbyId(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		Order order = orderService.findById(id);
		order.setStatus(!order.getStatus());
		orderRepository.save(order);

		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		return "redirect:/dashboard/welcome";
	}

	@RequestMapping(value = "deleteorderbyId", params = "id", method = RequestMethod.GET)
	public String deleteorderbyId(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		List<OrderDetail> details = orderDetailService.findByOrderId(id);
		for (OrderDetail orderDetail : details) {
			orderDetailRepository.delete(orderDetail);
		}
		orderRepository.deleteById(id);
		modelMap.addAttribute("orders", orderService.findAll());
		return "admin.dashboard.welcome";
	}

	@RequestMapping(value = "viewimage", params = "photos", method = RequestMethod.GET)
	public String viewimage(@RequestParam("photos") String photos, ModelMap modelMap, Principal principal) {
		String[] photoList = photos.split(",");
		modelMap.addAttribute("photoList", photoList);

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());

		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		return "admin.dashboard.viewphoto";
	}

	// Change Password
	@RequestMapping(value = "changepassword", method = RequestMethod.GET)
	public String changePassword() {
		return "admin.dashboard.changepassword";
	}

	@RequestMapping(value = "changepassword", method = RequestMethod.POST, headers = "Content-Type=application/json")
	@ResponseBody
	public Response updatepassword(@RequestBody String[] passwordup, Principal principal) {
		Account account = accountService.findByUsername(principal.getName());
		String result = "";
		if (passwordup[0].isEmpty())
			result = "Current password is required.";
		else if (BCrypt.checkpw(passwordup[0], account.getPassword())) {
			if (passwordup[1].matches("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{6,}")) {
				account.setPassword(encoder().encode(passwordup[1]));
				accountRepository.save(account);
				result = "ok";
			} else
				result = "New Password must at least 6 include characters of upper- and lower-case, one or more digits and symbols.";
		} else
			result = "Current Password invaild.";
		Response response = new Response("Done", result);
		return response;

	}

	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}

}
