<%@ page import="cmn.Setting" %>

<h3 style="display: inline !important; text-align: center;">${title}</h3>
    %{--<div style="-moz-column-count: ${Setting.findByNameLike('grouping-colmns') ? Setting.findByNameLike('grouping-colmns').value.toInteger() : 2}; -webkit-column-count: ${Setting.findByNameLike('grouping-colmns') ? Setting.findByNameLike('grouping-colmns').value.toInteger() : 2}">--}%

<g:if test="${ssId}">

    <g:remoteLink controller="generics" action="fetchAddForm" id="${ssId}"
                  params="[entityController: 'mcs.parameters.SavedSearch',
                           updateRegion: '3rdPanel',
                           finalRegion: '3rdPanel']"
                  update="3rdPanel"
        style=""
                  title="Edit">
        (Edit)
    </g:remoteLink>

    <g:if test="${query}">
        <i style="line-height: 20px;">
            (${query})
        </i>
        <br/>
    %{--<hr/>--}%
    </g:if>


</g:if>

%{--<table> <tr>--}%
%{--todo: add to settings--}%
<div style="column-count: ${ker.OperationController.getPath('grouping.column.count') ?: '3'}" class="uk-margin-left uk-margin-right">
<g:each in="${groups}" var="g">
    <g:if test="${items[groupBy].contains(g)}">
        <g:set var="count"
               value="${0}"/>
    %{--<div >--}%
            %{--<hr/>--}%
        %{--</div>   --}%
       %{--<td style="vertical-align: top; border-right: 1px solid darkgray; padding: 6px;">--}%
        %{--<br/>--}%
        %{--<br/>--}%
<g:if test="${items.findAll( {it[groupBy] == g}).size() > 3}">

%{--<div style="column-break-inside: avoid; display: inline-block;">--}%
%{--SSSSSSSSSSSSSSSSS--}%
</g:if>
        %{--todo: group also < 3 sections--}%

            <h4 style="text-align: center; font-weight: bold;">${g}
            (${items.findAll( {it[groupBy] == g}).size()})
            </h4>
%{--<br/>--}%

    <g:findAll in="${items}" expr="${it[groupBy] == g}">
        %{--count===${count}===--}%
        <g:render template="/gTemplates/recordSummary" model="[record: it, reportType: reportType]"/>

        <br/>

        <g:set var="count"
               value="${count + 1}"/>
        <g:if test="${count == 3}">
            %{--|| count == items.findAll( {it[groupBy] == g}).size() }">--}%
            %{--EEEEEEEEEEEEEE--}%
            %{--</div>--}%
        </g:if>


    </g:findAll>
        %{--</td>--}%
                %{--<center>--}%
                    %{--* * *--}%
                %{--</center>--}%
        </g:if>

</g:each>
</div>
%{--</tr>--}%
%{--</table>--}%
    %{--</div>--}%
        %{--<br/>--}%
        %{--<br/>--}%
