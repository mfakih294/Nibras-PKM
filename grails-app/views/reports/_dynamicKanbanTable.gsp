<g:if test="${ssId}">

    <g:remoteLink controller="generics" action="fetchAddForm" id="${ssId}"
                  params="[entityController: 'mcs.parameters.SavedSearch',
                           updateRegion: 'centralArea',
                           finalRegion: 'centralArea']"
                  update="savedSearch${ssId}"
                  title="Edit">
        Edit
    </g:remoteLink>
</g:if>

%{--<table style="border-collapse: collapse; border: 1px solid gray;" border="1">--}%
%{--    <tr>--}%
<div style="column-count: 5">
        <g:each in="${groups}" var="g">
            <g:if test="${items[groupBy].contains(g)}">
%{--                <td style="vertical-align: top">--}%
                    <div style="height: 50px; vertical-align: top">
                        %{---moz-column-break-after: column !important;-moz-column-break-before: column !important;--}%
                    <h4 style=" text-align: center; font-weight: bold; padding-left: 0 !important; margin-left: 0 !important">${g}</h4>
                    </div>
                    <g:findAll in="${items}" expr="${it[groupBy] == g}">
                        <g:render template="/gTemplates/box" model="[record: it]"/>
                    </g:findAll>
%{--                </td>--}%
            </g:if>
        </g:each>
</div>
%{--    </tr>--}%
%{--</table>--}%
