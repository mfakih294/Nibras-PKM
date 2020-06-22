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

<%@ page import="mcs.Planner; cmn.DataChangeAudit; ker.OperationController; app.Indicator; mcs.Goal; mcs.Task; mcs.Journal; mcs.Writing; app.IndexCard; mcs.Excerpt; mcs.Book; mcs.Course;" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <meta name="layout" content="main"/>
    <title>${record.entityCode()} ${record?.toString()}</title>
    %{--${record.id}--}%

    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'record.ico')}" type="image/png"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.layout-latest_min.js')}"></script>



%{--    <r:require modules="application"/>--}%
    %{--<r:require module="fileuploader"/>--}%
%{--    <r:require modules="jquery"/>--}%
%{--    <r:require modules="jquery-ui"/>--}%
%{----}%

%{--    <r:layoutResources/>--}%


    <script type="text/javascript" src="${resource(dir: 'js', file: 'jqueryui-editable.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqueryui-editable.css')}"/>


    <script type="text/javascript">


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

            //   for (var i = 0; i < localStorage.length; i++) {
            // do something with localStorage.getItem(localStorage.key(i));
            //       var key = localStorage.key(i)
            //       var value = localStorage[key]


//            console.log('key ' + key + 'value' + value)
//            if ((typeof value == 'string' || value instanceof String) && !value.contains('datum'))
//            if (value.contains('pkm-'))
//            document.getElementById('commandHistory').options.add(new Option(value, localStorage.key(i)))


            //   }




            myLayout = $('body').layout({
                west__size: 3,
                east__size: 380,
                west__initClosed: true,
                south__initClosed: true,
                north__initClosed: true,
                east__togglerContent_closed: '<<',
                // RESIZE Accordion widget when panes resize
                west__onresize: $.layout.callbacks.resizePaneAccordions,
                east__onresize: $.layout.callbacks.resizePaneAccordions,
                onresize: $.layout.callbacks.resizePaneAccordions,
                north__closable: false,
                south__closable: false,
                north__spacing_closed: 5		// big resizer-bar when open (zero height)
                , north__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , south__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , north__spacing_open: 5		// no resizer-bar when open (zero height)
                , south__spacing_open: 5		// no resizer-bar when open (zero height)
                , south__spacing_closed: 5		// big resizer-bar when open (zero height)

                , east__spacing_open: 5		// no resizer-bar when open (zero height)
                , east__spacing_closed: 25		// big resizer-bar when open (zero height)
                , west__spacing_open: 5		// no resizer-bar when open (zero height)
                , west__spacing_closed: 15		// big resizer-bar when open (zero height)
//            , west__initClosed: true
                , west__slideTrigger_open: 'click'
                , east__slideTrigger_open: 'mouseover'


            });


            $.fn.editable.defaults.mode = 'inline';
            $.fn.editable.defaults.showbuttons = false;

            jQuery('.fg-button').hover(
                function () {
                    jQuery(this).removeClass('ui-state-default').addClass('ui-state-focus');
                },
                function () {
                    jQuery(this).removeClass('ui-state-focus').addClass('ui-state-default');
                }
            );

            var matched, browser;

            jQuery.uaMatch = function (ua) {
                ua = ua.toLowerCase();

                var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
                    /(webkit)[ \/]([\w.]+)/.exec(ua) ||
                    /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
                    /(msie) ([\w.]+)/.exec(ua) ||
                    ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) ||
                    [];

                return {
                    browser: match[1] || "",
                    version: match[2] || "0"
                };
            };

            matched = jQuery.uaMatch(navigator.userAgent);
            browser = {};

            if (matched.browser) {
                browser[matched.browser] = true;
                browser.version = matched.version;
            }

// Chrome is Webkit, but Webkit is also Safari.
            if (browser.chrome) {
                browser.webkit = true;
            } else if (browser.webkit) {
                browser.safari = true;
            }

            jQuery.browser = browser;

            // this layout could be created with NO OPTIONS - but showing some here just as a sample...
            // myLayout = jQuery('body').layout(); -- syntax with No Options

            //        jQuery('input').iCheck({
            //            checkboxClass: 'icheckbox_minimal-grey',
            //            radioClass: 'iradio_minimal-grey',
            //            increaseArea: '-20%' // optional
            //        });

        });

        %{--</script>--}%


        //    jQuery(document).ready(function () {


        //    });

        //    $(function() {
        //         jQuery("#tabsTask").tabs();
        //        $( "#tabs" ).tabs();
        //    });

    </script>


    %{----}%
