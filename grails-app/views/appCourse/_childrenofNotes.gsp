%{--<g:if test="${app.IndexCard.countByCourseAndWbsParent(record, parent) > 0}">--}%
<g:if test="${app.IndexCard.executeQuery('select count (*) from IndexCard where course = ? and wbsParent = ? and priority >= 2', [record, parent])[0] > 0}">
    <ol>
        %{--<g:each in="${app.IndexCard.findAllByCourseAndWbsParent(record, parent, [sort: 'orderNumber', order: 'asc'])}" var="n">--}%
            <g:each in="${app.IndexCard.executeQuery('from IndexCard where priority >= 2 and course = ? and wbsParent = ? order by orderNumber asc' , [record, parent])}"
                    var="n">

            <li style="display: list-item;" class="mjs-nestedSortable-branch mjs-nestedSortable-expanded" id="menuItem_${n.id}">
                <div> <b color="darkbblue">${n.wbsNumber}</b> #${n.orderNumber} ${n.summary}

                    <g:remoteLink controller="page" action="panel"
                                  params="${[id: n.id, entityCode: n.entityCode()]}"
                                  update="3rdPanel"
                                  style="padding: 2px; font-size: 12px;"
                                  before=" myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0)">
                        i${n.id}
                    </g:remoteLink>

                </div>
            </li>
            <g:render template="/appCourse/childrenofNotes" model="[record: record, parent: n]"/>
        </g:each>
    </ol>
    </li>
</g:if>
<g:else>
    </li>
</g:else>




