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

<table> <tr>

<g:each in="${groups}" var="g">
    <g:if test="${items[groupBy].contains(g)}">
        %{--<div >--}%
            %{--<hr/>--}%
        %{--</div>   --}%
       <td style="vertical-align: top;">
        <h4 style="text-align: center; font-weight: bold;">${g?.code}</h4>


    <g:findAll in="${items}" expr="${it[groupBy] == g}">
        <g:render template="/gTemplates/box" model="[record: it]"/>
    </g:findAll>
        </td>
                %{--<center>--}%
                    %{--* * *--}%
                %{--</center>--}%
        </g:if>

</g:each>
</tr>
</table>
    %{--</div>--}%
        <br/>
        <br/>
