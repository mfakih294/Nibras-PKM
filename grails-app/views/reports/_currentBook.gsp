<g:each in="${mcs.Course.executeQuery('from Course c where c.bookmarked = 1').department.unique().sort({i, j -> if (i.orderNumber && j.orderNumber){ i.orderNumber?.compareTo(j.orderNumber)}  else 0})}" var="d">

# ${d.summary}

## المهام
<g:each in="${mcs.Task.executeQuery('from Task p where p.bookmarked = 1 and  p.department = ? and p.course = null order by p.priority desc',
    [d])}"
    var="p">
<g:render template="/gTemplates/recordEntryInCurrentBook" model="[record: p, expanded: true]"></g:render>
</g:each>
## الموارد
<g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.department = ? and p.course = null order by p.priority desc',
    [d])}"
    var="p">
<g:render template="/gTemplates/recordEntryInCurrentBook" model="[record: p, expanded: true]"></g:render>
</g:each>
## الأهداف
<g:each in="${mcs.Book.executeQuery('from Book p where p.bookmarked = 1 and p.department = ? and p.course = null order by p.priority desc',
    [d])}"
    var="p">
<g:render template="/gTemplates/recordEntryInCurrentBook" model="[record: p, expanded: true]"></g:render>
</g:each>
## الملاحظات
<g:each in="${mcs.Book.executeQuery('from IndexCard p where p.bookmarked = 1 and p.department = ? and p.course = null order by p.priority desc',
    [d])}"
    var="p">
<g:render template="/gTemplates/recordEntryInCurrentBook" model="[record: p, expanded: true]"></g:render>
</g:each>
## الكتابات
<g:each in="${mcs.Book.executeQuery('from Writing p where p.bookmarked = 1 and p.department = ? and p.course = null order by p.priority desc',
    [d])}"
    var="p">
<g:render template="/gTemplates/recordEntryInCurrentBook" model="[record: p, expanded: true]"></g:render>
</g:each>
<g:if test="${mcs.Course.executeQuery('select count(*) from Course c where c.bookmarked = 1 and c.department = ?', d)[0] == 0}">
__No bookmarked courses.__
</g:if>
<g:else>
<g:each in="${mcs.Course.executeQuery('from Course c where c.bookmarked = 1 and c.department = ? order by c.department.code', [d])}"
        var="c">
## ${c.summary}
</g:each>
</g:else>
</g:each>

