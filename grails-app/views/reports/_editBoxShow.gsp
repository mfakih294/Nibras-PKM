<%@ page import="ker.OperationController; cmn.Setting; app.IndexCard; mcs.Writing" %>


<h2>Changed records (${OperationController.getPath('editBox.path')})</h2>


<br/>
%{--Edit folder: .--}%

<g:if test="${!new File(OperationController.getPath('editBox.path')).exists()}">
    Folder does not exist. Set: <g:render template="/forms/updateSetting" model="[settingValue: 'editBox.path']"/>.
    </g:if>
<g:else>
<g:each in="${new File(OperationController.getPath('editBox.path')).listFiles()}" var="f">

    <g:if test="${f.name.endsWith('.md') && 'WN'.contains(f.name?.substring(0, 1))}">
    %{--<g:set value="${f.name.split(/\./)[0].substring(1)}" var="id"></g:set>--}%
        <g:set value="${f.name.split('-')[1].replace('.md', '')}" var="id"></g:set>

        <g:if test="${f.name?.startsWith('W')}">
            <g:set value="${Writing.get(id)?.description}" var="description"></g:set>
        </g:if>
        <g:if test="${f.name?.startsWith('N')}">
            <g:set value="${IndexCard.get(id.toLong()).description}" var="description"></g:set>
        </g:if>

        <g:if test="${f && f.text != description}">

            <div id="summary${f.name.substring(0, 1)}${id}">

                <table>

                    <tr>
                        <td colspan="2" style="text-align: left; padding: 5px; margin-top: 10px;">
                            <hr/>
                            <b>${f.name}:</b>
                            <g:render template="/gTemplates/recordSummary"
                                      model="[record: f.name?.substring(0, 1) == 'W' ? Writing.get(id) : IndexCard.get(id.toLong())]"></g:render>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <g:remoteLink controller="generics" action="commitTextChanges" id="${id}"
                                          params="[entityCode: f.name?.substring(0, 1), name: f.name]"
                                          update="summary${f.name.substring(0, 1)}${id}"
                                style="font-size: big; margin: 2px; padding: 2px"
                                          title="Commit text changes to database">
                                Commit changes &crarr;
                            </g:remoteLink>
                            <br/>
                            <br/>

                            <br/>
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 50%; vertical-align: top; text-align: justify" class="textar">
                            <br/>
                            <g:each in="${description?.split('\n')}" var="l">
                                <g:if test="${!f?.text?.contains(l)}">
                                  +  ${l} <br/> <br/>
                                </g:if>
                            </g:each>

                        </td>
                        <td style="width: 50%;  background: #CAED9E; vertical-align: top; padding: 7px; text-align: justify" class="textar">

                            <br/>
                        %{--${?.encodeAsHTML()?.replace('\n', '<br/>')}--}%

                            <g:each in="${f?.text?.split('\n')}" var="l">
                                <g:if test="${!description?.contains(l)}">
                                  +  ${l} <br/><br/>
                                </g:if>
                            </g:each>

                            <br/>
                            <g:set value="" var="description"></g:set>
                        </td>

                    </tr>

                </table>
            </div>
        </g:if>
    </g:if>

</g:each>
</g:else>
</table>


<br/>
<br/>
<br/>
<br/>
