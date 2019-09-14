<%@ page import="mcs.parameters.ResourceStatus; mcs.parameters.WritingType; mcs.parameters.PlannerType; mcs.Book; mcs.Excerpt; mcs.Task; mcs.Journal; mcs.Writing; mcs.Goal; mcs.Planner" %>


<html>
<head>

    <title>
        <g:layoutTitle default="Nibras PKM"/>
    </title>

%{--    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/png"/>--}%

    %{--<r:layoutResources/>--}%
    <g:layoutHead/>


    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}"/>--}%



    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'fg.menu.css')}"/>--}%

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'ui.achtung-min.js')}"></script>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>--}%

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>


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
