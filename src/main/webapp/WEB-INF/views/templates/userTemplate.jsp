<%@ page language="java" contentType="text/html;  charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>Memory Storage Shop</title>

<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Hind:400,700"
	rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/bootstrap.min.css" />
<!-- Slick -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/slick.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/slick-theme.css" />

<!-- nouislider -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/nouislider.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/style.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/my-style.css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![end
]-->

</head>

<body>
	<!-- HEADER -->
<p id="test"></p>
	<header>
		<!-- top Header -->
		<div id="top-header">
			<div class="container">
				<div class="pull-left">
					<span>Open: 9am to 10pm</span>
				</div>
				<div class="pull-right">
					<ul class="header-top-links">
						<li><a href="#">Store</a></li>
						<li><a href="#">Newsletter</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- /top Header -->

		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="${pageContext.request.contextPath }/home"> <img
							src="${pageContext.request.contextPath}/resources/user/img/logo.png"
							alt="">
						</a>
					</div>
					<!-- /Logo -->

					<!-- Search -->
					<div class="header-search">
						<div id="searchform">
							<input class="input search-input" type="text"
								placeholder="Enter your keyword..." id="key" style="width: 485px;" /> <select
								class="input search-categories" id="id">
								<option value="0">All Categories</option>
								<c:forEach items="${productCategories }" var="category">
									<option value="${category.id }">${category.name }</option>
								</c:forEach>


							</select>
							<button class="search-btn" type="submit" onclick="search()"
								id="searchbutton">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
					<!-- /Search -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown"
								aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">My Account <i
									class="fa fa-caret-down"></i></strong>
							</div> <c:set value="${pageContext.request.userPrincipal.name } "
								var="username"></c:set> <c:set value="${fn:length(username)}"
								var="test"></c:set> <c:choose>
								<c:when test="${test == 1 }">
									<a href="${pageContext.request.contextPath }/account-panel/login"
										class="text-uppercase">Login</a> / <a href="${pageContext.request.contextPath }/account/register"
										class="text-uppercase">Join</a>

								</c:when>
								<c:otherwise>
									<span class="text2line">${username }</span>
									<ul class="custom-menu">
										
										<li><a
											href="${pageContext.request.contextPath }/cart/orderdetail"><i
												class="fa fa-check"></i> My Orders</a></li>
										<li><a
											href="${pageContext.request.contextPath }/account-panel/process-logout"><i
												class="fa fa-unlock-alt"></i> Logout</a></li>
									</ul>
								</c:otherwise>
							</c:choose>




						</li>
						<!-- /Account -->

						<!-- Cart -->
						<li class="header-cart dropdown default-dropdown"><a
							class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-shopping-cart"></i> <span class="qty">${fn:length(cart) }
									</span>
								</div> <strong class="text-uppercase">My Cart:</strong> <br> <span>
									<c:set value="0" var="sumprice" /> <c:forEach items="${cart }"
										var="item">
										<c:set value="${item.product.price*item.quantity }"
											var="price" />
										<c:set value="${price+ sumprice }" var="sumprice" />
									</c:forEach> <fmt:formatNumber value="${sumprice }" type="currency"
										currencySymbol="$"></fmt:formatNumber>
							</span>
						</a>
							<div class="custom-menu">
								<c:choose>
									<c:when test="${fn:length(cart) > 0}">

										<div id="shopping-cart">
											<div class="shopping-cart-list">
												<c:forEach items="${cart }" var="item">
													<div class="product product-widget">
														<div class="product-thumb">
															<img
																src="${pageContext.request.contextPath}/images/${item.product.photo }"
																alt="">
														</div>
														<div class="product-body">
															<h3 class="product-price">
																<fmt:formatNumber value="${item.product.price }"
																	type="currency" currencySymbol="$"></fmt:formatNumber>
																<span class="qty">x${item.quantity}</span>
															</h3>
															<h2 class="product-name text2line">
																<a
																	href="${pageContext.request.contextPath }/product/detail?id=${item.product.id }"
																	class="text2line">${item.product.name }</a>
															</h2>
														</div>
														<a
															href="${pageContext.request.contextPath }/cart/delete?id=${item.product.id }"><button
																class="cancel-btn">
																<i class="fa fa-trash"></i>
															</button></a>
													</div>
												</c:forEach>
											</div>
											<div class="shopping-cart-btns">
												<button class="main-btn">
													<a href="${pageContext.request.contextPath }/cart">View
														Cart</a>
												</button>
												<a href="${pageContext.request.contextPath }/cart/checkout"><button class="primary-btn">
													Checkout <i class="fa fa-arrow-circle-right"></i>
												</button></a>
											</div>
										</div>

									</c:when>
									<c:when test="${fn:length(cart) eq 0}">
										<span>There are no products in your cart.</span>
									</c:when>
								</c:choose>
							</div></li>
						<!-- /Cart -->

						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn">
								<i class="fa fa-bars"></i>
							</button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
			</div>
			<!-- header -->
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- category nav -->
				<div id="nav" class="category-nav show-on-click" style="cursor: pointer;">
					<span class="category-header">Categories <i
						class="fa fa-list"></i></span>
					<ul class="category-list">

						<c:forEach items="${productCategories}" var="category">
							<c:choose>

								<c:when test="${category.id eq 1}">
									<c:set value="${SDCardSizes }" var="sizes" />
									<c:set value="${SDCardBrands }" var="brands" />
								</c:when>
								<c:when test="${category.id eq 2}">
									<c:set value="${USBSizes }" var="sizes" />
									<c:set value="${USBBrands }" var="brands" />
								</c:when>
								<c:when test="${category.id eq 3}">
									<c:set value="${SSDSizes }" var="sizes" />
									<c:set value="${SSDBrands }" var="brands" />
								</c:when>
								<c:when test="${category.id eq 4}">
									<c:set value="${LapMemSizes }" var="sizes" />
									<c:set value="${LapMemBrands }" var="brands" />
								</c:when>
								<c:when test="${category.id eq 5}">
									<c:set value="${DeskMemSizes }" var="sizes" />
									<c:set value="${DeskMemBrands }" var="brands" />
								</c:when>
								<c:when test="${category.id eq 6}">
									<c:set value="${HDDSizes }" var="sizes" />
									<c:set value="${HDDBrands }" var="brands" />
								</c:when>
							</c:choose>
							<c:set value="${fn:replace(category.name,' ','') }"
								var="cagoryname"></c:set>
							<li class="dropdown side-dropdown"><a
								class="dropdown-toggle" data-toggle="dropdown"
								aria-expanded="true" style="cursor: pointer;">${category.name} <i
									class="fa fa-angle-right"></i>
							</a>
								<div class="custom-menu">
									<div class="row">
										<div class="col-md-4 menu-child-category">
											<ul class="list-links">
												<li>
													<h3 class="list-links-title">CAPACITY</h3>
												</li>
												<c:forEach items="${sizes }" var="size">
													<li><a
														href="${pageContext.request.contextPath }/product/${cagoryname }?size=${size }">${category.name}
															${size}GB</a></li>
												</c:forEach>
											</ul>
											<hr class="hidden-md hidden-lg">
										</div>
										<div class="col-md-4">
											<ul class="list-links">
												<li>
													<h3 class="list-links-title">BRAND</h3>
												</li>
												<c:forEach items="${brands }" var="brand">
													<li><a
														href="${pageContext.request.contextPath }/product/${cagoryname }?brand=${brand }">${category.name}
															${brand }</a></li>
												</c:forEach>
											</ul>
											<hr class="hidden-md hidden-lg">
										</div>
										<div class="col-md-3">
											<ul class="list-links">
												<li>
													<h3 class="list-links-title">${category.name}</h3>
												</li>
												<li><a
													href="${pageContext.request.contextPath }/product/${cagoryname }">Show
														All</a></li>
											</ul>
											<hr class="hidden-md hidden-lg">
										</div>

									</div>
								</div></li>
						</c:forEach>
					</ul>
				</div>
				<!-- /category nav -->

				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="${pageContext.request.contextPath}/home" id="home">Home</a></li>
						<li><a href="${pageContext.request.contextPath }/other/payment" id="payment">Payment</a></li>
						<li><a href="${pageContext.request.contextPath }/other/shipping" id="shipping">Shipping Policy</a></li>
						<li><a href="#">Contact</a></li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->




	<tiles:insertAttribute name="content"></tiles:insertAttribute>
	<!-- FOOTER -->
	<footer id="footer" class="section section-grey">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- footer widget -->
				<div class="col-md-4 col-sm-6 col-xs-6">
					<div class="footer">
						<!-- footer logo -->
						<div class="footer-logo">
							<a class="logo" href="${pageContext.request.contextPath }/home"> <img
								src="${pageContext.request.contextPath}/resources/user/img/logo.png"
								alt="">
							</a>
						</div>
						<!-- /footer logo -->

						<p>Shop specializes in providing the best quality computer hardware</p>

						<!-- footer social -->
						<ul class="footer-social">
							<li><a href="#"><i class="fa fa-facebook"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#"><i class="fa fa-instagram"></i></a></li>
							<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
							<li><a href="#"><i class="fa fa-pinterest"></i></a></li>
						</ul>
						<!-- /footer social -->
					</div>
				</div>
				<!-- /footer widget -->

				<!-- footer widget -->
				

				<div class="clearfix visible-sm visible-xs"></div>

				<!-- footer widget -->
				<div class="col-md-4 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">Service</h3>
						<ul class="list-links">
							<li><a href="#">About Us</a></li>
							<li><a href="#">Shiping & Return</a></li>
							<li><a href="#">Shiping Guide</a></li>
							<li><a href="#">FAQ</a></li>
						</ul>
					</div>
				</div>
				<!-- /footer widget -->

				<!-- footer subscribe -->
				<div class="col-md-4 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">Contact</h3>
						<p>Phone: (84)357771184</p>
						<p>Shop open: 9am to 10pm</p>
					</div>
				</div>
				<!-- /footer subscribe -->
			</div>
			<!-- /row -->
			<hr>
			<!-- row -->
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center">
					<!-- footer copyright -->
					<div class="footer-copyright">
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;
						<script type="text/javascript">
							document.write(new Date().getFullYear());
						</script>
						All rights reserved | This website is made with <i
							class="fa fa-heart-o" aria-hidden="true"></i> by <a
							href="http://fb.com/nguyentanluc301" target="_blank">Luc Nguyen</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</div>
					<!-- /footer copyright -->
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</footer>
	<!-- /FOOTER -->

	<!-- jQuery Plugins -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/user/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/user/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/user/js/slick.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/user/js/nouislider.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/user/js/jquery.zoom.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/user/js/main.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/user/js/myjs.js"></script>
	<script type="text/javascript">
		document.getElementById("key").addEventListener("keyup",
				function(event) {
					event.preventDefault();
					if (event.keyCode === 13) {
						document.getElementById("searchbutton").click();
					}
				});
		function search() {
			var keyword = document.getElementById('key').value;
			var id = document.getElementById('id').value;
			if (id == 0)
				window.location.href = '${pageContext.request.contextPath}/product/search?keyword='
						+ keyword;
			else
				window.location.href = '${pageContext.request.contextPath}/product/search?keyword='
						+ keyword + '&id=' + id;
		}

		
	</script>
</body>

</html>
