<%@ page import="app.IndexCard" %>
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>

<div class="recordDetailsBody" style="margin-left: 5px; margin-bottom: 40px;" id="detailsRegion${entityCode}${record.id}">

<div id="panelComments${entityCode}Record${record.id}">
    <g:render template="/indexCard/add"
              model="[indexCardInstance: new app.IndexCard(), recordId: record.id,
                      bookId: (entityCode == 'R' ? record.id : null),
                      recordEntityCode: entityCode, language: record.language]"/>
</div>


<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


</div>