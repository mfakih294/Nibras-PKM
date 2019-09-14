<%@ page import="mcs.Writing; mcs.Book" %>
<g:set var="entityCode"  value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>
<g:set var="recordId"  value="${record.id}"/>
<g:set var="language"  value="${(entityCode == 'R' ? record.language : 'ar')}"/>


<div class="recordDetailsBody" style="margin-left: 5px;" id="detailsRegion${entityCode}${record.id}">

<div id="panelComments${entityCode}Record${record.id}">

%{--<h4>Attach index card</h4> entityCode != 'Bx' && entityCode != 'Wx' &&  --}%
    <g:if test="${entityCode != 'C'}">

        <g:formRemote name="save" url="[controller: 'indexCard', action: 'attach']" update="panelComments${entityCode}Record${recordId}" method="post"
                      onComplete="">


            <g:if test="${writingId || bookId}">

                <div class="dialog">
                    <g:render template="/indexCard/form" model="[indexCardInstance: indexCardInstance, writingId: writingId, bookId: bookId, language: language]"/>
                </div>


            </g:if>
            <g:else>
                <g:hiddenField name="entityCode" value="${entityCode}"></g:hiddenField>
                <g:hiddenField name="recordId" value="${recordId}"></g:hiddenField>

                <div class="dialog">
                    <g:render template="/indexCard/form" model="[indexCardInstance: indexCardInstance]"/>
                </div>


            </g:else>


            <g:submitButton name="create" value="${message(code: 'save', 'default': 'Save')}"
                            class="fg-button ui-widget ui-state-default ui-corner-all"/>
        </g:formRemote>

    </g:if>



    <g:if test="${entityCode && recordId}">

        <g:each in="${app.IndexCard.findAllByEntityCodeAndRecordId(entityCode, recordId, [sort: 'dateCreated', order: 'desc'])}"
                var="c">
            <g:render template="/gTemplates/box" model="[record: c]"/>
        </g:each>
    </g:if>

    <g:if test="${writingId && Writing.get(writingId) != null}">
        <g:each in="${app.IndexCard.findAllByWriting(Writing.get(writingId), [sort: 'dateCreated', order: 'asc'])}"
                var="c">
            <g:render template="/gTemplates/box" model="[record: c]"/>
        </g:each>
    </g:if>

    <g:if test="${bookId && Book.get(bookId) != null}">

        <g:each in="${app.IndexCard.findAllByBook(Book.get(bookId), [sort: 'dateCreated', order: 'asc'])}" var="c">
            <g:render template="/gTemplates/box" model="[record: c]"/>
        </g:each>
    </g:if>



</div>


</div>
