<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
%{--xml:lang="ar" lang="ar" dir="rtl"--}%
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	%{--<meta name="layout" content="main"/>--}%


	%{--<b style="color: white">--}%


	<title style="direction: rtl; text-align: right;">

		${OperationController.getPath('app.name') ?: 'Nibras PKM'}
		%{--<g:meta name="app.version"/>--}%
		${new Date()?.format('HH:mm')}

	</title>


	%{--<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon-transparent.png')}" type="image/png"/>--}%
	<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon-transparent.png')}" type="image/png"/>



	<link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen.css')}"/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.continuousCalendar.css')}"/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jqueryui-editable.css')}"/>
	%{--    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout-mine.css')}"/>--}%
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'personalization.css')}"/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'simpleSlider.css')}"/>

	%{--    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uploader.css')}"/>--}%


	<script type="text/javascript" src="${resource(dir: 'js/jsdiff', file: 'diff.js')}"></script>




	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>

	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>

	<script type="text/javascript" src="${resource(dir: 'js/ploty', file: 'plotly-2.18.2.min.js')}"></script>

	<script type="text/javascript" src="${resource(dir: 'js', file: 'chosen.jquery.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'am2_SimpleSlider.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.address-1.5.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.continuousCalendar-latest.js')}"></script>
	%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.layout-latest_min.js')}"></script>--}%
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.purr.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.relatedselects.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.tablednd_0_5.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jqueryui-editable.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'morris.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.idletimeout.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.idletimer.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>

	%{--custom js for the keyboard shortcuts--}%
	<script type="text/javascript" src="${resource(dir: 'js', file: 'mybindings.js')}"></script>

	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.qtip.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'raphael-min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'typeahead.bundle.js')}"></script>


	%{--    <asset:javascript src="uploadr.manifest.js"/>--}%
	%{--    <asset:javascript src="uploadr.demo.manifest.js"/>--}%
	%{--    <asset:stylesheet href="uploadr.manifest.css"/>--}%
	%{--    <asset:stylesheet href="uploadr.demo.manifest.css"/>--}%


	<script type="text/javascript" src="${resource(dir: 'plugins/uploader', file: 'jquery.tipTip.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'plugins/uploader', file: 'jquery.uploadr.js')}"></script>
	<link rel="stylesheet" href="${resource(dir: 'plugins/uploader', file: 'jquery.uploadr.css')}"/>


	<!-- LAYOUT v 1.4.3 -->
	<link rel="stylesheet" href="${resource(dir: 'layout', file: 'layout-default.css')}"/>

	<script type="text/javascript" src="${resource(dir: 'layout', file: 'jquery.layout_and_plugins.js')}"></script>

	%{--<script type="text/javascript" src="${resource(dir: 'layout-1.4.3', file: 'jquery.uploadr.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'layout-1.4.3', file: 'jquery.uploadr.js')}"></script>--}%

	%{--<script type="text/javascript" src="./stable/jquery-2.1.1.js"></script>--}%
	%{--<script type="text/javascript" src="./stable/jquery-ui-1.11.0.js"></script>--}%
	%{--<script type="text/javascript" src="./stable/jquery.layout_and_plugins.js"></script>--}%



	<script type="text/javascript" src="${resource(dir: 'uikit-min/js', file: 'uikit.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'uikit-min/js', file: 'uikit-icons.js')}"></script>
	%{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-ui-1.7.2.custom.min.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'chosen.jquery.min-new.js')}"></script>--}%
	%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen1.8.7.css')}"/>--}%


	<link rel="stylesheet" href="${resource(dir: 'uikit-min/css', file: 'uikit.css') }"/>




	%{--${ker.OperationController.getPath('app.headers.background') ?: '#5b7a59'}--}%





	<script type="text/javascript">


		(function ($) {
			var _ = $.layout;

// make sure the callbacks branch exists
			if (!_.callbacks) _.callbacks = {};

			_.callbacks.resizePaneAccordions = function (x, ui) {
				// may be called EITHER from layout-pane.onresize OR tabs.show
				var $P = ui.jquery ? ui : $(ui.newPanel || ui.panel);
				// find all VISIBLE accordions inside this pane and resize them
				$P.find(".ui-accordion:visible").each(function () {
					var $E = $(this);
					if ($E.data("accordion"))		// jQuery < 1.9
						$E.accordion("resize");
					if ($E.data("ui-accordion"))	// jQuery >= 1.9
						$E.accordion("refresh");
				});
			};
		})(jQuery);


		var myLayout;

	$(document).ready(function () {

		// this layout could be created with NO OPTIONS - but showing some here just as a sample...
		// myLayout = $('body').layout(); -- syntax with No Options




		myLayout = $('body').layout({

			center__paneSelector:	".outer-center"
		//	reference only - these options are NOT required because 'true' is the default
		,	closable:					true	// pane can open & close
		,	resizable:					true	// when open, pane can be resized 
		,	slidable:					true	// when closed, pane can 'slide' open over other panes - closes on mouse-out
		,	livePaneResizing:			true
       ,onresize: $.layout.callbacks.resizePaneAccordions
//			,	center__onresize:		"myLayout.resizeAll"
		//	some resizing/toggling settings
		,	north__slidable:			false	// OVERRIDE the pane-default of 'slidable=true'
		,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
		,	north__spacing_closed:		20		// big resizer-bar when open (zero height)
//		,	north__size:				50
		,	south__resizable:			true	// OVERRIDE the pane-default of 'resizable=true'
		,	west__spacing_open:		20		// no resizer-bar when open (zero height)
		,	west__togglerContent_closed: '>>'
		,	west__togglerContent_open: '<<'
		,   slideTrigger_open: "mouseover"
		,   slideTrigger_close: "mouseleave"
		,	west__spacing_closed:		25		// big resizer-bar when open (zero height)
		,	south__spacing_closed:		25		// big resizer-bar when open (zero height)
	,	south__initClosed:	false
	,	west__initClosed:	false
		//	some pane-size settings
		,	west__minSize:				350
		,	west__size:				350
			, west__slideTrigger_close: 'mouseleave'
			,	east__size:					350
//					, west__togglerContent_closed: '<<'

		,	east__minSize:				350
		,	east__maxSize:				.5 // 50% of layout width
		,	west__maxSize:				.5 // 50% of layout width
		,	center__minWidth:			100

		//	some pane animation settings
			,	west__fxName_close:			"none"	// NO animation when closing west-pane
			,	west__fxName_opene:			"none"	// NO animation when closing west-pane
/*
		,	west__animatePaneSizing:	false
		,	west__fxSpeed_size:			"fast"	// 'fast' animation when resizing west-pane
		,	west__fxSpeed_open:			1000	// 1-second animation when opening west-pane
		,	west__fxSettings_open:		{ easing: "easeOutBounce" } // 'bounce' effect when opening
		,	west__fxName_close:			"none"	// NO animation when closing west-pane
*/


		//	enable showOverflow on west-pane so CSS popups will overlap north pane
		,	west__showOverflowOnHover:	true

		//	enable state management
		,	stateManagement__enabled:	false // automatic cookie load & save enabled by default

		,	showDebugMessages:			false// log and/or display messages from debugging & testing code
		});



		var innerLayout = $('div.outer-center').layout({
			center__paneSelector:	".inner-center"
			, south__paneSelector:	".inner-south"
			%{--,	west__paneSelector:		".inner-west"--}%
			%{--,	east__paneSelector:		".inner-east"--}%
			,	west__size:				75
			,	east__size:				75
			,	spacing_open:			8  // ALL panes
			,	spacing_closed:			8  // ALL panes
			,	north__spacing_closed:		25		// big resizer-bar when open (zero height)
			,	south__spacing_closed:		25		// big resizer-bar when open (zero height)
			,	south__spacing_open:		20		// no resizer-bar when open (zero height)
			,	north__togglerContent_closed: 'Commands'
			,	north__togglerContent_open: '^^'
,	south__togglerContent_closed: 'Quick add'
			,	south__togglerContent_open: '^^'

		});




		$.fn.editable.defaults.mode = 'inline';
		$.fn.editable.defaults.showbuttons = true;

		jQuery('.fg-button').hover(
				function () {
					jQuery(this).removeClass('ui-state-default').addClass('ui-state-focus');
				},
				function () {
					jQuery(this).removeClass('ui-state-focus').addClass('ui-state-default');
				}
		);

		var matched, browser;

		jQuery.uaMatch = function (ua) {
			ua = ua.toLowerCase();

			var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
					/(webkit)[ \/]([\w.]+)/.exec(ua) ||
					/(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
					/(msie) ([\w.]+)/.exec(ua) ||
					ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) ||
					[];

			return {
				browser: match[1] || "",
				version: match[2] || "0"
			};
		};

		matched = jQuery.uaMatch(navigator.userAgent);
		browser = {};

		if (matched.browser) {
			browser[matched.browser] = true;
			browser.version = matched.version;
		}

// Chrome is Webkit, but Webkit is also Safari.
		if (browser.chrome) {
			browser.webkit = true;
		} else if (browser.webkit) {
			browser.safari = true;
		}

		jQuery.browser = browser;

		// this layout could be created with NO OPTIONS - but showing some here just as a sample...
		// myLayout = jQuery('body').layout(); -- syntax with No Options

//        jQuery('input').iCheck({
//            checkboxClass: 'icheckbox_minimal-grey',
//            radioClass: 'iradio_minimal-grey',
//            increaseArea: '-20%' // optional
//        });

//        jQuery('#searchForm').load('${request.contextPath}/generics/hqlSearchForm/T')
		jQuery('#tagCloud').load('${request.contextPath}/report/tagCloud')

// jQuery('#centralArea').load('${request.contextPath}/generics/recentRecords')

//        jQuery('#quickAddTextField').select();
//        jQuery('#quickAddTextField').focus();




//
//		$("#accordionCenter").accordion({
//			heightStyle: "fill",
//			header: "h6",
//			fillSpace: true,
//			event: "click",
//			active: 0,
//			collapsible: false,
//			icons: {
//				header: "ui-icon-circle-arrow-e",
//				headerSelected: "ui-icon-circle-arrow-s"
//			}
//
//		});



		jQuery("#accordionWest").accordion({
			heightStyle: "fill",
			fillSpace: true,
			header: "h3",
			event: "click",
			active: ${ker.OperationController.getPath('accordion.west.default.panel')?: '0'},
			collapsible: true,
			icons: {
				header: "ui-icon-circle-arrow-e",
				headerSelected: "ui-icon-circle-arrow-s"
			}

		});

		/*
		 $("#accordionEast").accordion({
		 heightStyle: "fill",
		 header: "h3",
		 fillSpace: true,
		 event: "click",
		 active: ${ker.OperationController.getPath('accordion.east.default.panel')?: '1'},
		 collapsible: true,
		 icons: {
		 header: "ui-icon-circle-arrow-e",
		 headerSelected: "ui-icon-circle-arrow-s"
		 }
		 });
		 */


//            setTimeout(function() {
//                window.location.href = window.location;
//            }, 300000);

		/*

		 jQuery.idleTimeout('#idletimeout', '#idletimeout a', {
		 idleAfter: -1,
		 pollingInterval: 2,
		 keepAliveURL: '${request.contextPath}/page/heartbeat',
		 serverResponseEquals: 'ok',
		 onIdle: function () {
		 jQuery.ajax({
		 type: 'GET',
		 url: '${request.contextPath}/page/heartbeat',
		 dataType: 'html',
		 success: function(html, textStatus) {
		 jQuery('#onlineLog').html("<span style='background: darkgray; color: darkgreen'>Online</span>");
		 //                        console.log('resp idle: ' + html)
		 if (html == 'ok')
		 alert('still online '  + html + ' ' + textStatus);
		 else {
		 //                            confirm('Session lost!')
		 //                        confirm('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
		 //                            alert('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
		 alert('now offline '  + html + ' ' + textStatus);
		 }

		 },

		 error: function(xhr, textStatus, errorThrown) {
		 jQuery('#onlineLog').html("<span style='background: darkgray; color: darkred'>OFFLINE</span>");
		 //                        confirm('Session lost!')
		 //                        confirm('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
		 alert('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
		 }
		 });
		 },
		 onTimeout: function () {
		 //                confirm('Your session has timeout.');
		 jQuery.ajax({
		 type: 'GET',
		 url: '${request.contextPath}/page/heartbeat',
		 dataType: 'html',
		 success: function(html, textStatus) {
		 //                    jQuery('body').append(html);
		 jQuery('#onlineLog').html('Online');
		 //                        console.log('resp timeout: ' + html)
		 },
		 error: function(xhr, textStatus, errorThrown) {
		 confirm('Session timeout!')
		 jQuery('#onlineLog').html('OFFLINE');
		 //                        alert('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
		 }
		 });
		 }
		 });
		 */
		/*
		 jQuery.idleTimeout('#importFileCount','#importFileCount', {
		 idleAfter: 10,
		 pollingInterval: 15,
		 keepAliveURL: '${request.contextPath}/page/importbeat',
		 serverResponseEquals: 'ok',
		 AJAXTimeout: 5,
		 onTimeout: function () {
		 //                confirm('Your session has timeout.');
		 jQuery.ajax({
		 type: 'GET',
		 url: '${request.contextPath}/page/importbeat',
		 dataType: 'html',

		 success: function(html, textStatus) {
		 jQuery('#importFileCount').text(html);
		 //                        console.log('resp timeout: ' + html)
		 }
		 });
		 }
		 });
		 */
		jQuery('#contactPanel').load('${request.contextPath}/generics/contactCloud');
		jQuery('#tagsPanel').load('${request.contextPath}/generics/tagCloud');
		jQuery('#importFileCount').load('${request.contextPath}/page/importbeat');
		jQuery('#recentRecordsCount').load('${request.contextPath}/generics/countRecentRecords');
//            jQuery('#centralArea').load('${request.contextPath}/generics/recentRecords');





		setInterval(function() {
			jQuery.ajax({
				type: 'GET',
				url: '${request.contextPath}/page/heartbeat',
				dataType: 'html',
				success: function(html, textStatus) {
					if (html == 'ok'){
						jQuery('body').removeClass("offline");
						jQuery('#onlineLog').html("<span style='padding: 1px 3px; background: darkgreen; color: white'>Online</span>");
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					jQuery('#onlineLog').html("<span style='padding: 1px 3px; background: darkred; color: white'>OFFLINE</span>");
					jQuery('body').addClass("offline");
					alert('Nibras PKM is offline now!')
//                        console.log('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
				}
			});
		}, 30000);



            Mousetrap.bindGlobal('shift+f4', function (e) {
      jQuery('#addXcdFormDaftarSubmit').click();
//                jQuery('#addXcdFormDaftarSubmit').click();
//                jQuery('#descriptionDaftar').focus();
//            jQuery('#quickAddXcdField').focus();
            });
     Mousetrap.bindGlobal('f4', function (e) {
      jQuery('#typeField').focus();
//                jQuery('#addXcdFormDaftarSubmit').click();
//                jQuery('#descriptionDaftar').focus();
//            jQuery('#quickAddXcdField').focus();
            });

		//Todo how to disable formRemote submission
		// document.forms.quickAddForm['submit'].disabled = true;


		jQuery(window).bind('beforeunload', function () {
			return 'Are you sure you want to leave the application?';
		});


		jQuery.ajaxSetup({
			beforeSend: function () {
				jQuery('#spinner2').show();
			},
			complete: function () {
				jQuery('#spinner2').hide();
			}
			,
			success: function () {
				jQuery('#spinner2').hide();
			}
		});

		jQuery(document).ajaxComplete(function () {
			$('#spinner2').hide();
		});

		jQuery(document).ajaxStop(function () {
			$('#spinner2').hide();
		});
		jQuery(document).ajaxSuccess(function () {
			$('#spinner2').hide();
		});

		$(document).ajaxError(function () {
			$('#spinner2').hide();
		});




//            jQuery('#quickAddTextFieldBottomTop').focus();
		jQuery('#summayDaftar').focus();


//                        if (window.isHidden)
		jQuery(".content").hide();

		jQuery(".heading").click(function() {
			jQuery(this).next(".content").slideToggle(200);

			if (!window.isHidden)
				window.isHidden = true;
			else
				window.isHidden = false;
		});




//		jQuery(".headingAdd").click(function() {
//			jQuery(this).next(".contentAdd").slideToggle(200);

//			if (!window.isHidden)
//				window.isHidden = true;
//			else
//				window.isHidden = false;
//		});


//		jQuery(".contentAdd").hide();


		jQuery(".chosen").chosen({allow_single_deselect: true, search_contains: true, no_results_text: "None found"});
		jQuery("#writingNote").chosen({allow_single_deselect: true, search_contains: true, no_results_text: "None found"});

		jQuery("#chosenTags").chosen({allow_single_deselect: true, no_results_text: "None found"});

		jQuery("#chosenTagsArt").chosen({allow_single_deselect: true, no_results_text: "None found"});


//    jQuery("#addXcdFormNgs").relatedSelects({
//        onChangeLoad: '${request.contextPath}/generics/fetchCoursesForDepartment',
//        defaultOptionText: '',
//        selects: {
//            'department.id': {loadingMessage: ''},
//            'course.id': {loadingMessage: ''}
//        }
//    });



		jQuery('#chosenTags_chzn').addClass('width95')
		jQuery('#chosenTagsArt_chzn').addClass('width95')

	});




var clearFormFields = function () {

	jQuery('#title').val('')
	jQuery('#summary').val('')
	jQuery('#description').val('')
	jQuery('#fullText').val('')
	jQuery('#link').val('')
	jQuery('#url').val('')
	jQuery('#approximateDate').clear()
}


$(".common").prev('h6').click(function () {
	document.getElementById("centralArea").setAttribute("id", "tmpId");
	//$(this).id//.nextSibling().setAttribute("id", "centralArea");
//        console.log(document.getElementById($(this).next().attr("id")).attr("id"))
	//$(this).next()[0].firstChild.setAttribute("id", "centralArea");
	$(this).next()[0].firstChild.nextSibling.setAttribute("id", "centralArea");
	//console.log($(this).next().attr('id'));


	//alert(currentID);

//        $(this).next().setAttribute("id", "centralArea");

});

//jQuery('#resourceType').prop('disabled',true);
	</script>


</head>
<body>

<!-- manually attach allowOverflow method to pane -->
<div class="ui-layout-north" onmouseover="myLayout.allowOverflow('north')" onmouseout="myLayout.resetOverflow(this)">

	<g:render template="/appMain/north"/>

</div>

<!-- allowOverflow auto-attached by option: west__showOverflowOnHover = true -->
<div class="ui-layout-west">

	<g:render template="/appMain/west"/>

</div>

<div class="ui-layout-south" style="background: ${OperationController.getPath('app.color') ?: '#6D6D74'} !important; color: white; padding: 5px 7px 5px 7px;">

	<g:render template="/appMain/south" model="[ips: ips]"/>

</div>

<div class="ui-layout-east" >


	<g:render template="/appMain/east"/>

</div>

<div class="outer-center" style="background: #f4f7ef;">


	<div class="ui-layout-north ui-layout-pane ui-layout-pane-north" style="z-index: 100000;">

		<g:formRemote name="batchAdd2" class=""
					  url="[controller: 'generics', action: 'actionDispatcher']"
					  update="centralArea" style=""
					  method="post">
			%{--onLoading="jQuery('#spinner2').show();" onComplete="jQuery('#spinner2').hide();"--}%
			%{--todo: no spinner--}%

			<g:hiddenField name="sth2" value="${new java.util.Date()}"/>
			<g:submitButton name="batch" value="Execute"
							style="margin: 0px; width: 100px !important; display: none"
							id="quickAddXcdSubmitTop2"
							class="fg-button ui-widget ui-state-default"/>

			<g:textField name="input" id="quickAddTextFieldBottomTop" value=""
						 autocomplete="off"
						 style="margin: 0px !important;"
						 placeholder="Enter a command ...(F2)"
						 onkeyup="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))"
						 onkeypress="jQuery('#notificationAreaHidden').load('${request.contextPath}/generics/verifySmartCommand', { 'line':jQuery('#quickAddTextFieldBottomTop').val() }, function (response, status, xhr) {jQuery('#quickAddTextFieldBottomTop').addClass('');jQuery('#quickAddTextFieldBottomTop').addClass(response); });"
						 onfocus="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()));jQuery('#notificationAreaHidden').load('${request.contextPath}/generics/verifySmartCommand', { 'line':jQuery('#quickAddTextFieldBottomTop').val() }, function (response, status, xhr) {jQuery('#quickAddTextFieldBottomTop').addClass('');jQuery('#quickAddTextFieldBottomTop').addClass(response); });"
						 onblur="jQuery('#hintArea').html('')"
						 class="uk-input uk-width-expand "/>

		</g:formRemote>
		%{--</sec:ifAnyGranted>--}%
		%{--if (jQuery('#quickAddTextFieldBottomTop').val().search('--')== -1){--}%
		%{--<div style="-moz-column-count: 3; -webkit-column-count:3">--}%



	</div>

	<div class="inner-south ui-layout-pane ui-layout-pane-south" style="background: #eefaed">

		<g:if test="${OperationController.getPath('quick-add-form.enabled')?.toLowerCase() == 'yes' ? true : false}">
		%{--<hr/>--}%
		%{--<br/>--}%
		%{--<div class="">--}%
		%{--<h2>Create new record...</h2>--}%
		%{--<h4 style="user-focus-pointer: hand; cursor: hand;"></h4>--}%
		%{--<br/>--}%
		%{--</div>--}%

			<div id="quickAddForm" style="border: 0px solid darkgreen; padding: 4px;" class="">

				%{--<div class="headingAdd uk-heading-line">--}%
				%{--<h2>Create new record...</h2>--}%
				%{--<h3 class="addRecordHeading">--}%

				<span>Add a record</span>

				%{--</h3>--}%
				%{--<br/>--}%
				%{--</div>--}%
				<div class="contentAdd">

					<g:formRemote name="addXcdFormDaftar" id="addXcdFormDaftar"

								  url="[controller: 'indexCard', action: 'addXcdFormDaftar']"
								  update="underAreaForQuickAdd"
								  onComplete=" jQuery('#descriptionDaftar').val('');jQuery('#summayDaftar').val('');jQuery('#topDaftarArea').html(''); jQuery('#underAreaForQuickAdd').scrollIntoView({block: 'center', inline: 'nearest', behavior: 'smooth', });"
								  method="post">
					%{--jQuery('#summayDaftar').focus();--}%

						<div class="uk-grid uk-grid-small"  uk-grid>

							%{--onkeyup="jQuery('#topDaftarArea').load('${request.contextPath}/indexCard/extractTitle/', {'typing': this.value})"--}%
							%{--<code>Format: title (line 1) <br/> details (from line 2 till the end)--}%
							%{--</code>--}%

							%{--<fieldset class="uk-fieldset uk-form-horizontal">--}%
							%{--<legend class="uk-legend">Legend</legend>--}%

							<div class="uk-width-auto@s">
								%{--<label class="uk-form-label" for="typeField">1</label>--}%
								%{--<div class=uk-form-controls">--}%
								<g:select name="type" from="${types}"
										  class="uk-select uk-form-width-small"
										  id="typeField"
										  tabindex="1"
										  optionKey="id"
										  optionValue="name"
										  onchange="if (this.value == 'R') {jQuery('#resourceType').prop('disabled',false)} else {jQuery('#resourceType').prop('disabled',true);}"
										  value="N"/>
								%{--</div>--}%
							</div>
							%{--console.log('now sel: ', this.value);--}%

							%{--<g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
							<div class="uk-width-auto@s">
								%{--<label class="uk-form-label" for="resourceType">2</label>--}%
								%{--<div class=uk-form-controls">--}%

								<g:select name="resourceType" id="resourceType" from="${app.parameters.ResourceType.list([sort: 'code', order: 'asc'])}"
										  class="uk-select uk-form-width-xsmall"
										  tabindex="5"
										  optionKey="id" style="" optionValue="code" noSelection="${['': '...']}"/>
								%{--disabled="true"--}%
								%{--</g:if>--}%

								%{--</div>--}%
							</div>
							%{--<div class="uk-width-expand">--}%
							%{--<label class="uk-form-label" for="summayDaftar">3</label>--}%
							%{--<div class=uk-form-controls">--}%

							<g:textField name="title" value=""
										 class="uk-input uk-width-expand"
										 tabindex="2" id="summayDaftar"
										 style="background: #f8f9fa; width: 99% !important;  text-align: start  !important; unicode-bidi: plaintext !important; display: inline;  font-family: tahoma, Lato, serif;"
										 placeholder="Summary *"/>

							<g:submitButton name="save" value="Save"
											tabindex="3"
											style="height: 40px"
											title="Add record"
											id="addXcdFormDaftarSubmit"
											class="uk-button-primary uk-width-auto@s"/>

							%{--</div>--}%
							%{--</div>--}%
							%{--<a--}%
							%{--class="uk-button uk-button-default"--}%
							%{--title="Hide"--}%
							%{--onclick="jQuery('#detailsOfQuickAdd').removeClass('hidden');" style="padding: 3px; color: black; margin-right: 4px;">--}%
							%{--more--}%
							%{--</a>--}%



							%{--</fieldset>--}%
							%{--(ctrl+enter)--}%

							%{--<div id="detailsOfQuickAdd" class="hidden">--}%


							%{--p <g:select name="priority" from="${(1..5)}" style="border-radius: 5px;"--}%
							%{--id="priority"--}%
							%{--tabindex="1"--}%
							%{--value="${2}"/>--}%
							%{--&nbsp;--}%
							%{--<a class="" title="Hide"--}%
							%{--onclick="jQuery('#detailsOfQuickAdd').addClass('hidden');" style="color: darkgray; float: right;">x</a>--}%



							%{--<br/>--}%
							%{--&nbsp;--}%

							%{--<g:checkBox name="addOperation" id="addOperation" checked="checked"/>Operation--}%
							%{--<g:checkBox name="addFolder" id="addFolder" checked="checked"/>Make folder--}%
							%{--<g:checkBox name="grabAllFiles" id="grabAllFiles"/>Move new files--}%



							%{--<g:select name="language" id="language" from="${OperationController.getPath('repository.languages')?.split(',')}"--}%
							%{--value="${OperationController.getPath('default.language')}"--}%
							%{--/>--}%


							%{--<g:if test="${OperationController.getPath('courses.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
							%{--<g:select name="courseNgs" id="courseNgs" from="${mcs.Course.findAll([sort: 'department', order: 'desc'])}"--}%
							%{--optionKey="id" class="chosen" style="width: 450px !important;" optionValue="summary" noSelection="${['': 'No course']}"/>--}%
							%{--</g:if>--}%


						</div>
					%{--<div class="uk-grid" uk-grid>--}%
					%{--<div class="uk-width: 1-1">--}%
						<g:textArea cols="80" rows="12" placeholder="Description / full text ..."
									tabindex="4"
									name="description" id="descriptionDaftar"
									value=""
									class="uk-textarea"
									style="background: #f8f9fa; font-family: tahoma;  text-align: start  !important; unicode-bidi: plaintext !important; padding: 9px 3px; width: 99%; height: 90px !important;"/>

						%{--<div class="uk-width-1-1@s">--}%
							%{--<label class="uk-form-label" for="addXcdFormDaftarSubmit">5</label>--}%
							%{--<div class=uk-form-controls">--}%


							%{--</div>--}%
						%{--</div>--}%
					%{--</div>--}%
					%{--</div>--}%




					</g:formRemote>



				<br/>

				<div id="underAreaForQuickAdd" class="uk-margin-left uk-margin-right"></div>
				<br/>



			</div>

				%{--<br/>--}%


				%{--<hr class="uk-divider-icon">--}%
				</div>







		%{--</div>--}%

		</g:if>

	</div>



	%{--<div class="middle-center ui-layout-pane ui-layout-pane-center ui-layout-container"--}%
		 %{--style="position: absolute; margin: 0px; z-index: 0; display: block; visibility: visible; overflow: hidden;">--}%



	<div class="inner-center ui-layout-pane ui-layout-pane-center" style="z-index: 1000 !important;">

	<div id="hintArea" style="font-size: 12px; padding: 0px; margin: 0px; z-index: 1000000 !important; overflow: visible;"></div>

		<div id="notificationAreaHidden"></div>

		<div id="logRegion"></div>

		<div id="logArea"></div>


		%{--<a class="uk-accordion-title" href="#">Main panel</a>--}%
		%{--<div class="uk-accordion-content">--}%


		<div id="searchArea" class="nonPrintable">

		</div>


		%{--<div id="spinner2" style="display:none; z-index: 10000 !important">--}%
		%{--<img src="${resource(dir: '/images', file: 'Eclipse-1.4s-200px.gif')}" alt="Spinner2"--}%
		%{--style="z-index: 10000 !important"/>--}%
		%{--</div>--}%

		<span id="spinner2" style="display:none; z-index: 10000 !important"
			  uk-spinner="ratio: 3">
		</span>
		%{--<div class="uk-accordion-content">--}%

		%{--<br/>--}%
		<br/>

		<div id="centralArea" class="uk-margin-medium-right uk-margin-medium-left" style="">
		%{--                <g:render template="/reports/heartbeat" model="[dates: dates]"></g:render>--}%
		%{--<g:render template="/gTemplates/recordListing" model="[list: recentRecords, title: 'Last records']"></g:render>--}%



			<g:render template='/reports/heartbeat'/>
			<g:render template='/reports/homepageSavedSearchesAdhoc'/>


			<g:if test="${tasksActiveNotStarted.size() >= 1000}">
			%{--<tr>--}%
			%{--<td style="vertical-align: top">--}%
			%{--<g:render template="/gTemplates/recordListing" model="[list: notStarted ]"></g:render>--}%
			%{--<g:each in="${tasksActiveNotStarted?.context?.unique()}" var="c">--}%
			%{--<h4 style="text-align: center">@${c}</h4>--}%
				<ul style="direction: rtl;text-align: center; width: 90%; padding: 3px;;">
				%{--.grep{it.context == c}--}%
					<g:each in="${tasksActiveNotStarted}" var="task">
						<li class="text${task.language}" style="border: 1px solid darkgray; border-radius: 5px; padding: 3px; margin: 6px 2px; list-style-type: none;">

							<g:remoteLink controller="generics" action="showSummary" id="${task.id}" params="[entityCode: 'T']"
										  update="currentTaskArea"
										  title="Show task  ">
								<b>${task.context?.code}</b>
								${task.summary}
							</g:remoteLink>

						</li>

					%{--<g:render template="/gTemplates/recordSummary" model="[record: task]"></g:render>--}%
					</g:each>
				</ul>
			%{--</g:each>--}%

			%{--</td>--}%

			</g:if>



		%{--</div>--}%
		%{--<br/>--}%

		%{--<a class="fg-button ui-widget ui-state-default ui-corner-all" title="Hide"--}%
		%{--onclick="jQuery('#centralArea').html('');" style="float: right; color: darkgray; margin-right: 4px;">Clear</a>--}%


		%{--</div>--}%

		</div>

<g:if test="${1 == 2}">
<hr class="uk-divider-icon">

		<ul id="accord" uk-accordion="collapsible: true" class="uk-margin-medium-left uk-margin-medium-right">

			%{--<li class="uk-open">--}%
			%{--<a class="uk-accordion-title" href="#">Commands</a>--}%
			%{--<div class="uk-accordion-content">--}%

			%{--</div>--}%
			%{--</li>--}%

			%{--<li>--}%
			%{--<a class="uk-accordion-title" href="#">Main</a>--}%
			%{----}%
			%{--</li>--}%
			<li>


				<a class="uk-accordion-title" href="#" style="background: #f3f6f1; ">
					Quick add
				</a>
				<div class="uk-accordion-content">



				</div>
			</li>



			<g:if test="${1 == 2 && OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
				<li>
					<a class="uk-accordion-title" href="#" style="background: #f3f6f1; ">
						Advanced add
					</a>
					<div class="uk-accordion-content">

						<g:render template="/layouts/commandbar" model="[]"/>
					</div>
				</li>
			</g:if>




		</ul>


</g:if>



		%{--<sec:ifNotGranted roles="ROLE_ADMIN">--}%
		%{--<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
		%{--<g:render template="/layouts/commandbar" model="[]"/>--}%
		%{--</g:if>--}%
		%{--</sec:ifNotGranted>--}%
		%{--<div id="accordionCenter"--}%
		%{--style="margin: 0px !important; width: 100% !important; padding: 0px !important;">--}%

		%{--<h6 style="text-aling: center"><a href="#" id="testTitle1">--}%
		%{--Main panel--}%
		%{--panel--}%
		%{--</a></h6>--}%

		<div id="1" class="common" style="">






		%{--                <div id="centralArea" class="common" style="">--}%

		%{--                </div>--}%


		%{--<div id="subDaftarArea">--}%
		%{----}%
		%{--</div>--}%

		%{--                <br/>--}%
		%{--                <hr style="color: darkgray; background: darkgray"/>--}%
		%{--                <br/>--}%






		%{--                <span class="focusPSouth" style="text-align: right !important; direction: rtl !important;"--}%
		%{--                title="${Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', ['knb'])[0]?.description}">--}%
		%{--<h5>Last plan</h5>--}%
		%{--<g:render template="/gTemplates/recordSummary" model="[record: Planner.executeQuery('from Planner p where p.type.code = ? order by id desc', [OperationController.getPath('planner.homepage.default-type')],[max: 1])[0]]"></g:render>--}%


		%{--                    render(template: '/reports/heartbeat', model: [dates: dates])--}%





		%{--</span>--}%

		%{--<g:if test="${!new File(OperationController.getPath('root.rps1.path')).exists()}">--}%
		%{--<br/>--}%
		%{--<br/>--}%
		%{--Repository folder not found. Please choose an existing folder:--}%
		%{--<br/>--}%
		%{--<g:render template="/forms/updateSetting" model="[settingValue: 'root.rps1.path']"/>--}%
		%{--</g:if>--}%


		%{--<g:if test="${ker.GenericsController.countRecentRecordsStatic() == 0}">--}%
		%{--<g:render template="/layouts/message" model="[messageCode: 'help.recent.records.no']"/>--}%
		%{--</g:if>--}%
		%{--                </div>--}%

			<g:if test="${1 == 2 && OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
			%{--before="jQuery('#testTitle2').text('[2]: ' + jQuery('#testField2').val());"--}%
				<br/>
				<br/>
				<br/>

				<br/>
				<g:formRemote name="batchAdd2" class="commandBarInPanel"
							  url="[controller: 'generics', action: 'actionDispatcher']"
							  update="centralArea" style="display: inline"

							  method="post">
					<g:hiddenField name="sth2" value="${new java.util.Date()}"/>
					<g:submitButton name="batch" value="Execute"
									style="height: 30px; margin: 0px; width: 120px !important; display: none"
									id="quickAddXcdSubmitTop1"
									class="fg-button ui-widget ui-state-default"/>

					<g:textField name="input" value="" id="testField1"
								 autocomplete="off"
								 style="display: inline; padding-left: 5px; font-family: tahoma ; width: 100% !important; border: 1px solid darkgray"
								 placeholder="Command bar"
								 class="commandBarTexFieldTop uk-input"/>
				</g:formRemote>
			</g:if>


		</div>

		<g:if test="${OperationController.getPath('extra-panes.enabled')?.toLowerCase() == '=======yes' ? true : false}">
			<h6 style="text-align: center"><a href="#" id="testTitle2">
				Side panel
			</a></h6>



			<div id="2" class="common" style="">
				<div id="inner2" class="common" style="">

				</div>





			%{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
				<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
				%{--before="jQuery('#testTitle2').text('[2]: ' + jQuery('#testField2').val());"--}%
					<br/>
					<br/>
					<br/>

					<br/>
					<g:formRemote name="batchAdd2" class="commandBarInPanel"
								  url="[controller: 'generics', action: 'actionDispatcher']"
								  update="centralArea" style="display: inline"

								  method="post">
						<g:hiddenField name="sth2" value="${new java.util.Date()}"/>

						<g:submitButton name="batch" value="Execute"
										style="height: 30px; margin: 0px; width: 120px !important; display: none;"
										id="quickAddXcdSubmitTop3"
										class="fg-button ui-widget ui-state-default"/>

						<g:textField name="input" value="" id="testField2"
									 autocomplete="off"
									 class="uk-input uk-width-1-1 commandBarTexFieldTop"
									 placeholder="Command bar"/>
					</g:formRemote>
				</g:if>
			%{--</sec:ifAnyGranted>--}%
			</div>

			<g:if test="${1 == 2}">
				<h6><a href="#" id="testTitle3">
					Extra panel
				</a></h6>

				<div id="3" class="common" style="">
					<div id="inner3" class="common" style="">

						%{--<h3>Saved searches</h3>--}%
						%{--<g:render template='/reports/homepageSavedSearches'/>--}%

					</div>
					%{--before="jQuery('#testTitle3').text('[3]: ' + jQuery('#testField3').val());"--}%
					%{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
					<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
						<g:formRemote name="batchAdd2" class="commandBarInPanel"
									  url="[controller: 'generics', action: 'actionDispatcher']"

									  update="centralArea" style="display: inline"
									  method="post">
							<g:hiddenField name="sth2" value="${new java.util.Date()}"/>
							<g:submitButton name="batch" value="Execute"
											style="height: 30px; margin: 0px; width: 100px !important; display: none"
											id="quickAddXcdSubmitTop4"
											class="fg-button ui-widget ui-state-default"/>

							<g:textField name="input" value="" id="testField3"
										 autocomplete="off"
										 style="display: inline; padding-left: 5px;  font-family: tahoma ; width: 100% !important;  border: 1px solid darkgray"
										 placeholder=""
										 class="commandBarTexFieldTop uk-input"/>
						</g:formRemote>
					</g:if>
					%{--</sec:ifAnyGranted>--}%

				</div>

			</g:if>
		</g:if>
	%{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%

		<g:if test="${1 == 2 && OperationController.getPath('advanced-panel.enabled')?.toLowerCase() == 'yes' ? true : false}">
			<h6 id="h64"><a href="#" id="testTitle4">
				Advanced panel
			</a></h6>

			<div id="4d" class="common" style="">
				<div id="inner4" class="common" style="">
				</div>

				%{--<br/>--}%

				<g:if test="${OperationController.getPath('commandBar.enabled')?.toLowerCase() == 'yes' ? true : false}">
					<g:render template="/layouts/commandbar" model="[]"/>
				</g:if>


				%{--first commented one below was in action 14.03.2019 --}%
				%{--<g:formRemote name="batchAdd2"  class="commandBarInPanel"--}%
				%{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
				%{--update="centralArea" style="display: inline"--}%
				%{--before="jQuery('#testTitle4').text('[4]: ' + jQuery('#testField4').val());"--}%
				%{--method="post">--}%
				%{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
				%{--<g:submitButton name="batch" value="Execute"--}%
				%{--style="height: 30px; margin: 0px; width: 100px !important; display: none"--}%
				%{--id="quickAddXcdSubmitTop5"--}%
				%{--class="fg-button ui-widget ui-state-default"/>--}%

				%{--<g:textField name="input"  value="" id="testField4"--}%
				%{--autocomplete="off"--}%
				%{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
				%{--placeholder=""--}%
				%{--class="commandBarTexFieldTop"/>--}%
				%{--</g:formRemote>--}%




				%{--<g:formRemote name="batchAdd2"--}%
				%{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
				%{--update="centralArea" style="display: inline"--}%
				%{--method="post">--}%
				%{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
				%{--<g:submitButton name="batch" value="Execute"--}%
				%{--style="height: 20px; margin: 0px; width: 100px !important; display: none"--}%
				%{--id="quickAddXcdSubmitTop6"--}%
				%{--class="fg-button ui-widget ui-state-default"/>--}%

				%{--<g:textField name="input"  value=""--}%
				%{--autocomplete="off"--}%
				%{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
				%{--placeholder=""--}%
				%{--class="commandBarTexFieldTop"/>--}%
				%{--</g:formRemote>--}%

				%{--<g:formRemote name="batchAdd2"--}%
				%{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
				%{--update="centralArea" style="display: inline"--}%
				%{--method="post">--}%
				%{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
				%{--<g:submitButton name="batch" value="Execute"--}%
				%{--style="height: 20px; margin: 0px; width: 100px !important; display: none"--}%
				%{--id="quickAddXcdSubmitTop7"--}%
				%{--class="fg-button ui-widget ui-state-default"/>--}%

				%{--<g:textField name="input" value=""--}%
				%{--autocomplete="off"--}%
				%{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
				%{--placeholder=""--}%
				%{--class="commandBarTexFieldTop"/>--}%
				%{--</g:formRemote>--}%

			</div>
		</g:if>
	%{--</sec:ifAnyGranted>--}%

	%{--<h6 style="text-aling: center"><a href="#" id="testTitle5">--}%
	%{--5--}%
	%{--</a></h6>--}%

	%{--<div id=5 class="common" style="">--}%
	%{--<div id="inner5" class="common" style="">--}%
	%{--</div>--}%

	%{--<g:formRemote name="batchAdd5"  class="commandBarInPanel"--}%
	%{--url="[controller: 'generics', action: 'actionDispatcher']"--}%
	%{--update="centralArea" style="display: inline"--}%
	%{--before="jQuery('#testTitle5').text('[5]: ' + jQuery('#testField5').val());"--}%
	%{--method="post">--}%
	%{--<g:hiddenField name="sth5" value="${new java.util.Date()}"/>--}%
	%{--<g:submitButton name="batch" value="Execute"--}%
	%{--style="height: 30px; margin: 0px; width: 100px !important; display: none"--}%

	%{--id="quickAddXcdSubmitTop8"--}%
	%{--class="fg-button ui-widget ui-state-default"/>--}%

	%{--<g:textField name="input"  value=""--}%
	%{--autocomplete="off"--}%
	%{--id="testField5"--}%
	%{--style="display: inline;  font-family: tahoma ; width: 100% !important;"--}%
	%{--placeholder=""--}%
	%{--class="commandBarTexFieldTop"/>--}%
	%{--</g:formRemote>--}%

	%{--</div>--}%

	%{--</div>--}%

	%{--<hr/>--}%
	%{--before="jQuery('#testTitle1').text('[1]: ' + jQuery('#quickAddTextFieldBottomTop').val());"--}%

	%{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%


	%{--</div>--}%


	%{--<div class="footer">--}%
	%{--footer--}%
	%{--</div>--}%
	%{----}%



	</div>
		%{--<div class="inner-west ui-layout-pane ui-layout-pane-west" style="position: absolute; margin: 0px; inset: 49px auto 49px 0px; height: 544px; z-index: 0; width: 54px; display: block; visibility: visible;">--}%
			%{--Inner West</div>--}%
		%{--<div class="inner-east ui-layout-pane ui-layout-pane-east" style="position: absolute; margin: 0px; inset: 49px 0px 49px auto; height: 544px; z-index: 0; width: 54px; display: block; visibility: visible;">--}%
			%{--Inner East</div>--}%





	%{--</div>--}%
%{--</div>--}%






</div>

</body>

<style>
.ui-layout-south {
	padding: 0px;
}

.ui-layout-north{
	background: ${OperationController.getPath('app.color') ?: '#6D6D74'} !important;
	color: white;
	padding-left: 7px;
	padding-right: 7px;
}

.ui-layout-north {
	padding: 0px;
}
.ui-layout-south a, .ui-layout-north a {
	color: white;
	font-size: 0.875rem;

}

.uk-navbar-nav > li > a {
	text-transform: none;
	min-height: 50px;
	color: white;
}
</style>

</html>