
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


<g:if test="${record.class.declaredFields.name.contains('description')}">
    <g:formRemote name="appendText" url="[controller: 'generics', action: 'appendTextToNotes']"
                  update="${entityCode}Record${record.id}"
        onComplete="jQuery('#appendTextFor${entityCode}${record.id}').select()"
                  style="display: inline; padding: 3px; ">
        <g:hiddenField name="id" value="${record.id}"/>
        <g:hiddenField name="entityCode" value="${entityCode}"/>
        <g:textArea id="appendTextFor${entityCode}${record.id}" name="text" class="ui-corner-all appendTextFor" cols="80"
         rows="5"
                     placeholder="Notes..."
                     style="width:98%;  height: 120px; display: inline; " value=""/>
        <br/>
        <br/>
        <g:submitButton name="add" value="Append" style="width: 99%; height: 30px"
                        class="fg-button ui-widget ui-state-default ui-corner-all"/>
        <br/>
    </g:formRemote>

    <br/>
    <hr/>
    <br/>

</g:if>


<script type="text/javascript">
    jQuery('#appendTextFor${entityCode}${record.id}').focus();
    jQuery('#appendTextFor${entityCode}${record.id}').select();
</script>
