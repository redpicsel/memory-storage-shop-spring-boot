<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section class="content">
	<!-- Small boxes (Stat box) -->
	<div class="row">
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-aqua">
				<div class="inner">
					<h3>${numbersorders }</h3>

					<p>New Orders</p>
			</div>
				<div class="icon"><i class="ion ion-bag"></i></div> <a href="#"
				class="small-box-footer"> <i
					class="fa fa-arrow-circle-right"></i></a>
		</div>
	</div> <!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-green">
				<div class="inner">
					<h3>${sizeP}<sup style="font-size: 20px"></sup></h3>

					<p>Product</p>
			</div>
				<div class="icon"><i class="ion ion-stats-bars"></i></div> <a
				href="${pageContext.request.contextPath }/dashboard/viewallproduct"
				class="small-box-footer"> <i
					class="fa fa-arrow-circle-right"></i></a>
		</div>
	</div> <!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-yellow">
				<div class="inner">
					<h3>3</h3>

					<p>User Account</p>
			</div>
				<div class="icon"><i class="ion ion-person-add"></i></div> <a
				href="${pageContext.request.contextPath }/dashboard/viewalluser"
				class="small-box-footer"> <i
					class="fa fa-arrow-circle-right"></i></a>
		</div>
	</div> <!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-red">
				<div class="inner">
					<h3><fmt:formatNumber value="${totalP}" type="currency"
							currencySymbol="$"></fmt:formatNumber></h3>

					<p>Total Product Value</p>
			</div>
				<div class="icon"><i class="ion ion-pie-graph"></i></div> <a
				href="#" class="small-box-footer"> <i
					class="fa fa-arrow-circle-right"></i></a>
		</div>
	</div> <!-- ./col -->
</div> <!-- /.row -->



	<h3>LIST ORDER</h3>
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>Order Id.</th>
				<th>Account Name</th>
				<th>Status</th>
				<th>Address</th>
				<th>Phone</th>
				<th>Timestamp</th>
				<th>Detail</th>
				<th>Action</th>
		</tr>
	</thead>

		<tbody>
			<c:forEach items="${orders }" var="order">
				<tr>
					<td>${order.id }</td>
					<td>${order.account.username }</td>
					
					<td>${order.status }-<a
						href="${pageContext.request.contextPath}/dashboard/changestatus?id=${order.id}"
						onclick="return confirm('Are you sure?')">Change Status</a></td>
						<td>${order.account.address}</td>
						<td>${order.account.phone}</td>
					<td>${order.timestamp}</td>
					<td><a
						href="${pageContext.request.contextPath }/dashboard/detailorderbyId?id=${order.id }">Detail</a></td>
					<td><a
						href="${pageContext.request.contextPath }/dashboard/deleteorderbyId?id=${order.id }"
						onclick="return confirm('Are you sure?')">DELETE</a></td>
				</tr>
			</c:forEach>
	</tbody>

</table>
</section>