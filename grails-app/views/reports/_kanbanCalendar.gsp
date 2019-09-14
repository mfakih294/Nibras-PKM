<%@ page import="mcs.Planner; mcs.Journal" %>
<style type="text/css">
#jpCalendar table th {
    font-weight: bold !important;
    background: #7ba1b9;
    color: #ffffff;
}

#jpCalendar table td {
    vertical-align: top;
}
</style>

<h2>Kanban board</h2>

<div id="jpCalendar">
    <table border="1" style="width: 98%; border: #496779; border-collapse: collapse;">

        <thead>
        <g:each in="${(startDate..endDate)}" var="d">
        <th>${mcs.UtilsController.toWeekDate(d)}</th>
        </g:each>
        </thead>

        <tr>
<g:each in="${(startDate..endDate)}" var="d">
            <td>
                <g:render template="/gTemplates/box" collection="${Planner.executeQuery('from Planner where date(startDate) >= ? and date(startDate) < ? and type.code = ? order by dateCreated desc', [d, d + 1, 'knb'])}"
                var="record"/>
            </td>
    </g:each>
        </tr>

        </table>

</div>