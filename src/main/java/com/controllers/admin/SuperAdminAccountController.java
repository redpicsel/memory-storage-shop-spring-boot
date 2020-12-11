package com.controllers.admin;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.entities.Account;
import com.entities.AccountRole;
import com.entities.AccountRolePK;
import com.repository.AccountRepository;
import com.repository.AccountRoleRepository;
import com.services.AccountRoleService;
import com.services.AccountService;
import com.services.BrandService;
import com.services.ProductCategoryService;
import com.services.ProductService;
import com.services.RoleService;
import com.validator.UserValidator;

@Controller
@RequestMapping("/superadmin**")
public class SuperAdminAccountController {
	@Autowired
	private BrandService brandService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private AccountRoleRepository accountRoleRepository;
	@Autowired
	private AccountRepository accountRepository;
	@Autowired
	private RoleService roleService;
	@Autowired
	private AccountRoleService accountRoleService;

//	VIEW ALL ACCOUNT ADMIN
	@RequestMapping(value = "viewadmin", method = RequestMethod.GET)
	public String viewadminaccount(ModelMap modelMap, Principal principal) {
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());
		List<AccountRole> accountRoles = accountRoleService.findByRoleId(roleService.findByName("ROLE_ADMIN").getId());
		List<Account> accounts = new ArrayList<Account>();
		for (AccountRole accountRole : accountRoles) {
			accounts.add(accountRole.getAccount());
		}

		modelMap.addAttribute("accadmin", accounts);
		Account account = accountService.findByUsername(principal.getName());
		if(account.getPhoto().isEmpty())
			modelMap.addAttribute("accphoto", "userdefault.jpg");
		else
			modelMap.addAttribute("accphoto", account.getPhoto());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		return "admin.dashboard.viewadmin";
	}

//DELETE ACCOUNT ADMIN
	@RequestMapping(value = "deleteaccount", params = "id", method = RequestMethod.GET)
	public String deleteadmin(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		try {
			List<AccountRole> accounts = accountRoleService.findByAccountId(id);
			for (AccountRole account : accounts) {
				accountRoleRepository.delete(account);
			}
			accountRepository.deleteById(id);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		return "redirect:/superadmin/viewadmin";
	}

	// DELETE ACCOUNT USER
	@RequestMapping(value = "deleteuser", params = "id", method = RequestMethod.GET)
	public String deleteuser(@RequestParam("id") int id, ModelMap modelMap, Principal principal) {
		try {
			List<AccountRole> accounts = accountRoleService.findByAccountId(id);
			for (AccountRole account : accounts) {
				accountRoleRepository.delete(account);
			}
			accountRepository.deleteById(id);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		Account account = accountService.findByUsername(principal.getName());
		modelMap.addAttribute("nameaccount", account.getFullName());
		modelMap.addAttribute("roleaccount", account.getAccountRoles());
		modelMap.addAttribute("products", productService.findAll());
		modelMap.addAttribute("brands", brandService.findAll());
		modelMap.addAttribute("categories", productCategoryService.findAll());

		return "redirect:/dashboard/viewalluser";
	}

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String register_get(ModelMap modelMap) {
		modelMap.put("account", new Account());
		return "admin.dashboard.register";
	}

	@Autowired
	private AccountService accountService;

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(@ModelAttribute("account") @Valid Account account, BindingResult bindingResult,
			HttpServletRequest request, ModelMap modelMap) {

		UserValidator userValidator = new UserValidator();
		userValidator.validate(account, bindingResult);
		if (bindingResult.hasErrors())
			return "admin.dashboard.register";
		else {
			account.setPassword(encoder().encode(account.getPassword()));
			account.setAddress("");
			account.setStatus(true);
			account.setPhone("");
			account.setPhoto("");
			accountRepository.save(account);

			AccountRole accountRole = new AccountRole();
			AccountRolePK accountRolePK = new AccountRolePK();
			accountRolePK.setAccountId(accountService.findByUsername(account.getUsername()).getId());
			accountRolePK.setRoleId(roleService.findByName("ROLE_ADMIN").getId());

			accountRole.setId(accountRolePK);
			accountRole.setAccount(account);
			accountRole.setRole(roleService.findByName("ROLE_ADMIN"));
			accountRole.setStatus(true);
			accountRoleRepository.save(accountRole);
			return "redirect:/superadmin/viewadmin";
		}
	}



	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
}
