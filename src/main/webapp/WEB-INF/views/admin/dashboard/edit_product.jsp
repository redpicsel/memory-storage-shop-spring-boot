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
				<h3 class="box-title">Edit Product</h3>
			</div>
			<!-- /.box-header -->
			<!-- form start -->
			<s:form method="post" modelAttribute="product"
				action="${pageContext.request.contextPath }/dashboard/updateproduct"
				enctype="multipart/form-data">
				<s:hidden path="id" />
				<div class="box-body">
					<div class="form-group">
						<label for="exampleInputEmail1">Name</label>
						<s:input path="name" type="text" class="form-control"
							placeholder="Enter name" />
					</div>
					<div class="form-group">
						<div class="col-md-6" style="padding: 0;">
							<label for="exampleInputEmail1">Price</label>
							<s:input path="price" type="number" class="form-control"
								placeholder="Enter price" step="any" />
						</div>
						<div class="col-md-6" style="padding-right: 0;">
							<label for="exampleInputEmail1">Quantity</label>
							<s:input path="quantity" type="number" class="form-control"
								placeholder="Enter quantity" />
						</div>

					</div>
					<div class="form-group">
						<div class="col-md-6" style="padding: 0;">
							<label>Brand</label>
							<s:select path="brand" title="--Select Brand--"
								itemLabel="--Select Brand--" class="form-control">
								<s:option label="${product.brand.name }"
									value="${product.brand.id }"></s:option>
								<c:forEach items="${brands }" var="brand">
									<s:option label="${brand.name }" value="${brand.id }"></s:option>
								</c:forEach>
							</s:select>
						</div>
						<div class="col-md-6" style="padding-right: 0;">
							<label>Category</label>
							<s:select path="productCategory" title="--Select Category--"
								class="form-control">
								<s:option label="${product.productCategory.name }"
									value="${product.productCategory.id }"></s:option>
								<c:forEach items="${categories }" var="category">
									<s:option label="${category.name}" value="${category.id }"></s:option>
								</c:forEach>
							</s:select>
						</div>
					</div>
					<div class="form-group">
						<label>Information</label>
						<s:textarea cols="80" id="editor1" path="information" rows="10"></s:textarea>
					</div>
					<div class="form-group">
						<label>Description</label>
						<s:textarea cols="80" id="editor2" path="description" rows="10"></s:textarea>
					</div>
					<div class="form-group">
					<div class="col-md-6" style="padding: 0;">
						<label>Status</label>
						<s:select path="status" title="---Select Status---" class="form-control">
						<s:option value="1" label="True" selected="selected"></s:option>
						<s:option value="0" label="Fasle"></s:option>
					</s:select>
					</div>
						<div class="col-md-6" style="padding-right: 0;">
							<label for="exampleInputEmail1">Size (GB)</label>
							<s:input path="size" type="number" class="form-control"
								placeholder="Enter size" />
						</div>
					</div>
					<div class="form-group">
						<label>Photo(s)</label> <input name="files" type="file" multiple="multiple"/>
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