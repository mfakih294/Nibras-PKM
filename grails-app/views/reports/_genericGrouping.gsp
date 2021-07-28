<%@ page import="cmn.Setting" %>

%{--<h2 style="display: inline !important; text-align: center;">${title}</h2>--}%
    %{--<div style="-moz-column-count: ${Setting.findByNameLike('grouping-colmns') ? Setting.findByNameLike('grouping-colmns').value.toInteger() : 2}; -webkit-column-count: ${Setting.findByNameLike('grouping-colmns') ? Setting.findByNameLike('grouping-colmns').value.toInteger() : 2}">--}%

%{--<g:if test="${ssId}">--}%

    %{--<g:remoteLink controller="generics" action="fetchAddForm" id="${ssId}"--}%
                  %{--params="[entityController: 'mcs.parameters.SavedSearch',--}%
                           %{--updateRegion: 'centralArea',--}%
                           %{--finalRegion: 'centralArea']"--}%
                  %{--update="centralArea"--}%
        %{--style="float: right;"--}%
                  %{--title="Edit">--}%
        %{--Edit--}%
    %{--</g:remoteLink>--}%
%{--</g:if>--}%

%{--<table> <tr>--}%
%{--todo: add to settings--}%
<div style="column-count: ${ker.OperationController.getPath('grouping.column.count') ?: '3'}">
<g:each in="${groups}" var="g">
    <g:if test="${items[groupBy].contains(g)}">
        %{--<div >--}%
            %{--<hr/>--}%
        %{--</div>   --}%
%{--       <td style="vertical-align: top;">--}%
        <h4 style="text-align: left; font-weight: bold;">${g}</h4>


    <g:findAll in="${items}" expr="${it[groupBy] == g}">
        <g:render template="/gTemplates/recordSummary" model="[record: it]"/>
    </g:findAll>
%{--        </td>--}%
                %{--<center>--}%
                    %{--* * *--}%
                %{--</center>--}%
        </g:if>

</g:each>
</div>
%{--</tr>--}%
%{--</table>--}%
    %{--</div>--}%
        <br/>
        <br/>
