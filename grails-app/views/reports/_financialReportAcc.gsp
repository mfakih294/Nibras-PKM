<%@ page import="app.Payment;app.PaymentCategory; mcs.Department; mcs.Planner; mcs.Journal" %>
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

<h2>T acc Report</h2>

<div id="jtrkReport">
    <table border="1" style="width: 98%; border: #496779; border-collapse: collapse;">

        <thead>

        <g:each in="${PaymentCategory.findAllByCategory('acc', [sort: 'code'])}" var="d">
            <th>${d.code}</th>
        </g:each>
        </thead>


<g:each in="${(0..4)}" var="off">


            <tr>
    <g:each in="${PaymentCategory.findAllByCategory('acc', [sort: 'code'])}" var="d">
                <td title="last ith statement of acc">
                    ${Payment.executeQuery('select amount from Payment where category = ? order by date desc',
                    [d], [offset: off])[0]}

                    ${Payment.executeQuery('select date from Payment where category = ? order by date desc',
                            [d], [offset: off])[0]?.format('dd.MM.yyyy')}

                </td>
    </g:each>
            </tr>


      </g:each>
        </tr>

    </table>

</div>

