<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="home">
	<!-- container -->
	<div class="container">
		<!-- home wrap -->
		<div class="home-wrap">
			<!-- home slick -->
			<div id="home-slick" class="home-slick">
				<!-- banner -->
				<div class="banner banner-1">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/banner01.jpg"
						alt="">
				</div>
				<!-- /banner -->
				<!-- banner -->
				<div class="banner banner-1">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/banner02.jpg"
						alt="">
					
				</div>
				<!-- /banner -->
				<!-- banner -->
				
				<!-- /banner -->
			</div>
			<!-- /home slick -->
		</div>
		<!-- /home wrap -->
	</div>
	<!-- /container -->
</div>
<div class="section" style="margin-top: 10px">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row bannerdown">
			<!-- banner -->
			<div class="col-md-4 col-sm-6">
				<a class="banner banner-1" href="#"> <img
					src="${pageContext.request.contextPath}/resources/user/img/banner_10.png"
					alt="">
					
				</a>
			</div>
			<!-- /banner -->

			<!-- banner -->
			<div class="col-md-4 col-sm-6">
				<a class="banner banner-1" href="#"> <img
					src="${pageContext.request.contextPath}/resources/user/img/banner_11.png"
					alt="">
					
				</a>
			</div>
			<!-- /banner -->

			<!-- banner -->
			<div class="col-md-4 col-md-offset-0 col-sm-6 col-sm-offset-3">
				<a class="banner banner-1" href="#"> <img
					src="${pageContext.request.contextPath}/resources/user/img/banner_12.png"
					alt="">
					
				</a>
			</div>
			<!-- /banner -->

		</div>

		<!-- /row -->
	</div>
	<!-- /container -->
</div>

<div class="section" style="margin-top: 60px">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- section-title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">
						<a href="" style="color: white;">SSD</a>
					</h2>
					<div class="pull-right">
						<div class="product-slick-dots-1 custom-dots"></div>
					</div>
					<div id="navigation">
						<div id="responsive-nav">
							<!-- menu nav -->
							<div class="menu-nav">
								<ul class="menu-child">
									<c:forEach items="${SSDSizes }" var="size">
										<li><a href="${pageContext.request.contextPath }/product/SSD?size=${size }">SSD ${size }GB</a></li>
									</c:forEach>
									<li><a href="${pageContext.request.contextPath }/product/SSD">Show All</a></li>
								</ul>
							</div>
							<!-- menu nav -->
						</div>
					</div>
				</div>
			</div>
			<!-- /section-title -->

			<!-- banner -->
			<div class="col-md-3 col-sm-6 col-xs-6">
				<div class="banner banner-2">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/bannerssd.jpg"
						alt="">
					
				</div>
				<!-- banner -->

				<div class="banner banner-2">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/banner-2.png"
						alt="">
				</div>
				<!-- /banner -->
			</div>
			<!-- /banner -->



			<!-- Product Slick -->
			<div class="col-md-9 col-sm-6 col-xs-6">
				<div class="row">
					<div id="product-slick-1" class="product-slick">
						<c:forEach items="${SSDProducts }" var="product" end="9">
							<div class="col-md-4">
								<div class="product product-single">
									<div class="product-thumb">
										<img
											src="${pageContext.request.contextPath }/images/${product.photo}"
											alt="">
									</div>
									<div class="product-body">
										<h3 class="product-price">
											<fmt:formatNumber value="${product.price }" type="currency"
												currencySymbol="$"></fmt:formatNumber>
										</h3>
										<div class="product-rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o empty"></i>
										</div>
										<h2 class="product-name">
											<a
												href="${pageContext.request.contextPath }/product/detail?id=${product.id }"
												class="text2line">${product.name }</a>
										</h2>
										<div class="product-btns">
											<button class="main-btn icon-btn">
												<i class="fa fa-heart"></i>
											</button>
											<c:choose>
												<c:when test="${product.quantity == 0 }">
														<button class="primary-btn add-to-cart">
														<i class="fa fa-shopping-cart"></i> <a
															style="color: inherit;">Out of stock</a>
													</button>
												</c:when>
												<c:otherwise>
												<button class="primary-btn add-to-cart">
												<i class="fa fa-shopping-cart"></i> <a
													style="color: inherit;"
													href="${pageContext.request.contextPath }/cart/add?id=${product.id }">Add
													to Cart</a>
											</button>
												</c:otherwise>
											</c:choose>
											
										</div>
									</div>
								</div>

							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- /Product Single -->
		</div>
	</div>
