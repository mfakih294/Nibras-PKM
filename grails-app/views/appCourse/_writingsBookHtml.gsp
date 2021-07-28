
<h1>Notes</h1>
<div style="direction: rtl; text-align: justify">
<g:each in="${app.IndexCard.findAllByCourseAndWbsParentIsNull(record, [sort: 'orderNumber', order: 'asc'])}"
        var="n">
    <g:if test="${(record.priority && record.priority >= 2)}">
    <h2>  ${n.wbsNumber} [${n.id}] ${n.summary}</h2>
    <div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%;">
        %{--${n.description}--}%
        ${n.descriptionHTML ? raw(n.descriptionHTML) : raw(n.description?.replace("\n", "<br/>"))}
    </div>
    </g:if>
    <div style="padding-left: 14px">
        <g:render template="/appCourse/childrenofNotesTextHtml" model="[record: record, parent: n, level: 3]"/>
    </div>
</g:each>
</div>