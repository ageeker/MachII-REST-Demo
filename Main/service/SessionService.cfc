<!---
	Albany Medical Center Intranet
 --->

<cfcomponent name="SessionService">

	<cffunction name="init"  access="public" returntype="Demo201302.service.SessionService" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="getSessionUser" returntype="any" output="false">
		<cfif structKeyExists(session,"s_user_ses")>
			<cfreturn session.s_user_ses />
		<cfelse>
			<cfthrow message="Session.NotDefined" detail="This user does not have a session! They may have times out..."/>
		</cfif>
	</cffunction>

	<cffunction name="setSessionUser" returntype="void" output="false">
		<cfargument name="SessionUser" type="any" required="true">
		<cfset session.s_user_ses = arguments.SessionUser/>
	</cffunction>
	
	<cffunction name="isSessionActive" returntype="boolean" output="false">
		<cfreturn structKeyExists(session, "s_user_ses") and (isStruct(session.s_user_ses) or isObject(session.s_user_ses)) />
	</cffunction>

	<cffunction name="endSession" returntype="void" output="false">
		<cfset structClear(session)/>
	</cffunction>

	<cffunction name="getSessionVariable" access="public" returntype="any" output="false">
		<cfargument name="SessionVariableName" type="string" required="true"/>
		<cfargument name="DefaultValue" type="any" required="false"/>

		<cfif structkeyexists(session,arguments.SessionVariableName)>
			<cfreturn session[arguments.SessionVariableName]/>
		<cfelseif structkeyexists(arguments,"DefaultValue")>
			<cfreturn arguments.DefaultValue/>
		<cfelse>
			<cfthrow message="Session variable:#arguments.SessionVariableName# could not be found and no default value was specified in the method call.">
		</cfif>
	</cffunction>

	<cffunction name="setSessionVariable" access="public" returntype="void" output="false">
		<cfargument name="SessionVariableName" type="string" required="true"/>
		<cfargument name="SessionVariableValue" type="any" required="true"/>
		<cfset session[arguments.SessionVariableName] = arguments.SessionVariableValue/>
	</cffunction>

	<cffunction name="hasSessionVariable" access="public" returntype="boolean" output="false">
		<cfargument name="VariableName" type="string" required="true"/>		
		<cfreturn structKeyExists(session,arguments.VariableName)/>
	</cffunction>
	
	<cffunction name="deleterSessionVariable" access="public" returntype="void" output="false"
				 hint="I remove a SessionVariable for the current user">
		<cfargument name="VariableName" type="string" required="true"/>					 
		<cfif hasSessionVariable(arguments.VariableName)>
			<cfset structDelete(session,arguments.VariableName)/>
		</cfif>
	</cffunction>

	<cffunction name="logUserOut" returntype="void" access="public" output="false">
		<cfset var itm = "" />

		<cfloop item="itm" collection="#session#">
			<cfif NOT listFindNoCase("cfid,cftoken,urltoken", itm)>
				<cfset structDelete(session, itm) />
			</cfif>
		</cfloop>
	</cffunction>	

	<cffunction name="isUserLoggedOn" returntype="boolean" access="public" output="false">
		<cfreturn isSessionActive()/>
	</cffunction>
	
</cfcomponent>