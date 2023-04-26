<%@ page import="app.IndexCard" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        ${record?.summary}
    </title>
    <!-- CSS FILES -->

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    %{--<link rel="stylesheet" href="${resource(dir: 'select2/css', file: 'select2.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="./uikit/css/uikit.min.css"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'search.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'autocomplete.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit-rtl.min.css')}"/>--}%

    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit-rtl.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'dashboard')}"/>--}%

    %{--<link rel="stylesheet" href="./uikit/css/uikit.min.css"/>--}%

    <link rel="stylesheet" href="./uikit/css/dashboard.css"/>

    <link rel="stylesheet" href="./uikit/css/uikit-rtl.css"/>


    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'dashboard.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit.min.css')}"/>--}%


    %{--<g:javascript library="prototype"/>--}%


    %{--<script type="text/javascript" src="${resource(dir: 'uikit', file: 'jquery-3.6.0.min.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit-icons.min.js')}"></script>--}%

    <script type="text/javascript" src="./uikit/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="./uikit/js/uikit.min.js"></script>
    <script type="text/javascript" src="./uikit/js/uikit-icons.min.js"></script>

    <script type="text/javascript">


    </script>

    <style>
    .uk-link, a {
        color: black;
    }

    img {
        padding: 7px;
        float: right;
    }


    .page-header {
        height: 80px;
    }

    .page-header .uk-navbar-nav > li > a,
    .page-header .uk-icon-link,
    .page-header .uk-icon-link:hover {
        color: #333;
    }

    .page-header .uk-navbar-nav > li > a {
        padding: 0 25px;
    }

    .page-header .uk-navbar-nav > li > a:hover {
        background: #f6f7f9;
    }

    .page-header .multi .uk-navbar-dropdown {
        padding: 0 25px;
    }

    .page-header .uk-navbar-dropdown-nav .uk-nav-header {
        color: #7c2a8a;
    }

    .page-header [class*="uk-column-"] > li {
        padding: 25px 0;
    }

    .page-header [class*="uk-column-"] > li:not(:last-child) {
        border-right: 1px solid #e5e5e5;
    }

    .page-header [class*="uk-column-"] .uk-icon {
        color: #c6c6c6;
    }

    .offcanvas .uk-nav-header {
        color: rgba(246, 247, 249, 0.5);
    }

    .offcanvas .top-menu > li + li {
        margin-top: 10px;
    }

    .offcanvas .sub-menu {
        border-left: 1px solid #484848;
    }

    .offcanvas .sub-menu li {
        padding-left: 30px;
    }

    .offcanvas .sub-menu li.uk-nav-header {
        padding-left: 10px;
    }


    </style>

</head>
<body class="uk-margin-left uk-margin-right rtl">

<!--HEADER-->
%{--<header id="top-head" class="uk-position-fixed  uk-margin-left uk-margin-right">--}%
    %{--<div class="uk-container uk-container-expand uk-background-primary">--}%
        %{--<nav class="uk-navbar uk-light" data-uk-navbar="mode:click; duration: 250">--}%
            %{--<div class="uk-navbar-left uk-text-primary uk-margin-top">--}%
                %{--<h1 style="">--}%
                    %{--أهلاً وسهلاً بكم في موقع مشروع جبل عامل--}%
                %{--</h1>--}%

            %{--</div>--}%
            %{--<div class="uk-navbar-right">--}%
                %{--<ul class="uk-navbar-nav">--}%
                    %{--<li><a style="color: white;"--}%
                           %{--href=""--}%
                           %{--data-uk-icon="icon:user"--}%
                           %{--title="Your profile"--}%
                           %{--data-uk-tooltip class="uk-text-lowercase uk-text-large">--}%

                    %{--</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a style="color: white;" class="uk-text-capitalize"--}%
                           %{--href="${createLink(controller: 'j_spring_security_logout')}"--}%
                           %{--data-uk-icon="icon:  sign-out" title="Log Out" data-uk-tooltip>--}%
                            %{--Log out--}%
                        %{--</a>--}%
                    %{--</li>--}%
                    %{--<li><a class="uk-navbar-toggle" data-uk-toggle data-uk-navbar-toggle-icon href="#offcanvas-nav" title="Offcanvas" data-uk-tooltip></a></li>--}%
                %{--</ul>--}%
            %{--</div>--}%
        %{--</nav>--}%
    %{--</div>--}%
