<%@ page import="mcs.Planner; mcs.Task; mcs.parameters.SavedSearch" %>


<g:each in="${SavedSearch.findAllByOnHomepage(true, [sort: 'entity', order: 'desc'])}" var="s">
    <g:if test="${s.queryType == 'adhoc'}">
        <g:render template='/reports/adHocQueryResults' model="[
                list: Task.executeQuery(s.query), ssId: s.id,
                title: s.summary + (s.countQuery ? ' (' + Task.executeQuery(s.countQuery)[0] + ')' : '')]"/>
    </g:if>

</g:each>