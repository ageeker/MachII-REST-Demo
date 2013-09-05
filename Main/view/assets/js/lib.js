	$(document).ready( function() {
		$("header:first").addClass("ui-widget").addClass("ui-state-hover").addClass("ui-padded").addClass("ui-corner-all");
		//$("nav").addClass("ui-margined");
		$("nav").addClass("ui-state-default");
		$("nav ul li a").addClass("ui-widget-content");
		$("nav ul li a").hover(
      function () {
        $(this).addClass("ui-state-focus");
      }, 
      function () {
        $(this).removeClass("ui-state-focus");
      }
    );
		$("section").addClass("ui-padded").addClass("ui-margined");
		// this will find images that dont have a figure parent tag, add it and add a fig caption
		$("#main img").each(function (i){
			// images that use a class "no-auto-figure" will not get the figure/figurecatpion wrap - this is useful when using the jquery cycle plugin for a lside show
			// if you add "no-auto-format" then none of the formatting will occur (the drop shadow wont be added either)
			var autoformat = !$(this).hasClass("no-auto-format");
			var autofigure = !$(this).hasClass("no-auto-figure");
			if(autoformat){
				$(this).css("box-shadow","5px 5px 5px #888888");
				var alt= $(this).attr("alt");
				var hasfigure = $(this).parent("figure").length;
				if(! hasfigure && autofigure)
					$(this).wrap('<figure />')
				// now add a figure caption if there isn't already one
				var figure = $(this).parent("figure");
				var hasFigCaption = $("figcaption",figure).length;
				if(! hasFigCaption & autofigure) 
					$(this).after('<figcaption>'+alt+'</figcaption>');
			}
		});
		$("figcaption").wrapInner('<span class="ui-state-highlight ui-padded-wide ui-corner-all" />');
		
		$('.coming-soon').click(function(){
			alert('coming soon');															 
			return false;
		});
		$('.focus').focus();
		$(".accordion").accordion({ header: "h3"});
		$('.tabs').tabs({ selected: 0 });
		$('.confirm').click( function() {
			var text = $(this).attr("title");
			if(!text.length){
				text = $(this).html();
				if($(this).is(":input")){
					text = $(this).val();
				}
				text = "Please confirm you would like to: "+text;
			}else{
				text = "Are you sure you would like to " + text;
			}
			return confirm(text);
		} );

		// any form elements that have the class auto-hint will show their title attribute whenever blank. be careful of submits as these values will come through
		$("input.auto-hint").each(function(){
			var hint = $(this).attr("title");
			var size = $(this).attr("size");
			var max_size = 80;
			if(size == 0){
				if(hint.length > max_size) $(this).attr("size",max_size)
				else if(hint.length > 0) $(this).attr("size",hint.length);
			}
			$(this).blur(function() {
				if(!$(this).val().length){
					$(this).val($(this).attr("title"));
					$(this).addClass("ui-hinted");
				}
			});
			$(this).focus(function () {
				$(this).removeClass("ui-hinted");
				if($(this).val() == $(this).attr("title")){
					$(this).val("");
				}
			});
		}).blur();
		
		$('.datepicker').datepicker({
			showOn: 'button'
			,buttonImage: troyweb1.baseURL+'images/icons/calendar.gif'
			,buttonImageOnly: true
		});

		$('.dob-datepicker').datepicker({
			showOn: 'button'
			,buttonImage: troyweb1.baseURL+'images/icons/calendar.gif'
			,buttonImageOnly: true
			,changeMonth: true
			,changeYear: true
			,yearRange: '-15:-2'
			,defaultDate:'-10y'
		});

		$('.jq-button').button();
		$("[class*=jq-button-]").each( function() {
			var classes = $(this).attr("class").split(" ");
			for(var ii in classes){
				if(classes[ii].substring(0,10) == "jq-button-"){
					var iconClass = "ui-icon-"+classes[ii].substring(10,classes[ii].length);
					$(this).button( {
						 icons: {primary:iconClass}
					});
					break;
				}
			}
		});
		$("[class*=jq-icon-link-]").each( function() {
			var classes = $(this).attr("class").split(" ");
			for(var ii in classes){
				if(classes[ii].substring(0,13) == "jq-icon-link-"){
					var iconClass = "ui-icon ui-icon-"+classes[ii].substring(13,classes[ii].length);
					$(this).before('<span style="display:inline-block; margin-right:3px; vertical-align:text-bottom" class="'+iconClass+'"></span>');
					break;
				}
			}
		});

		$("a").each( function(){
			var atts = {href:$(this).attr("href"),target:$(this).attr("target"),mime:""};
			var skip=$(this).children("figure").length || $(this).children("img").length || $(this).hasClass("ui-icon-none");
			atts.extlink = atts.href.indexOf("http://")==0 && atts.href.indexOf(troyweb1.baseURL)<0;
			atts.mail = atts.href.indexOf("mailto:")==0;
			atts.newwin = atts.target != void(null) && atts.target.indexOf("_blank")==0;
			if(endsWith(atts.href,".doc") || endsWith(atts.href,".docx")) atts.mime="doc"; 
				else if(endsWith(atts.href,".ppt") || endsWith(atts.href,".pptx")) atts.mime="ppt";
					else if(endsWith(atts.href,".xls") || endsWith(atts.href,".xlsx"))  atts.mime="xls";
						else if(endsWith(atts.href,".pdf")) atts.mime="pdf";
							else if(endsWith(atts.href,".txt")) atts.mime="txt";
								else if(endsWith(atts.href,".zip")) atts.mime="zip";
									else if(endsWith(atts.href,".rss")) atts.mime="rss";
										else if(endsWith(atts.href,".cal")) atts.mime="cal";
			if(skip) void(null);
				else if(atts.mime.length) $(this).after('<span style="display:inline-block;" class="ui-icon-mime ui-icon-mime-'+atts.mime+'"></span>');
					else if(atts.mail) $(this).after('<span style="display:inline-block; margin-left:3px; vertical-align:text-bottom" class="ui-icon ui-icon-mail-closed"></span>');	
						else if(atts.newwin) $(this).after('<span style="display:inline-block; margin-left:3px; vertical-align:text-bottom" class="ui-icon ui-icon-newwin"></span>');
							else if(atts.extlink && !atts.newwin)	$(this).after('<span style="display:inline-block; margin-left:3px; vertical-align:text-bottom" class="ui-icon ui-icon-extlink"></span>');
		
			//debug(atts.href+" - "+skip);
		});
		
		$(".auto-submit").change(function () {
			$(this).parents("form").submit();
		});

		$(".auto-hide").addClass("ui-helper-hidden");
		$(".no-link-icon").css("margin","0").css("padding","0").css("background-image","none");
		// setup content tables
		$("#main table[class!='no-auto-format'] caption[class!='no-auto-format']").addClass("ui-state-focus").addClass("ui-corner-all");
		$("#main table[class!='no-auto-format'] tfoot[class!='no-auto-format']").addClass("ui-state-default");
		$("table[class*='cfdump_']").css("margin","0");
		
		$("#main fieldset").css("background","none").css("font-weight","normal").addClass("ui-state-focus").addClass("ui-padded").addClass("ui-corner-all");
		$("#main fieldset legend").addClass("ui-state-focus").addClass("ui-padded").addClass("ui-corner-all");
		$(":input.auto-tip").after('<span class="tip-display"></span>');
		$(":input.auto-tip").change(function () {
				var tip = $(this).next("span.tip-display");
				var me = $(this).attr("id");
				var option = $("#"+me+" option:selected");
				tip.hide().text(option.attr("title"));
				tip.fadeIn("slow");
			}).change();
	} );

	function endsWith(str, suffix) {
			return str.indexOf(suffix, str.length - suffix.length) !== -1;
	}

	function buildOptionString(data) {
				var htmlRet = '<option value=""><\/option>';    
				for(var ii=0; ii < data.length; ii++) {
							htmlRet += '<option value="' + data[ii].VALUE + '">' + data[ii].DISPLAY + '<\/option>';
				}
				return htmlRet;
	}

	function debug(msg){
		if($("#jquery-debug-text").length ==0){
			$("body").append('<div id="jquery-debug-text"><textarea rows="20"></textarea></div>');
		}
		var current = $("#jquery-debug-text textarea").text();
		if(current.length >0) current = current + "\n";
		var msg = current + msg;
		$("#jquery-debug-text textarea").text(msg);
	}