</div>
<!-- /Product Slick -->


<!-- Memory section -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- section-title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">
						<a href="" style="color: white; text-transform: uppercase;">Memory</a>
					</h2>
					<div class="pull-right">
						<div class="product-slick-dots-2 custom-dots"></div>
					</div>
					<div id="navigation">
						<div id="responsive-nav">
							<!-- menu nav -->
							<div class="menu-nav">
								<ul class="menu-child">
									<li><a href="${pageContext.request.contextPath }/product/LaptopMemory">Laptop Memory</a></li>
									<li><a href="${pageContext.request.contextPath }/product/DesktopMemory">Desktop Memory</a></li>
									<c:forEach items="${LapMemBrands }" var="brand">
										<li><a href="${pageContext.request.contextPath }/product/LaptopMemory?brand=${brand }" style="text-transform: uppercase;">${brand }</a></li>
									</c:forEach>
									<li><a href="${pageContext.request.contextPath }/product/LaptopMemory">Show All</a></li>
								</ul>
							</div>
							<!-- menu nav -->
						</div>
					</div>
				</div>
			</div>
			<!-- /section-title -->
			<!-- banner -->

			<!-- /banner -->
			<!-- Product Slick -->
			<div class="col-md-9 col-sm-6 col-xs-6">
				<div class="row">
					<div id="product-slick-2" class="product-slick">
						<c:forEach items="${Memories }" var="memory" end="9">
							<div class="col-md-4">
								<div class="product product-single">
									<div class="product-thumb">
										<img
											src="${pageContext.request.contextPath}/images/${memory.photo}"
											alt="">
									</div>
									<div class="product-body">
										<h3 class="product-price">
											<fmt:formatNumber value="${memory.price }" type="currency"
												currencySymbol="$"></fmt:formatNumber>
										</h3>
										<div class="product-rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o empty"></i>
										</div>
										<h2 class="product-name">
											<a
												href="${pageContext.request.contextPath }/product/detail?id=${memory.id }"
												class="text2line">${memory.name }</a>
										</h2>
										<div class="product-btns">
											<button class="main-btn icon-btn">
												<i class="fa fa-heart"></i>
											</button>
											<c:choose>
												<c:when test="${product.quantity == 0 }">
														<button class="primary-btn add-to-cart">
														<i class="fa fa-shopping-cart"></i> <a
															style="color: inherit;">Out of stock</a>
													</button>
												</c:when>
												<c:otherwise>
												<button class="primary-btn add-to-cart">
												<i class="fa fa-shopping-cart"></i> <a
													style="color: inherit;"
													href="${pageContext.request.contextPath }/cart/add?id=${memory.id }">Add
													to Cart</a>
											</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>

							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- /Product Single -->
			<div class="col-md-3 col-sm-6 col-xs-6">
				<div class="banner banner-2">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/bannerram.jpg"
						alt="">
					
				</div>
				<!-- banner -->

				<div class="banner banner-2">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/banner-2.png"
						alt="">
				</div>
				<!-- /banner -->
			</div>
		</div>
	</div>
</div>
<!-- /Product Slick -->



