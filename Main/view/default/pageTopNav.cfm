<cfset myCart = event.getArg("myCart") />

<cftry>
	<cfoutput>
		<div class="secondary-nav internal">
			<ul class="inner">
				<cfif NOT structIsempty(myCart)>
					<li class="cart"><a href="./?event=myCart"><span class="content">My Cart</span></a></li>
				</cfif>
			</ul>
		</div>
	</cfoutput>
	<cfcatch><!--- IGNORE ---></cfcatch>
</cftry>