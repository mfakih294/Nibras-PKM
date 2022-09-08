<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>EOWP Applications</title>
		<!-- CSS FILES -->


		<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit.min.css')}"/>
		<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'dashboard.css')}"/>
	</head>
	<body>

		<!--HEADER-->
		<header id="top-head" class="uk-position-fixed">
			<div class="uk-container uk-container-expand uk-background-primary">
				<nav class="uk-navbar uk-light" data-uk-navbar="mode:click; duration: 250">
					<div class="uk-navbar-left">
						<div class="uk-navbar-item uk-hidden@m">
							<a class="uk-logo" href="#"><img class="custom-logo" src="img/dashboard-logo-white.svg" alt=""></a>
						</div>
						<ul class="uk-navbar-nav uk-visible@m">
							<li><a href="#">Accounts</a></li>
							<li>
								<a href="#">Settings <span data-uk-icon="icon: triangle-down"></span></a>
								<div class="uk-navbar-dropdown">
									<ul class="uk-nav uk-navbar-dropdown-nav">
										<li class="uk-nav-header">YOUR ACCOUNT</li>
										<li><a href="#"><span data-uk-icon="icon: info"></span> Summary</a></li>
										<li><a href="#"><span data-uk-icon="icon: refresh"></span> Edit</a></li>
										<li><a href="#"><span data-uk-icon="icon: settings"></span> Configuration</a></li>
										<li class="uk-nav-divider"></li>
										<li><a href="#"><span data-uk-icon="icon: image"></span> Your Data</a></li>
										<li class="uk-nav-divider"></li>
										<li><a href="#"><span data-uk-icon="icon: sign-out"></span> Logout</a></li>
									</ul>
								</div>
							</li>
						</ul>
						<div class="uk-navbar-item uk-visible@s">
							<form action="dashboard.html" class="uk-search uk-search-default">
								<span data-uk-search-icon></span>
								<input class="uk-search-input search-field" type="search" placeholder="Search">
							</form>
						</div>
					</div>
					<div class="uk-navbar-right">
						<ul class="uk-navbar-nav">
							<li><a href="#" data-uk-icon="icon:user" title="Your profile" data-uk-tooltip></a></li>
							<li><a href="#" data-uk-icon="icon: settings" title="Settings" data-uk-tooltip></a></li>
							<li><a href="#" data-uk-icon="icon:  sign-out" title="Sign Out" data-uk-tooltip></a></li>
							<li><a class="uk-navbar-toggle" data-uk-toggle data-uk-navbar-toggle-icon href="#offcanvas-nav" title="Offcanvas" data-uk-tooltip></a></li>
						</ul>
					</div>
				</nav>
			</div>
		</header>
		<!--/HEADER-->
		<!-- LEFT BAR -->
		<aside id="left-col" class="uk-visible@m">
			<!--div class="left-logo uk-flex uk-flex-middle">
				<img class="custom-logo" src="img/dashboard-logo.svg" alt="">
			</div-->
			<div class="left-content-box">
				<h4 class="uk-text-center uk-margin-remove-vertical text-light">App template</h4>
			</div>
			
			<div class="left-nav-wrap">
				<ul class="uk-nav uk-nav-default uk-nav-parent-icon" data-uk-nav>
					<li class="uk-nav-header">MENU</li>
					<li><a href="#"><span data-uk-icon="icon: comments" class="uk-margin-small-right"></span>Messages</a></li>
					<li><a href="#"><span data-uk-icon="icon: users" class="uk-margin-small-right"></span>Friends</a></li>
					<li class="uk-parent"><a href="#"><span data-uk-icon="icon: thumbnails" class="uk-margin-small-right"></span>Templates</a>
						<ul class="uk-nav-sub">
							<li><a title="Article" href="https://zzseba78.github.io/Kick-Off/article.html">Article</a></li>
							<li><a title="Album" href="https://zzseba78.github.io/Kick-Off/album.html">Album</a></li>
							<li><a title="Cover" href="https://zzseba78.github.io/Kick-Off/cover.html">Cover</a></li>
							<li><a title="Cards" href="https://zzseba78.github.io/Kick-Off/cards.html">Cards</a></li>
							<li><a title="News Blog" href="https://zzseba78.github.io/Kick-Off/newsBlog.html">News Blog</a></li>
							<li><a title="Price" href="https://zzseba78.github.io/Kick-Off/price.html">Price</a></li>
							<li><a title="Login" href="https://zzseba78.github.io/Kick-Off/login.html">Login</a></li>
							<li><a title="Login-Dark" href="https://zzseba78.github.io/Kick-Off/login-dark.html">Login - Dark</a></li>
						</ul>
					</li>
					<li><a href="#"><span data-uk-icon="icon: album" class="uk-margin-small-right"></span>Albums</a></li>
					<li><a href="#"><span data-uk-icon="icon: thumbnails" class="uk-margin-small-right"></span>Featured Content</a></li>
					<li><a href="#"><span data-uk-icon="icon: lifesaver" class="uk-margin-small-right"></span>Tips</a></li>
					<li class="uk-parent">
						<a href="#"><span data-uk-icon="icon: comments" class="uk-margin-small-right"></span>Reports</a>
						<ul class="uk-nav-sub">
							<li><a href="#">Sub item</a></li>
							<li><a href="#">Sub item</a></li>
						</ul>
					</li>
				</ul>
				<div class="left-content-box uk-margin-top">
					
						<h5>Daily Reports</h5>
						<div>
							<span class="uk-text-small">Traffic <small>(+50)</small></span>
							<progress class="uk-progress" value="50" max="100"></progress>
						</div>
						<div>
							<span class="uk-text-small">Income <small>(+78)</small></span>
							<progress class="uk-progress success" value="78" max="100"></progress>
						</div>
						<div>
							<span class="uk-text-small">Feedback <small>(-12)</small></span>
							<progress class="uk-progress warning" value="12" max="100"></progress>
						</div>
					
				</div>
				
			</div>
			<div class="bar-bottom">
				<ul class="uk-subnav uk-flex uk-flex-center uk-child-width-1-5" data-uk-grid>
					<li>
						<a href="#" class="uk-icon-link" data-uk-icon="icon: home" title="Home" data-uk-tooltip></a>
					</li>
					<li>
						<a href="#" class="uk-icon-link" data-uk-icon="icon: settings" title="Settings" data-uk-tooltip></a>
					</li>
					<li>
						<a href="#" class="uk-icon-link" data-uk-icon="icon: social"  title="Social" data-uk-tooltip></a>
					</li>
					
					<li>
						<a href="#" class="uk-icon-link" data-uk-tooltip="Sign out" data-uk-icon="icon: sign-out"></a>
					</li>
				</ul>
			</div>
		</aside>
		<!-- /LEFT BAR -->
		<!-- CONTENT -->
		<div id="content" data-uk-height-viewport="expand: true">


		<h1></h1>
		&nbsp;Below are the applications that you are allowed to access.
		<br/>
		<br/>
		%{--<a routerLink='/signup'>Create Account</a>--}%

			<g:each in="${grantedApplications}" var="app">
				<div class="uk-card uk-card-small uk-card-default" style="display: inline; float: left; width: 350px; height: 200px;">
					<div style="padding: 7px;">
						<div class="subtitle" style="color: darkolivegreen;">
							${app.englishName}
						</div>
						<div class="title" style="float: right; align: right; font-size: 1.2em;">
							<a style="text-transform: none;" href="${app.applicationUrl}" target="_blank">
								<span class="icon" name="${app.frenchName}">
									?
								</span>
								${app.arabicName}
							</a>
						</div>
					</div>

					<div class="card-content" style="padding: 7px; margin: 5px; font-size: 1em; text-align: right; direction: rtl; clear: both">
						${app.description}
					</div>
				</div>

			</g:each>



			<div class="uk-container uk-container-expand">
				<div class="uk-grid uk-grid-divider uk-grid-medium uk-child-width-1-2 uk-child-width-1-4@l uk-child-width-1-5@xl" data-uk-grid>
					<div>
					
					</div>
					<div>
						
					
						
					</div>
					<div>
						
					
						
					</div>
					<div>
						
					
					</div>
					<div class="uk-visible@xl">
				
					</div>
				</div>
				<hr>
				<div class="uk-grid uk-grid-medium" data-uk-grid uk-sortable="handle: .sortable-icon">
					
					<!-- panel -->
					<!-- card -->




					<div class="nature-card" data-tags="a beautiful landscape - nature outdoor">
						<div class="uk-card uk-card-small uk-card-default">
							<div class="uk-card-header">
								<div class="uk-grid uk-grid-small uk-text-small" data-uk-grid>
									<div class="uk-width-expand">
										<span class="cat-txt-rtl">Nature / Outdoor</span>
									</div>
									<div class="uk-width-auto uk-text-right uk-text-muted">
										<span data-uk-icon="icon:clock; ratio: 0.8"></span> 3 min.
									</div>
								</div>
							</div>
							<div class="uk-card-media">
								<div class="uk-inline-clip uk-transition-toggle" tabindex="0">
									
									<div class="uk-transition-slide-bottom uk-position-bottom uk-overlay uk-overlay-primary">
										<span data-uk-icon="icon:heart; ratio: 0.8"></span> 12.345 <span data-uk-icon="icon:comment; ratio: 0.8"></span> 12.345
									</div>
								</div>
								
							</div>
							<div class="uk-card-body">
								<h6 class="uk-margin-small-bottom uk-margin-remove-adjacent uk-text-bold">A BEAUTIFUL LANDSCAPE HERE</h6>
								<p class="uk-text-small uk-text-muted">Duis aute irure dolor in reprehenderit in voluptate velit</p>
							</div>
							<div class="uk-card-footer">
								<div class="uk-grid uk-grid-small uk-grid-divider uk-flex uk-flex-middle" data-uk-grid>
									<div class="uk-width-expand uk-text-small">
										John Doe
									</div>
									<div class="uk-width-auto uk-text-right">
										<a href="#" data-uk-tooltip="title: Twitter" class="uk-icon-link" data-uk-icon="icon:twitter; ratio: 0.8"></a>
										<a href="#" data-uk-tooltip="title: Instagram" class="uk-icon-link" data-uk-icon="icon:instagram; ratio: 0.8"></a>
										<a href="#" data-uk-tooltip="title: Behance" class="uk-icon-link" data-uk-icon="icon:behance; ratio: 0.8"></a>
										<a href="#" data-uk-tooltip="title: Pinterest" class="uk-icon-link" data-uk-icon="icon:pinterest; ratio: 0.8"></a>
									</div>
									<div class="uk-width-auto uk-text-right">
										<a data-uk-tooltip="title: Drag this card" href="#" class="uk-icon-link drag-icon" data-uk-icon="icon:move; ratio: 1"></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /card -->
					
					<!-- /panel -->
					<!-- panel -->
					
					<!-- /panel -->
					<!-- panel -->
					
					<!-- /panel -->
					<!-- panel -->
					
					<!-- /panel -->
					<!-- panel -->
			
					<!-- /panel --> 
				</div>
				<footer class="uk-section uk-section-small uk-text-center">
					<hr>
					<p class="uk-text-small uk-text-center">Copyright 2019 - <a href="https://github.com/zzseba78/Kick-Off">Created by KickOff</a> | Built with <a href="http://getuikit.com" title="Visit UIkit 3 site" target="_blank" data-uk-tooltip><span data-uk-icon="uikit"></span></a> </p>
				</footer>
			</div>
		</div>
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
		
		<!-- JS FILES -->
	<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit-icons.min.js')}"></script>

	</body>
</html>
