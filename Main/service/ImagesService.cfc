<cfcomponent output="false">

	<cffunction name="init" access="public" returntype="Demo201302.service.ApplicationService">
		<cfargument name="dsnMain" type="String" required="true">

		<cfset variables.dsnMain = arguments.dsnMain />
		<cfset generateImages() />

		<cfreturn this />
	</cffunction>

	<cffunction name="generateImages" access="public" returntype="Void" output="false">
		<cfargument name="term" type="variableName" required="false" default="title" />

		<cfset var img1 = "" />
		<cfset var img2 = "" />
		<cfset var img3 = "" />
		<cfset var products = "" />

		<cfsetting requesttimeout="300" />

		<cfquery name="products" datasource="#variables.dsnMain#">
			SELECT id
			FROM tblFakeProducts
			WHERE imageSmall IS NULL OR imageMedium IS NULL OR imageLarge
		</cfquery>
		
		<cfloop query="products">
			<cfhttp method="get" url="http://lorempixel.com/125/125/technics/" getasbinary="Yes" result="img1">
			<cfhttp method="get" url="http://lorempixel.com/200/220/technics/" getasbinary="Yes" result="img2">
			<cfhttp method="get" url="http://lorempixel.com/300/350/technics/" getasbinary="Yes" result="img3">
			
			<cfquery name="results" datasource="#variables.dsnMain#">
				UPDATE tblFakeProducts
				SET 
					imageSmall = <cfqueryparam cfsqltype="cf_sql_blob" value="#img1.fileContent#">,
					imageMedium = <cfqueryparam cfsqltype="cf_sql_blob" value="#img2.fileContent#">,
					imageLarge = <cfqueryparam cfsqltype="cf_sql_blob" value="#img3.fileContent#">
				WHERE id = #products.id#
			</cfquery>
		</cfloop>

		<cfquery name="products" datasource="#variables.dsnMain#">
			SELECT id FROM tblFakeProducts
		</cfquery>

		<cfloop query="products">
			<cfif NOT fileExists(expandPath('/Demo201302/view/assets/images/product_icons/#products.id#small.jpg'))>
				<cfset writeProductImageToDisk(products.id, "small") />
			</cfif>
			<cfif NOT fileExists(expandPath('/Demo201302/view/assets/images/product_icons/#products.id#medium.jpg'))>
				<cfset writeProductImageToDisk(products.id, "medium") />
			</cfif>
			<cfif NOT fileExists(expandPath('/Demo201302/view/assets/images/product_icons/#products.id#large.jpg'))>
				<cfset writeProductImageToDisk(products.id, "large") />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="writeProductImageToDisk" access="public" returntype="Void" output="false">
		<cfargument name="id" type="numeric" required="true" />
		<cfargument name="size" type="variableName" required="false" default="small" />

		<cfset var results = "" />

		<cfquery name="results" datasource="#variables.dsnMain#">
			SELECT 
				<cfif arguments.size EQ "large">
					imageLarge
				<cfelseif arguments.size EQ "medium">
					imageMedium
				<cfelse>
					imageSmall
				</cfif> as Image
			FROM tblFakeProducts
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" />
		</cfquery>
		
		<cffile action="write" file="#expandPath('/Demo201302/view/assets/images/product_icons/#id##size#.jpg')#" output="#results.Image#">
	</cffunction>

</cfcomponent>