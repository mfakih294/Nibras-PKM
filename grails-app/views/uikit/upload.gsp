<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Upload Service</title>
		<!-- CSS FILES -->

		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

		<link rel="stylesheet" href="${resource(dir: 'select2/css', file: 'select2.min.css')}"/>
		<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit.min.css')}"/>
		%{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit-rtl.min.css')}"/>--}%
		<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'dashboard.css')}"/>
		<g:javascript library="prototype"/>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-3.6.0.min.js')}"></script>
		<script>jQuery.noConflict();</script>
		<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit-icons.min.js')}"></script>

		<script type="text/javascript">

//			Ajax.Responders.register({
//				onCreate: function() {
//					document.getElementById('spinner2').style.display = "inline"
//				},
//				onComplete: function() {
//					document.getElementById('spinner2').style.display = "none"
//				}
//			});

		</script>


<style>
.select2-container{ width: 100% !important; }
</style>

	</head>
	<body class="uk-margin-left uk-margin-right">

		<!--HEADER-->
		<header id="top-head" class="uk-position-fixed  uk-margin-left uk-margin-right">
			<div class="uk-container uk-container-expand uk-background-primary">
				<nav class="uk-navbar uk-light" data-uk-navbar="mode:click; duration: 250">
					<div class="uk-navbar-left uk-text-primary uk-margin-top">
						<h1 style="">
							Welcome to Upload Service!
						</h1>

					</div>
					<div class="uk-navbar-right">
						<ul class="uk-navbar-nav">
							<li><a style="color: white;"
									href="${org.codehaus.groovy.grails.commons.ConfigurationHolder.config.grails.accountUrl}"
									data-uk-icon="icon:user"
									title="Your profile"
									data-uk-tooltip class="uk-text-lowercase uk-text-large">

								<g:isLoggedIn>
											<g:loggedInUserInfo
													field="username"/>
								</g:isLoggedIn>

							</a>
							</li>
							<li>
								<a style="color: white;" class="uk-text-capitalize"
								   href="${createLink(controller: 'j_spring_security_logout')}"
								   data-uk-icon="icon:  sign-out" title="Log Out" data-uk-tooltip>
Log out
							</a>
							</li>
							%{--<li><a class="uk-navbar-toggle" data-uk-toggle data-uk-navbar-toggle-icon href="#offcanvas-nav" title="Offcanvas" data-uk-tooltip></a></li>--}%
						</ul>
					</div>
				</nav>
			</div>
		</header>
		<!--/HEADER-->
		<!-- LEFT BAR -->
		<!-- /LEFT BAR -->
		<!-- /CONTENT -->
		<!-- OFFCANVAS -->
	<div id="offcanvas-nav" data-uk-offcanvas="flip: true; overlay: true">
		<div class="uk-offcanvas-bar uk-offcanvas-bar-animation uk-offcanvas-slide">
			<button class="uk-offcanvas-close uk-close uk-icon" type="button" data-uk-close></button>
			<ul class="uk-nav uk-nav-default">
				<li class="uk-active"><a href="#">Active</a></li>
				<li class="uk-parent">
					<a href="#">Parent</a>
					<ul class="uk-nav-sub">
						<li><a href="#">Sub item</a></li>
						<li><a href="#">Sub item</a></li>
					</ul>
				</li>
				<li class="uk-nav-header">Header</li>
				<li><a href="#js-options"><span class="uk-margin-small-right uk-icon" data-uk-icon="icon: table"></span> Item</a></li>
				<li><a href="#"><span class="uk-margin-small-right uk-icon" data-uk-icon="icon: thumbnails"></span> Item</a></li>
				<li class="uk-nav-divider"></li>
				<li><a href="#"><span class="uk-margin-small-right uk-icon" data-uk-icon="icon: trash"></span> Item</a></li>
			</ul>
			<h3>Title</h3>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		</div>
	</div>
	<!-- /OFFCANVAS -->


	<div class="uk-section uk-section-small uk-section-muted uk-preserve-color">
	<div id="content" class="uk-container uk-container-expand" data-uk-height-viewport="expand: true">




<h3>Prepare a new set</h3>
<g:formRemote name="batchAdd2" class="commandBarInPanel"
			  url="[controller: 'document', action: 'saveNewSet']"
			  update="logAreaModal"
			  method="post">
