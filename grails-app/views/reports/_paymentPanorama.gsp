<%@ page import="app.PaymentCategory" %>



<h3>Enter recent payments</h3>



<table border="1" style="width: 99%; border: #496779; border-collapse: collapse;">
    <thead>
    <th style="width: 6%">Category</th>
    <th  style="width: 54%">New</th>
	
	<th  style="width: 40%">Last payment date / value</th>    
    
    </thead>

    <g:each in="${app.PaymentCategory.findAllByBookmarked(true, [sort: 'code'])}" var="i">
             <tr>
                 <td style="text-align: center;">
                        <b>
                            ${i.code}
                        </b>
                     <g:if test="${1 == 2 && i.name}">                  
                         ${i.name}
                     </g:if>

                 </td>
              
                 <td style="">



                     <g:formRemote name="qedit" url="[controller: 'generics', action: 'savePayment']" style="display: inline;"
                                   update="${i.id}Notes" method="post">


                         <g:hiddenField name="entityCode" value="q"/>
                         <g:hiddenField name="category.id" value="${i.id}"/>

                         <pkm:datePicker style="width: 50px;" name="date" id="field${i.id}" value="${new Date() - 1}" />
&nbsp;
                         <g:textField value="" style="width:50px; display: inline;"  placeholder="amount"
                                   name="amount"/>
&nbsp;
                         <g:textField value="" style="width: 67%; display: inline;"  placeholder="summary"
                                   name="summary"/>
                        
                         <!--g:textField value="" style="width: 310px; display: inline;" placeholder="description"
                                   name="description"/-->
                         %{--<a onclick="jQuery('#notes${i.id}').css('display', 'inline');" style="display: inline;">+n</a>--}%
   %{--<g:textField value="" style="width: 300px; height: 20px; display: none;" id="notes${i.id}"--}%
                                   %{--name="summary"/>--}%


                         <g:submitButton name="create" value="${message(code: 'save', 'default': 'Save')}" style="visibility: hidden;"
                                         class="fg-button ui-widget ui-state-default ui-corner-all"/>

                     </g:formRemote>


                 </td>
				 
				    <td style="">
					    <div id="${i.id}Notes"></div>
                     <i>${app.Payment.findByCategory(i, [sort: 'dateCreated', order: 'desc'])?.date?.format('dd.MM.yyyy')}</i>
        <b style="color: darkgreen";>
            ${app.Payment.findByCategory(i, [sort: 'dateCreated', order: 'desc'])? new java.text.DecimalFormat('###,###').format(app.Payment.findByCategory(i, [sort: 'dateCreated', order: 'desc'])?.amount): ''}
        </b>
                     <i>${app.Payment.findByCategory(i, [sort: 'dateCreated', order: 'desc'])?.summary}</i>
                 </td>
				 
                 
             </tr>

       </g:each>
</table>
<br/>
