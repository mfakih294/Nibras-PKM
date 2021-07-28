<div class="message">
    <g:message code="help.settings"></g:message>
</div>

<style>
    .row-even{
       background: lightgrey;
        padding: 2px;
    }
    .row-odd{
        padding: 2px;
    }
</style>

    <g:each in="${full == false ? cmn.Setting.findAllByBookmarked(true, [sort: 'name']) : cmn.Setting.findAll([sort: 'name'])}" var="it" status="i">
        <div class="row-${i % 2 == 0 ? 'even': 'odd'}">

            <table border="0" style="border-collapse: collapse; width: 99%">
                <tr>
                    <td width="25%" style="width: 25%; max-width: 25%;">     <b>${it.name}</b>:</td>
                    <td width="75%" style="">

                        <g:formRemote name="saveSettings"
                                          url="[controller: 'operation', action: 'updateSettings', id: it.id]"
                                          update="saveResults${it.id}" style="display: inline"
                                          method="post">

                    %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%

                            <g:if test="${it.allowedValues}">
                                <g:select name="newValue" from="${it.allowedValues?.split(',')}" value="${it.value}"
                                          style="overflow: visible; z-index: 200" noSelection="${['0': '']}"/>
                            </g:if>
                            <g:else>
                                <g:textField name="newValue" value="${it.value}"
                                             autocomplete="off"
                                             style="display: inline; direction: ltr; text-align: right; "
                                             placeholder="Value"
                                             class=""/>
                            </g:else>

                            <g:textField name="allowedValues" value="${it.allowedValues ?: 'yes,no'}"
                                         autocomplete="off"
                                         style="display: inline; direction: ltr; text-align: right; "
                                         placeholder="allowedValues"
                                         class=""/>
                        <g:textField name="description" value="${it.description}"
                                         style="display: inline; direction: ltr; text-align: right; "
                                         placeholder="description"
                                         class=""/>


                                %{--String explanation--}%

                        <g:submitButton name="batch" value="Save"
                                        style="margin: 0px; display: inline!important;"
                                        id="quickAddXcdSubmitTop"
                                        class="fg-button ui-widget ui-state-default"/>

                        <span style="color: darksalmon">
                        </span>
                        <div id="saveResults${it.id}"></div>

                    </g:formRemote>


                        <g:remoteLink controller="generics" action="physicalDelete"
                                      params="${[id: it.id, entityCode: 'Y']}" style="display: inline;;"
                                      update="YRecord${it.id}"
                                      before="if(!confirm('Are you sure you want to permanantly physically delete the record?')) return false"
                                      title="Delete record permanantly">
                            x
                        </g:remoteLink>
                        <span id="YRecord${it.id}"></span>

                    </td>
                </tr>
            </table>


        </div>



        </g:each>