<label>Title</label>
	<br/>
	<input class="uk-input" type="text" class="ui-corner-all"  name="title" id="title" style="width: 99%;"/><br/>

	<label>Recipients</label>
	<select name="recipients" class="js-data-example-ajax uk-input"  style=""></select>
	<br/>
	<br/>
	<g:submitButton name="batch" value="Save"
					style="height: 32px  !important; margin: 3px; width: 99% !important;"
					class="fg-button ui-widget ui-state-default"/>
</g:formRemote>

		<div id="logAreaModal"></div>
<br/>
<br/>
		<div class="uk-section uk-section-xsmall uk-section-muted uk-padding-small">
			%{--<div class=" uk-margin">--}%
			Below are the file sets shared with you.
		</div>


		%{--<div class="uk-position-center">--}%
			%{--<div uk-spinner id="spinner2"></div>--}%
		%{--</div>--}%

		%{--<a routerLink='/signup'>Create Account</a>--}%
		<div class="uk-grid uk-flex uk-flex-top uk-flex-center uk-flex-wrap uk-margin uk-grid-column-small uk-grid-row-small">

			<g:each in="${cmn.Document.findAllByRecipientsLikeOrSubmittedByLike('%' + loggedInUsername().toString() + '%',  '%' + loggedInUsername().toString() + '%',
					[sort: 'dateCreated', order: 'desc'])}" var="doc">

<g:if test="${doc.name}">
				<g:render template="/uikit/docCard" model="[doc: doc]"></g:render>
</g:if>


			</g:each>

		</div>


				<footer class="uk-section uk-section-small uk-text-center">
					<hr>
					<p class="uk-text-small uk-text-center">
						&copy; 2022 -
						<a href="https://github.com/zzseba78/Kick-Off">Created by KickOff</a>
						| Built with
						<a href="http://getuikit.com" title="Visit UIkit 3 site" target="_blank" data-uk-tooltip>
						<span data-uk-icon="uikit"></span>
					</a> </p>
				</footer>
			</div>
	</div>
    <!-- /CONTENT -->
		<!-- JS FILES -->
	%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-3.6.0.min.js')}"></script>--}%
	<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>

	<script type="text/javascript" src="${resource(dir: 'select2/js', file: 'select2.full.min.js')}"></script>

	<script>

//				jQuery.noConflict();

				jQuery(document).ajaxStart(function() {
			document.getElementById('spinner2').style.display = "inline"
			console.log('ajax start!!!')
		});
				jQuery(document).ajaxStop(function() {
			document.getElementById('spinner2').style.display = "none"
			console.log('ajax start!!!')
		});

				jQuery.ajaxSetup({
			statusCode : {
				400 : function () {
					document.getElementById('spinner2').style.display = "none"
					console.log('found 400!!!')
				},
				500 : function () {
					document.getElementById('spinner2').style.display = "none"
					console.log('found 500!!!')
				},
				200 : function () {
					document.getElementById('spinner2').style.display = "none"
					console.log('found 200!!!')
				},
				300 : function () {
					document.getElementById('spinner2').style.display = "none"
					console.log('found 300!!!')
				}
			}
		});

//		setTimeout(
//			function(){
//				document.getElementById('spinner2').style.display = "inline"
//				jQuery.ajax({
//					url: "/trn/attachment/wait",
//					data: { }
//				});
//			}
//		, 5000);

//		document.getElementById('spinner2').style.display = "inline";



				jQuery(document).ready(function() {

					jQuery('.js-data-example-ajax').select2({
						ajax: {
							url: '/trn/document/getUsersJson',
							dataType: 'json',
//							delay: 0,
							data: function (params) {
								return {
									q: params.term, // search term
									page: params.page
								};
							},
							processResults: function (response) {
								return {
									results: response
								};
							},

//							minimumInputLength: 2

							// Additional AJAX parameters go here; see the end of this chapter for the full code of this example
						},
						multiple: true,
						placeholder: 'Enter usernames...',
						width: 'element'
					});

				})



	</script>


	%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'autocomplete.min.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'search.min.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'form-select.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'notify.min.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: '')}"></script>--}%
	<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit-icons.min.js')}"></script>

	</body>
</html>
