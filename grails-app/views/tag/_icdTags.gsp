<div id="tags${instance.id}" style="display: block;">
    <g:if test="${instance.tags}">
        <g:each in="${instance.tags}" var="t">
        %{--<g:formRemote name="removeTag" url="[controller: 'tag', action:'removeTagFromNews']" update="tags${instance.id}"--}%
        %{--style="display: inline">--}%
        %{--<g:hiddenField name="tagId" value="${t.id}"/>--}%
        %{--<g:hiddenField name="newsId" value="${instance.id}"/>--}%
        %{--<g:submitButton name="delete" value="x"/>--}%
        %{--</g:formRemote>--}%
            <span style="display:inline; background:#f5f2f2">
                <g:remoteLink controller="tag" action="removeTagFromIcd" id="${instance.id}" update="tags${instance.id}"
                              params="[tagId: t.id, icdId: instance.id]" title="remove tag">x</g:remoteLink>
                %{--onclick="return confirm('Are you sure to delete the tag?');"--}%
                ${t?.name}
            </span><br/>
        </g:each>
    </g:if>
</div>
