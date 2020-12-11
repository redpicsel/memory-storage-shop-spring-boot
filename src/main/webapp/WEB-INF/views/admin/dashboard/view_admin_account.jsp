<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="content"><br>
<a href="${pageContext.request.contextPath }/superadmin/register" class="text-center">Register a new
				AdminAccount</a>
	<h3>View ALL ADMIN ACCOUNT</h3> <br>
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>ID</th>
				<th>Username</th>
				<th>FullName</th>
				<th>Address</th>
				<th>PhoneNumber</th>
				<th>Photo</th>
				<th>Status</th>
				<th>Action</th>
		</tr>
	</thead>
		<tbody>

			<c:forEach items="${accadmin }" var="item">
				<tr>
					<td>${item.id }</td>
					<td>${item.username }</td>
					<td>${item.fullName }</td>
					<td>${item.address }</td>
					<td>${item.phone }</td>
					<td>${item.photo }</td>
					<td>${item.status }</td>
					<td><a
						href="${pageContext.request.contextPath }/superadmin/deleteaccount?id=${item.id }"
						onclick="return confirm('Are you sure?')">Delete Account</a></td>
				</tr>
			</c:forEach>
	</tbody>

</table></section>