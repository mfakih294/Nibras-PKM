
%{--<g:each in="${Relationship.executeQuery('from Relationship where (entityA = ?) and recordA = ?',--}%
        %{--[record.entityCode(), record.id])}"--}%
        %{--status="c"--}%
        %{--var="t">--}%
    %{--<g:render template="/gTemplates/recordSummary"--}%
              %{--model="[record: mcs.Book.get(t.recordB), expanded: true]"/>--}%
%{--</g:each>--}%

<g:if test="${parent.tags}">
    <g:each in="${parent.tags?.sort(){i,j -> i.name.toLowerCase().compareTo(j.name.toLowerCase())}}" var="t">
    <g:each in="${mcs.Book.createCriteria().list() {
        tags { idEq(t.id.toLong()) }
    }}" var="record">

        <g:render template="/gTemplates/recordSummary"
    model="[record: record, expanded: true]"/>
        %{--gt('priority', 1)--}%

    </g:each>
    </g:each>
</g:if>
%{--<g:else>No tags!!! </g:else>--}%



<g:if test="${app.IndexCard.countByCourseAndWbsParent(record, parent) > 0}">
        %{--<g:each in="${app.IndexCard.findAllByCourseAndWbsParent(record, parent, [sort: 'orderNumber', order: 'asc'])}" var="n">--}%
            <g:each in="${app.IndexCard.executeQuery('from IndexCard where priority >= 2 and course = ? and wbsParent = ? order by orderNumber asc', [record, parent])}" var="n">
            %{--<g:if test="${(record.priority && record.priority >= 2)}">--}%
            %{--<h${level}> ${n.wbsNumber} - ${n.summary}</h${level}>--}%
                <a id="${n.id}"></a>

                <div class="uk-panel rtl">

                    <h${level} class="uk-panel-title uk-text-primary">
                        ${n.wbsNumber} - ${n.summary}
                    </h${level}>
                    <div class="uk-block uk-block-secondary">
                        <span class="uk-icon-quote"></span>
                        ${raw(n.description?.replace("\n", "<br/>"))}
                    </div>
                </div>


            %{--<div style="line-height: 25px; direction: rtl; text-align: justify; margin: 1% 10%; ">--}%
                %{--${n.description ? raw(n.description) : ''}--}%
                %{--${n.descriptionHTML ? raw(n.descriptionHTML) : raw(n.description)}--}%
            %{--</div>--}%
                %{--</g:if>--}%
            <div style="padding-left: 14px">
            <g:render template="/appCourse/childrenofNotesTextHtml" model="[record: record, parent: n, level: level + 1]"/>
            </div>
        </g:each>
</g:if>
