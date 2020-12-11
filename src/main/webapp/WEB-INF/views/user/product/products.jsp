<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/user/css/simplePagination.css" />
<div id="breadcrumb">
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}/home">Home</a></li>
			<c:choose>
				<c:when test="${not empty cate }">
					<li class="active" id="cate">${cate }</li>
				</c:when>
				<c:otherwise>
					<li class="active" id="cate">Search: <i>${keyword }</i> <c:if
							test="${not empty catesearch }"> in <i>${catesearch.name }</i>
						</c:if></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>
<div class="section" style="margin-top: 30px; margin-bottom: 80px">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- ASIDE -->
			<div id="aside" class="col-md-3">
				<!-- aside widget -->
				<div class="aside">
					<h3 class="aside-title">Shop by:</h3>


					<ul class="filter-list" id="filter-size">
					</ul>
					<ul class="filter-list" id="filter-brand">
					</ul>

					<button class="primary-btn" onclick="clearall()">Clear All</button>
				</div>
				<!-- /aside widget -->

				<!-- aside widget -->
				<div class="aside">
					<h3 class="aside-title">Filter by Price</h3>
					<div id="price-slider"></div>
					<button class="primary-btn" onclick="filterprice()">Filter</button>
				</div>
				<!-- aside widget -->

				<!-- aside widget -->

				<!-- /aside widget -->

				<!-- aside widget -->
				<div class="aside">
					<h3 class="aside-title">Filter By Size:</h3>
					<ul class="size-option">
						<c:forEach items="${sizes }" var="size">
							<li class="active"><a style="cursor: pointer;"
								onclick="filterFunction('${size}')">${size }GB</a></li>
						</c:forEach>

					</ul>
				</div>
				<!-- /aside widget -->

				<!-- aside widget -->
				<div class="aside">
					<h3 class="aside-title">Filter by Brand</h3>
					<ul class="list-links">
						<c:forEach items="${brands }" var="brand">
							<li><a style="cursor: pointer;"
								onclick="filterFunction('${brand}')">${brand }</a></li>





						</c:forEach>
					</ul>
				</div>

				<!-- /aside widget -->

				<!-- aside widget -->

				<!-- /aside widget -->

				<!-- aside widget -->

				<!-- /aside widget -->
			</div>
			<!-- /ASIDE -->

			<!-- MAIN -->
			<div id="main" class="col-md-9">
				<!-- store top filter -->
				<div class="store-filter clearfix">
					<div class="pull-left">
						<div class="row-filter">
							<a href="#"><i class="fa fa-th-large"></i></a> <a href="#"
								class="active"><i class="fa fa-bars"></i></a>
						</div>
						<div class="sort-filter">
							<span class="text-uppercase">Sort By:</span> <select
								class="input">
								<option value="0">Position</option>
								<option value="0">Price</option>
								<option value="0">Rating</option>
							</select>
						</div>
					</div>
					<div class="pull-right"
						style="position: absolute; right: 15px; top: -10px;">


						<ul class="pagination" id="paging">
							<li id="previous-page"><a href="javascript:void(0)"
								aria-label=Previous><span aria-hidden=true>&laquo;</span></a></li>
						</ul>

					</div>
				</div>
				<!-- /store top filter -->

				<!-- STORE -->
				<div id="store">

					<!-- row -->
					<div class="row" id="dataproducts">
						<c:choose>
							<c:when test="${fn:length(products) > 0 }">
								<c:forEach items="${products }" var="product">
									<div class="col-md-3 list-group" id="product">
										<div class="product product-single">
											<div class="product-thumb">
												<img
													src="${pageContext.request.contextPath}/images/${product.photo } "
													alt="">
											</div>
											<div class="product-body">
												<h3 class="product-price">
													<fmt:formatNumber value="${product.price }" type="currency"
														currencySymbol="$"></fmt:formatNumber>
												</h3>
												<div class="product-rating">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star"></i> <i class="fa fa-star"></i> <i
														class="fa fa-star-o empty"></i>
												</div>
												<h2 class="product-name">
													<a
														href="${pageContext.request.contextPath }/product/detail?id=${product.id }"
														class="text2line">${product.name }</a>
												</h2>
												<div class="product-btns">
													<button class="main-btn icon-btn">
														<i class="fa fa-heart"></i>
													</button>
													<c:choose>
														<c:when test="${product.quantity == 0 }">
															<button class="primary-btn add-to-cart">
																<i class="fa fa-shopping-cart"></i> <a
																	style="color: inherit;">Out of stock</a>
															</button>
														</c:when>
														<c:otherwise>
															<button class="primary-btn add-to-cart">
																<i class="fa fa-shopping-cart"></i> <a
																	style="color: inherit;"
																	href="${pageContext.request.contextPath }/cart/add?id=${product.id }">Add
																	to Cart</a>
															</button>
														</c:otherwise>
													</c:choose>

												</div>
											</div>
										</div>

									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p>No result...</p>
							</c:otherwise>
						</c:choose>


					</div>
					<!-- /row -->
				</div>
				<!-- /STORE -->


			</div>
			<!-- /MAIN -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/user/js/nouislider.min.js"></script>

