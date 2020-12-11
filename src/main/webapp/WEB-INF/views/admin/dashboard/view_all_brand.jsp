<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="content"><br>
<h3>VIEW ALL BRAND</h3> <br> <a
	href="${pageContext.request.contextPath }/dashboard/addnewbrand">Add
		New Brand</a> <br>
<br>
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>Name</th>
				<th>Photo</th>
				<th>Action</th>
		</tr>
	</thead>
		<tbody>

			<c:forEach items="${brands }" var="item">
				<tr>
					<td>${item.name }</td>
					<td><a target="_blank
					href="${pageContext.request.contextPath }/WEB-INF/images/brand/${item.photo}">${item.photo }</a></td>
					<td><a
						href="${pageContext.request.contextPath }/dashboard/editbrand?id=${item.id }">EDIT</a>
						| <a
						href="${pageContext.request.contextPath }/dashboard/deletebrand?id=${item.id }"
						onclick="return confirm('Are you sure?')">DELETE</a></td>
				</tr>
			</c:forEach>
	</tbody>

</table></section>