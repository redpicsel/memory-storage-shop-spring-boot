<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="content">
	<br>
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">View Profile</h3>
					- <small><a
						href="${pageContext.request.contextPath }/dashboard/changepassword">Change
							Password</a></small>
				</div>
				<!-- /.box-header -->
				<!-- form start -->
				<s:form method="post" modelAttribute="account"
					action="${pageContext.request.contextPath }/dashboard/updateprofile"
					enctype="multipart/form-data">
					<s:hidden path="id" />
					<div class="box-body">
						<div class="form-group">
							<label>Full Name</label>
							<s:input path="fullName" type="text" class="form-control"
								placeholder="Enter new full name" />
						</div>
						<div class="form-group">
							<div class="col-md-6" style="padding: 0;">
								<label>Address</label>
								<s:input path="address" type="text" class="form-control"
									placeholder="Enter new address" />
							</div>
							<div class="col-md-6" style="padding-right: 0;">
								<label>Phone</label>
								<s:input path="phone" type="tel" pattern="[0-9]{10}"
									class="form-control" placeholder="Enter new Phone Number" />
							</div>
						</div>
						<div class="form-group">

							<label>Photo</label> <input name="files" type="file"
								multiple="multiple" />

						</div>

					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</s:form>
			</div>
		</div>



	</div>


</section>