<%@ page import="app.IndicatorData; app.Indicator" %>
<h4>All indicators</h4>

<ul style="-moz-column-count: 4">

    <g:each in="${(1..8)}" var="cat">
        <li><a>Type ${cat}</a>

            <ul>
                <g:each in="${Indicator.executeQuery('from Indicator where category = ? order by name', cat)}"
                        var="t">
                    <li>
                        <a onclick="jQuery('#centralArea').load('${contextPath}/indicator/showEvolution/${t.id}')">
                            <span title="${t.name}">
                                ${t.code}
                            </span>
                            (${IndicatorData.countByIndicator(t)})</a>
                    </li>
                </g:each>
            </ul>
        </li>
    </g:each>

</ul>