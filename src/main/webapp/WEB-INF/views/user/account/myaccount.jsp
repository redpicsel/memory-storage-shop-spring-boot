<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/styleinfo.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/material-design-iconic-font.css" />

<div id="breadcrumb">
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}/home">Home</a></li>
			<li class="active">My Account</li>
		</ul>
	</div>
</div>
<!-- /BREADCRUMB -->

<div class="section" style="padding-top: 60px; padding-bottom: 80px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<div class="order-summary clearfix">
					<div class="section-title">
						<h3 class="title" style="color: white;">My Information</h3>

						<div class="billing-details">
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/user/js/maininfo.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/user/js/jquery.steps.js"></script>
<script type="text/javascript">
	document.getElementById('home').style.color = "#008744";
</script>