package com.controllers.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.entities.Account;
import com.entities.ItemCart;
import com.entities.Order;
import com.entities.OrderDetail;
import com.entities.OrderDetailPK;
import com.entities.Product;
import com.repository.OrderDetailRepository;
import com.repository.OrderRepository;
import com.repository.ProductRepository;
import com.services.AccountService;
import com.services.OrderDetailService;
import com.services.OrderService;
import com.services.ProductCategoryService;
import com.services.ProductService;

@Controller
@RequestMapping("/cart**")
public class CartController 
{
	@Autowired
	private ProductService productService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private OrderRepository orderRepositoy;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDetailRepository orderDetailRepositoy;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private ProductCategoryService productCategoryService;
	
	
	@RequestMapping(method= RequestMethod.GET)
	public String index(HttpSession session, ModelMap model) 
	{
		
		model.addAttribute("itemUpdate", new ItemCart());
		if(currentUser()==null)
		{
			session.removeAttribute("cart");
		}
		loadMenu(model);
		return "cart.index";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value="add", params="id", method= RequestMethod.GET)
	public String add(@RequestParam(value="id") int id, @RequestParam(value = "quantity") Optional<Integer> quantity, HttpSession session)
	{
		
			Product product = productService.findById(id);
			String[] photos = product.getPhoto().split(",");
			product.setPhoto(photos[0]);
			
			if(product.getQuantity()==0)
			{
				return "redirect:/cart";
			}
			int qty= 1;
			if(session.getAttribute("cart") == null)
			{
				List<ItemCart> cart = new ArrayList<>();
				if(quantity.isPresent())
					qty = quantity.get();
				cart.add(new ItemCart(product ,qty));
				session.setAttribute("cart", cart);
				
			}else
			{
				List<ItemCart> cart = (List<ItemCart>) session.getAttribute("cart");
				int index =this.exists(id, cart);
				if(index == -1)
				{
					cart.add(new ItemCart(product ,1));
				}else
				{
					if(quantity.isPresent())
						qty = quantity.get();
					cart.get(index).setQuantity(cart.get(index).getQuantity() + qty);
				}
				session.setAttribute("cart", cart);
			}
		
		return "redirect:/cart";
	}
	@RequestMapping(value="remove", params="id", method = RequestMethod.GET)
	public String remove(@RequestParam(value="id") int id, HttpSession session)
	{
		
		@SuppressWarnings("unchecked")
		List<ItemCart> cart = (List<ItemCart>) session.getAttribute("cart");
		int index = this.exists(id, cart);
		cart.remove(index);
		session.setAttribute("cart", cart);
		return "redirect:/cart";
	}
	@RequestMapping(value="delete", params="id", method = RequestMethod.GET)
	public String removeFromHome(@RequestParam(value="id") int id, HttpSession session)
	{
		
		@SuppressWarnings("unchecked")
		List<ItemCart> cart = (List<ItemCart>) session.getAttribute("cart");
		int index = this.exists(id, cart);
		cart.remove(index);
		session.setAttribute("cart", cart);
		return "redirect:/home";
	}
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String update(@Valid @ModelAttribute("itemUpdate") ItemCart itemUpdate, BindingResult bindingResult, HttpSession session)
	{
		@SuppressWarnings("unchecked")
		List<ItemCart> cart = (List<ItemCart>) session.getAttribute("cart");
		int index = this.exists(itemUpdate.getProduct().getId(), cart);
		cart.get(index).setQuantity(itemUpdate.getQuantity());
		session.setAttribute("cart", cart);
		return "redirect:/cart";
	}
	
