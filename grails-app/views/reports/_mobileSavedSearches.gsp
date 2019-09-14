<%@ page import="mcs.Task; mcs.parameters.SavedSearch" %>


<g:each in="${SavedSearch.findAllByOnMobile(true, [sort: 'entity', order: 'asc'])}" var="s">

    <g:if test="${s.queryType == 'hql'}">
        <g:render template='/gTemplates/recordListingBox' model="[mobileView: true,
                list: Task.executeQuery(s.query, [max: 50]), ssId: s.id,
                title: s.summary + (s.countQuery ? '(' + Task.executeQuery(s.countQuery)[0] + ')' : '')]"/>
    </g:if>
    <g:if test="${s.queryType == 'adhoc'}">
        <g:render template='/reports/adHocQueryResults' model="[
                list: Task.executeQuery(s.query, [max: 50]), ssId: s.id,
                title: s.summary + (s.countQuery ? '(' + Task.executeQuery(s.countQuery)[0] + ')' : '')]"/>
    </g:if>

</g:each>