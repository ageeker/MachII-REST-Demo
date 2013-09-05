<cfset term = event.getArg("term") />
<cfset myCart = event.getArg("myCart") />
<cfset searchForm = event.getArg("searchForm") />

<cfset searchResults = event.getArg("searchResults", queryNew("")) />

<cfset resultSet = searchResults.resultSet />
<cfset startingAt = searchResults.startingAt />
<cfset maxCount = searchResults.maxCount />

<cfoutput>
	<h2>My Fake Product Search</h2>

	#searchForm#
	
	<!--- 
			<cfreturn {resultSet=queryNew(""), totalRecord=0, startingAt=0, maxCount=0} /> --->

	<cfif searchResults.totalRecords NEQ -1>
		<cfset resultSetNav = "" />
		<!--- <cfsavecontent variable="resultSetNav">
			<cfset lastSet = startingAt - maxCount />
			<cfset nextSet = startingAt + maxCount />
			
			<div style="text-align: center;">
				<br />
				<cfif lastSet GT 0>
					<a href="./index.cfm?event=findProducts&term=#term#">First Page</a> | 
					<a href="./index.cfm?event=findProducts&term=#term#&startAt=#lastSet#">Previous Page</a>
				</cfif>
				<cfif lastSet GT 0 AND nextSet LT searchResults.totalRecords> | </cfif>
				<cfif nextSet LT searchResults.totalRecords><a href="./index.cfm?event=findProducts&term=#term#&startAt=#nextSet#">Next Page</a></cfif>
			</div>
		</cfsavecontent> --->

		<div id="productsListing">
			<div id="resultCount">#searchResults.totalRecords# results match your query</div>
			#resultSetNav#

			<cfloop query="resultSet">
				<label class="title">#resultSet.product#</label>
				<div class="row2">
					<div class="prodDesc"><div class='imagesmall'><img src="#resultSet.imageSmall#" width="75" /></div>#left(resultSet.description, 200)#<cfif len(resultSet.description) GT 200>...</cfif></div>
					<div class="actionRow">
						<cfif structKeyExists(myCart, id)>#myCart[id]# In Cart (<a href="./index.cfm?event=removeFromCart&productId=#resultSet.id#&term=#term#&startAt=#startingAt#" title="Remove 1">X</a>) | </cfif>
						<a href="./index.cfm?event=addToCart&productId=#resultSet.id#&term=#term#&startAt=#startingAt#">Add To Cart</a> | 
						<span class="cost">#dollarFormat(resultSet.cost)#</span>
					</div>
				</div>
			</cfloop>

		</div>

		#resultSetNav#

	<cfelse>
		<div id="productsListing">
			<br />
			Please use the above search form to search for some of the great products we keep in stock. As always we promise delivery within 12 hours anywhere in the world for orders over $1.
		</div>
	</cfif>
</cfoutput>