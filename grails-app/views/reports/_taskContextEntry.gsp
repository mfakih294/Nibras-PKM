
<h4>Enter tasks</h4>

<br/>
<br/>


<table border="1" style="width: 99%; border: #496779; border-collapse: collapse;">
    <thead>
    <th style="width: 10%">Context</th>
    %{--<th  style="width: 40%">Last payment date / value</th>--}%
    <th  style="width: 40%">New</th>
    <th  style="width: 10%">Log</th>
    </thead>

    <g:each in="${mcs.parameters.Context.findAll([sort: 'code'])}" var="i">
        <g:if test="${mcs.Task.countByContext(i) > 0}">
        <tr>
                 <td style="text-align: center">
                        <b>
                            ${i.code}
                        </b>

                         (${mcs.Task.countByContext(i)})

                 </td>
                <td>



                     <g:formRemote name="qedit" url="[controller: 'generics', action: 'saveTaskWithContext']" style="display: inline;"
                                   update="${i.id}Notes" method="post" onComplete="jQuery('#summaryField${i.id}').select(); jQuery('#summaryField${i.id}').focus()">

                         <g:hiddenField name="entityCode" value="t"/>
                         <g:hiddenField name="context.id" value="${i.id}"/>

                         <pkm:datePicker style="width: 60px;" name="endDate" id="field${i.id}" value="${new Date() + 3}" />

                         <g:textField id="summaryField${i.id}" style="width: 160px; display: inline;"  placeholder="summary"
                                   name="summary"/>
                         %{--<a onclick="jQuery('#notes${i.id}').css('display', 'inline');" style="display: inline;">+n</a>--}%
   %{--<g:textField value="" style="width: 300px; height: 20px; display: none;" id="notes${i.id}"--}%
                                   %{--name="summary"/>--}%
                         <g:submitButton name="create" value="${message(code: 'save', 'default': 'Save')}" style="visibility: hidden;"
                                         class="fg-button ui-widget ui-state-default ui-corner-all"/>

                     </g:formRemote>


                 </td>
                 <td>
                     <div id="${i.id}Notes"></div>
                 </td>
             </tr>
        </g:if>
       </g:each>
</table>