</head>

<body style="margin-left:100px;margin-right:100px; background: lightgray">

%{--todo--}%
<g:if test="${record.entityCode().length() == 1999}">
    <div style="float: right; display: inline">
        <uploader:uploader id="yourUploaderId${record.id}"
                           url="${[controller: 'attachment', action: 'upload']}"
                           params="${[recordId: record.id, entityCode: record.entityCode()]}">
            <uploader:onComplete>
            %{--jQuery('#notificationArea').html(responseJSON[0]);--}%
                jQuery('#notificationArea').html('Ok');
            </uploader:onComplete>
            Attach...
        </uploader:uploader>
    </div>
</g:if>

<g:if test="${record.entityCode() == 'R'}">
    <h2>Book highlights</h2>
</g:if>

<g:if test="${record.entityCode() == 'G'}">
    <h2>Goal page</h2>
</g:if>

<g:if test="${record.entityCode() == 'W'}">
    <h2>Writing page</h2>
</g:if>



<div class="ui-layout-north southRegion appBkg" style="overflow: hidden;"
     style="">
</div>

<div class="ui-layout-west westRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">
</div>

<div class="ui-layout-south footerRegion"
     style="font-size: 12px; margin-top: 10px; margin-left: 20px; min-height: 0px !important;  padding: 3px; direction: ltr; text-align: left; font-family: tahoma; color: white">
</div>


<div class="ui-layout-east eastRegion appBkg" style="padding-top: 0px !important;padding-bottom: 0px !important;">
    <div id="3rdPanel">

    </div>

</div>


<div class="ui-layout-center appBkg" style="margin-top: 4px !important; margin-bottom: 4px !important;">

    <table>
        <tr>
            <td>
                <g:render template="/gTemplates/recordSummary" model="[record: record]"/>
            </td>

            <td>





            </td>
        </tr>
    </table>



    <div id="cardBoxes">

        %{----}%

        %{--<g:if test="${record.entityCode() == 'W'}">--}%
        %{--<g:each in="${app.IndexCard.findAllByWriting(Writing.get(record.id), [sort: 'orderInWriting', order: 'asc'])}"--}%
        %{--var="c">--}%
        %{--<g:render template="/gTemplates/box" model="[record: c]"/>--}%
        %{--</g:each>--}%
        %{--</g:if>--}%


    </div>




    <div id="notificationArea"></div>


</div>





%{--<g:render template="/gTemplates/recordDetails" model="[record: record]"/>--}%





<g:if test="${1 ==2}">
<div id="tabsTask">
    <ul>
        <li><a href="#type-1"><span>Description</span></a></li>
<g:if test="${record.entityCode() == 'C'}">
        <li><a href="#type-2"><span>Writings (${Writing.countByCourse(record)})</span></a></li>
</g:if>
<g:if test="${record.entityCode() == 'C'}">

        <li><a href="#type-8"><span>Goals (${Goal.countByCourse(record)})</span></a></li>
</g:if>

<g:if test="${record.entityCode() == 'G' || record.entityCode() == 'C'}">
<li><a href="#type-9"><span>Tasks (0)</span></a></li>
    </g:if>

<g:if test="${record.entityCode() == 'R'}">

        <li><a href="#type-4"><span>Excerpts (${Excerpt.countByBook(record)})</span></a></li>
    <li><a href="#type-8"><span>J & P (${Journal.countByBook(record) + Planner.countByBook(record)})</span></a></li>

