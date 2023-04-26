<%@ page import="ker.OperationController" %>

<span style="color: white; border: 1px darkgray solid;     background: #536B78;    padding: 1px 4px 1px 4px;    border-radius: 5px;    margin: 3px;">
<b>  IP:</b>
&nbsp;
<g:each in="${ips}" var="ip">

    <span title="${ip.name}"> ${ip.ip}</span>
%{--    vs .title ?--}%
%{--    (${ip.name})--}%
    &nbsp; &nbsp;
</g:each>

    </span>
<span style="color: white; border: 1px darkgray solid;     background: #536B78;    padding: 1px 4px 1px 4px;    border-radius: 5px;    margin: 3px;">
<b>Last mobile sync:</b>
<pkm:prettyDuration date1="${Date.parse('dd.MM.yyyy HH:mm', ker.OperationController.getPath('lastMobileSync'))}"/>
%{--<pkm:prettyDuration date1="${new Date()}" />--}%

</span>