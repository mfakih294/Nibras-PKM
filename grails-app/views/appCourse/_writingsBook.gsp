
<h1>Notes</h1>
<div style="direction: rtl; text-align: justify">
<g:each in="${app.IndexCard.findAllByCourseAndWbsParentIsNull(record, [sort: 'orderNumber', order: 'asc'])}"
        var="n">
    <h2>  ${n.wbsNumber} ${n.summary}</h2>
    <div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%; ">
        %{--${n.description}--}%
        ${raw(n.description?.replace("\n", "<br/>"))}
    </div>

    <div style="padding-left: 14px">
        <g:render template="/appCourse/childrenofNotesText" model="[record: record, parent: n, level: 3]"/>
    </div>
</g:each>
</div>