	@RequestMapping(value="checkout", method=RequestMethod.GET)
	public String checkout( @RequestParam(value = "pwupdate") Optional<Boolean> passUpdate, ModelMap modelMap, HttpSession session)
	{
		if(session.getAttribute("cart") == null)
		{
			return "redirect:/cart";
		}
		Account account = accountService.findByUsername(currentUser());
		if(account.getFullName().isEmpty() || account.getAddress().isEmpty() || account.getPhone().isEmpty())
			modelMap.addAttribute("err", "You need to update the full information before ordering.");
		if(passUpdate.isPresent())
			modelMap.addAttribute("err", "Password update success!");
		account.setPassword("");
		modelMap.addAttribute("account", account );
		loadMenu(modelMap);
		return "cart.checkout";
	}
	@RequestMapping(value="order", method= RequestMethod.POST)
	public String order(HttpSession session, ModelMap modelMap)
	{
		Account account = accountService.findByUsername(currentUser());
		if(account.getFullName().isEmpty() || account.getAddress().isEmpty() || account.getPhone().isEmpty())
			return "redirect:/cart/checkout";
			
		Order order = new Order();
		order.setAccount(account);
		order.setStatus(false);
		order.setTimestamp(new Date());
		int idOrder = orderRepositoy.save(order).getId();
		
		@SuppressWarnings("unchecked")
		List<ItemCart> cart = (List<ItemCart>) session.getAttribute("cart");
		OrderDetail orderDetail = new OrderDetail();
		order = orderService.findById(idOrder);
		for (ItemCart item : cart) 
		{
			OrderDetailPK detailPK = new OrderDetailPK();
			detailPK.setOrderId(idOrder);
			detailPK.setProductId(item.getProduct().getId());
			orderDetail.setOrderDetailPKID(detailPK);
			orderDetail.setOrder(order);
			orderDetail.setProduct(item.getProduct());
			orderDetail.setQuantity(item.getQuantity());
			orderDetail.setPrice(item.getQuantity() * item.getProduct().getPrice());
			orderDetailRepositoy.save(orderDetail);
			
			item.getProduct().setQuantity(item.getProduct().getQuantity()- item.getQuantity());
			productRepository.save(item.getProduct()); //update so luong product
			
		}
		
		session.removeAttribute("cart");
		return "redirect:/cart/orderdetail";
	}
	
	
	@RequestMapping(value="orderdetail", method= RequestMethod.GET)
	public String orderDetail(ModelMap modelMap)
	{
		Account account = accountService.findByUsername(currentUser());
		List<Order> ordersFalse = orderService.findByAccountIdAndStatus(account.getId(), false);
		List<Order> ordersTrue = orderService.findByAccountIdAndStatus(account.getId(), true);
		Map<Integer, List<OrderDetail>> orderDetailsFalse = new HashMap<Integer, List<OrderDetail>>();
		Map<Integer, List<OrderDetail>> orderDetailsTrue = new HashMap<Integer, List<OrderDetail>>();
		for (Order order : ordersFalse) 
		{
			List<OrderDetail> details =orderDetailService.findByOrderId(order.getId());
			for (OrderDetail orderDetail : details) 
			{
				String[] photos = orderDetail.getProduct().getPhoto().split(",");
				orderDetail.getProduct().setPhoto(photos[0]);
			}
			orderDetailsFalse.put(order.getId(), details);
		}
		for (Order order : ordersTrue) 
		{
			List<OrderDetail> details =orderDetailService.findByOrderId(order.getId());
			for (OrderDetail orderDetail : details) 
			{
				String[] photos = orderDetail.getProduct().getPhoto().split(",");
				orderDetail.getProduct().setPhoto(photos[0]);
			}
			orderDetailsTrue.put(order.getId(), details);
		}
		modelMap.addAttribute("detailsFalse", orderDetailsFalse);
		modelMap.addAttribute("ordersFalse", ordersFalse);
		modelMap.addAttribute("detailsTrue", orderDetailsTrue);
		modelMap.addAttribute("ordersTrue", ordersTrue);
		loadMenu(modelMap);
		return "cart.orderdetail";
	}
	
	
	
	private int exists(int id, List<ItemCart> cart) 
	{
		for (int i = 0; i < cart.size(); i++) 
		{
			if (cart.get(i).getProduct().getId() == id)
			{
				return i;
			}
		}
		return -1;
	}
	public String currentUser()
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if( !(authentication instanceof AnonymousAuthenticationToken))
		{
			String currentUserName = authentication.getName();
		    return currentUserName;
		}
		return null;
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
