<%@ page import="java.nio.file.Paths; java.nio.file.Files; org.apache.commons.lang.StringUtils; ker.OperationController; app.parameters.ResourceType; cmn.Setting; mcs.parameters.PlannerType; mcs.parameters.JournalType; mcs.Planner; mcs.Journal; mcs.parameters.ResourceStatus; mcs.Book" %>


<br/><br/>

%{--Update value of 'root.rps1.path': <br/>--}%
%{--<g:render template="/forms/updateSetting" model="[settingValue: 'root.rps1.path']"/>--}%
%{----}%
%{--<br/>--}%
%{--<br/>--}%





<table border="0" style="border-collapse: collapse; width: 95%">

    <tr>
        <td style="vertical-align: top">
<g:each in="${1..3}" var="r">
    <g:if test="${Setting.findByName('root.rps' + r + '.path') && new File(OperationController.getPath('root.rps' + r + '.path')).exists()}">
        <h4>Folders and files in <b>${OperationController.getPath('root.rps' + r + '.path')}/new</b>:</h4>
        <g:each in="${new java.io.File(OperationController.getPath('root.rps' + r + '.path') + '/new').listFiles()}" var="i">

            <g:if test="${i.isFile() && !java.nio.file.Files.isSymbolicLink(java.nio.file.Paths.get(i.path)) && i.name ==~ /(?i)[a-z] [\S\s ;-_]*\.[\S]*/ && i.name?.contains('--')}">
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
                        <g:hiddenField name="rootPath" value="${OperationController.getPath('root.rps' + r + '.path')}"></g:hiddenField>
                        <g:actionSubmit value="import" class="uk-button-secondary"/>
                        <script>
                            jQuery("#notificationAreaHidden").load('${request.contextPath}/generics/verifySmartFileName', {'line': "${i.name}"}, function (response, status, xhr) {
                                jQuery("#${i.name.encodeAsMD5()}").attr('class', response);
                            })
                        </script>
                    </g:formRemote>
                </div>
                <span style="display: inline; font-family: monospace;"
                      id="${i.name.encodeAsMD5()}">
                    ${i.name}
                </span>
                <br/>
                <hr/>
                <br/>
            </g:if>


            <g:if test="${i.isFile() && !java.nio.file.Files.isSymbolicLink(Paths.get(i.path)) && !i.name?.contains('--') && !'desktop.ini,'.contains(i.name + ',')}">
                <div style="display: inline; font-family: monospace;" id="file${i.name.encodeAsMD5()}">
                    <g:formRemote name="importIndividualFile"
                                  url="[controller: 'import', action: 'importIndividualFile']"
                                  update="file${i.name.encodeAsMD5()}"
                                  style="display: inline; "
                                  onComplete="jQuery('#quickAddXcdField').val('')"
                                  method="post">
                        <g:hiddenField name="entityCode"
                                       value="R"></g:hiddenField>
                        <g:hiddenField name="type" value="${null}"></g:hiddenField>
                        <g:hiddenField name="name" value="r #doc -- ${i.name}"></g:hiddenField>
                        <g:hiddenField name="smart" value="yes"></g:hiddenField>
                        <g:hiddenField name="path" value="${i.path}"></g:hiddenField>
                        <g:hiddenField name="rootPath" value="${OperationController.getPath('root.rps' + r + '.path')}"></g:hiddenField>
                        <g:actionSubmit value="import"
                                        class="uk-button-secondary"/>
                    </g:formRemote>
                </div>
                <span style="display: inline; font-family: monospace;"
                      id="${i.name.encodeAsMD5()}">
                    ${i.name}
                </span>
                <hr/>
                <br/>
            </g:if>


            <g:if test="${i.isDirectory() && !java.nio.file.Files.isSymbolicLink(Paths.get(i.path)) && i.name ==~ /(?i)[a-z] [\S\s ;-_]*/  && i.name?.contains('--') && i.name?.length() > 1 && !i.name?.startsWith('.')  && !'scans,later,raw,site,dmp,sns,sch,mbl,'.contains(i.name + ',')}">
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
                        <g:hiddenField name="rootPath" value="${OperationController.getPath('root.rps' + r + '.path')}"></g:hiddenField>
                        <g:actionSubmit value="add" class="uk-button-secondary"/>
                        <script>
                            jQuery("#notificationAreaHidden").load('${request.contextPath}/generics/verifySmartFileName', {'line': "${i.name}"}, function (response, status, xhr) {
                                jQuery("#${i.name.encodeAsMD5()}").attr('class', response);
                            })
                        </script>
                    </g:formRemote>
                </div>
                <span style="display: inline; font-family: monospace;"
                      id="${i.name.encodeAsMD5()}">${i.name}
                </span>
                <hr/>
                <br/>
            </g:if>

            <g:if test="${i.isDirectory() && !java.nio.file.Files.isSymbolicLink(Paths.get(i.path)) && !i.name?.contains('--') && i.name?.length() > 1  && !i.name?.startsWith('.')  && !i.name?.startsWith('.')  && !'scans,later,raw,'.contains(i.name + ',')}">
                <div style="display: inline; font-family: monospace;" id="file${i.name.encodeAsMD5()}">
                    <g:formRemote name="importIndividualFolder"
                                  style="display: inline; "
                                  url="[controller: 'import', action: 'importIndividualFolder']"
                                  update="file${i.name.encodeAsMD5()}"
                                  onComplete="jQuery('#quickAddXcdField').val('')"
                                  method="post">
                        <g:hiddenField name="entityCode"
                                       value="R"></g:hiddenField>
                        <g:hiddenField name="type" value="${null}"></g:hiddenField>
                        <g:hiddenField name="name" value="r #doc -- ${i.name}"></g:hiddenField>
                        <g:hiddenField name="smart" value="yes"></g:hiddenField>
                        <g:hiddenField name="path" value="${i.path}"></g:hiddenField>
                        <g:hiddenField name="rootPath" value="${OperationController.getPath('root.rps' + r + '.path')}"></g:hiddenField>
                        <g:actionSubmit value="add" class="uk-button-secondary"/>
                    </g:formRemote>
                </div>
                <span style="display: inline; font-family: monospace;"
                      id="${i.name.encodeAsMD5()}">${i.name}
                </span>
                <hr/>
                <br/>
            </g:if>
        </g:each>


        <g:if test="${1==2}">
            <g:each in="${files}"
                    var="i">

                <g:if test="${i.isFile() && i.name?.contains(' ')}">
                    <br/>

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
                            <g:hiddenField name="rootPath" value="${OperationController.getPath('root.rps' + r + '.path')}"></g:hiddenField>
                            <g:actionSubmit value="import" class="uk-button-secondary"/>
                            <script>
                                jQuery("#notificationAreaHidden").load('${request.contextPath}/generics/verifySmartFileName', {'line': "${i.name}"}, function (response, status, xhr) {
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

    </g:if>


            <g:else>
                <i style="color: red">Setting name 'root.rps${r}.path' /new is not defined or folder does not exit.
                </i>
                <hr/>
                <br/>
            </g:else>
</g:each>
        </td>

    </tr>

</table>

