<%@ page import="mcs.parameters.ResourceStatus; mcs.parameters.WritingType; mcs.parameters.PlannerType; mcs.Book; mcs.Excerpt; mcs.Task; mcs.Journal; mcs.Writing; mcs.Goal; mcs.Planner" %>


<html>
<head>

    <title>
%{--        <g:layoutTitle default="Nibras PKM"/>--}%
        ${ker.OperationController.getPath('app.name') ?: 'Nibras PKM'}
        <g:meta name="app.version"/>
    </title>

%{--    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/png"/>--}%

    %{--<r:layoutResources/>--}%
    <g:layoutHead/>


    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}"/>--}%



    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'fg.menu.css')}"/>--}%

    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'ui.achtung-min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>





    <!-- ToDo: standardize the below code -->
    <style type="text/css" media="print">
    /**
   *	PRINT Stylesheet
   *
   *	First 'neutralize' all the positioning/overflow CSS added by Layout
   *	Then change or add cosmetic styles (borders, padding) for printing
   *
   *	MUST use "!important" for all size, position, margin & overflow rules,
   *	so these will 'override' styles applied to the elements by Layout
   */

    html, body {
        /* NEUTRALIZE 'layout container' styles */
        overflow: visible !important;
        width: auto !important;
        height: auto !important;
    }

    .ui-layout-pane,
    .ui-layout-resizer,
    .ui-layout-toggler {
        /* NEUTRALIZE 'layout element' styles */
        display: none !important; /* hide ALL by default */
        position: relative !important;
        top: auto !important;
        bottom: auto !important;
        left: auto !important;
        right: auto !important;
        width: auto !important;
        height: auto !important;
        overflow: visible !important;
    }

    /* SHOW ONLY the panes you want */
    .ui-layout-pane-center,
    .ui-layout-pane-south {
        display: block !important;
        /* OPTIONAL: change cosmetic styles as desired
          border:		0			!important;
          padding:	0			!important;
          background:	transparent	!important;
          */
    }



    </style>


    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'fg.menu.js')}"></script>

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.autocomplete.min.js')}"></script>--}%

    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>



    <script language="javascript" type="text/javascript">

        jQuery(document).ready(function () {

            jQuery('.fg-button').hover(
                    function () {
                        jQuery(this).removeClass('ui-state-default').addClass('ui-state-focus');
                    },
                    function () {
                        jQuery(this).removeClass('ui-state-focus').addClass('ui-state-default');
                    }
            );

        });
    </script>

</head>

<body>

<g:layoutBody/>

</body>
</html>
