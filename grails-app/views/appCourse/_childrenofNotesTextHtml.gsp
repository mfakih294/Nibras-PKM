<g:if test="${app.IndexCard.countByCourseAndWbsParent(record, parent) > 0}">
        <g:each in="${app.IndexCard.findAllByCourseAndWbsParent(record, parent, [sort: 'orderNumber', order: 'asc'])}" var="n">
            <g:if test="${(record.priority && record.priority >= 2)}">
            <h${level}> ${n.wbsNumber} ${n.summary}</h${level}>
            <div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%; ">
                ${n.descriptionHTML ? raw(n.descriptionHTML) : raw(n.description)}
            </div>
                </g:if>
            <div style="padding-left: 14px">
            <g:render template="/appCourse/childrenofNotesTextHtml" model="[record: record, parent: n, level: level + 1]"/>
            </div>
        </g:each>
</g:if>
