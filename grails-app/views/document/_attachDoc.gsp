<h1>Attach new document</h1>

<g:form controller="document" action="save" method="post" enctype="multipart/form-data">
    <div class="dialog">
        %{--Documents are stored in Alfresco in the folder REFA/tasks/task_id --}%
        <table id="tablelist">
            <tbody>
            <tr class="prop"><td valign="top">
                <label for="name"><g:message code="document.name" default="Name"/></label>
                <g:textField name="name" value=""/>
            </td></tr><!--/g:ifAnyGranted-->

            <tr class="prop"><td valign="top">
                <label for="description"><g:message code="document.description"
                                                    default="Description"/> (optional)</label>
                <g:textArea name="description" rows="5" cols="40" value=""/>
            </td></tr>

            <tr><td>
                <label for="file">File:</label>
                <input type="file" name="document" id="document" style="width:200px;"/>
                <br/>
            </td></tr>
            <tr><td>
                <input type="hidden" name="recordId" value="${recordId}"/>
                <input type="hidden" name="entityId" value="4"/> <!-- todo p3 -->
                <input type="hidden" name="applicationCode" value="mrq"/>

            </td>
            </tr>
        </table>
    </div>
    <g:submitButton name="create" value="${message(code: 'save', 'default': 'Save')}"
                    class="fg-button ui-widget ui-state-default ui-corner-all"/>
</g:form>
          

