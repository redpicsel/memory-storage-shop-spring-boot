<%@ page language="java" contentType="text/html;  charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="breadcrumb">
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}/home">Home</a></li>
			<li class="active">Cart</li>
		</ul>
	</div>
</div>
<!-- /BREADCRUMB -->

<!-- section -->
<div class="section" style="padding-top: 60px; padding-bottom: 80px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<div class="order-summary clearfix">

					<c:set value="${fn:length(cart)}" var="haveCart"></c:set>
					<c:choose>
						<c:when test="${haveCart > 0}">
							<div class="section-title">
								<h3 class="title" style="color: white;">Order Review</h3>
							</div>
							<table class="shopping-cart-table table">
								<thead>
									<tr>
										<th>Product</th>
										<th></th>
										<th class="text-center">Price</th>
										<th class="text-center">Quantity</th>
										<th class="text-center">Total</th>
										<th class="text-right"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${cart }" var="item">
										<tr>
											<td class="thumb"><img
												src="${pageContext.request.contextPath}/images/${item.product.photo }"
												alt=""></td>
											<td class="details"><a
												href="${pageContext.request.contextPath }/product/detail?id=${item.product.id }">${item.product.name }</a>
												<ul>
													<li><span>Capacity: ${item.product.size }GB</span></li>
													<li><span>Brand: ${item.product.brand.name }</span></li>
												</ul></td>
											<td class="price text-center"><strong><fmt:formatNumber value="${item.product.price }" type="currency" currencySymbol="$"></fmt:formatNumber>
													</strong><br></td>
											<td class="qty text-center"><s:form
													id="quantity${item.product.id }"
													modelAttribute="itemUpdate" method="post"
													action="${pageContext.request.contextPath }/cart/update">
													<s:input class="input" type="number"
														value="${item.quantity }" min="1"
														max="${item.product.quantity }" path="quantity" />
													<s:input value="${item.product.id }" path="product.id"
														type="hidden" />
												</s:form></td>
											<td class="total text-center"><strong
												class="primary-color">
												<fmt:formatNumber value="${item.product.price*item.quantity }" type="currency" currencySymbol="$"></fmt:formatNumber>
												</strong></td>
											<td class="text-right"><a
												href="#modal-dialog${item.product.id }" class="modal-toggle"
												data-toggle="modal" data-modal-type="confirm"
												data-modal-title="Delete Property"><button
														class="main-btn icon-btn">
														<i class="fa fa-close"></i>
													</button></a>
												<button class="main-btn icon-btn"
													form="quantity${item.product.id }" type="submit">
													<i class="fa fa-check"></i>
												</button></td>
										</tr>
										<div id="modal-dialog${item.product.id }" class="modal">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<a href="#" data-dismiss="modal" aria-hidden="true"
															class="close">×</a> <span class="product-name">${item.product.name }</span>
													</div>
													<div class="modal-body">
														<p>Do you want to delete?</p>
													</div>
													<div class="modal-footer">
														<a
															href="${pageContext.request.contextPath }/cart/remove?id=${item.product.id }"
															id="btnYes" class="btn confirm">Yes</a> <a href="#"
															data-dismiss="modal" aria-hidden="true"
															class="btn secondary">No</a>
													</div>
												</div>
											</div>
										</div>
										<c:set value="${item.product.price*item.quantity + sumprice}"
											var="sumprice"></c:set>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr style="height: 5px"></tr>
									<tr>
										<th class="empty" colspan="3"></th>
										<th>TOTAL</th>
										<th colspan="2" class="total">
										<fmt:formatNumber value="${sumprice }" type="currency" currencySymbol="$"></fmt:formatNumber>
										</th>
									</tr>
								</tfoot>
							</table>
							<div class="pull-right">
								<button class="primary-btn"><a href="${pageContext.request.contextPath }/cart/checkout" style="color: inherit;">Place Order</a></button>
							</div>
							<div class="pull-right" style="margin-right: 5px;">
								<button class="primary-btn"><a href="${pageContext.request.contextPath }/product" style="color: inherit;">Continue Shopping</a></button>
							</div>
						</c:when>
						<c:when test="${haveCart eq 0 }">
							<span> There are no products in your cart. Return to the
								store to continue shopping.</span>
						</c:when>
					</c:choose>
				</div>

			</div>

		</div>
		<!-- /row -->




	</div>
	<!-- /container -->
</div>
<!-- /section -->
<script type="text/javascript">
	document.getElementById('home').style.color = "#008744";
	$('#modal-dialog').on('show', function() {
		var link = $(this).data('link'), confirmBtn = $(this).find('.confirm');
	})

	$('#btnYes').click(function() {

		// handle form processing here

		alert('submit form');
		$('form').submit();

	});

	
</script>