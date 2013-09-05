<cfset pageTopNavContent = event.getArg("pageTopNavContent") />
<cfset navigation = event.getArg("navigation") />
<cfset mainContent = event.getArg("mainContent") />

<cfset sleep(2200)>

<cfsetting enablecfoutputonly="false" />
<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js"><!-- InstanceBegin template="/Templates/master.dwt.cfm" codeOutsideHTMLIsLocked="false" -->
<!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title dir="ltr">CFUG RESTFul Demo</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">

	<link rel="shortcut icon" href="/view/assets/images/icon.png">
	<link rel="stylesheet" href="/view/assets/css/normalize.min.css">
	<link rel="stylesheet" href="/view/assets/css/layout.css">
	<link rel="stylesheet" href="/view/assets/css/demo-styles.css">

	<script src="/view/assets/js/modernizr-2.6.1-respond-1.1.0.min.js"></script>
	<script type="text/javascript">
		var troyweb1 = {baseURL:"/"};
	</script>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script> 

	<cfset writeOutput(event.getArg("extraHeaderContent")) />
</head>
<body>

		<cfset writeOutput(pageTopNavContent) />

		<div class="main-wrapper internal internal--shadow">
			<header class="main internal twc-cf">
				<div class="top-section twc-cf">
					<div class="left-col">
						<div class="logo-container">
							<h1 class="logo">CFUG Demo<span style="color: silver; font-size: .7em; font-style: italic;"> (02/2013)</span></h1>
						</div>
					</div>
					<div class="right-col">
						<div class="tagline">
							<h2>Improving UX by Leveraging CF &amp; JS</sup></h2>
						</div>
					</div>
				</div>
				<cfset writeOutput(navigation) />
			</header>
			<div class="content" style="padding: 30px 20px 0 20px;">
				<cfset writeOutput(mainContent) />
			</div>
			<footer class="internal">
				<div class="footer-top"></div>
				<div class="inner twc-cf">
					<section class="contact inner">
						<ul style="margin-left: 12px;">
							<li><a href="http://www.anycfug.org">www.anycfug.org</a></li>
							<li><a href="http://www.TroyWebConsulting.com">www.TroyWebConsulting.com</a></li>
						</ul>
					</section>
					<section class="contact inner">
						<ul style="margin-left: 25px;">
							<li><a href="http://mach-ii.com">Mach II Framework</a></li>
							<li><a href="http://www.coldspringframework.org">ColdSpring Framework</a></li>
						</ul>
					</section>
					<section class="contact inner">
						<ul style="margin-left: 12px;">
							<li style="color: silver;">Senior Technologist</li>
							<li><a href="email:Russell@TroyWeb.com">Russell.Brown@TroyWeb.com</a></li>
						</ul>
					</section>
				</div>
			</footer>
		</div>
		<div class="copyright internal">
			Copyright 2013 Troy Web Consulting, LLC.
		</div>

	
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js"></script>
	<script src="/view/assets/js/plugins.js"></script> 
	<script src="/view/assets/js/main.js"></script>
    <script src="/view/assets/js/responsiveslides.min.js"></script>
	
  <!--- <cfinclude template="../lib/includes/ui/google-analytics.cfm" /> --->
	<!-- InstanceBeginEditable name="js" -->
	<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
<cfsetting enablecfoutputonly="true" />