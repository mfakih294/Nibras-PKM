<%@ page import="app.Indicator; mcs.Department; org.apache.commons.lang.StringUtils; mcs.Course" %>

<div style="-moz-column-count: 3">
    <ul style="font-size: 14px; line-height: 25px;">
        %{--<g:each in="${(1..12)}" var="c">--}%
            %{--<b>${c}</b>--}%
            %{--<br/>--}%
        <g:each in="${Indicator.findAll([sort: 'name', order: 'asc'])}" var="t">
            <li>
                <g:remoteLink controller="indicator" action="showEvolution" id="${t.id}"
                              update="centralArea">

                    ${t.name} <b style="font-size: 12px;"> ${t.code}</b>
                </g:remoteLink>
            </li>
        </g:each>
        %{--</g:each>--}%
    </ul>
</div>