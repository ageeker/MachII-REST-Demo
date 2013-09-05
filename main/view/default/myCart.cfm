<cfset myCart = event.getArg("myCart", queryNew("")) />

<cfset resultSet = myCart.resultSet />
<cfset startingAt = myCart.startingAt />
<cfset maxCount = myCart.maxCount />

<cfoutput>
	<div><a href="./?event=findProducts">Search For More Items</a></div>
	<h2>My Cart Of Fake Products</h2>

	<!--- 
			<cfreturn {resultSet=queryNew(""), totalRecord=0, startingAt=0, maxCount=0} /> --->

	<cfif myCart.totalRecords NEQ -1>
		<cfsavecontent variable="resultSetNav">
			<cfset lastSet = startingAt - maxCount />
			<cfset nextSet = startingAt + maxCount />
			
			<div style="text-align: center;">
				<br />
				<cfif lastSet GT 0>
					<a href="./index.cfm?event=findProducts&term=#term#">First Page</a> | 
					<a href="./index.cfm?event=findProducts&term=#term#&startAt=#lastSet#">Previous Page</a>
				</cfif>
				<cfif lastSet GT 0 AND nextSet LT myCart.totalRecords> | </cfif>
				<cfif nextSet LT myCart.totalRecords><a href="./index.cfm?event=findProducts&term=#term#&startAt=#nextSet#">Next Page</a></cfif>
			</div>
		</cfsavecontent>

		<div id="productsListing">
			<cfif myCart.totalRecords EQ 1>
				<div id="resultCount">#myCart.totalRecords# Item Type In Your Cart</div>
			<cfelse>
				<div id="resultCount">#myCart.totalRecords# Different Items In Your Cart</div>
			</cfif>

			#resultSetNav#
			
			<table border="0">
			<cfloop query="resultSet">
				<tr class="itemHeader prod#currentRow# row1">
					<td colspan="3"><label class="title">#resultSet.product#</label></td>
				</tr>
				<tr class="prod#currentRow# row2">
					<td valign="top"><div class="prodImg"><img src="#resultSet.imageSmall#" width="85" /></div></td>
					<td valign="top">
						<div class="description">#left(resultSet.description, 200)#<cfif len(resultSet.description) GT 200>...</cfif></div>
						<div class="details">
							<span>
								#resultSet.inCartCount# In Cart (<a href="./index.cfm?event=removeOneFromMyCart&productId=#resultSet.id#&startAt=#startingAt#" title="Remove 1">X</a>) | 
								<a href="./index.cfm?event=addAnotherToMyCart&productId=#resultSet.id#&startAt=#startingAt#">Add Another</a>
							</span>
							 | 
							<span>#dollarFormat(resultSet.cost)#</span>
						</div>
					</td>
				</tr>
			</cfloop>
			</table>
		</div>

		#resultSetNav#

	<cfelse>
		<div id="productsListing">
			<br />
			Please use the above search form to search for some of the great products we keep in stock. As always we promise delivery within 12 hours anywhere in the world for orders over $1.
		</div>
	</cfif>
</cfoutput>