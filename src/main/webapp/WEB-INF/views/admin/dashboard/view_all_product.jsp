<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="content"><br>
	<h3>VIEW ALL PRODUCT</h3> <br>
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>Name</th>
				<th>Price</th>
				<th>Quantity(s)</th>
				<th>Photo</th>
				<th>Category</th>
				<th>Brand</th>
				<th>Status</th>
				<th>Capacity</th>
				<th>Action</th>
		</tr>
	</thead>
		<tbody>

			<c:forEach items="${products }" var="item">
				<tr>
					<td>${item.name }</td>
					<td>$ ${item.price }</td>
					<td>${item.quantity }</td>
					<td>${item.photo } - <a href="${pageContext.request.contextPath }/dashboard/viewimage?photos=${item.photo}" target="_blank">View</a></td>
					<td>${item.productCategory.name }</td>
					<td>${item.brand.name }</td>
					<td>${item.status }</td>
					<td>${item.size} GB</td>
					<td><a
						href="${pageContext.request.contextPath }/dashboard/editproduct?id=${item.id }">EDIT</a>
						| <a
						href="${pageContext.request.contextPath }/dashboard/delete?id=${item.id }"
						onclick="return confirm('Are you sure?')">DELETE</a></td>
				</tr>
			</c:forEach>
	</tbody>

</table></section>