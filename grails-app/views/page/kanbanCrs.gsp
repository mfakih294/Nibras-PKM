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

    <meta name="layout" content="main"/>
    <title>${title ?: 'Kanban'}</title>


    <!-- To make the page refresh every 120 seconds -->

    <meta http-equiv="refresh" content="1200">



    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'gears.ico')}" type="image/png"/>



    %{--<r:require modules="application"/>--}%
    %{--<r:require module="fileuploader"/>--}%
    %{--<r:require modules="jquery"/>--}%
    %{--<r:require modules="jquery-ui"/>--}%



    <script type="text/javascript" src="${resource(dir: 'uikit-min/js', file: 'uikit.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'uikit-min/js', file: 'uikit-icons.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'uikit-min/css', file: 'uikit.css') }"/>





    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.10.4.custom.css')}"/>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'personalization.css')}"/>
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}"/>--}%

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'fg.menu.css')}"/>
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout-mine.css')}"/>--}%

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'ui.achtung-min.js')}"></script>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>--}%



    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.address-1.5.min.js?autoUpdate=0')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>


    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}"/>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'select2.min.js')}"></script>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqueryui-editable.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jqueryui-editable.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'typeahead.bundle.js')}"></script>
    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'fileuploader.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.flipcountdown.js')}"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>


    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.layout-latest_min.js')}"></script>


    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'fileuploader.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'css', file: 'uploader.css')}"></script>--}%


    <script type="text/javascript" src="${resource(dir: 'js', file: 'raphael-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'morris.js')}"></script>


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'fg.menu.css')}"/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'morris.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqueryui-editable.css')}"/>


    <script type="text/javascript" src="${resource(dir: 'js', file: 'fg.menu.js')}"></script>

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.relatedselects.min.js')}"></script>--}%

    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'shortcut.js')}"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>




    <script type=text/javascript>

        jQuery(document).ready(function () {

        });

    </script>

</head>

<body style="margin: 5px; ">
%{--<table width="99%" style="width: 99%;">--}%
    %{--<tr>--}%
        %{--<td style="width: 75%; vertical-align: top;">--}%



%{--</center>--}%


        %{--</td>--}%
        %{--<td style="width: 25%; vertical-align: top;">--}%
        %{----}%
        %{--</td>--}%
    %{--</tr>--}%
%{--</table>--}%
%{--<center>--}%


%{--<div class="ui-layout-north southRegion appBkg" style="overflow: hidden;"--}%
     %{--style="">--}%

%{--</div>--}%

%{--<div class="ui-layout-west westRegion appBkg"  style="margin-top: 5px !important;margin-bottom: 5px !important;">--}%
    %{--<div class="ui-layout-content ui-widget-content">--}%


    %{--</div>--}%
%{--</div>--}%

%{--<div class="ui-layout-south southRegion" style="direction: rtl; text-align: center; font-family: tahoma; padding-bottom: 4px;">--}%

%{--</div>--}%


%{--<div class="ui-layout-east eastRegion appBkg" style="margin-top: 5px !important;margin-bottom: 5px !important;">--}%

    %{--<div class="ui-layout-content ui-widget-content">--}%
        %{--<div id="3rdPanel" ></div>--}%
    %{--</div>--}%
%{--</div>--}%


<div class="ui-layout-center appBkg" style="margin-top: 10px !important; margin-bottom: 5px !important; ">
    %{--ToDo: display none?!--}%
    %{--<div class="ui-layout-content" onmouseover="jQuery('#hintArea').html('')">--}%
        <div id="notificationArea"></div>

    <g:if test="${items}">

        %{--/reports/dynamicKanbanTable"--}%
    <g:render
            template="/reports/genericGrouping"
              model="[items: items, groups: groups,
//                      reportType: reportType,
                      groupBy: groupBy, title:title, ssId: ssId]"/>
        </g:if>
    <g:elseif test="${ssId}">
            %{--<g:render template="/gTemplates/recordListing" model="[--}%
        <g:render template="/reports/genericGrouping" model="[
                    ssId: ssId,
                    searchResultsTotal: searchResultsTotal,
                    totalHits: totalHits,
//                    reportType: reportType,
                    box: 1,
                    list: list,
                    title: title]"/>
        </g:elseif>
       <g:elseif test="${list}">
            <g:render template="/gTemplates/recordListing" model="[
                    totalHits: totalHits,
                    list: list,
                    title: title]"/>
        </g:elseif>
        <g:else>
            <g:render template="/reports/kanbanCrs" model="[title: title]"/>
        </g:else>


    </div>

   %{--</div>--}%
</body>

<r:layoutResources/>

</html>
