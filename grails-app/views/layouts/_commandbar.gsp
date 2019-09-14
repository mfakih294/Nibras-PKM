<%@ page import="ker.OperationController; mcs.parameters.WritingType; app.Tag; app.parameters.CommandPrefix" %>

%{--<a style="font-size: smaller; color: gray; margin-buttom: 5px; float: right;" onclick="jQuery('#commandBars').removeClass('navHidden')">+script&nbsp; </a>--}%

<div id="commandBars">
    %{--<a onclick="jQuery('#commandBars').addClass('navHidden')" style="font-size: smaller; color: gray; float: right;">Hide &nbsp;</a>--}%
    <div id="top"></div>

    <g:formRemote name="batchAdd2"
                  url="[controller: 'generics', action: 'batchAddPreprocessor']"
                  update="centralArea"

                  method="post">
        %{--onComplete="var cdate = 'pkm-' + new Date().toISOString(); jQuery('#quickAddTextField').select();localStorage[cdate] = jQuery('#quickAddTextField').val(); document.getElementById('commandHistory').options.add(new Option(localStorage[cdate], cdate));"--}%
        <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
        <table style="width: 98%; padding: 0px; margin: 0px;">

             %{--</td>--}%
            <tr>
                <td style=" padding: 0px; margin: 0px; width: 60%">
                    Choose action:
                    <g:select name="commandPrefix"
                              from="${CommandPrefix.list([sort: 'orderNumber'])}" optionKey="id" optionValue="summary"
                              style="direction: ltr; text-align: left; display: inline; width: 160px;"
                              onchange="jQuery.getJSON('/nibras/generics/commandNotes?q=' + this.value, function(jsdata){jQuery('#quickAddTextField').val(jsdata.info);jQuery('#prefixField').val(jsdata.prefix);if (jsdata.info  == null ||  jsdata.info  == 'null' || !jsdata.info) jQuery('#quickAddTextField').addClass('commandMode'); else  jQuery('#quickAddTextField').removeClass('commandMode') })"
                              value=""/>

                    Prefix: <g:textField id="prefixField" name="prefix" class="ui-corner-all" cols="80"
                                 rows="5"
                                 style="width:30%; display: inline; " value=""/>



                    %{--History <select id="commandHistory" style="width: 50px;"--}%
                                    %{--onchange="jQuery('#quickAddTextField').val(this.options[this.selectedIndex].text)">--}%
                    %{--<option></option>--}%
                %{--</select>--}%
                    <g:submitButton name="batch" value="Execute"
                                    style="margin: 0px; width: 60px !important;"
                                    id="quickAddXcdSubmit"
                                    class="fg-button ui-widget ui-state-default"/>

                </td>
            </tr>   <tr>
            <td colspan="2">
                %{--(Add, update, search, assign records...) Type ? for more info--}%
                <g:textArea cols="120" rows="5" name="block" id="quickAddTextField" value="${OperationController.getPath('commandBar.initialText')?.replace('+', '\n')?.replaceAll(/\?date/, ker.OperationController.toWeekDate(new Date() -1))}"
                            autocomplete="off"
                            dir="rtl"
                            placeholder="Batch operations..."
                            onkeyup="if (jQuery('#quickAddTextField').val().search(';')== -1){jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextField').val()))}"
                            onfocus="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextField').val()))"
                            onblur="jQuery('#hintArea').html('')"
                            class="commandBarTexField"/>

            </td>
            %{--<td style="width: 25px !important ; padding: 0px; margin: 0px;">--}%

        </tr>

        </table>

    </g:formRemote>
     <br/>
     <br/>



</div>



<script type="text/javascript">
//   jQuery('#commandBars').addClass('navHidden')
</script>
