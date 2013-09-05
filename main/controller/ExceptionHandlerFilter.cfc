<cfcomponent extends="MachII.framework.EventFilter" output="false">

	<cffunction name="configure" access="public" output="false" returntype="void" hint="Configures the filter">
		<!--- Does nothing --->
	</cffunction>

	<cffunction name="filterEvent" access="public" output="false" returntype="boolean" hint="Runs the filter event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfif arguments.event.getArg("exception").getType() EQ "MachII.framework.EventHandlerNotDefined">
			<cfset arguments.eventContext.announceEvent("showErrorHandler_404", arguments.event.getArgs()) />
			<cfreturn false />
		</cfif>

		<cfreturn true />
	</cffunction>

</cfcomponent>
