<%@ page import="mcs.Goal; app.Payment; app.IndicatorData; mcs.parameters.JournalType; mcs.Journal; mcs.parameters.PlannerType; mcs.Planner" %>

<p>JP Level ${title}</p>


<g:if test="${level == 'd'}">

    <div style="width: 600px;">
        <h3>Focus</h3>
        <g:render template="/planner/line"
                  model="[plannerInstance:
                          Planner.findAll('from Planner where date(startDate) = date(?) and type = ? ', [date, PlannerType.get(5)])[0]]"></g:render>
    </div>

</g:if>

<g:if test="${level == 'd'}">

    <div style="width: 600px; ">
        <h3>Title</h3>
        <g:render template="/journal/line"
                  model="[journalInstance:
                          Journal.findAll('from Journal where date(startDate) = date(?) and type = ?', [date, JournalType.get(36)])[0]]"></g:render>
    </div>

</g:if>


<hr/>



%{--<div style="width: 600px;">--}%
%{--<h3>Challenges</h3>--}%
%{--<g:render template="/planner/line"--}%
%{--collection="${Planner.executeQuery('from Planner where date(startDate) = date(?) and type = ? ', date, PlannerType.get(10))}"--}%
%{--var="plannerInstance"></g:render>--}%
%{--</div>--}%
<g:if test="${level == 'd'}">

    <div style="width: 600px;">
        <h3>Summary</h3>
        <g:render template="/journal/line"
                  model="[journalInstance: Journal.findAll('from Journal where date(startDate) = date(?) and type = ? ', [date, JournalType.get(1)])[0]]"></g:render>
    </div>
</g:if>


<hr/>

<g:if test="${level == 'd'}">

    <div style="width: 600px;">
        <h3>Day payments</h3>
        <g:each in="${Payment.executeQuery('from Payment where date(date) = date(?)', [date])}" var="n">
            <g:render template="/payment/card" model="[paymentInstance: n]"></g:render>
        </g:each>
    </div>
</g:if>


<g:if test="${level == 'w'}">
    <div style="width: 600px;">
        %{--date1: Date.parse("yyyy-MM-dd", supportService.fromWeekDate(params.id.toString() + '1.11')),--}%
        %{--date2: Date.parse("yyyy-MM-dd", supportService.fromWeekDate(params.id.toString() + '7.11')),--}%
        <h3>Week Payments</h3>
        <g:each in="${Payment.executeQuery('from Payment where date >= ? and date <= ?', [startDate, endDate])}" var="n">
            <g:render template="/payment/card" model="[paymentInstance: n]"></g:render>
        </g:each>


        <h3>Week Goals</h3>
        <g:each in="${Planner.executeQuery('from Planner where startDate >= ? and endDate <= ? and goal != null', [
                startDate, endDate])}" var="n">
            <g:render template="/goal/line" model="[goalInstance: n.goal]"></g:render>
        </g:each>
    </div>

</g:if>

<g:if test="${level == 'd'}">

    <div style="width: 600px;">
        <h3>Indicators</h3>
        <g:each in="${IndicatorData.executeQuery('from IndicatorData where date(date) = date(?)', [date])}" var="n">
            <g:render template="/indicatorData/card" model="[indicatorDataInstance: n]"></g:render>
        </g:each>
    </div>

    <hr/>


    <div style="width: 600px;">

        <h3>Planners</h3>
        <g:each in="${Planner.executeQuery('from Planner where date(startDate) = date(?)', [date])}" var="n">
            <g:render template="/planner/line" model="[plannerInstance: n]"></g:render>
        </g:each>
    </div>


    <div style="width: 600px;">
        <h3>Journal</h3>
        <g:each in="${Journal.executeQuery('from Journal where date(startDate) = date(?)', [date])}" var="n">
            <g:render template="/journal/line" model="[journalInstance: n]"></g:render>
        </g:each>
    </div>

</g:if>



<g:if test="${level == 'y'}">

    <div style="width: 600px;">

        <h3>Planners</h3>
        %{--<g:each in="${Planner.executeQuery('from Planner where ((year(startDate) = year(?) and month(startDate) = month(?)) or ( year(endDate) = year(?) and month(endDate) = month(?))) and planLevel = ?',--}%
        %{--[year, month, year, month, 'M'])}" var="n">--}%
        <g:each in="${Planner.executeQuery('''from Planner where planLevel = ? and year(startDate) = ? and year(endDate) = ? ''',
                ['y', year.toInteger(), year.toInteger()])}" var="n">
            <g:render template="/planner/line" model="[plannerInstance: n]"></g:render>
        </g:each>
    </div>

</g:if>


<g:if test="${level == 'M'}">

    <div style="width: 600px;">

        <h3>Planners ${year} ${month}</h3>
        %{--<g:each in="${Planner.executeQuery('from Planner where ((year(startDate) = year(?) and month(startDate) = month(?)) or ( year(endDate) = year(?) and month(endDate) = month(?))) and planLevel = ?',--}%
        %{--[year, month, year, month, 'M'])}" var="n">--}%
        <g:each in="${Planner.executeQuery('''from Planner where planLevel = ? and year(startDate) = ? and month(startDate) = ?
and year(endDate) = ? and month(endDate) = ?''',
                ['M', year.toInteger(), month.toInteger(), year.toInteger(), month.toInteger()])}" var="n">
            <g:render template="/planner/line" model="[plannerInstance: n]"></g:render>
        </g:each>
    </div>

</g:if>