</g:if>

        <li><a href="#type-5"><span>Notes (${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id)})</span></a></li>


        <li><a href="#type-6"><span>Linked records</span></a></li>
        <li><a href="#type-7"><span>Changes</span></a></li>




    </ul>

    <div id="type-1" style="-moz-column-count:1">
        <div class="text${record.class.declaredFields.name.contains('language') && record.language ? record.language : ''}">

        <g:if test="${record.class.declaredFields.name.contains('shortDescription')}">
            <span style="font-size: 12px; font-style: italic; color: #4A5C69">
                <b>Summary:</b> ${record?.shortDescription?.replaceAll('\n', '<br/>')}
            </span>
        </g:if>



    %{--<h4>AsciiDoc to HTML converted</h4>--}%
    %{--${OperationController.convertAsciiDocToHtml(record.description)}--}%



    %{--</g:if>--}%




        <g:if test="${record.class.declaredFields.name.contains('description')}">
        %{--<b>${record.summary?.encodeAsHTML()?.replaceAll('\n', '<br/>')}</b>--}%
        %{--<br/>--}%
        %{--${record.description?.encodeAsHTML()?.replaceAll('\n', '<br/>')}--}%

        %{--<b>${record.summary?.encodeAsHTML()?.replaceAll('\n', '<br/>')}</b>--}%
        %{--<br/>--}%


            <g:if test="${record.class.declaredFields.name.contains('fullText')}">


                <div style="${OperationController.getPath('recordPage.text.style')}">
                    <span id="fullTextBlock${record.id}">
                        ${record.fullText?.replaceAll('\n', '<br/>')?.decodeHTML()?.replaceAll('\n', '<br/>')?.replace('Product Description', '')}
                    </span>
                </div>
            </g:if>

            <div style="${OperationController.getPath('recordPage.text.style')}">
                <span id="descriptionBloc${record.id}">
                    ${record.description?.replaceAll('\n', '<br/>')?.decodeHTML()?.replaceAll('\n', '<br/>')?.replace('Product Description', '')}
                    %{--${?.encodeAsHTML()?.replaceAll('\n', '<br/>')}--}%
                </span>

                %{--${WikiParser.renderXHTML(record.description)?.replaceAll('\n', '<br/>')?.decodeHTML()}--}%

            </div>
            <g:if test="${record.entityCode() == 'W'}">

                <g:remoteLink url="[controller: 'operation', action: 'convertAsciiDocToHtml', id: record.id]"
                              update="descriptionBloc${record.id}"
                              class="actionLink"
                              title="Convert to HTML">
                    Convert to HTML (inline)
                </g:remoteLink>
                </g:if>

                <g:if test="${record.entityCode() == 'C'}">


                    <g:link url="[controller: 'export', action: 'generateCourseWritingsAsHtml', id: record.id]"
                              class="actionLink"
                    target="_blank"
                              title="Convert to HTML">
                    Combine writings in HTML format (new tab)
                </g:link>
                
                
                
                    <g:link url="[controller: 'export', action: 'generateCourseWritingsAsIs', id: record.id]"
                              class="actionLink"
                    target="_blank"
                              title="Convert to HTML">
                    Combine writings as is (new tab)
                </g:link>





<br/>
<br/>
  <g:link url="[controller: 'export', action: 'generateCoursePresentation', id: record.id]"
                              class="actionLink"
                    target="_blank"
                              title="Convert to HTML">
                    Generate presentation (new tab)
                </g:link>


            </g:if>
        </g:if>


    %{--direction: ${record?.source?.language == 'ar' ? 'rtl' : 'ltr'}--}%
    %{--todo--}%






    </div>
    %{--direction: ${record?.source?.language == 'ar' ? 'rtl' : 'ltr'}; text-align: ${record?.source?.language == 'ar' ? 'right' : 'left'}--}%
    %{--todo--}%

    </div>
<g:if test="${record.entityCode() == 'R'}">
    <div id="type-4" style="">

        <g:if test="${'R'.contains(record.entityCode())}">

            %{--<h4>Excerpts</h4>--}%
            <g:each in="${Excerpt.findAllByBook(record)}" var="r">

                <g:render template="/gTemplates/recordSummary" model="[record: r, expandedView: false]"/>
            </g:each>
        %{--<g:each in="${Planner.findAllByBook(record)}" var="r">--}%
        %{----}%
        %{--<g:render template="/gTemplates/recordSummary" model="[record: r]"/>--}%
        %{--</g:each>--}%

        </g:if>

    </div>
      </g:if>

    <div id="type-2" style="">

        <g:if test="${record.entityCode() == 'C'}">
         <h4>Writings</h4>
            <g:each in="${mcs.Writing.findAllByCourse(record, [sort: 'orderInCourse', order: 'asc'])}"
                    var="c">
                <g:render template="/gTemplates/recordSummary" model="[record: c, expandedView: false]"/>
                <g:each in="${app.IndexCard.findAllByWriting(c, [sort: 'orderInWriting', order: 'asc'])}"
                        var="i">
                    <div style="margin-left: 20px">
                    <g:render template="/gTemplates/recordSummary" model="[record: i]"/>
                    </div>
                </g:each>

            <%--  <g:each in="${app.IndexCard.findAllByWriting(c, [sort: 'orderInWriting', order: 'asc'])}"
                       var="i">
                   <g:render template="/gTemplates/box" model="[record: i]"/>
               </g:each>
                --%>
            </g:each>
        </g:if>
