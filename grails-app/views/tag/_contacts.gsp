<div id="contacts${entity}${instance.id}" style="display: inline;">
    <g:if test="${instance.contacts}">
        <g:each in="${instance.contacts?.sort(){i,j -> i.summary.toLowerCase().compareTo(j.summary.toLowerCase())}}" var="t">
            &nbsp;  <div style=" display:inline; color: darkolivegreen; padding: 1px; margin-right: 3px; font-size: 11px; border: 1px solid #808080; border-radius: 4px;"
                         class="ui-corner-all">

                <i>${t?.summary}</i>


            <g:remoteLink controller="generics" action="removeContactFromRecord" id="${instance.id}"
                          update="contacts${entity}${instance.id}"
                          params="[tagId: t.id, recordId: instance.id, entityCode: entity]"
                          before="if(!confirm('Are you sure you want to remove the contact from the record? The contact itself will NOT be deleted')) return false"
                          title="remove contact" style="font-size: smaller">x</g:remoteLink>

        </div>
        </g:each>
    </g:if>
</div>