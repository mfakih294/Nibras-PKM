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
    <title>${title ?: 'Kanban'}</title>


    <!-- To make the page refresh every 120 seconds -->

    <meta http-equiv="refresh" content="1200">



    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'gears.ico')}" type="image/png"/>



    %{--<r:require modules="application"/>--}%
    %{--<r:require module="fileuploader"/>--}%
    %{--<r:require modules="jquery"/>--}%
    %{--<r:require modules="jquery-ui"/>--}%


    <r:layoutResources/>


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

        /**
         *    UI Layout Callback: resizePaneAccordions
         *
         *    This callback is used when a layout-pane contains 1 or more accordions
         *    - whether the accordion a child of the pane or is nested within other elements
         *    Assign this callback to the pane.onresize event:
         *
         *    SAMPLE:
         *    < jQuery UI 1.9: $("#elem").tabs({ show: $.layout.callbacks.resizePaneAccordions });
         *    > jQuery UI 1.9: $("#elem").tabs({ activate: $.layout.callbacks.resizePaneAccordions });
         *    $("body").layout({ center__onresize: $.layout.callbacks.resizePaneAccordions });
         *
         *    Version:    1.2 - 2013-01-12
         *    Author:        Kevin Dalman (kevin.dalman@gmail.com)
         */
        ;
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


        jQuery(document).ready(function () {

            var myLayout = $('body').layout({
                west__size: 310,
                east__size: 430,
                // RESIZE Accordion widget when panes resize
                west__onresize: $.layout.callbacks.resizePaneAccordions,
                east__onresize: $.layout.callbacks.resizePaneAccordions,
                onresize: $.layout.callbacks.resizePaneAccordions,
                north__closable: true,
                south__closable: true,
                north__spacing_closed: 5		// big resizer-bar when open (zero height)
                , north__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , south__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , south__spacing_open: 5		// no resizer-bar when open (zero height)
                , south__spacing_closed: 5		// big resizer-bar when open (zero height)

                , east__spacing_open: 5		// no resizer-bar when open (zero height)
                , east__spacing_closed: 5		// big resizer-bar when open (zero height)
                , west__spacing_open: 5		// no resizer-bar when open (zero height)
                , west__spacing_closed: 5		// big resizer-bar when open (zero height)
//            , west__initClosed: true
                , west__slideTrigger_open: 'mouseover'


            });


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
<r:layoutResources/>


<div class="ui-layout-north southRegion appBkg" style="overflow: hidden;"
     style="">

</div>

%{--<div class="ui-layout-west westRegion appBkg"  style="margin-top: 5px !important;margin-bottom: 5px !important;">--}%
    %{--<div class="ui-layout-content ui-widget-content">--}%


    %{--</div>--}%
%{--</div>--}%

<div class="ui-layout-south southRegion" style="direction: rtl; text-align: center; font-family: tahoma; padding-bottom: 4px;">

</div>


<div class="ui-layout-east eastRegion appBkg" style="margin-top: 5px !important;margin-bottom: 5px !important;">

    <div class="ui-layout-content ui-widget-content">
        <div id="3rdPanel" ></div>
    </div>
</div>


<div class="ui-layout-center appBkg" style="margin-top: 5px !important; margin-bottom: 5px !important; ">
    %{--ToDo: display none?!--}%
    <div class="ui-layout-content ui-widget-content" onmouseover="jQuery('#hintArea').html('')">
        <div id="notificationArea"></div>

        <g:if test="${ssId}">
            <g:render template="/gTemplates/recordListing" model="[
                    ssId: ssId,
                    searchResultsTotal: searchResultsTotal,
                    totalHits: totalHits,
                    box: 1,
                    list: list,
                    title: title]"/>
        </g:if>
       <g:elseif test="${list}">
            <g:render template="/gTemplates/recordListing" model="[
                    totalHits: totalHits,
                    list: list,
                    title: title]"/>
        </g:elseif>
        <g:elseif test="${items}">
            <g:render template="/reports/dynamicKanbanTable"
                      model="[items: items, groups: groups, groupBy: groupBy, title:title, ssId: ssId]"/>
        </g:elseif>
        <g:else>
            <g:render template="/reports/kanbanCrs" model="[title: title]"/>
        </g:else>


    </div>

   </div>
</body>

%{--<r:layoutResources/>--}%

</html>
