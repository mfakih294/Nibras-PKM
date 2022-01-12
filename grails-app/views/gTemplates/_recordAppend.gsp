
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


<g:if test="${record.class.declaredFields.name.contains('description')}">
    <div id="${entityCode}Record${record.id}newText"></div>
    <g:formRemote name="appendText" url="[controller: 'generics', action: 'appendText']"
                  update="${entityCode}Record${record.id}newText"
                  style="display: inline;">
        <g:hiddenField name="id" value="${record.id}"/>
        <g:hiddenField name="entityCode" value="${entityCode}"/>
        <g:textArea id="appendTextFor${entityCode}${record.id}" name="text" class="ui-corner-all" cols="80"
                     placeholder="Append to description..."
                     rows="5"
                     style="width:98%;  display: inline; height: 70px;" value=""/>
        <g:submitButton name="add" value="+" style=""
                        class="fg-button ui-widget ui-state-default ui-corner-all"/>
    </g:formRemote>
</g:if>

<script type="text/javascript">
 // jQuery("#appendTextFor${entityCode}${record.id}").focus();
</script>
