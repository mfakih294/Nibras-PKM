<%@ page import="mcs.Journal" %>

<h4>Enter journal</h4>

<br/>
<br/>


<table border="1" style="width: 99%; border: #496779; border-collapse: collapse;">
    <thead>
    <th style="width: 10%">Type</th>
    %{--<th  style="width: 40%">Last payment date / value</th>--}%
    <th  style="width: 40%">New</th>
    <th  style="width: 10%">Log</th>
    </thead>

    <g:each in="${mcs.Journal.executeQuery('select count(*), j.type from Journal j group by j.type order by count(*) desc')}" var="j">
        <g:set var="i" value="${j[1]}"></g:set>
        <g:if test="${mcs.Journal.countByType(i) > 14}">
        <tr>
                 <td style="text-align: center">

                     ${i.name}
                     <b>
                            ${i.code}

                        </b>

                         (${mcs.Journal.countByType(i)})

                 </td>
                <td>



                     <g:formRemote name="qedit" url="[controller: 'generics', action: 'saveJournalSheetEntry']" style="display: inline;"
                                   update="${i.id}Notes" method="post" onComplete="jQuery('#summaryField${i.id}').select(); jQuery('#summaryField${i.id}').focus()">

                         %{--<g:hiddenField name="entityCode" value="j"/>--}%
                         <g:hiddenField name="type.id" value="${i.id}"/>

                         <pkm:datePicker style="width: 60px;" name="startDate" id="field${i.id}" value="${new Date() - 1}" />
                         <pkm:datePicker style="width: 60px;" name="endDate" id="field${i.id}" value="${new Date() -1}" />

                         <g:textField id="summaryField${i.id}" style="width: 60%; display: inline;"  placeholder="summary"
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