<script type="text/javascript">
	document.getElementById('home').style.color = "#008744";
	var cate = document.getElementById("cate").textContent;
	var maxprice = 0, minprice = 0;
	var slider = document.getElementById('price-slider');
	if (slider) {
		noUiSlider.create(slider, {
			start : [ 1, 999 ],
			connect : true,
			tooltips : [ true, true ],
			format : {
				to : function(value) {
					return value.toFixed(2) + '$';
				},
				from : function(value) {
					return value
				}
			},
			range : {
				'min' : 1,
				'max' : 999
			}
		});
		slider.noUiSlider.on('update', function(values, handle) {
			var value = values[handle];
			if (handle) {
				maxprice = value;
			} else {
				minprice = value;
			}
		});
	}

	var filter = [], prices = [];
	var filterbrand = '', filtersize = '';
	prices.push('1');
	prices.push('999');
	function filterprice() {
		prices[0] = minprice;
		prices[1] = maxprice;
		filters(filter, prices);
	}

	function filterFunction(element) {
		for (var i = 0; i < filter.length; i++) {
			if (filter[i] === element)
				break;
		}
		if (i === filter.length) {
			filter.push(element);
			filters(filter, prices);
			if (isNaN(element)) //du lieu loc khong phai la so, tuc la brand
			{
				if (filterbrand === "")
					filterbrand = '<li><span class="text-uppercase">Brand:</span></li>';
				filterbrand += '<li id="' + element
						+ '" onclick="removefilter(\'#' + element
						+ '\')"><a style="cursor: pointer;">' + element
						+ '</a></li>';
				document.getElementById("filter-brand").innerHTML = filterbrand;
			} else //du lieu loc la so, tuc la size
			{
				if (filtersize === "")
					filtersize = '<li><span class="text-uppercase">Size:</span></li>';
				filtersize += '<li id="' + element
						+ '" onclick="removefilter(\'#' + element
						+ '\')"><a style="cursor: pointer;">' + element
						+ 'GB</a></li>';
				document.getElementById("filter-size").innerHTML = filtersize;

			}

		}

	}
	function removefilter(id) {
		$(id).remove();
		id = id.replace("#", "");
		for (var i = 0; i < filter.length; i++) {
			if (filter[i] === id) {
				filter.splice(i, 1);
				break;
			}
		}
		filters(filter, prices);
		if (filter.length === 0) {
			filterbrand = "";
			filtersize = "";
		} else {
			var havebrand = havesize = false;
			for (var i = 0; i < filter.length; i++)
				if (isNaN(filter[i]))
					havebrand = true;
				else
					havesize = true;
			if (!havebrand)
				filterbrand = "";
			if (!havesize)
				filtersize = "";
		}

		filterbrand = filterbrand.replace('<li id="' + id
				+ '" onclick="removefilter(\'#' + id
				+ '\')"><a style="cursor: pointer;">' + id + '</a></li>', '');
		filtersize = filtersize.replace('<li id="' + id
				+ '" onclick="removefilter(\'#' + id
				+ '\')"><a style="cursor: pointer;">' + id + 'GB</a></li>', '');
		document.getElementById("filter-brand").innerHTML = filterbrand;
		document.getElementById("filter-size").innerHTML = filtersize;

	}
	function filters(f, p) {
		$
				.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/product/filters?names="
							+ f + "&prices=" + p,
					success : function(result) {
						if (result.status == "Done") {
							var data = result.data;
							var productData = "";
							if (data.length === 0) {
								productData = "<p class=\"noresult\">No result...</p>"
							} else {
								for (var i = 0; i < data.length; i++) {
									productData += '<div class="col-md-3 list-group"><div class="product product-single"><div class="product-thumb">'
											+ '<img src="${pageContext.request.contextPath}/images/'+data[i].photo+'"alt="">'
											+ '</div><div class="product-body"><h3 class="product-price">$'
											+ data[i].price
											+ '</h3><div class="product-rating">'
											+ '<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i>'
											+ '<i class="fa fa-star-o empty"></i></div><h2 class="product-name"><a href="'
											+ '${pageContext.request.contextPath }/product/detail?id='
											+ data[i].id
											+ '"class="text2line">'
											+ data[i].name
											+ '</a></h2><div class="product-btns"><button class="main-btn icon-btn" ><i class="fa fa-heart"></i></button>';

									if (data[i].quantity == 0)
										productData += '<button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i>'
												+ '<a style="color: inherit;">Out of stock</a></button></div></div></div></div>';
									else
										productData += '<button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i><a style="color: inherit;"'
												+ 'href="${pageContext.request.contextPath }/cart/add?id='
												+ data[i].id
												+ '"> Add to Cart</a></button></div></div></div></div>';
								}
							}
							$('#dataproducts').html(productData);
							document.getElementById("paging").innerHTML = '<li id="previous-page"><a href="javascript:void(0)" aria-label=Previous><span aria-hidden=true>&laquo;</span></a></li>';
							demo();
							console.log("Success");
						} else {
							console.log("Fail: ", result);
						}
					},
					error : function(e) {
						console.log("ERROR: ", e);
					}

				});

		urlload();
	}
	function clearall() {
		filter = [];
		filterbrand = "";
		filtersize = "";
		prices[0] = '1';
		prices[1] = '999';
		filters(filter, prices);
		document.getElementById("filter-brand").innerHTML = filterbrand;
		document.getElementById("filter-size").innerHTML = filtersize;
	}
	function urlload() {
		for (var i = 0, urlbrand = "", urlsize = "", urlprice = ""; i < filter.length; i++)
			if (isNaN(filter[i]))
				urlbrand += filter[i] + '%';
			else
				urlsize += filter[i] + '%';
		urlprice += prices[0].replace("$", "") + '-'
				+ prices[1].replace("$", "");
		window.history.pushState('', '', '/product/' + cate + '?q=(' + urlbrand
				+ '&' + urlsize + '&' + urlprice + ')');
		$(window).scrollTop(131);
	}
	function demo()
	{
		var numberOfItems = $('#dataproducts .list-group').length; // Get total number of the items that should be paginated
		var limitPerPage = 12; // Limit of items per each page
		$('#dataproducts .list-group:gt(' + (limitPerPage - 1) + ')').hide(); // Hide all items over page limits (e.g., 5th item, 6th item, etc.)
		var totalPages = Math.round(numberOfItems / limitPerPage); // Get number of pages
		$(".pagination").append("<li class='current-page active'><a href='javascript:void(0)'>" + 1 + "</a></li>"); // Add first page marker

		// Loop to insert page number for each sets of items equal to page limit (e.g., limit of 4 with 20 total items = insert 5 pages)
		for (var i = 2; i <= totalPages; i++) {
		  $(".pagination").append("<li class='current-page'><a href='javascript:void(0)'>" + i + "</a></li>"); // Insert page number into pagination tabs
		}

		// Add next button after all the page numbers  
		$(".pagination").append("<li id='next-page'><a href='javascript:void(0)' aria-label=Next><span aria-hidden=true>&raquo;</span></a></li>");

		// Function that displays new items based on page number that was clicked
		$(".pagination li.current-page").on("click", function() {
		  // Check if page number that was clicked on is the current page that is being displayed
		  if ($(this).hasClass('active')) {
		    return false; // Return false (i.e., nothing to do, since user clicked on the page number that is already being displayed)
		  } else {
		    var currentPage = $(this).index(); // Get the current page number
		    $(".pagination li").removeClass('active'); // Remove the 'active' class status from the page that is currently being displayed
		    $(this).addClass('active'); // Add the 'active' class status to the page that was clicked on
		    $("#dataproducts .list-group").hide(); // Hide all items in loop, this case, all the list groups
		    var grandTotal = limitPerPage * currentPage; // Get the total number of items up to the page number that was clicked on

		    // Loop through total items, selecting a new set of items based on page number
		    for (var i = grandTotal - limitPerPage; i < grandTotal; i++) {
		      $("#dataproducts .list-group:eq(" + i + ")").show(); // Show items from the new page that was selected
		    }
		  }

		});

		// Function to navigate to the next page when users click on the next-page id (next page button)
		$("#next-page").on("click", function() {
		  var currentPage = $(".pagination li.active").index(); // Identify the current active page
		  // Check to make sure that navigating to the next page will not exceed the total number of pages
		  if (currentPage === totalPages) {
		    return false; // Return false (i.e., cannot navigate any further, since it would exceed the maximum number of pages)
		  } else {
		    currentPage++; // Increment the page by one
		    $(".pagination li").removeClass('active'); // Remove the 'active' class status from the current page
		    $("#dataproducts .list-group").hide(); // Hide all items in the pagination loop
		    var grandTotal = limitPerPage * currentPage; // Get the total number of items up to the page that was selected

		    // Loop through total items, selecting a new set of items based on page number
		    for (var i = grandTotal - limitPerPage; i < grandTotal; i++) {
		      $("#dataproducts .list-group:eq(" + i + ")").show(); // Show items from the new page that was selected
		    }

		    $(".pagination li.current-page:eq(" + (currentPage - 1) + ")").addClass('active'); // Make new page number the 'active' page
		  }
		});

		// Function to navigate to the previous page when users click on the previous-page id (previous page button)
		$("#previous-page").on("click", function() {
		  var currentPage = $(".pagination li.active").index(); // Identify the current active page
		  // Check to make sure that users is not on page 1 and attempting to navigating to a previous page
		  if (currentPage === 1) {
		    return false; // Return false (i.e., cannot navigate to a previous page because the current page is page 1)
		  } else {
		    currentPage--; // Decrement page by one
		    $(".pagination li").removeClass('active'); // Remove the 'activate' status class from the previous active page number
		    $("#dataproducts .list-group").hide(); // Hide all items in the pagination loop
		    var grandTotal = limitPerPage * currentPage; // Get the total number of items up to the page that was selected

		    // Loop through total items, selecting a new set of items based on page number
		    for (var i = grandTotal - limitPerPage; i < grandTotal; i++) {
		      $("#dataproducts .list-group:eq(" + i + ")").show(); // Show items from the new page that was selected
		    }

		    $(".pagination li.current-page:eq(" + (currentPage - 1) + ")").addClass('active'); // Make new page number the 'active' page
		  }
		});
	}
	
</script>

