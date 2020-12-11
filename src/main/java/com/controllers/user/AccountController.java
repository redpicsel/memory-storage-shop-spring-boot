package com.controllers.user;


import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entities.Account;
import com.entities.AccountRole;
import com.entities.AccountRolePK;
import com.entities.Response;
import com.repository.AccountRepository;
import com.repository.AccountRoleRepository;
import com.services.AccountService;
import com.services.RoleService;
import com.validator.UserValidator;

@Controller
@RequestMapping("/account**")
public class AccountController {

	@Autowired
	private AccountRepository acccountRepository;
	@Autowired
	private AccountRoleRepository accountRoleRepository;
	@Autowired
	private RoleService roleService;
	@Autowired
	private AccountService accountService;

	
	

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String register(ModelMap modelMap) {

		modelMap.put("account", new Account());
		return "account.register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(@ModelAttribute("account") @Valid Account account, BindingResult bindingResult,
			HttpServletRequest request, ModelMap modelMap) {

		UserValidator userValidator = new UserValidator();
		userValidator.validate(account, bindingResult);
		if (bindingResult.hasErrors())
			return "account.register";
		else {
			account.setPassword(encoder().encode(account.getPassword()));
			account.setAddress("");
			account.setStatus(true);
			account.setPhone("");
			account.setPhoto("");
			acccountRepository.save(account);

			AccountRole accountRole = new AccountRole();
			AccountRolePK accountRolePK = new AccountRolePK();
			accountRolePK.setAccountId(accountService.findByUsername(account.getUsername()).getId());
			accountRolePK.setRoleId(roleService.findByName("ROLE_USER").getId());

			accountRole.setId(accountRolePK);
			accountRole.setAccount(account);
			accountRole.setRole(roleService.findByName("ROLE_USER"));
			accountRole.setStatus(true);
			accountRoleRepository.save(accountRole);
			return "redirect:/account-panel/login";
		}
	}

	@RequestMapping(value="updateinfo", method= RequestMethod.POST)
	public String updateInformation(@ModelAttribute("account") Account account, ModelMap modelMap)
	{
		Account accountUpdate = accountService.findByUsername(account.getUsername());
		if(BCrypt.checkpw(account.getPassword(), accountUpdate.getPassword()))
		{
			accountUpdate.setAddress(account.getAddress());
			accountUpdate.setFullName(account.getFullName());
			accountUpdate.setPhone(account.getPhone());
			acccountRepository.save(accountUpdate);
		}
		else
		{
			modelMap.addAttribute("err", "Password invalid.");
			return "cart.checkout";
		}
		return "redirect:/cart/checkout";
	}
	
	
	
	@RequestMapping(value = "updatepassword", method = RequestMethod.POST,  headers="Content-Type=application/json")
	@ResponseBody
	public Response updatepassword(@RequestBody String[] passwordup, Principal principal) {
		Account account =accountService.findByUsername(principal.getName());
		String result = "";
		if(passwordup[0].isEmpty())
			result="Current password is required.";
		else
			if(BCrypt.checkpw(passwordup[0], account.getPassword()))
			{
				if(passwordup[1].matches("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{6,}"))
				{
					account.setPassword(encoder().encode(passwordup[1]));
					acccountRepository.save(account);
					result="ok";
				}
				else
					result="New Password must at least 6 include characters of upper- and lower-case, one or more digits and symbols.";
			}
			else result="Current Password invaild.";
		Response response = new Response("Done", result);
		return response;
		
	}
	
	
	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}

}
