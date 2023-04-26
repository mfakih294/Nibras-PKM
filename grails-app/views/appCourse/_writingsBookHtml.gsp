<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        ${record}
    </title>
    <!-- CSS FILES -->

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    %{--<link rel="stylesheet" href="${resource(dir: 'select2/css', file: 'select2.min.css')}"/>--}%
    <link rel="stylesheet" href="./uikit/css/uikit.min.css"/>
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'search.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css/components', file: 'autocomplete.min.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'uikit/css', file: 'uikit-rtl.min.css')}"/>--}%
    <link rel="stylesheet" href="./uikit/css/dashboard.css"/>

    %{--<g:javascript library="prototype"/>--}%


    <script type="text/javascript">


    </script>

</head>
<body class="uk-margin-left uk-margin-right">

<!--HEADER-->
<header id="top-head" class="uk-position-fixed  uk-margin-left uk-margin-right">
    <div class="uk-container uk-container-expand uk-background-primary">
        <nav class="uk-navbar uk-light" data-uk-navbar="mode:click; duration: 250">
            <div class="uk-navbar-left uk-text-primary uk-margin-top">
                <h1 style="">
                    Welcome to Jabal Amil website!
                </h1>

            </div>
            <div class="uk-navbar-right">
                <ul class="uk-navbar-nav">
                    <li><a style="color: white;"
                           href=""
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
    <div id="content" class="uk-container uk-container-expand" data-uk-height-viewport="expand: true">


        <div class="uk-section uk-section-xsmall uk-section-muted uk-padding-small">
            %{--<div class=" uk-margin">--}%
            Below are the applications that you are allowed to access.
        </div>


        <div id="logAreaModal"></div>
        <div id="attachmentCard1"></div>

        <div style="direction: rtl; text-align: justify">
            <g:each in="${app.IndexCard.findAllByCourseAndWbsParentIsNull(record, [sort: 'orderNumber', order: 'asc'])}"
                    var="n">
                <g:if test="${(record.priority && record.priority >= 2)}">
                    <h2>  ${n.wbsNumber} ${n.summary}</h2>
                    %{--[${n.id}]--}%
                    <div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%;">
                        %{--${n.description}--}%
                        ${n.descriptionHTML ? raw(n.descriptionHTML) : raw(n.description?.replace("\n", "<br/>"))}
                    </div>
                </g:if>
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
</div>
<!-- /CONTENT -->
<!-- JS FILES -->
%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-3.6.0.min.js')}"></script>--}%
<script type="text/javascript" src="./uikit/js/uikit.min.js"></script>


<script>



</script>


%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'autocomplete.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'search.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'form-select.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: 'notify.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'uikit/js/components', file: '')}"></script>--}%
<script type="text/javascript" src="./uikit/js/uikit-icons.min.js"></script>

</body>
</html>
