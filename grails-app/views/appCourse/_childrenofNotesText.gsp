<g:if test="${app.IndexCard.countByCourseAndWbsParent(record, parent) > 0}"><g:each in="${app.IndexCard.findAllByCourseAndWbsParent(record, parent, [sort: 'orderNumber', order: 'asc'])}" var="n">
<% for (i in 1..level)  print('=')  %>  ${n.wbsNumber} ${n.summary}
${raw(n.description)}
<g:render template="/appCourse/childrenofNotesText" model="[record: record, parent: n, level: level + 1]"/></g:each></g:if>