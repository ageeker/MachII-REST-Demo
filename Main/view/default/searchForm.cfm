<cfset term = event.getArg("term") />

<cfoutput>
	<form name="searchForm" action="./index.cfm" method="get">
		<input type="hidden" name="event" value="findProducts" />
		<div class="searchForm">
			<span class="inputWrapper">
				<label class="title">Search</label>
				<input type="text" name="term" value="#term#"  />
				<label class="go" onClick="document.forms['searchForm'].submit();">go</label>
			</span>
		</div>
	</form>
</cfoutput>