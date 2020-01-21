<div id="tags${entity}${instance.id}" style="display: inline;  ">
    <g:if test="${instance.tags}">
        <g:each in="${instance.tags?.sort(){i,j -> i.name.toLowerCase().compareTo(j.name.toLowerCase())}}" var="t">
            &nbsp;  <div style=" display:inline; padding: 0px; margin-top: 1px; margin-right: 1px; font-size: 12px; border: 1px solid #808080; border-radius: 4px;" class="ui-corner-all">
            <g:if test="${t?.bookmarked == true}">
                <b>${t?.name}</b>
            </g:if>
            <g:else>
                <i>${t?.name}</i>
            </g:else>
&nbsp;
            %{--before="if(!confirm('Are you sure you want to remove the tag from the record? The tag itself will NOT be deleted')) return false"--}%
            <g:remoteLink controller="generics" action="removeTagFromRecord" id="${instance.id}" update="tags${entity}${instance.id}"
                          params="[tagId: t.id, recordId: instance.id, entityCode: entity]"
                          title="Remove tag ${t.id} ${t?.name}" style="font-size: smaller">x</g:remoteLink>

        </div>
        </g:each>
    </g:if>
</div>