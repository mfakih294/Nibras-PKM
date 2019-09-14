<%@ page import="mcs.Department; org.apache.commons.lang.StringUtils; mcs.Course" %>

<div style="-moz-column-count: 3">
<ul>
<g:each in="${Course.findAllByDepartment(Department.get(id), [sort: 'code', order: 'asc'])}"   var="t">
    <li>
        <g:remoteLink controller="generics" action="recordsByCourse" id="${t.id}"
                      update="centralArea">
            ${t.code} ${StringUtils.abbreviate(t.title, 26)}
        </g:remoteLink>
    </li>
</g:each>
</ul>
</div>