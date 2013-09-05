<cfcomponent displayname="Application" extends="MachII.mach-ii" output="false">
	<cfset this.name = "2013-02-CFUG-PRESO">
	<cfset this.sessionManagement = true>

	<cfset this.mappings["/Demo201302"] = expandPath('./')>

	<!--- MACH-II PROPERTIES --->
	<cfset MACHII_APP_KEY = this.name />
	<cfset MACHII_CONFIG_MODE = -1 />
	<cfset machii_config_path = expandPath('config-machii.xml')>

	<cffunction name="onApplicationStart" returnType="boolean" access="private">
		<cfset application.settings = structNew()>
		<cfset application.intranet.key = createUUID()>

		<cfreturn SUPER.onApplicationStart()>
	</cffunction>

	<cffunction name="onSessionStart" returnType="boolean" access="private">
	   <cfreturn true>
	</cffunction>

	<cffunction name="onRequestStart">
		<cfset var requestTimeout = 60/>

		<cfheader name="expires" value="#now()#"> 
		<cfheader name="pragma" value="no-cache"> 
		<cfheader name="Cache-Control" value="no-cache, no-store, must-revalidate">	

		<cfif structKeyExists(url, "rl")><!---  OR left(cgi.pathInfo, 4) NEQ "/api" --->
			<cflock scope="application" type="exclusive" timeout="15">
				<cfset MACHII_CONFIG_MODE = 1 />
				<cfobjectcache action="clear" />
			
				<cfset onApplicationStart()>
			</cflock>
		</cfif>
		
		<cfset SUPER.onRequestStart(argumentCollection=arguments) />
		
	</cffunction>

</cfcomponent>
