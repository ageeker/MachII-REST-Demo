<cfcomponent extends="Demo201302.endpoint.BaseEndpoint" output="false" rest:authenticate="false">
			
	<cffunction name="configure" access="public" returnType="Any">
		<cfreturn SUPER.configure() />
	</cffunction>

	<cffunction name="setApplicationService" access="public" returntype="VOID" output="false">
		<cfargument name="ApplicationService" type="Demo201302.service.ApplicationService" required="true">
		<cfset variables.ApplicationService = arguments.ApplicationService />
	</cffunction>

	<cffunction 
		name="findProducts" 
		access="public" returntype="String" output="false"
		rest:uri="/api/products/{term}"
		rest:method="GET"
		hint="Retrieves list of courses"
	>
		<cfset var x = "" />
		<cfset var results = "" />
		<cfset var argCollection = {term=arguments.term} />

		<cfif structKeyExists(arguments, "startAt")>
			<cfset argCollection["startAt"] = arguments.startAt />
		<cfelse>
			<cfset argCollection["startAt"] = 0 />
		</cfif>

		<cfset products = variables.ApplicationService.findProducts(argumentCollection=argCollection) />
		
		<cfset products.resultSet = queryToArray(products.resultSet)>
		
		<cfreturn serializeJSON(products) />
	</cffunction>

	<cffunction 
		name="getCart" 
		access="public" returntype="String" output="false"
		rest:uri="/api/cart"
		rest:method="GET"
		hint="Get Cart"
	>
		<cfreturn serializeJSON(variables.ApplicationService.getCartRaw()) />
	</cffunction>

	<cffunction 
		name="addToCart" 
		access="public" returntype="String" output="false"
		rest:uri="/api/cart/{productId}"
		rest:method="PUT"
		hint="Add Item To Cart"
	>
		<cfset var x = "" />
		<cfset var results = "" />

		<cfset variables.ApplicationService.addToCart(arguments.productId) />
		
		<cfreturn serializeJSON({success=true}) />
	</cffunction>


	<cffunction 
		name="removeFromCart" 
		access="public" returntype="String" output="false"
		rest:uri="/api/cart/{productId}"
		rest:method="DELETE"
		hint="Remove Item To Cart"
	>
		<cfset var x = "" />
		<cfset var results = "" />

		<cfset variables.ApplicationService.removeFromCart(arguments.productId) />

		<cfreturn serializeJSON({success=true}) />
	</cffunction>

</cfcomponent>