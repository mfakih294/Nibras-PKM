<%@ page import="app.Indicator" %>

<h4>Add indicator data</h4>
<i>Only indicators with updated data are shown.</i>
<br/>
<br/>


<table border="1" style="width: 98%; border: #496779; border-collapse: collapse;">
    <thead>
    <th>K</th>
    <th>I</th>
    <th>Last value</th>
    <th>New</th>
    <th>Log</th>
    </thead>

    <g:each in="${Indicator.findAll([sort: 'summary'])}" var="i">
        <g:if test="${SupportService.indicatorLastSavedValue(i.id) != SupportService.indicatorCurrentValue(i.id)}">
             <tr>
                 %{--<td>${i.category}</td>--}%
                 <td>
                        <b>
                            ${i.code}
                        </b>
                     ${i.summary}
                 </td>
                 <td>${SupportService.indicatorLastSavedDate(i.id)?.format('dd.MM.yyyy')}
                     :
                      ${SupportService.indicatorLastSavedValue(i.id)}</td>
                 <td>



                     <g:formRemote name="qedit" url="[controller: 'indicatorData', action: 'save']" style="display: inline;"
                                   update="${i.id}Notes" method="post">
                         <g:hiddenField name="indicator.id" value="${i.id}"/>

                         <pkm:datePicker name="date" id="field${i.id}" value="${new Date()}" style="width: 90px;"
                                         class="uk-input uk-width-auto"/>

                         <g:textField value="${SupportService.indicatorCurrentValue(i.id) ?: ''}" style=""
                             class="uk-input uk-width-expand"
                                   name="value"/>
                         <a onclick="jQuery('#notes${i.id}').css('display', 'inline');" style="display: inline;">with notes</a>
   <g:textField value="" style="display: none;" id="notes${i.id}"
                class="uk-input uk-width-auto"
                                   name="summary"/>


                         <g:submitButton name="create" value="${message(code: 'save', 'default': 'Save')}" style="visibility: hidden;"
                                         class="fg-button ui-widget ui-state-default ui-corner-all"/>

                     </g:formRemote>


                 </td>
                 <td>
                     <div id="${i.id}Notes"></div>
                 </td>
             </tr>
        </g:if> </g:each>
</table>
