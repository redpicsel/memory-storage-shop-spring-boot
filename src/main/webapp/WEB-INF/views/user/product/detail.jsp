<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- BREADCRUMB -->
<div id="breadcrumb">
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}/home">Home</a></li>
			<li><a href="#">${product.productCategory.name }</a></li>
			<li class="active">${product.name }</li>
		</ul>
	</div>
</div>
<!-- /BREADCRUMB -->

<!-- section -->
<div class="section" style="padding-top: 80px; padding-bottom: 80px">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!--  Product Details -->
			<div class="product product-details clearfix">
				<div class="col-md-6">
					<div id="product-main-view">
						<c:forEach items="${photos }" var="photo">
							<div class="product-view">
								<img
									src="${pageContext.request.contextPath}/images/${photo} "
									alt="">
							</div>
						</c:forEach>


					</div>
					<div id="product-view">
						<c:forEach items="${photos }" var="photo">
							<div class="product-view">
								<img
									src="${pageContext.request.contextPath}/images/${photo} "
									alt="">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="col-md-6">
					<div class="product-body">
						<h2 class="product-name">${product.name }</h2>
						<h3 class="product-price">
							<fmt:formatNumber value="${product.price }" type="currency"
								currencySymbol="$"></fmt:formatNumber>
						</h3>
						<div>
							<div class="product-rating">
								<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
									class="fa fa-star"></i> <i class="fa fa-star"></i> <i
									class="fa fa-star-o empty"></i>
							</div>
							<a href="#">3 Review(s) / Add Review</a>
						</div>
						<p style="color: #008744">
							<strong>Availability:</strong>
							<c:choose>
								<c:when test="${product.quantity > 0 }">
										In Stock
									</c:when>
								<c:otherwise>
										Out
									</c:otherwise>
							</c:choose>
							<span style="margin: 7px; color: black">|</span><strong>Brand:</strong>
							${product.productCategory.name }
						</p>
						<div class="information">${product.information }</div>


						<div class="product-btns">
							<p id="err" style="color: red; font-style: italic;"></p>
							
							<c:choose>
								<c:when test="${product.quantity == 0 }">
									<button class="primary-btn add-to-cart">
														<i class="fa fa-shopping-cart"></i> <a
															style="color: inherit;">Out of stock</a>
													</button>
								</c:when>
								<c:otherwise>
								<div class="qty-input">
							
								<span class="text-uppercase">Quantity: </span>
								
									<input class="input" type="number"
										value="${product.quantity >0?1:0 }" max="${product.quantity }"
										min="0" id="quantity">
							</div>
									<button class="primary-btn add-to-cart" onclick="submitqty(${product.id},${product.quantity })">
								<i class="fa fa-shopping-cart"></i> Add to Cart
							</button>
								</c:otherwise>
							</c:choose>
							
							
							
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="product-tab">
						<ul class="tab-nav">
							<li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
						</ul>
						<div class="tab-content">
							<div id="tab1" class="tab-pane fade in active">
								<p>${product.description }</p>
							</div>

						</div>
					</div>
				</div>

			</div>
			<!-- /Product Details -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->
<script type="text/javascript">
	document.getElementById('home').style.color = "#008744";
	function submitqty(id, max)
	{
		var quantity = document.getElementById('quantity').value;
		if(quantity == 0)
			document.getElementById("err").innerHTML = 'Please enter the quantity > 0' ;
		else if(quantity <= max && quantity >0)
			window.location.href = '${pageContext.request.contextPath}/cart/add?id='+id+'&quantity='+ quantity;
		else
			document.getElementById("err").innerHTML = 'Please enter the quantity < '+ max;
			
			
	}
</script>