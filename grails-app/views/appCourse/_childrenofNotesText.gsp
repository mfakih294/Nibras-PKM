<g:if test="${app.IndexCard.countByCourseAndWbsParent(record, parent) > 0}">
        <g:each in="${app.IndexCard.findAllByCourseAndWbsParent(record, parent, [sort: 'orderNumber', order: 'asc'])}" var="n">
            <h${level}> ${n.wbsNumber} ${n.summary}</h${level}>
            <div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%; ">
                ${raw(n.description?.replace("\n", "<br/>"))}
            </div>
            <div style="padding-left: 14px">
            <g:render template="/appCourse/childrenofNotesText" model="[record: record, parent: n, level: level + 1]"/>
            </div>
        </g:each>
</g:if>
