<cfset variables.exception = event.getArg('exception')>


<cfoutput>
	
	<div style="text-align: center; margin-top: 25px;">#variables.exception.getMessage()#</div>
	
	<div style="width: 230px; font-size: 75px; margin-left: auto; margin-right: auto; margin-top: 50px;">
		<div style="width: 230px; text-align: right;">301</div>
		<div style="width: 230px; text-align: right; border-bottom: 2px solid black;">+103</div>
		<div style="width: 230px; text-align: right;">?</div>
	</div>
</cfoutput>