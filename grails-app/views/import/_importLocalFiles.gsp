<%@ page import="org.apache.commons.lang.StringUtils; ker.OperationController; app.parameters.ResourceType; cmn.Setting; mcs.parameters.PlannerType; mcs.parameters.JournalType; mcs.Planner; mcs.Journal; mcs.parameters.ResourceStatus; mcs.Book" %>


<br/><br/>

%{--Update value of 'root.rps1.path': <br/>--}%
%{--<g:render template="/forms/updateSetting" model="[settingValue: 'root.rps1.path']"/>--}%
%{----}%
%{--<br/>--}%
%{--<br/>--}%





<table border="0" style="border-collapse: collapse; width: 95%">

    <tr>
        <td style="vertical-align: top">

            <h4>Folders and files found (in <b>${OperationController.getPath('root.rps1.path')})</b> :</h4>
            <g:if test="${Setting.findByName('root.rps1.path') && new File(OperationController.getPath('root.rps1.path')).exists()}">

                <g:each in="${new java.io.File(OperationController.getPath('root.rps1.path')).listFiles()}" var="i">
                    <g:if test="${i.isDirectory() && i.name ==~ /(?i)[a-z] [\S\s ;-_]*/}">
                        <br/>
                        <br/>
                        <div style="display: inline; font-family: monospace;" id="file${i.name.encodeAsMD5()}">
                            <g:formRemote name="importIndividualFolder"
                                          style="display: inline; "
                                          url="[controller: 'import', action: 'importIndividualFolder']"
                                          update="file${i.name.encodeAsMD5()}"
                                          onComplete="jQuery('#quickAddXcdField').val('')"
                                          method="post">

                                <g:hiddenField name="entityCode"
                                               value="${i.name?.substring(0, 1)?.toUpperCase()}"></g:hiddenField>
                                <g:hiddenField name="type" value="${null}"></g:hiddenField>
                                <g:hiddenField name="name" value="${i.name}"></g:hiddenField>
                                <g:hiddenField name="smart" value="yes"></g:hiddenField>
                                <g:hiddenField name="path" value="${i.path}"></g:hiddenField>
                                <g:hiddenField name="rootPath" value="${rootPath}"></g:hiddenField>

                                <g:actionSubmit value="add"/>





                                <script>
                                    jQuery("#notificationAreaHidden").load('/nibras/generics/verifySmartFileName', {'line': "${i.name}"}, function (response, status, xhr) {
                                        jQuery("#${i.name.encodeAsMD5()}").attr('class', response);
                                    })
                                </script>

                            </g:formRemote>
                        </div>
                        <span style="display: inline; font-family: monospace;"
                              id="${i.name.encodeAsMD5()}">${i.name}
                        </span>
                    </g:if>
      </g:each>



                <g:each in="${files}"
                        var="i">

                    <g:if test="${i.isFile() && i.name?.contains(' ')}">
                        <br/><br/>

                        <div style="display: inline; font-family: monospace;" id="file${i.name.encodeAsMD5()}">
                            <g:formRemote name="importIndividualFile"
                                          url="[controller: 'import', action: 'importIndividualFile']"
                                          update="file${i.name.encodeAsMD5()}"
                                          style="display: inline; "
                                          onComplete="jQuery('#quickAddXcdField').val('')"
                                          method="post">
                                <g:hiddenField name="entityCode"
                                               value="${i.name?.substring(0, 1)?.toUpperCase()}"></g:hiddenField>
                                <g:hiddenField name="type" value="${null}"></g:hiddenField>
                                <g:hiddenField name="name" value="${i.name}"></g:hiddenField>
                                <g:hiddenField name="smart" value="yes"></g:hiddenField>
                                <g:hiddenField name="path" value="${i.path}"></g:hiddenField>
                                <g:hiddenField name="rootPath" value="${rootPath}"></g:hiddenField>

                                <g:actionSubmit value="import"/>





                                <script>
                                    jQuery("#notificationAreaHidden").load('/nibras/generics/verifySmartFileName', {'line': "${i.name}"}, function (response, status, xhr) {
                                        jQuery("#${i.name.encodeAsMD5()}").attr('class', response);
                                    })

                                </script>

                            </g:formRemote>
                        </div>

                        <span style="display: inline; font-family: monospace;"
                              id="${i.name.encodeAsMD5()}">
                            ${i.name}
                        </span>
                    </g:if>

                </g:each>
            %{--</ul>--}%
            </g:if>
            <g:else>
                <i style="color: red">Setting name 'root.rps1.path' is not defined or folder not exits.
                </i>
                <br/>
            </g:else>

        </td>

    </tr>

</table>