</div>

<div id="type-5" style="">
        <span id="commentArea${record.entityCode()}${record.id}" style="display: inline;  margin-left: 10px;">

            %{--<h4>Notes</h4>--}%
            <g:each in="${app.IndexCard.findAllByEntityCodeAndRecordId(record.entityCode(), record.id)}" var="c">
                <g:render template="/gTemplates/recordSummary" model="[record: c, expandedView: false]"/>
            </g:each>
            <g:if test="${'R'.contains(record.entityCode())}">
                <g:each in="${app.IndexCard.findAllByBook(record)}" var="c">
                    <g:render template="/gTemplates/recordSummary" model="[record: c]"/>
                </g:each>
            </g:if>
        </span>

    </div>


<div id="type-7" style="">

<g:each in="${DataChangeAudit.findAllByEntityIdAndRecordId(144,record.id, [sort: 'dateCreated', order: 'desc'])}" var="c">
<br/>
<br/>
   ${c.userName}: ${c.datePerformed}     ${c.operationType}<br/>
%{--<g:each in="${c.operationDetails.split(';;')}" var="f">--}%
    %{--<g:if test="${c.operationType == 'Update'}">--}%
    %{--<b>${f.split(/\|\|/)[0]}:</b>--}%
    %{--${f.split(/\|\|/)[1]} ->--}%
    %{--${f.split(/\|\|/)[2]}:--}%
%{--<br/>    </g:if>--}%
     %{--<g:else>--}%
         %{--${f}<br/>--}%
     %{--</g:else>--}%
%{--</g:each>--}%

</g:each>



</div>


<div id="type-8" style="">

<g:if test="${record.entityCode() == 'R'}">
<g:each in="${mcs.Journal.findAllByBook(record, [sort: 'startDate', order: 'asc'])}"
        var="c">
<g:render template="/gTemplates/recordSummary" model="[record: c, expandedView: false]"/>
</g:each>

<g:each in="${mcs.Planner.findAllByBook(record, [sort: 'startDate', order: 'asc'])}"
        var="c">
    <g:render template="/gTemplates/recordSummary" model="[record: c, expandedView: false]"/>
</g:each>
    </g:if>
