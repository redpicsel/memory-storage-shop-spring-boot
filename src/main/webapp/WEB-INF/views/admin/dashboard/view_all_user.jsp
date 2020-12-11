<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="content"><br>
<h3>VIEW ALL ACCOUNT USER</h3>
<br>
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

			<c:forEach items="${accounts}" var="item">
				<tr>
					<td>${item.id }</td>
					<td>${item.username }</td>
					<td>${item.fullName }</td>
					<td>${item.address }</td>
					<td>${item.phone }</td>
					<td>${item.photo }</td>
					<td>${item.status }</td>
					<td><a
						href="${pageContext.request.contextPath }/superadmin/deleteaccount/${item.id }"
						onclick="return confirm('Are you sure?')">DELETE</a></td>
				</tr>
			</c:forEach>
	</tbody>
</table></section>