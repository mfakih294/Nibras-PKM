
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


<g:if test="${record.class.declaredFields.name.contains('description')}">
    <g:formRemote name="appendText" url="[controller: 'generics', action: 'appendText']"
                  update="${entityCode}Record${record.id}"
                  style="display: inline;">
        <g:hiddenField name="id" value="${record.id}"/>
        <g:hiddenField name="entityCode" value="${entityCode}"/>
        <g:textField id="appendTextFor${entityCode}${record.id}" name="text" class="ui-corner-all" cols="80"
                     placeholder="Append to description..."
                     rows="5"
                     style="width:98%;  display: inline; " value=""/>
        <g:submitButton name="add" value="+=" style="display:none;"
                        class="fg-button ui-widget ui-state-default ui-corner-all navHidden"/>
    </g:formRemote>
</g:if>

<script type="text/javascript">
jQuery("#appendTextFor${entityCode}${record.id}").focus();
</script>
