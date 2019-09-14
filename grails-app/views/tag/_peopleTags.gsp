<div id="contacts${entity}${instance.id}" style="display: inline;">
    <g:if test="${instance.people}">
        <g:each in="${instance.people?.sort(){i,j -> i.name.toLowerCase().compareTo(j.name.toLowerCase())}}" var="t">
            &nbsp;  <span style="display:inline; padding: 1px; font-size: small; background:#d3e0d3" class="ui-corner-all">


                <i>${t?.code}</i>


            <g:remoteLink controller="generics" action="removeContactFromRecord" id="${instance.id}" update="contacts${entity}${instance.id}"
                          params="[tagId: t.id, recordId: instance.id, entityCode: entity]"
                          before="if(!confirm('Are you sure you want to remove the contact from the record? The contact record itself will NOT be deleted')) return false"
                          title="Remove contact" style="font-size: smaller">x</g:remoteLink>

        </span>
        </g:each>
    </g:if>
</div>