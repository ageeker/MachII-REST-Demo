<cfsetting enablecfoutputonly="false" />

<h2>My Fake Product Search Using AJAX/REST (2)</h2>

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
		
		$.getJSON("/index.cfm/api/cart", function(data){
			myCart = data;
		});

		if (input.length == 0)
			return;
		
		$.getJSON("/index.cfm/api/products/" + input, renderResults);
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

		witnessCartItems();
	}

	function witnessCartItems() {
		for (itm in myCart) {
			$("#inCartDetails" + itm).html(
				myCart[itm] + ' In Cart (<a href="#" class="crtDltFnc" title="Remove" productid="' + itm + '">X</a>) | '
			);
		}
	}

	function rowTemplate(id, title, desc, cost, img) {
		var tmplt = "";
		var term = $("#searchTermInput").val();

		tmplt += '<label class="title">' + title + '</label>';
		tmplt += '<div class="row2">';
			tmplt += '<div class="prodDesc">';
				tmplt += '<div class="imagesmall"><img src="'+img+'" width="75" /></div>';
				tmplt += desc;
			tmplt += '</div>';
			tmplt += '<div class="actionRow">';
				tmplt += '<span id="inCartDetails' + id + '"></span>';
				tmplt += '<a href="./index.cfm?event=stage2:addToCart&productId='+id+'&term='+term+'&startAt=0">Add To Cart</a> | ';
				tmplt += '<span class="cost">$' + cost + '.00</span>';				
			tmplt += '</div>';

		tmplt += '</div>';
		
		return tmplt;
	}
</script>


<cfsetting enablecfoutputonly="true" />