<!-- USB & SdCard -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- section-title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">
						<a href="" style="color: white; text-transform: uppercase;">USB
							& SDCARD</a>
					</h2>
					<div class="pull-right">
						<div class="product-slick-dots-3 custom-dots"></div>
					</div>
					<div id="navigation">
						<div id="responsive-nav">
							<!-- menu nav -->
							<div class="menu-nav">
								<ul class="menu-child">
									<li><a href="${pageContext.request.contextPath }/product/USB">USB</a></li>
									<li><a href="${pageContext.request.contextPath }/product/MicroSDCard">SDCard</a></li>
									<c:forEach items="${USBBrands }" var="brand">
										<li><a href="${pageContext.request.contextPath }/product/USB?brand=${brand }" style="text-transform: uppercase;">${brand }</a></li>
									</c:forEach>
									<li><a href="${pageContext.request.contextPath }/product/USB">Show All</a></li>
								</ul>
							</div>
							<!-- menu nav -->
						</div>
					</div>
				</div>
			</div>
			<!-- /section-title -->
			<!-- banner -->
			<div class="col-md-3 col-sm-6 col-xs-6">
				<div class="banner banner-2">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/banner001.jpg"
						alt="">
					
				</div>
				<!-- banner -->

				<div class="banner banner-2">
					<img
						src="${pageContext.request.contextPath}/resources/user/img/banner-2.png"
						alt="">
				</div>
				<!-- /banner -->
			</div>
			<!-- /banner -->
			<!-- Product Slick -->
			<div class="col-md-9 col-sm-6 col-xs-6">
				<div class="row">
					<div id="product-slick-3" class="product-slick">

						<c:forEach items="${UsbSdCards }" var="product" end="9">
							<div class="col-md-4">
								<div class="product product-single">
									<div class="product-thumb">
										<img
											src="${pageContext.request.contextPath}/images/${product.photo}"
											alt="">
									</div>
									<div class="product-body">
										<h3 class="product-price">
											<fmt:formatNumber value="${product.price }" type="currency"
												currencySymbol="$"></fmt:formatNumber>
										</h3>
										<div class="product-rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o empty"></i>
										</div>
										<h2 class="product-name">
											<a
												href="${pageContext.request.contextPath }/product/detail?id=${product.id }"
												class="text2line">${product.name }</a>
										</h2>
										<div class="product-btns">
											<button class="main-btn icon-btn">
												<i class="fa fa-heart"></i>
											</button>
											<c:choose>
												<c:when test="${product.quantity == 0 }">
														<button class="primary-btn add-to-cart">
														<i class="fa fa-shopping-cart"></i> <a
															style="color: inherit;">Out of stock</a>
													</button>
												</c:when>
												<c:otherwise>
												<button class="primary-btn add-to-cart">
												<i class="fa fa-shopping-cart"></i> <a
													style="color: inherit;"
													href="${pageContext.request.contextPath }/cart/add?id=${product.id }">Add
													to Cart</a>
											</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>

							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- /Product Single -->

		</div>
	</div>
</div>
<!-- /Product Slick -->

<!--Brand Section -->
<div class="section" style="padding-top: 30px; padding-bottom: 60px;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-xs-12 ">
				<div class="heading">
					<h2 class="title-head">FAVORITE BRANDS</h2>
					<div class="line"></div>
				</div>
			</div>
			<div class="col-lg-12 col-xs-12 " id="brands-slick">
				<div class="brand-item">
					<a href=""><img
						src="${pageContext.request.contextPath}/resources/user/img/BrandCucial.png" /></a>
				</div>
				<div class="brand-item">
					<a href=""><img
						src="${pageContext.request.contextPath}/resources/user/img/BrandKingston.png" /></a>
				</div>
				<div class="brand-item">
					<a href=""><img
						src="${pageContext.request.contextPath}/resources/user/img/BrandSamsung.png" /></a>
				</div>
				<div class="brand-item">
					<a href=""><img
						src="${pageContext.request.contextPath}/resources/user/img/BrandWestern.png" /></a>
				</div>
			</div>

		</div>
	</div>
</div>
<!--/Brand Section -->

<script type="text/javascript">
	var nav = document.getElementById("nav");
	nav.classList.remove("show-on-click");
	document.getElementById('home').style.color = "#008744";
	
	
</script>
