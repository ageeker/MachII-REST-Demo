<cfcomponent output="false">

	<cffunction name="init" access="public" returntype="Demo201302.service.ApplicationService">
		<cfargument name="dsnMain" type="String" required="true">

		<cfset variables.dsnMain = arguments.dsnMain />

		<cfreturn this />
	</cffunction>

	<cffunction name="setSessionService" access="public" returntype="VOID" output="false">
		<cfargument name="SessionService" type="Demo201302.service.SessionService" required="true">
		<cfset variables.SessionService = arguments.SessionService />
	</cffunction>

	<cffunction name="findProducts" access="public" returntype="Struct" output="false">
		<cfargument name="term" type="variableName" required="false" default="title" />
		<cfargument name="startAt" type="Numeric" required="false" default="0" />

		<cfset var c = 0 />
		<cfset var p = 0 />
		<cfset var maxCount = 10 />
		<cfset var results = structNew() />

		<cfquery name="c" datasource="#variables.dsnMain#">
			SELECT COUNT(id) as `count`
			FROM tblFakeProducts
			WHERE 
				product LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%arguments.term%" />
				or description LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%" />
		</cfquery>

		<cfquery name="p" datasource="#variables.dsnMain#">
			SELECT 
				id, product, description, cost,
				CONCAT('/view/assets/images/product_icons/', id, 'small.jpg') as imageSmall,
				CONCAT('/view/assets/images/product_icons/', id, 'medium.jpg') as imageMedium,
				CONCAT('/view/assets/images/product_icons/', id, 'large.jpg') as imageLarg
			FROM tblFakeProducts
			WHERE 
				product LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%arguments.term%" />
				or description LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%" />
			limit #startAt#, #maxCount#
		</cfquery>
		
		<cfset results = {resultSet=p, totalRecords=c.count, startingAt=arguments.startAt, maxCount=maxCount}>

		<cfreturn results />
	</cffunction>

	<cffunction name="getCartRendered" access="public" returntype="Struct" output="false">
		<cfargument name="startAt" type="Numeric" required="false" default="0" />
	
		<cfset var p = 0 />
		<cfset var c = 0 />
		<cfset var results = "" />
		<cfset var myCart = getCartRaw() />
		<cfset var maxCount = 10 />

		<cfquery name="c" datasource="#variables.dsnMain#">
			SELECT  COUNT(id) as `count`
			FROM tblFakeProducts
			WHERE id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#structKeyList(myCart)#" list="true" />)
		</cfquery>

		<cfquery name="p" datasource="#variables.dsnMain#">
			SELECT 
				id, product, description, cost, 0 as inCartCount,
				CONCAT('/view/assets/images/product_icons/', id, 'small.jpg') as imageSmall,
				CONCAT('/view/assets/images/product_icons/', id, 'medium.jpg') as imageMedium,
				CONCAT('/view/assets/images/product_icons/', id, 'large.jpg') as imageLarg
			FROM tblFakeProducts
			WHERE id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#structKeyList(myCart)#" list="true" />)
			limit #startAt#, #maxCount#
		</cfquery>

		<cfloop query="p">
			<cfif structKeyExists(myCart, p.id)>
				<cfset querySetcell(p, "inCartCount", myCart[p.id], currentRow)>
			</cfif>
		</cfloop>

		<cfset results = {resultSet=p, totalRecords=c.count, startingAt=arguments.startAt, maxCount=maxCount}>
		
		<cfreturn results />
	</cffunction>

	<cffunction name="getCartRaw" access="public" returntype="Struct" output="false">
		<cfreturn variables.SessionService.getSessionVariable("shoppingCart", structNew())>
	</cffunction>

	<cffunction name="updateCart" access="public" returntype="Void" output="false">
		<cfargument name="cart" type="struct" required="true" />
		<cfset variables.SessionService.setSessionVariable("shoppingCart", arguments.cart) />
	</cffunction>

	<cffunction name="addToCart" access="public" returntype="Boolean" output="false">
		<cfargument name="productId" type="Numeric" required="true" />

		<cfset cart = getCartRaw() />

		<cfif structKeyExists(cart, productId) AND isNUmeric(cart[productId]) >
			<cfset cart[productId] = cart[productId] + 1 />
		<cfelse>
			<cfset cart[productId] = 1 />
		</cfif>
		
		<cfset updateCart(cart) />

		<cfreturn true />
	</cffunction>

	<cffunction name="removeFromCart" access="public" returntype="Boolean" output="false">
		<cfargument name="productId" type="Numeric" required="true" />

		<cfset cart = getCartRaw() />

		<cfif structKeyExists(cart, productId) AND isNUmeric(cart[productId]) >
			<cfif cart[productId] EQ 1>
				<cfset structDelete(cart, productId) />
			<cfelse>
				<cfset cart[productId] = cart[productId] - 1 />
			</cfif>
		</cfif>
		
		<cfset updateCart(cart) />

		<cfreturn true />
	</cffunction>

    <cffunction name="queryToStruct" access="public" returntype="Struct" output="false">
        <cfargument name="q" type="Query" required="true">
        <cfargument name="i" type="String" required="true" hint="index column">

		<cfset results = structNew() />
		<cfset columns = lCase(q.columnList) />

		<cfloop query="q">
			<cfset results[q[arguments.i][currentRow]] = structNew() />
			<cfloop index="col" list="#columns#">
				<cfset results[q[arguments.i][currentRow]][col] = q[col][currentRow] />
			</cfloop>
		</cfloop>

       <cfreturn results />
    </cffunction>

</cfcomponent>