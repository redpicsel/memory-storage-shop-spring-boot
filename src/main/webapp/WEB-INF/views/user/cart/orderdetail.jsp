<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<div id="breadcrumb">
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath }/home">Home</a></li>
			<li class="active">Checkout</li>
		</ul>
	</div>
</div>
<div class="section" style="padding-top: 60px; padding-bottom: 80px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">

			<div class="col-md-6">
				<div class="shiping-methods">
					<div class="section-title">
						<h4 class="title" style="color: white;">Delivering</h4>
					</div>
					<c:choose>
						<c:when test="${fn:length(ordersFalse) > 0 }">
							<c:forEach items="${ordersFalse }" var="order">
								<div class="input-checkbox" style="overflow: hidden;">
									<input type="radio" name="shipping" id="shipping-1" checked>
									<label for="shipping-1">Order No.${order.id }
										(${order.timestamp })</label>
									<div class="caption" style="overflow-y: scroll;">
										<p></p>
										<table class="shopping-cart-table table">
											<thead>
												<tr>
													<th>Product</th>
													<th></th>
													<th class="text-center">Quantity</th>
													<th class="text-center">Total</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${detailsFalse[order.id] }" var="detail">
													<tr>
														<td class="thumb"><img
															src="${pageContext.request.contextPath }/images/${detail.product.photo }"
															alt=""></td>
														<td class="details"><a
															href="${pageContext.request.contextPath }/product/detail?id=${detail.product.id }">${detail.product.name }</a>
															<ul>
																<li><span>Capacity: ${detail.product.size }GB</span></li>
																<li><span>Brand: ${detail.product.brand.name }</span></li>
															</ul></td>
														<td class="qty text-center"><input id="quantity"
															name="quantity" min="1" max="20" type="text"
															class="input" value="${detail.quantity }" disabled></td>
														<td class="total text-center"><strong
															class="primary-color"> <fmt:formatNumber
																	value="${detail.price }" type="currency"
																	currencySymbol="$"></fmt:formatNumber>
														</strong></td>

													</tr>
													<c:set value="${detail.price + sumprice}" var="sumprice"></c:set>
												</c:forEach>
											</tbody>
											<tfoot>
												<tr style="height: 5px"></tr>
												<tr>
													<th class="empty" colspan="2"></th>
													<th>TOTAL</th>
													<th colspan="2" class="total"><fmt:formatNumber
															value="${sumprice }" type="currency" currencySymbol="$"></fmt:formatNumber>
													</th>
													<c:set value="0" var="sumprice" />
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p>There are no orders delivering in your account.</p>
						</c:otherwise>
					</c:choose>



				</div>


			</div>
			<div class="col-md-6">
				<div class="shiping-methods">
					<div class="section-title">
						<h4 class="title" style="color: white;">History Order</h4>
					</div>
					<c:choose>
						<c:when test="${fn:length(ordersTrue) > 0 }">
							<c:forEach items="${ordersTrue }" var="order">
								<div class="input-checkbox" style="overflow: hidden;">
									<input type="radio" name="shipping" id="shipping-1">
									<label for="shipping-1">Order No.${order.id }
										(${order.timestamp })</label>
									<div class="caption" style="overflow-y: scroll;">
										<p></p>
										<table class="shopping-cart-table table">
											<thead>
												<tr>
													<th>Product</th>
													<th></th>
													<th class="text-center">Quantity</th>
													<th class="text-center">Total</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${detailsTrue[order.id] }" var="detail">
													<tr>
														<td class="thumb"><img
															src="${pageContext.request.contextPath }/images/${detail.product.photo }"
															alt=""></td>
														<td class="details"><a
															href="${pageContext.request.contextPath }/product/detail?id=${detail.product.id }">${detail.product.name }</a>
															<ul>
																<li><span>Capacity: ${detail.product.size }GB</span></li>
																<li><span>Brand: ${detail.product.brand.name }</span></li>
															</ul></td>
														<td class="qty text-center"><input id="quantity"
															name="quantity" min="1" max="20" type="text"
															class="input" value="${detail.quantity }" disabled></td>
														<td class="total text-center"><strong
															class="primary-color"> <fmt:formatNumber
																	value="${detail.price }" type="currency"
																	currencySymbol="$"></fmt:formatNumber>
														</strong></td>

													</tr>
													<c:set value="${detail.price + sumprice}" var="sumprice"></c:set>
												</c:forEach>
											</tbody>
											<tfoot>
												<tr style="height: 5px"></tr>
												<tr>
													<th class="empty" colspan="2"></th>
													<th>TOTAL</th>
													<th colspan="2" class="total"><fmt:formatNumber
															value="${sumprice }" type="currency" currencySymbol="$"></fmt:formatNumber>
													</th>
													<c:set value="0" var="sumprice" />
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p>There are no orders history in your account.</p>
						</c:otherwise>
					</c:choose>
				</div>


			</div>



		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<script type="text/javascript">
	document.getElementById('home').style.color = "#008744";
	
</script>