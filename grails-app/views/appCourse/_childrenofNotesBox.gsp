<g:if test="${app.IndexCard.countByCourseAndWbsParent(record, parent) > 0}">
        <g:each in="${app.IndexCard.findAllByCourseAndWbsParent(record, parent, [sort: 'orderNumber', order: 'asc'])}" var="n">
            <g:render template="/gTemplates/box" model="[record: n]"/>
            <div style="padding-left: 14px">
            <g:render template="/appCourse/childrenofNotesBox" model="[record: record, parent: n]"/>
            </div>
        </g:each>
</g:if>




