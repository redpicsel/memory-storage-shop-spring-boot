<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>MemoryShop | Dashboard</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/bootstrap/dist/css/bootstrap.min.css">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/css/skins/_all-skins.min.css">
<!-- Morris chart -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/morris.js/morris.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/jvectormap/jquery-jvectormap.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/bootstrap-daterangepicker/daterangepicker.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/admin/bower_components/datatables.net/css/jquery.dataTables.min.css">
<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<style type="text/css">
input {
	width: 100%
}
</style>


</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper"><header class="main-header"> <!-- Logo -->
			<a href="${pageContext.request.contextPath }/dashboard/welcome"
			class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span
				class="logo-mini"><b>A</b>LT</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>MEMORY</b>STORAGE</span>
		</a> <!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top">
				<!-- Sidebar toggle button--> <a href="#" class="sidebar-toggle"
				data-toggle="push-menu" role="button"> <span class="sr-only">Toggle
						navigation</span>
			</a>

				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">

						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="${pageContext.request.contextPath }/images/${accphoto}"
								class="user-image" alt="User Image"> <span
								class="hidden-xs">${pageContext.request.userPrincipal.name }</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="${pageContext.request.contextPath }/images/${accphoto}"
									class="img-circle" alt="User Image">

									<p>${nameaccount}<c:forEach items="${roleaccount }"
											var="item">
											<small>${item.role.name}</small>
										</c:forEach>

								</p></li>

								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left"><a href="${pageContext.request.contextPath }/dashboard/updateprofile"
										class="btn btn-default btn-flat">Profile</a></div>
									<div class="pull-right"><a
										href="${pageContext.request.contextPath }/dashboard/process-logout"
										class="btn btn-default btn-flat">Sign out</a></div>
							</li>
						</ul></li>

				</ul>
			</div>
		</nav>
	</header> <!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image"><img
						src="${pageContext.request.contextPath }/images/${accphoto}"
						class="img-circle" alt="User Image"></div>
					<div class="pull-left info">
						<p>${accname }</p> <a href="#"><i
							class="fa fa-circle text-success"></i> Online</a>
				</div>
			</div> <!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">MAIN NAVIGATION</li>
					<li class="treeview"><a href="#"> <i class="fa fa-share"></i>
							<span>Product</span> <span class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a
								href="${pageContext.request.contextPath}/dashboard/viewall "><i
									class="fa fa-circle-o"></i>VIEW ALL</a></li>
							<!-- LOAD LIST BRAND -->
							<li class="treeview"><a href="#"><i
									class="fa fa-circle-o"></i>BY BRAND <span
									class="pull-right-container"> <i
										class="fa fa-angle-left pull-right"></i>
								</span> </a>
								<ul class="treeview-menu">
									<c:forEach items="${brands}" var="brand">
										<li><a
											href="${pageContext.request.contextPath }/dashboard/searchbybrand?id=${brand.id}"><i
												class="fa fa-circle-o"></i>${brand.name}</a></li>
									</c:forEach>
							</ul></li>
							<!-- LOAD LIST CATEGORY -->
							<li class="treeview"><a href="#"><i
									class="fa fa-circle-o"></i>BY CATEGORY<span
									class="pull-right-container"> <i
										class="fa fa-angle-left pull-right"></i>
								</span> </a>
								<ul class="treeview-menu">
									<c:forEach items="${categories}" var="category">
										<li><a
											href="${pageContext.request.contextPath }/dashboard/searchbycategory?id=${category.id}"><i
												class="fa fa-circle-o"></i>${category.name}</a></li>
									</c:forEach>
							</ul></li>
					</ul></li>
					<!-- ACTION -->
					<li class="treeview"><a href="#"> <i class="fa fa-share"></i>
							<span>Action ADD</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li>
								<!-- ADD NEW PRODUCT --> <a
								href="${pageContext.request.contextPath}/dashboard/addnewproduct "><i
									class="fa fa-circle-o"></i>NEW PRODUCT</a>
						</li>
							<li>
								<!-- ADD NEW BRAND --> <a
								href="${pageContext.request.contextPath}/dashboard/addnewbrand"><i
									class="fa fa-circle-o"></i>NEW BRAND</a>
						</li>
							<li>
								<!-- ADD NEW CATEGORY --> <a
								href="${pageContext.request.contextPath}/dashboard/addnewcategory "><i
									class="fa fa-circle-o"></i>NEW CATEGORY</a>
						</li>

					</ul></li>
					<!-- Brand / Category -->
					<li class="treeview"><a href="#"> <i class="fa fa-share"></i>
							<span>View Brand / Category</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li>
								<!-- VIEW BRAND & EDIT & DELETE --> <a
								href="${pageContext.request.contextPath}/dashboard/viewallbrand "><i
									class="fa fa-circle-o"></i>ALL BRAND</a>
						</li>
							<li>
								<!-- VIEW CATEGORY & EDIT & DELETE --> <a
								href="${pageContext.request.contextPath}/dashboard/viewallcategory"><i
									class="fa fa-circle-o"></i>ALL CATEGORY</a>
						</li>
					</ul></li>
					<!-- ACcount View -->
					<li class="treeview"><a href="#"> <i class="fa fa-share"></i>
							<span>View Account</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li>
								<!-- VIEW ACCOUNT ADMIN --> <a
								href="${pageContext.request.contextPath}/superadmin/viewadmin "
								target="_blank"><i class="fa fa-circle-o"></i>ADMIN</a>
						</li>
							<li>
								<!-- VIEW USER --> <a
								href="${pageContext.request.contextPath}/dashboard/viewalluser"><i
									class="fa fa-circle-o"></i>USER</a>
						</li>


					</ul></li>
			</ul>
		</section> <!-- /.sidebar -->
	</aside> <!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>Dashboard <small>Control panel</small>
			</h1>
				<ol class="breadcrumb">
					<li><a
						href="${pageContext.request.contextPath }/dashboard/welcome"><i
							class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Dashboard</li>
			</ol>
		</section> <!-- Main content --> <!-- /.content --> <tiles:insertAttribute
				name="content"></tiles:insertAttribute>
	</div> <!-- /.content-wrapper --> <footer class="main-footer">
			<div class="pull-right hidden-xs"><b>Version</b> 2.4.0</div> <strong>Copyright
				&copy; 2018-2019 <a
				href="${pageContext.request.contextPath }/dashboard">MemoryStorage
					Shop</a>.
		</strong> All rights reserved.
	</footer> <!-- Control Sidebar -->
		<div class="control-sidebar-bg"></div></div>
	<!-- ./wrapper -->
	<!-- EDITOR BOOTRAP -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/plugins/bootstrap-wysihtml5/jquery-1.7.2.min.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/plugins/bootstrap-wysihtml5/prettify.js"></script>

	<script
	src="${pageContext.request.contextPath }/resources/admin/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>

	<!-- jQuery 3 -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- Bootstrap 3.3.7 -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- Morris.js charts -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/raphael/raphael.min.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/morris.js/morris.min.js"></script>
	<!-- Sparkline -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
	<!-- jvectormap -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<!-- jQuery Knob Chart -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/moment/min/moment.min.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- datepicker -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>

	<!-- Slimscroll -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/fastclick/lib/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/js/adminlte.min.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/js/jquery-1.4.2.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/js/jquery-ui-1.8.2.custom.min.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- jQuery 3 -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/js/pages/dashboard.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script
	src="${pageContext.request.contextPath }/resources/admin/js/demo.js"></script>
	<!-- DataTables -->

	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
	src="${pageContext.request.contextPath }/resources/admin/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script src="https://cdn.ckeditor.com/4.11.1/standard-all/ckeditor.js"></script>
	<script>
		var editor1 = CKEDITOR.replace('editor1', {
			extraAllowedContent : 'div',
			height : 230
		});
		editor1.on('instanceReady', function() {
			// Output self-closing tags the HTML4 way, like <br>.
			this.dataProcessor.writer.selfClosingEnd = '>';

			// Use line breaks for block elements, tables, and lists.
			var dtd = CKEDITOR.dtd;
			for ( var e in CKEDITOR.tools.extend({}, dtd.$nonBodyContent,
					dtd.$block, dtd.$listItem, dtd.$tableContent)) {
				this.dataProcessor.writer.setRules(e, {
					indent : true,
					breakBeforeOpen : true,
					breakAfterOpen : true,
					breakBeforeClose : true,
					breakAfterClose : true
				});
			}
			// Start in source mode.
			this.setMode('source');
		});
	</script>
	<script>
		var editor1 = CKEDITOR.replace('editor2', {
			extraAllowedContent : 'div',
			height : 460
		});
		editor2.on('instanceReady', function() {
			// Output self-closing tags the HTML4 way, like <br>.
			this.dataProcessor.writer.selfClosingEnd = '>';

			// Use line breaks for block elements, tables, and lists.
			var dtd = CKEDITOR.dtd;
			for ( var e in CKEDITOR.tools.extend({}, dtd.$nonBodyContent,
					dtd.$block, dtd.$listItem, dtd.$tableContent)) {
				this.dataProcessor.writer.setRules(e, {
					indent : true,
					breakBeforeOpen : true,
					breakAfterOpen : true,
					breakBeforeClose : true,
					breakAfterClose : true
				});
			}
			// Start in source mode.
			this.setMode('source');
		});
	</script>
	<script type="text/javascript">
		$.fn.dataTable.ext.type.detect
				.unshift(function(d) {
					return d === 'Low' || d === 'Medium' || d === 'High' ? 'salary-grade'
							: null;
				});

		$.fn.dataTable.ext.type.order['salary-grade-pre'] = function(d) {
			switch (d) {
			case 'Low':
				return 1;
			case 'Medium':
				return 2;
			case 'High':
				return 3;
			}
			return 0;
		};

		$(document).ready(function() {
			$('#example').DataTable();
		});
	</script>

</body>
</html>
