<%@ page language="java" contentType="text/html;  charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>

<!-- BREADCRUMB -->
<div id="breadcrumb">
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li class="active">Checkout</li>
		</ul>
	</div>
</div>
<!-- /BREADCRUMB -->
<!-- section -->

<div class="section" style="padding-top: 60px; padding-bottom: 80px;">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div id="checkout-form" class="clearfix">
				<div class="col-md-6">
					<div class="billing-details">

						<div class="section-title">
							<h3 class="title" style="color: white">Details</h3>
						</div>
						
						<s:form
							action="${pageContext.request.contextPath }/account/updateinfo"
							method="post" modelAttribute="account">
							<div class="form-group">
								<s:input class="input" type="text" name="fullname" id="fullname"
									placeholder="Full Name: ${account.fullName }" disabled="true"
									path="fullName" />
							</div>
							<div class="form-group">
								<s:input class="input" type="text" name="address" id="address"
									placeholder="Address: ${account.address }" disabled="true"
									path="address" />
								<s:input class="input" type="hidden" path="username" />
								<s:input class="input" type="hidden" path="photo" />
								<s:input class="input" type="hidden" path="status" />
							</div>
							<div class="form-group">
								<s:input class="input" type="tel" pattern="[0-9]{10}" name="tel"
									id="phone" placeholder="Phone: ${account.phone }"
									disabled="true" path="phone" />
							</div>
							<p style="color: red; font-style: italic;" id="err">${err }</p>
							<div class="form-group">
								<div class="input-checkbox">
									<input type="checkbox" id="register" onclick="changeinfo()">
									<label class="font-weak" for="register">Change
										Information?</label>
									<div class="caption" id="changepass">
									
										<p>
											Enter your password to confirm
											<p>
											<s:input class="input" type="password" name="password"
												placeholder="Enter Your Password" path="password" />
											<button class="primary-btn" type="submit"
												style="float: right; margin-top: 10px;">Update</button>
											<a style="cursor: pointer; font-style: italic;"
												onclick="updatepass()">Update password</a></div>
			
															
										
									
								</div>
							</div>
						</s:form>
						</div>
						
					</div>
					<div class="col-md-6">
					<div class="shiping-methods">
						<div class="section-title">
							<h4 class="title" style="color: white;">Payment Methods</h4>
						</div>
						<div class="input-checkbox">
							<input type="radio" name="shipping" id="shipping-1" checked>
							<label for="shipping-1">Payment on delivery (COD)</label>
							<div class="caption">
								<p>
									You will receive the goods and pay with the delivery staff.<br />
									Note: delivery agents belonging to Memory Storage partners only
									allow inspection of goods, not technical support, installation.
									When receiving the goods, please check the packaging.
								
								<p>
							
							</div>
						</div>
					</div>

					<div style="float: right;">
						<form action="${pageContext.request.contextPath }/cart/order"
							method="post">
							<button class="primary-btn" type="submit">Order</button>
						</form>

					</div>

				</div>
				</div>
				
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->

<!-- /section -->
<script type="text/javascript">
	document.getElementById('home').style.color = "#008744";

	function changeinfo() {
		document.getElementById('fullname').disabled = false;
		document.getElementById('address').disabled = false;
		document.getElementById('phone').disabled = false;
	}
	function updatepass() {
		document.getElementById('changepass').innerHTML = '<p id="msgupdate" style="color:red;"></p><form action=""><div class="form-group"><input class="input" type="password"'
			+' placeholder="Enter Your Current Password" id="old" /></div><div class="form-group"><input class="input" type="password"'
			+' placeholder="Enter Your New Password" id="new" /></div><a class="primary-btn" onclick="ajaxchangepass()"'
			+' style="float: right; margin-top: 10px; cursor: pointer;">Update</a><a class="primary-btn" onclick="cancelupdate()"'
			+' style="float: right; margin-top: 10px; cursor: pointer; margin-right:6px;">Cancel</a></form>';
	}
	function ajaxchangepass()
	{
		var oldpass=document.getElementById('old').value;
		var newpass=document.getElementById('new').value;
		var passwordup = [];
		passwordup.push(oldpass);
		passwordup.push(newpass);
		$.ajax({
			type : "POST",
	        contentType : 'application/json; charset=utf-8',
	        dataType : 'json',
			url : "${pageContext.request.contextPath}/account/updatepassword",
			data : JSON.stringify(passwordup),
			success : function(result) {
				if (result.status == "Done") {
					var data = result.data;
					if(data === "ok")
						window.location.href = '${pageContext.request.contextPath}/cart/checkout?pwupdate=true';
					document.getElementById('msgupdate').innerHTML=data;
					document.getElementById('err').innerHTML='';
					console.log("Success");
				} else {
					console.log("Fail: ", result);
				}},
			error : function(e) {
				console.log("ERROR: ", e);
			}

		});
	}
	function cancelupdate()
	{
		window.location.href = '${pageContext.request.contextPath}/cart/checkout';
	}

	
</script>