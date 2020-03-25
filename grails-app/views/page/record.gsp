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





    <r:require modules="application"/>
    %{--<r:require module="fileuploader"/>--}%
    <r:require modules="jquery"/>
    <r:require modules="jquery-ui"/>
%{----}%

    <r:layoutResources/>


<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jqueryui-editable.min.js')}"></script>


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>


    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqueryui-editable.css')}"/>


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

<br/>
<br/>
<g:if test="${record.entityCode() == 'R'}">
    <h2>Book highlights</h2>
</g:if>

<g:if test="${record.entityCode() == 'G'}">
    <h2>Goal page</h2>
</g:if>

<g:if test="${record.entityCode() == 'W'}">
    <h2>Writing page</h2>
</g:if>

<g:render template="/gTemplates/recordSummary" model="[record: record]"/>


%{--<g:render template="/gTemplates/recordDetails" model="[record: record]"/>--}%



<br/>
<br/>


<div id="3rdPanel">

</div>


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

%{--<simpleModal:javascript />--}%

<r:layoutResources/>

</body>


<script type="text/javascript">

    %{--</script>--}%

//    jQuery(document).ready(function () {


//    });

//    $(function() {
        jQuery("#tabsTask").tabs();
//        $( "#tabs" ).tabs();
//    });

</script>

</html>
