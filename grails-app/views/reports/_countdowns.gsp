<%@ page import="mcs.parameters.JournalType; mcs.Journal; mcs.Planner; mcs.parameters.PlannerType" %>

%{--Refactor--}%
<h2>Countdowns</h2>
<ul>
    <g:each in="${Planner.findAllByType(PlannerType.get(9), [sort: 'endDate', order: 'desc'])}" var="j">
        <li>
            ${j.description} - ${(j.endDate..new Date()).size()} days to go
        </li>

    </g:each>
</ul>

<h2>Countups</h2>
<ul>
    <g:each in="${Journal.findAllByType(JournalType.get(52), [sort: 'endDate', order: 'desc'])}" var="j">
        <li>
            ${j.body} - ${(j.startDate..new Date()).size()} days have passed
        </li>

    </g:each>
</ul>