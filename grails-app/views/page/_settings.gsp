<div class="message">
    <g:message code="help.settings"></g:message>
</div>


    <g:each in="${full == false ? cmn.Setting.findAllByBookmarked(true, [sort: 'name']) : cmn.Setting.findAll([order: 'name'])}">
            <b>${it.name}</b>  :<br/>

            <g:formRemote name="saveSettings"
                          url="[controller: 'operation', action: 'updateSettings', id: it.id]"
                          update="saveResults${it.id}" style="display: inline"
                          method="post">

            %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
                <g:submitButton name="batch" value="Execute"
                                style="margin: 0px; display: none"
                                id="quickAddXcdSubmitTop"
                                class="fg-button ui-widget ui-state-default"/>

                <g:textField name="newValue" value="${it.value}"
                             autocomplete="off"
                             style="display: inline;  width: 100% !important; direction: ltr; text-align: left;"
                             placeholder="Value"
                             class=""/>

                <span style="color: darksalmon"> ${it.description? 'Allowed values: ' + it.description : ''}
                </span>
                <div id="saveResults${it.id}"></div>

            </g:formRemote>



            <br/>
        </g:each>