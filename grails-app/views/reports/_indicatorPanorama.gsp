<%@ page import="app.Indicator" %>

<h4>Update indicators</h4>
<table border="1" style="width: 98%; border: #496779; border-collapse: collapse;">
    <thead>
    <th>K</th>
    <th>I</th>
    <th>Last value</th>
    <th>New</th>
    <th>Log</th>
    </thead>

    <g:each in="${Indicator.findAllByBookmarked(true, [sort: 'category'])}" var="i">
        <g:if test="${SupportService.indicatorLastSavedValue(i.id) != SupportService.indicatorCurrentValue(i.id)}">
             <tr>
                 <td>${i.category}</td>
                 <td>
                        <b>
                            ${i.code}
                        </b>
                     ${i.name}
                 </td>
                 <td>${SupportService.indicatorLastSavedDate(i.id)?.format('dd.MM.yyyy')}
                     :
                      ${SupportService.indicatorLastSavedValue(i.id)}</td>
                 <td>



                     <g:formRemote name="qedit" url="[controller: 'indicatorData', action: 'save']" style="display: inline;"
                                   update="${i.id}Notes" method="post">
                         <g:hiddenField name="indicator.id" value="${i.id}"/>

                         <pkm:datePicker name="date" id="field${i.id}" value="${new Date()}" style="width: 90px;"/>

                         <g:textField value="${SupportService.indicatorCurrentValue(i.id) ?: ''}" style="width: 50px; height: 20px; display: inline;"
                                   name="value"/>
                         <a onclick="jQuery('#notes${i.id}').css('display', 'inline');" style="display: inline;">+n</a>
   <g:textField value="" style="width: 300px; height: 20px; display: none;" id="notes${i.id}"
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
