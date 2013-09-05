<cfset term = event.getArg("term") />

<cfif NOT len(term)>
	<cfset searchTermArg="">
<cfelse>
	<cfset searchTermArg="&term=#term#">
</cfif>

<cfoutput>

<div class="nav-container twc-cf">
	<div class="nav-side"></div>
	<div class="nav-curve">
		<img src="./view/assets/images/spacer.jpg" alt="">
	</div>
	<div class="left-side"></div>
	<nav>
		<a href="##" class="menu">
			<div class="oval-container">
				<span></span>
				<span></span>
				<span></span>
			</div>
			<span>Navigation</span>
		</a>
		<ul>
			<li class="web"><a href="./index.cfm?event=findProducts#searchTermArg#"><span>Stage 1</span></a></li>
			<li class="web"><a href="./index.cfm?event=stage2:findProducts#searchTermArg#"><span>Stage 2</span></a></li>
			<li class="web"><a href="./index.cfm?event=stage3:findProducts#searchTermArg#"><span>Stage 3</span></a></li>
		</ul>
	</nav>
</div>

</cfoutput>