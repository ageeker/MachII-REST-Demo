<cfcomponent output="false" extends="MachII.framework.Listener">

	<cffunction name="configure" access="public" returnType="Demo201302.controller.ApplicationListener">
		<cfreturn this />
	</cffunction>

	<cffunction name="setApplicationService" access="public" returntype="VOID" output="false">
		<cfargument name="ApplicationService" type="Demo201302.service.ApplicationService" required="true">
		<cfset variables.ApplicationService = arguments.ApplicationService />
	</cffunction>

	<cffunction name="findProducts" access="public" returntype="Struct" hint="">
		<cfargument name="event" type="MachII.framework.Event" required="yes"/>

		<cfset var term = arguments.event.getArg("term") />
		<cfset var startAt = arguments.event.getArg("startAt", 0) />

		<cfif NOT len(term)>
			<cfreturn {resultSet=queryNew(""), totalRecords=-1, startingAt=0, maxCount=0} />
		</cfif>

		<cfreturn variables.ApplicationService.findProducts(term, startAt)>
	</cffunction>

	<cffunction name="addToCart" access="public" returntype="Boolean" hint="">
		<cfargument name="event" type="MachII.framework.Event" required="yes"/>

		<cfset var productId = arguments.event.getArg("productId") />

		<cfreturn variables.ApplicationService.addToCart(productId)>
	</cffunction>

	<cffunction name="removeFromCart" access="public" returntype="Boolean" hint="">
		<cfargument name="event" type="MachII.framework.Event" required="yes"/>

		<cfset var productId = arguments.event.getArg("productId") />

		<cfreturn variables.ApplicationService.removeFromCart(productId)>
	</cffunction>

	<cffunction name="getCartRendered" access="public" returntype="Struct" hint="">
		<cfargument name="event" type="MachII.framework.Event" required="yes"/>
		<cfreturn variables.ApplicationService.getCartRendered()>
	</cffunction>

	<cffunction name="getCartRaw" access="public" returntype="Struct" hint="">
		<cfargument name="event" type="MachII.framework.Event" required="yes"/>
		<cfreturn variables.ApplicationService.getCartRaw()>
	</cffunction>

	<cffunction name="generateImages" access="public" returntype="Void" hint="">
		<cfargument name="event" type="MachII.framework.Event" required="yes"/>
		<cfset variables.ApplicationService.generateImages()>
	</cffunction>

</cfcomponent>