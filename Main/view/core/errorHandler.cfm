<cfset variables.exception = event.getArg('exception')>
<cfset variables.stack = variables.exception.getTagContext()>

<cfoutput>
	<style>
		##basicError td {
			vertical-align: top;
		}

		##basicError td.header {
			background-color: lightblue;
			font-weight: bold;
			padding-right: 15px;
			vertical-align: top;
		}

		##basicError ##stackTrace tr td.item  {
			border-bottom: 1px solid black;
		}

		##basicError td.stackTraceNum {
			background-color: lightgreen;
			vertical-align: top;
		}

		##basicError ##stackTraceItem .itemDetail{
			background-color: ##DEDEDE;
			text-transform: lowercase;
			text-align: right;
			padding-right: 5px;
		}
	</style>

	<table id="basicError" border="0" cellpadding="2" cellspacing="0">
		<tr>
			<td class="header">Type</td>
			<td>#variables.exception.getType()#</td>
		</tr>
		<tr>
			<td class="header">Message</td>
			<td>#variables.exception.getMessage()#</td>
		</tr>
		<tr>
			<td class="header">Details</td>
			<td>#variables.exception.getDetail()#</td>
		</tr>
		<tr>
			<td class="header">Stack Trace</td>
			<td>
				<table id="stackTrace" border="0" cellpadding="2" cellspacing="0">
					<cfloop index="i" from="1" to="#arrayLen(variables.stack)#">
						<tr>
							<td class="item stackTraceNum">#i#</td>
							<td class="item">
								<table id="stackTraceItem" border="0" cellpadding="2" cellspacing="0">
									<cfloop index="x" list="#structKeyList(variables.stack[i])#">
										<tr>
											<td class="itemDetail">#x#:</td>
											<td>#variables.stack[i][x]#</td>
										</tr>
									</cfloop>
								</table>
							</td>
						</tr>
					</cfloop>
				</table>
			</td>
		</tr>
	</table>
</cfoutput>

<cfabort>
<cfif request.eventContext.getpreviousevent().getName() EQ "ShowDebugForm">
	<cfabort>
</cfif>