%{--</header>--}%
<!--/HEADER-->
<!-- LEFT BAR -->
<!-- /LEFT BAR -->
<!-- CONTENT -->

﻿<header class="page-header uk-box-shadow-medium uk-background-default" uk-sticky>
    <div class="uk-container uk-container-expand uk-height-1-1">
        <nav class="uk-height-1-1" uk-navbar>
            <div class="uk-navbar-left">
                %{--<button class="uk-icon-link uk-margin-right" uk-icon="search" type="button" aria-label="Toggle Search Form"></button>--}%
                %{--<a href="#" class="uk-icon-link" uk-icon="heart" aria-label="Open Wishlist Page"></a>--}%
                <button class="uk-margin-right uk-hidden@l" uk-toggle="target: #offcanvas" uk-icon="icon: menu" type="button" aria-label="Toggle Mobile Menu"></button>
                &nbsp;
                &nbsp;
            </div>

            <a href="" class="uk-flex uk-flex-middle rtl">
                %{--<img width="178" height="38" src="" alt="forecastr logo">--}%
                <h3 style="">
        موقع مشروع جبل عامل
                </h3>
            </a>

            <ul class="uk-navbar-nav uk-navbar-center uk-visible@l">

              <g:each in="${app.IndexCard.executeQuery('from IndexCard where course = ? and priority >= ? order by orderNumber asc', [record, 2])}" var="h">
              <g:if test="${!h.wbsNumber?.contains('.')}">
                <li>
                    <a href="#${h.id}">
                        %{--${h.wbsNumber}--}%
                  <b>      ${h.summary}
                    </b>
                    </a>
                    <div class="uk-navbar-dropdown" uk-dropdown="offset: 0">
                        <ul class="uk-nav uk-navbar-dropdown-nav">

                  <g:each in="${app.IndexCard.executeQuery('from IndexCard where course = ? and priority >= ? and wbsParent = ? order by orderNumber asc', [record, 2, h])}" var="h2">
                            <li>
                                <a href="#${h2.id}">
                                %{--${h2.wbsNumber}--}%
                                ${h2.summary}
                            </a>
                            </li>
                      </g:each>
                        </ul>
                    </div>
                </li>

              </g:if>
              </g:each>

            </ul>


        </nav>
    </div>

    <div class="offcanvas uk-hidden@l" id="offcanvas" uk-offcanvas="flip: true; overlay: true; mode: reveal">
        <div class="uk-offcanvas-bar">
            <button class="uk-offcanvas-close" type="button" uk-close aria-label="Close Mobile Menu"></button>

            <ul class="top-menu uk-nav uk-margin-top">

             <g:each in="${app.IndexCard.executeQuery('from IndexCard where course = ? and priority >= ? order by orderNumber asc', [record, 2])}" var="h">
                    <g:if test="${!h.wbsNumber?.contains('.')}">
                        <li>
                            <a href="${h.id}">
                                ${h.wbsNumber}
                                ${h.summary}
                            </a>
                            <ul class="sub-menu uk-nav rtl">

                                    <g:each in="${app.IndexCard.executeQuery('from IndexCard where course = ? and priority >= ? and wbsParent = ? order by wbsNumber asc', [record, 2, h])}" var="h2">
                                        <li>
                                        &nbsp;    <a href="#${h2.id}">
                                                ${h2.wbsNumber}
                                                ${h2.summary}
                                            </a>
                                        </li>
                                    </g:each>
                                </ul>
                        </li>

                    </g:if>
                </g:each>
                             <!-- more items here -->
            </ul>
        </div>
    </div>
</header>

