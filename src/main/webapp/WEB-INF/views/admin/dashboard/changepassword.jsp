<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <br/>
<section class="content">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Change Password</h3>
				</div>
				<p id="msgupdate" style="color: red;"></p>
				<form>
					<div class="box-body">
					<div class="form-group">
						<label for="exampleInputEmail1">Current Password</label>
						<input  type="password" class="form-control"
							placeholder="Enter current password" id="currentpass" />
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">New Password</label>
						<input  type="password" class="form-control"
							placeholder="Enter New password" id="newpass" />
					</div>
					
						</div>
						<div class="box-footer">
					<a  class="btn btn-primary" style="cursor: pointer;" onclick="changepass()">Save</a>
				</div>
				</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
function changepass()
	{
		var oldpass=document.getElementById('currentpass').value;
		var newpass=document.getElementById('newpass').value;
		var passwordup = [];
		passwordup.push(oldpass);
		passwordup.push(newpass);
		$.ajax({
			type : "POST",
	        contentType : 'application/json; charset=utf-8',
	        dataType : 'json',
			url : "${pageContext.request.contextPath}/dashboard/changepassword",
			data : JSON.stringify(passwordup),
			success : function(result) {
				if (result.status == "Done") {
					var data = result.data;
					if(data === "ok")
						window.location.href = '${pageContext.request.contextPath}/dashboard';
					document.getElementById('msgupdate').innerHTML=data;
					console.log("Success");
				} else {
					console.log("Fail: ", result);
				}},
			error : function(e) {
				console.log("ERROR: ", e);
			}

		});
	}

</script>
	
</section>