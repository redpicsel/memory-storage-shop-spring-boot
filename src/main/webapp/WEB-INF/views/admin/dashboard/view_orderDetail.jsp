<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section class="content"><br>
	<h3>ORDER DETAIL</h3>
<br>
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>Product Name</th>
				<th>Size</th>
				<th>Brand</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Total</th>
				<th></th>
		</tr>
	</thead>

		<tbody>
			<c:forEach items="${details}" var="detail">
				<tr>
					<td><a
						href="${pageContext.request.contextPath }/product/detail?id=${detail.product.id }"
						target="_blank">${detail.product.name }</a></td>
					<td>${detail.product.size } GB</td>
					<td>${detail.product.brand.name }</td>
					<td>$${detail.price}</td>
					<td>${detail.quantity}</td>
					<td><fmt:formatNumber value="${detail.price*detail.quantity }"
							type="currency" currencySymbol="$"></fmt:formatNumber></td>
				</tr>
				<c:set value="${detail.price*detail.quantity + sumprice}"
					var="sumprice"></c:set>
			</c:forEach>
	</tbody>
		<tfoot>

			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th>TOTAL</th>
				<th style="color: red;"><fmt:formatNumber value="${sumprice }"
						type="currency" currencySymbol="$"></fmt:formatNumber></th>
		</tr>
	</tfoot>
</table></section>