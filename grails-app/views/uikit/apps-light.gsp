<%@ page import="mcs.Task; mcs.Planner; mcs.Journal; app.IndexCard; mcs.Writing; mcs.Book; mcs.Goal" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>EOWP Applications</title>
		<!-- CSS FILES -->

		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

		<link rel="stylesheet" href="${resource(dir: 'select2/css', file: 'select2.min.css')}"/>
		<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit.min.css')}"/>
		%{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'search.min.css')}"/>--}%
		%{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'autocomplete.min.css')}"/>--}%
		%{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit-rtl.min.css')}"/>--}%
		<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'dashboard.css')}"/>


<style>
.select2-container{ width: 100% !important; }
</style>

	</head>
	<body class="uk-margin-left uk-margin-right uk-rtl rtl">

		<!--HEADER-->
		<header id="top-head" class="uk-position-fixed  uk-margin-left uk-margin-right">
			<div class="uk-container uk-container-expand uk-background-primary uk-container-rtl">
				<nav class="uk-navbar uk-light" data-uk-navbar="mode:click; duration: 250">
					<div class="uk-navbar-left uk-text-primary uk-margin-top">
						<h1 style="">
نبراس
						</h1>

					</div>
					<div class="uk-navbar-right">
						<ul class="uk-navbar-nav">
							<li><a style="color: white;"
									href="#"
									data-uk-icon="icon:user"
									title="Your profile"
									data-uk-tooltip class="uk-text-lowercase uk-text-large">
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
		<!-- CONTENT -->
	<div class="uk-section uk-section-small uk-section-muted uk-preserve-color">
	<div id="content" class="uk-container uk-container-small" data-uk-height-viewport="expand: true">


		<div class="uk-section uk-section-xsmall uk-section-muted uk-padding-small uk-section-rtl">
		%{--<div class=" uk-margin">--}%
			الكتابات الحالية
		</div>


		<div class="uk-position-center" style="display: none;;">
		<div uk-spinner id="spinner2"></div>
		</div>


		<div id="logAreaModal"></div>
		<div id="attachmentCard1"></div>

		<g:if test="${1==2}">
		<div class="uk-positin-relative uk-visible-toggle uk-light" tabindex="-1" uk-slider="center: true">
			<ul class="uk-slider-items uk-child-width-1-1@s uk-child-width-1-2@ uk-grid">
				<g:each in="${ mcs.Planner.findAllByBookmarked(true) + mcs.Journal.findAllByBookmarked(true) +
				mcs.Task.findAllByBookmarked(true) + IndexCard.findAllByBookmarked(true) + mcs.Writing.findAllByBookmarked(true) + mcs.Book.findAllByBookmarked(true) +
				mcs.Goal.findAllByBookmarked(true)}" var="r" status="status">
				<li>
					<div class="uk-panel">
					%{--<g:render template="/gTemplates/box" model="[record: r]"/>--}%

						<article class="uk-article uk-width-large uk-margin-left uk-margin-right uk-margin-bottom">
							<h1 class="uk-article-title">${r.toString()}</h1>
							<p class="uk-article-meta">${r.lastUpdated?.format('dd.MM.yyyy HH:mm')}</p>

						</article>
						<p class="uk-text-lead rtl uk-margin-large">
							${r.description?.replace('\n', '<br/>')}
							%{--<pkm:summarize text="${r.description}" length="300"/>--}%
						</p>


						<div class="uk-position-center uk-panel"><h1>${status}</h1></div>
					</div>
				</li>
				</g:each>

			</ul>

			<a href="#" uk-slider-item="previous">Previous</a>
			<a href="#" uk-slider-item="next">Next</a>
			<ul class="uk-slider-nav uk-dotnav"/>
		</div>


		</g:if>


		%{--<a routerLink='/signup'>Create Account</a>--}%
		%{--<div class="uk-grid uk-flex uk-flex-top uk-flex-center uk-flex-wrap uk-margin uk-grid-column-small uk-grid-row-small">--}%

			<g:each in="${records}" var="r">

				<article class="uk-article uk-width-small uk-margin-left uk-margin-right uk-margin-bottom">
					<h1 class="uk-article-title">${r.summary}</h1>
					<p class="uk-article-meta">${r.lastUpdated?.format('dd.MM.yyyy HH:mm')}</p>

				</article>
				<p class="uk-text-lead rtl uk-margin-large">
					${raw(r.description?.replaceAll('\n', '<br/>'))}
					%{--<pkm:summarize text="${r.description}" length="300"/>--}%
				</p>
				<br/>
				<br/>
				<br/>

			</g:each>

		%{--</div>--}%

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
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-3.6.0.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>

	<script type="text/javascript" src="${resource(dir: 'select2/js', file: 'select2.full.min.js')}"></script>

	<script>



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

		setTimeout(
			function(){
				document.getElementById('spinner2').style.display = "inline"
				jQuery.ajax({
					url: "/trn/attachment/wait",
					data: { }
				});
			}
		, 5000);

//		document.getElementById('spinner2').style.display = "inline";


		var bar = document.getElementById('js-progressbar');

		UIkit.upload('.js-upload', {

			url: '/trn/attachment/upload2',
			multiple: true,
			params: {id: 1231, type: 'adfadf'},
			beforeSend: function () {
				console.log('beforeSend', arguments);
			},
			beforeAll: function () {
				console.log('beforeAll', arguments);
			},
			load: function () {
				console.log('load', arguments);
			},
			error: function () {
				console.log('error', arguments);
			},
			complete: function () {
				console.log('complete', arguments);
			},

			loadStart: function (e) {
				console.log('loadStart', arguments);

				bar.removeAttribute('hidden');
				bar.max = e.total;
				bar.value = e.loaded;
			},

			progress: function (e) {
				console.log('progress', arguments);

				bar.max = e.total;
				bar.value = e.loaded;
			},

			loadEnd: function (e) {
				console.log('loadEnd', arguments);

				bar.max = e.total;
				bar.value = e.loaded;
			},

			completeAll: function () {
				console.log('completeAll', arguments);

				setTimeout(function () {
					bar.setAttribute('hidden', 'hidden');
				}, 1000);

				alert('Upload Completed');
			}

		});

				jQuery.noConflict();


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
						placeholder: 'Username',
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