%{--<div class="uk-section uk-section-expand uk-preserve-color">--}%
    %{--أهلاً وسهلاً بكم في موقع جبل عامل--}%

    <div id="content" class="uk-container uk-container-expand" data-uk-height-viewport="expand: true">


        <div class="uk-section-rtl uk-section-xsmall uk-section-muted uk-padding-small rtl">
            %{--<div class=" uk-margin">--}%
            الإصدار الرابع - آخر تحديث:
            3 كانون الأول 2022
        </div>


        <div id="logAreaModal"></div>
        <div id="attachmentCard1"></div>

        <div style="direction: rtl; text-align: justify; margin: 10px 10%;">
            %{--<g:each in="${app.IndexCard.findAllByCourseAndWbsParentIsNull(record, [sort: 'orderNumber', order: 'asc'])}"--}%
            <g:each in="${app.IndexCard.executeQuery('from IndexCard where priority >= 2 and course = ? and wbsParent is null order by orderNumber asc' , [record])}"
                    var="n">
                %{--<g:if test="${(record.priority && record.priority >= 2)}">--}%
                <a id="${n.id}"></a>
                <div class="uk-panel rtl">

                    <h1 class="uk-panel-title uk-text-primary" >

                        ${n.wbsNumber} - ${n.summary}
                    </h1>
                    <div class="uk-block uk-block-secondary">
                        <span class="uk-icon-quote"></span>
                    ${raw(n.description?.replace("\n", "<br/>"))}
                    </div>
                </div>

                    %{--<h2>  ${n.wbsNumber} - ${n.summary}</h2>--}%
                    %{--[${n.id}]--}%
                    %{--<div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%;">--}%
                        %{--${n.description}--}%
                        %{--${raw(n.description?.replace("\n", "<br/>"))}--}%
                        %{--n.description ? raw(n.description) :--}%
                    %{--</div>--}%


                %{--</g:if>--}%
                <div style="padding-left: 14px">
                    <g:render template="/appCourse/childrenofNotesTextHtml" model="[record: record, parent: n, level: 3]"/>
                </div>
            </g:each>
        </div>




        %{--<a routerLink='/signup'>Create Account</a>--}%
        <div class="uk-grid uk-flex uk-flex-top uk-flex-center uk-flex-wrap uk-margin uk-grid-column-small uk-grid-row-small">

            <g:each in="${grantedApplications}" var="app">
                <div class="uk-card uk-card-small uk-card-default uk-card-hover uk-height-small uk-margin uk-animation-slide-top-medium"
                     style="margin: 4px 10px; width: 350px;">


                    <div class="uk-card-header" >
                        <div class="uk-grid uk-grid-small uk-text-large" data-uk-grid>
                            <div class="uk-width-expand rtl">
                                <span class="cat-txt">


                                    <a style="text-transform: none;" class="rtl" href="${app.applicationUrl}" target="_blank">
                                        %{--<span class="icon" name="${app.frenchName}">--}%
                                        %{--?--}%
                                        %{--</span>--}%
                                        ${app.arabicName}
                                    </a>


                                </span>
                            </div>
                            <div class="uk-width-auto uk-text-right rtl">
                                <span data-uk-icon="icon:${app.frenchName}; ratio: 1.8"></span>
                                %{--version ??--}%
                            </div>
                        </div>
                    </div>



                    %{--<div style="padding: 7px;">--}%
                    %{--<div class="subtitle" style="color: darkolivegreen;">--}%
                    %{--${app.englishName}--}%
                    %{--</div>--}%
                    %{--<div class="title" style="float: right; align: right; font-size: 1.2em;">--}%
                    %{--<a style="text-transform: none;" href="${app.applicationUrl}" target="_blank">--}%
                    %{--<span class="icon" name="${app.frenchName}">--}%
                    %{--?--}%
                    %{--</span>--}%

                    %{--</a>--}%
                    %{--</div>--}%
                    %{--</div>--}%

                    %{--<div class="card-content" style="padding: 7px; margin: 5px; font-size: 1em; text-align: right; direction: rtl; clear: both">--}%
                    %{----}%
                    %{--</div>--}%

                    <div class="uk-card-body uk-rtl">
                        %{--<h6 class="uk-margin-small-bottom uk-margin-remove-adjacent uk-text-bold">--}%
                        %{--A BEAUTIFUL LANDSCAPE HERE--}%
                        %{--</h6>--}%
                        <div class="uk-text rtl">
                            ${app.description}
                        </div>
                    </div>
                </div>

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
%{--</div>--}%
<!-- /CONTENT -->
<!-- JS FILES -->



<script>



</script>

%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'autocomplete.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'search.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'form-select.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'notify.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: '')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit-icons.min.js')}"></script>
%{--<script type="text/javascript" src="./uikit/js/"></script>--}%

</body>
</html>
