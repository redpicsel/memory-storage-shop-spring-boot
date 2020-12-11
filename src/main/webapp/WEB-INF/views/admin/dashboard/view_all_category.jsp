<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="content"><br>
	<h3>VIEW ALL CATEGORY</h3> <br> <a
	href="${pageContext.request.contextPath }/dashboard/addnewcategory">Add
		New Category</a> <br> <br>
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>Name</th>
				<th>Action</th>
		</tr>
	</thead>
		<tbody>

			<c:forEach items="${categories }" var="item">
				<tr>
					<td>${item.name }</td>
					<td><a
						href="${pageContext.request.contextPath }/dashboard/editcategory?id=${item.id }">EDIT</a>
						| <a
						href="${pageContext.request.contextPath }/dashboard/deletecategory?id=${item.id }"
						onclick="return confirm('Are you sure?')">DELETE</a></td>
				</tr>
			</c:forEach>
	</tbody>

</table></section>