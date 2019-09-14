%{--
  - Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
  -
  - This program is free software: you can redistribute it and/or modify
  - it under the terms of the GNU General Public License as published by
  - the Free Software Foundation, either version 3 of the License, or
  - (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  - GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License
  - along with this program.  If not, see <http://www.gnu.org/licenses/>
  --}%

<%@ page import="app.Indicator; mcs.Goal; mcs.Task; mcs.Journal; mcs.Writing; app.IndexCard; mcs.Excerpt; mcs.Book" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    %{--<meta name="layout" content="main"/>--}%
    <title>Kanban</title>


    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'calendar7.ico')}" type="image/png"/>



    <r:require modules="application"/>
    <r:require module="fileuploader"/>
    <r:require modules="jquery"/>
    <r:require modules="jquery-ui"/>


    <r:layoutResources/>


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uploader.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}"/>


    %{--<uploader:head css="${resource(dir: 'css', file: 'uploader.css')}"/>--}%

    %{----}%

    %{--<uploader:head/>--}%


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.continuousCalendar.css')}"/>



    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery/jquery-1.3.2.min.js')}"></script>--}%



    <script type="text/javascript" src="${resource(dir: 'js', file: 'DateFormat.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'DateLocale.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'DateRange.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'DateTime.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.continuousCalendar-latest.js')}"></script>

    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'fileuploader.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'css', file: 'uploader.css')}"></script>--}%


    <script type="text/javascript" src="${resource(dir: 'js', file: 'raphael-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'morris.js')}"></script>


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'fg.menu.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'ui.achtung-min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'fullcalendar.min.js')}"></script>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'morris.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>


    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'fg.menu.js')}"></script>

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.jeditable.mini.js')}"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.blockUI.js')}"></script>



    <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.autocomplete.min.js')}"></script>

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.relatedselects.min.js')}"></script>--}%

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'shortcut.js')}"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>




    <script type=text/javascript>

        jQuery(document).ready(function () {


        });

    </script>

</head>

<body style="margin:15px;">

<g:render template="/reports/kanban" model="[]"/>


<div id="notificationArea"></div>


<r:layoutResources/>

</body>

%{--<r:layoutResources/>--}%

</html>
