<g:each in="${app.IndexCard.findAllByCourseAndWbsParentIsNull(record, [sort: 'orderNumber', order: 'asc'])}"
        var="n">
= ${n.wbsNumber} ${n.summary}
${raw(n.description)}
<g:render template="/appCourse/childrenofNotesText" model="[record: record, parent: n, level: 2]"/>
</g:each>
