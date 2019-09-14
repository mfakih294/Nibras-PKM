<%@ page import="app.Payment; app.IndicatorData; mcs.parameters.JournalType; mcs.Journal; mcs.parameters.PlannerType; mcs.Planner" %>
<h1>${title}</h1>

%{--<div style="width: 300px; float: left;">--}%
%{--<h3>Focuses</h3>--}%
%{--<g:render template="/planner/line" model="[plannerInstance: Planner.executeQuery('from Planner where date(startDate) = date(?) and type = ? ', date, PlannerType.get(5))[0]]"></g:render>--}%
%{--</div>--}%

%{--<div style="width: 300px; float: left;">--}%
%{--<h3>Titles</h3>--}%
%{--<g:render template="/journal/line" model="[journalInstance: Journal.executeQuery('from Journal where date(startDate) = date(?) and type = ? ', date, JournalType.get(36))[0]]"></g:render>--}%
%{--</div>--}%

%{--<div style="clear: both;"></div>--}%

%{--<hr/>--}%

%{--<div style="width: 300px; float: left;">--}%
%{--<h3>Challenges</h3>--}%
%{--<g:render template="/planner/line" collection="${Planner.executeQuery('from Planner where date(startDate) = date(?) and type = ? ', date, PlannerType.get(10))}" var="plannerInstance"></g:render>--}%
%{--</div>--}%

%{--<div style="width: 300px; float: left;">--}%
%{--<h3>Summaries</h3>--}%
%{--<g:render template="/journal/line" model="[journalInstance: Journal.executeQuery('from Journal where date(startDate) = date(?) and type = ? ', date, JournalType.get(1))[0]]"></g:render>--}%
%{--</div>--}%

%{--<div style="clear: both;"></div>--}%

%{--<hr/>--}%



%{--<div style="width: 300px; float: left;">--}%
%{--<h3>Indicators</h3>--}%
%{--<g:each in="${IndicatorData.executeQuery('from IndicatorData where date(date) = date(?)', date)}" var="n">--}%
%{--<g:render template="/indicatorData/card" model="[indicatorDataInstance: n]"></g:render>--}%
%{--</g:each>--}%
%{--</div>--}%

%{--<div style="clear: both;"></div>--}%

%{--<hr/>--}%


%{--<div style="width: 300px; float: left;clear: both;">--}%

%{--<h3>Decisions</h3>--}%
%{--<g:each in="${list2}" var="n">--}%
%{--<g:render template="/planner/line" model="[plannerInstance: n]"></g:render>--}%
%{--</g:each>--}%
%{--</div>--}%

%{--<div style="width: 300px; float: left;">--}%
%{--<h3>Statements and achievements</h3>--}%
%{--<g:each in="${list1}" var="n">--}%
%{--<g:render template="/journal/line" model="[journalInstance: n]"></g:render>--}%
%{--</g:each>--}%
%{--</div>--}%

