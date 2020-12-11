<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
div.gallery {
	margin: 5px;
	border: 1px solid #ccc;
	float: left;
	width: 180px;
}

div.gallery:hover {
	border: 1px solid #777;
}

div.gallery img {
	width: 100%;
	height: auto;
}

div.desc {
	padding: 15px;
	text-align: center;
}
</style>
<section class="content">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Photos Manager</h3>
				</div>
				<c:forEach var="photo" items="${photoList }">

		<div class="gallery">
			<a target="_blank"
				href="${pageContext.request.contextPath }/images/${photo}"> <img
				src="${pageContext.request.contextPath }/images/${photo}"
				width="600" height="400">
			</a>
			<div class="desc">${photo }</div>
		</div>
	</c:forEach>
			</div>
		</div>
	</div>



	

</section>