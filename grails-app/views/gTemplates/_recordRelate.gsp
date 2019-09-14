<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


<div class="recordDetailsBody" style="margin-left: 5px;" id="relationshipRegion${entityCode}${record.id}">



    <g:if test="${entityCode.length() == 1}">
        <!--br/><b>Relate</b-->
        <br/>
        <span id="addRelationship${record.id}" style="display: inline;">
            <g:render template="/gTemplates/addRelationships"
                      model="[record: record, entity: entityCode]"/>
        </span>
    </g:if>

</div>