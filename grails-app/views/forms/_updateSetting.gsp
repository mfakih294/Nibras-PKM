<%@ page import="ker.OperationController" %>


<g:formRemote name="saveSettings"
              url="[controller: 'operation', action: 'updateSettingsByName']"
              update="notificationArea" style="display: inline"
              method="post">

<g:hiddenField name="settingName" value="${settingValue}"/>
    <g:submitButton name="batch" value="Execute"
                    style="margin: 0px; display: none"
                    id="quickAddXcdSubmitTop"
                    class="fg-button ui-widget ui-state-default"/>

    <g:textField name="newValue" value="${ker.OperationController.getPath(settingValue)}"
                 autocomplete="off"
                 style="display: inline;  width: 70% !important; direction: ltr; text-align: left;"
                 placeholder="Value"
                 class=""/>


</g:formRemote>

<br/>
%{--<div id="saveResults${settingValue}12"></div>--}%