</div>

    <div id="type-6" style="">

    <g:if test="${record.entityCode() == 'W'}">

        <div id="OrderTheFields" style="-moz-columns-count:1">

            <table id="table1">
            %{--<ul id="item_list" >--}%
                <g:each in="${app.IndexCard.findAllByWriting(Writing.get(record.id), [sort: 'orderInWriting', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInWriting} C-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"
                                                                                         length="80"/>
                        </td></tr>
                </g:each>

                <g:each in="${app.IndexCard.findAllByRecordIdAndEntityCode(record.id.toString(), 'W', [sort: 'orderInWriting', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInWriting} C-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"
                                                                                         length="80"/>
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("http://localhost:2008${request.contextPath}/operation/orderIcdInWrt?type=W&child=N&tableId=1", jQuery("#table1").tableDnDSerialize())'/>

            <script type="text/javascript">
                jQuery("#table1").tableDnD();
            </script>
        </div>

    </g:if>
    <g:if test="${record.entityCode() == 'G'}">
        <div id="OrderTheFields" style="-moz-columns-count:1">
            <table id="table1">
            %{--<ul id="item_list" >--}%
                <g:each in="${mcs.Task.findAllByGoal(Goal.get(record.id), [sort: 'orderInGoal', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInGoal} T-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"
                                                                                      length="80"/>
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("operation/orderIcdInWrt?type=G&child=T&tableId=1", jQuery("#table1").tableDnDSerialize())'/>

            <script type="text/javascript">
                jQuery("#table1").tableDnD();
            </script>
        </div>
    </g:if>

    <g:if test="${record.entityCode() == 'C'}">
        <div id="OrderTheFields" style="-moz-columns-count:1">
            <table id="table1">
            %{--<ul id="item_list" >--}%
                <g:each in="${mcs.Goal.findAllByCourse(Course.get(record.id), [sort: 'orderInCourse', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInCourse} G-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"
                                                                                        length="80"/>
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("operation/orderIcdInWrt?type=C&child=G&tableId=1", jQuery("#table1").tableDnDSerialize())'/>
            <hr/>

            <table id="table2">
            %{--<ul id="item_list" >--}%
                <g:each in="${mcs.Writing.findAllByCourse(Course.get(record.id), [sort: 'orderInCourse', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInCourse} W-${c.id} - <b>${c.summary}</b><pkm:summarize
                                text="${c.description}"
                                length="80"/>
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("${request.contextPath}/operation/orderIcdInWrt?type=C&child=W&tableId=2", jQuery("#table2").tableDnDSerialize())'/>
            <hr/>

            <table id="table3">
                <g:each in="${mcs.Book.findAllByCourse(Course.get(record.id), [sort: 'orderInCourse', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInCourse} B-${c.id} - ${c.title} ${c.legacyTitle}<pkm:summarize
                                    text="${c.description}" length="80"/>
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("operation/orderIcdInWrt?type=C&child=B&tableId=3", jQuery("#table3").tableDnDSerialize())'/>



            <table id="table4">
            %{--<ul id="item_list" >--}%
                <g:each in="${mcs.Excerpt.executeQuery('from Excerpt r where r.book.course = ? order by orderInCourse asc', [Course.get(record.id)])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInCourse} R-${c.id} - <b>${c.book?.title} ${c.book?.legacyTitle}</b>:${c.chapters} ${c.summary}
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("operation/orderIcdInWrt?type=C&child=R&tableId=4", jQuery("#table4").tableDnDSerialize())'/>

            <table id="table5">
            %{--<ul id="item_list" >--}%
                <g:each in="${mcs.Excerpt.executeQuery('from Task r where r.course = ? and r.bookmarked = ? order by orderInCourse asc', [Course.get(record.id), true])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInCourse} T-${c.id} - <b>${c?.summary}
                        </td></tr>
                </g:each>
            </table>
            <input type="button" id="sortButton5" value="Save sort"
                   onclick='jQuery("#OrderTheFields").load("operation/orderIcdInWrt?type=C&child=T&tableId=5", jQuery("#table5").tableDnDSerialize())'/>






            <script type="text/javascript">
                jQuery("#table1").tableDnD();
                jQuery("#table2").tableDnD();
                jQuery("#table3").tableDnD();
                jQuery("#table4").tableDnD();
                jQuery("#table5").tableDnD();
            </script>
        </div>
    </g:if>




    <g:if test="${record.entityCode() == 'R'}">
        <div id="OrderTheFields" style="-moz-columns-count:1">
        <table id="table1">
            %{--<ul id="item_list" >--}%
            %{--<g:each in="${mcs.Writing.findAllByBook(Book.get(record.id), [sort: 'orderInBook', order: 'asc'])}" var="c">--}%
            %{--<tr id="${c.id}">--}%
            %{--<td>--}%
            %{--#${c.orderInBook} C-${c.id} - ${c.summary} <pkm:summarize text="${c.description}" length="80"/>--}%
            %{--</td></tr>--}%
            %{--</g:each>--}%

            <g:if test="${app.IndexCard.countByBook(Book.get(record.id)) > 0}">
                <g:each in="${app.IndexCard.findAllByBook(Book.get(record.id), [sort: 'orderInBook', order: 'asc'])}"
                        var="c">
                    <tr id="${c.id}">
                        <td>
                            #${c.orderInBook} C-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"
                                                                                      length="80"/>
                        </td></tr>
                </g:each>
                </table>
                <input type="button" id="sortButton" value="Save sort"
                       onclick='jQuery("#OrderTheFields").load("operation/orderIcdInWrt?type=B&child=C", jQuery("#table1").tableDnDSerialize())'/>

                <script type="text/javascript">
                    jQuery("#table1").tableDnD();
                </script>
            </g:if>
        </div>
    </g:if>

</div>

</div>

</g:if>


%{--<g:render template="/gTemplates/box"--}%
%{--collection="${IndexCard.findAllByRecordIdAndEntityCode(record.id, record.entityCode())}"--}%
%{--var="record"/>--}%


%{--<simpleModal:javascript />--}%

%{--<r:layoutResources/>--}%

</body>


</html>
