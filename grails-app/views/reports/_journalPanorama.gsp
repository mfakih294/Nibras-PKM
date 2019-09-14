<%@ page import="mcs.Journal" %>



<g:each in="${Journal.executeQuery('select date(startDate) from Journal where type.category = ? group by date(startDate) order by startDate desc', 3)}"
        var="d">
    <h4>${d}</h4>
    <ul>
        <g:each in="${Journal.executeQuery('from Journal where date(startDate) = ? and type.category = 3', [d])}"
                var="j">
            <li>
                <i>${j.type}</i>:  ${j.body}

            </li>
        </g:each>
    </ul>

</g:each>
