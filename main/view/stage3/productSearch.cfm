<cfsetting enablecfoutputonly="false" />

<h2>My Fake Product Search Using AJAX/REST (3)</h2>

<form name="searchForm" action="##" method="get" onSubmit="initSearch(); return false;">
	<input type="hidden" name="event" value="findProducts" />
	<div class="searchForm">
		<span class="inputWrapper">
			<label class="title">Search</label>
			<input type="text" id="searchTermInput" name="term" value="<cfset writeOutput(event.getArg('term')) />"  />
			<label id="searchGoBtn" class="go">go</label>
		</span>
	</div>
</form>

<div id="productsListing">
	<div>
		<br />
		Please use the above search form to search for some of the great products we keep in stock. As always we promise delivery within 12 hours anywhere in the world for orders over $1.
	</div>
</div>

<script type="text/javascript">
	var myCart = {};

	$("#searchGoBtn").click(initSearch);
	$("document").ready(initSearch);
	
	function initSearch() {
		var input = $("#searchTermInput").val();

		updateMyCart();

		if (input.length == 0)
			return;
		
		$.getJSON("/index.cfm/api/products/" + input, renderResults);
	}
	
	function updateMyCart() {
		$.getJSON("/index.cfm/api/cart", function(data){
			myCart = data;
			witnessCartItems();
		});
	}
	
	function tglFullDesc(el) {
		var elA = $(el).parent().children(".readMoreLink");
		var elB = $(el).parent().children(".prodDescExt");

		if (elA.css("display") == "none") {
			$(el).parent().children(".readMoreLink").css("display", "inline");
			$(el).parent().children(".prodDescExt").css("display", "none");
		} else {
			$(el).parent().children(".readMoreLink").css("display", "none");
			$(el).parent().children(".prodDescExt").css("display", "inline");
		}
	}
	
	function renderResults(data) {
		var tmp, readMore, t1, t2;
		var template = $("#itemTemplate");
		var target = $("#searchResultsOutput table tbody");

		$("#productsListing").html("");
		
		$("#productsListing").append(
			'<div id="resultCount">' + data.TOTALRECORDS + ' results match your query</div>'
		);
		
		$(data.RESULTSET).each(function(i, el){
			$("#productsListing").append(
				rowTemplate(el.id, el.product, el.description, el.cost, el.imagesmall)
			);
		});

		$("#productsListing").find(".cartFnc").each(function(i, el) {
			$(el).click(onCartAction);
		});
		
		witnessCartItems();
	}

	function onCartAction(event) {
		var itm = $(event.currentTarget);

		if (itm.html().indexOf("Add") > -1)
			cartAction("add", itm.attr("productid"));
		else
			cartAction("remove", itm.attr("productid"));

		return false;
	}
	
	function cartAction(type, id) {
		if (type == "add") {
			$.ajax({
				type: "PUT",
				url: '/index.cfm/api/cart/' + id,
				success: updateMyCart,
			});
		} else {
			$.ajax({
				type: "DELETE",
				url: '/index.cfm/api/cart/' + id,
				success: updateMyCart,
			});
		}
		
		return false;
	}
	
	function witnessCartItems() {
		for (itm in myCart) {
			$("#inCartDetails" + itm).html(
				myCart[itm] + ' In Cart (<a href="#" class="crtDltFnc" title="Remove" productid="' + itm + '">X</a>) | '
			);

			$("#inCartDetails" + itm + " .crtDltFnc").click(onCartAction);
		}

		$(".inCartDetails").each(function(i, el) {
			var pId = el.id.replace("inCartDetails", "");
			
			if (!myCart[pId]) {
				$("#inCartDetails" + pId).html("");
			}
		});
	}

	function rowTemplate(id, title, desc, cost, img) {
		var tmplt = "";

		tmplt += '<label class="title">' + title + '</label>';
		tmplt += '<div class="row2">';

			if (desc.length < 200) {
				tmplt += '<div class="prodDesc">';
					tmplt += '<div class="imagesmall"><img src="'+img+'" width="75" /></div>';
					tmplt += desc;
				tmplt += '</div>';
			} else {
				tmplt += '<div class="prodDesc">';
					tmplt += '<div class="imagesmall"><img src="'+img+'" width="75" /></div>';
					tmplt += desc.substring(0, 199);
					tmplt += '... <span class="readMoreLink" onClick="tglFullDesc(this);">click to read more</span>';
					tmplt += '<span class="prodDescExt" style="display: none;" onClick="tglFullDesc(this);">'
						tmplt += desc.substring(200);
					tmplt += '</span>';
				tmplt += '</div>';
			}

			tmplt += '<div class="actionRow">';
				tmplt += '<span class="inCartDetails" id="inCartDetails' + id + '"></span>';
				tmplt += '<a href="#" class="cartFnc" productid="' + id + '">Add To Cart</a> | ';
				tmplt += '<span class="cost">$' + cost + '.00</span>';				
			tmplt += '</div>';

		tmplt += '</div>';
		
		return tmplt;
	}
</script>

<cfsetting enablecfoutputonly="true" />