<%@ page import="app.Indicator;app.IndicatorData; mcs.Department; mcs.Planner; mcs.Journal" %>
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

<h2>Jtrk report</h2>

<div id="jtrkReport">
    <table border="1" style="width: 98%; border: #496779; border-collapse: collapse;">

        <thead>
        <td><i>Ind</i></td>
        <td><i>Total ind</i></td>
        <g:each in="${Department.list([sort: 'code'])}" var="d">
            <th>${d.code}</th>
        </g:each>
        </thead>
        <g:each in="${Indicator.findAllByCategory(19, [sort: 'code', order: 'desc'])}" var="i">

            <tr>
                <td>
                    ${i.code}
                </td>
                <td title="Total of ind">
                    ${IndicatorData.executeQuery('select sum(value) from IndicatorData where indicator = ? and date between ? and ? and department = ?',
                    [i, startDate, endDate, null])[0]}
                </td>

                <g:each in="${Department.list([sort: 'code'])}" var="d">
                    <td title="Sum of ${i.code} in ${d.code} from ${startDate} to ${endDate}">
                        ${IndicatorData.executeQuery('select sum(value) from IndicatorData where indicator = ? and date between ? and ? and department = ?',
                                [i, startDate, endDate, d])[0]}
                    </td>
                </g:each>

            </tr>
        </g:each>

        <tr>
            <td>
                <i>Total dept</i>
            </td>

            <td title="grand total">
                ${IndicatorData.executeQuery('select sum(value) from IndicatorData where date between ? and ? and department = ?',
                        [startDate, endDate, null])[0]}
            </td>

            <g:each in="${Department.list([sort: 'code'])}" var="d">
                <td title="sum of all types in ${d.code}">
    ${IndicatorData.executeQuery('select sum(value) from IndicatorData where date between ? and ? and department = ?',
            [startDate, endDate, d])[0]}

                </td>
            </g:each>
        </tr>

    </table>

</div>