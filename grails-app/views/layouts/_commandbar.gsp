<%@ page import="ker.OperationController; mcs.parameters.WritingType; app.Tag; app.parameters.CommandPrefix" %>

%{--<a style="font-size: smaller; color: gray; margin-buttom: 5px; float: right;" onclick="jQuery('#commandBars').removeClass('navHidden')">+script&nbsp; </a>--}%

%{--<h4>Batch data entry</h4>--}%

<table border="0" style="border: 0">
    <tr>
        <td style="width: 60% !important; vertical-align: top;">
            <div id="commandBars" style="width: 60% !important;">
                %{--<a onclick="jQuery('#commandBars').addClass('navHidden')" style="font-size: smaller; color: gray; float: right;">Hide &nbsp;</a>--}%
                <div id="top"></div>

                <g:formRemote name="batchAdd2"
                              url="[controller: 'generics', action: 'batchAddPreprocessor']"
                              update="hintAreaOneAtATime"

                              method="post">
                %{--onComplete="var cdate = 'pkm-' + new Date().toISOString(); jQuery('#quickAddTextField').select();localStorage[cdate] = jQuery('#quickAddTextField').val(); document.getElementById('commandHistory').options.add(new Option(localStorage[cdate], cdate));"--}%
                    <g:hiddenField name="sth2" value="${new java.util.Date()}"/>


                    <div class="uk-grid uk-grid-small"  uk-grid>
<div>

                                <label class="uk-form-label">
                                    Template
                                </label>
<div class=uk-form-controls">
                                    <g:select name="commandPrefix"
                                              class="uk-select uk-width-auto"
                                              from="${CommandPrefix.list([sort: 'orderNumber'])}" optionKey="id" optionValue="summary"
                                              style="direction: ltr; text-align: left; display: inline; width: 220px; font-size: normal;"
                                              onchange="jQuery.getJSON('${request.contextPath}/generics/commandNotes?q=' + this.value, function(jsdata){jQuery('#quickAddTextField').html('' + jsdata.info);jQuery('#prefixField').val(jsdata.prefix); })"
                                              value=""/>
</div>
</div>
                                    %{--if (jsdata.info  == null ||  jsdata.info  == 'null' || !jsdata.info) jQuery('#quickAddTextField').addClass('commandMode'); else  jQuery('#quickAddTextField').removeClass('commandMode')--}%



                                </span>

                    <div class="uk-width-expand">

                                <label class="uk-form-label">
                                    Prefix
                                </label>

    <div class=uk-form-controls">
                                <g:textField
                                        class="uk-input uk-width-expand"
                                        id="prefixField" name="prefix" cols="80"
                                                            style="" value=""/>
                                </div>
                                </div>
                                %{--For each line?--}%
                                %{--<input type="text" name="forEachLine" id="forEachLine"--}%
                                %{--/>--}%
<div class="uk-width-auto">
                                <label class="uk-form-label">
                                    Verify
                                </label>
        <div class=uk-form-controls">
                                <g:checkBox name="verifyMode"
                                            class="uk-checkbox uk-form-controls-text"
                                            value="${true}"/>
</div>
</div>


                                %{--History <select id="commandHistory" style="width: 50px;"--}%
                                %{--onchange="jQuery('#quickAddTextField').val(this.options[this.selectedIndex].text)">--}%
                                %{--<option></option>--}%
                                %{--</select>--}%


</div>
                                %{--(Add, update, search, assign records...) Type ? for more info--}%
                                %{--value="${OperationController.getPath('commandBar.initialText')?.replace('+', '\n')?.replaceAll(/\?date/, ker.OperationController.toWeekDate(new Date() -1))}"--}%
                                %{--value="localStorage['myscratch']"--}%
                                %{--placeholder="Batch operations..."--}%
                                %{--dir="rtl"--}%


                                %{--before one-at-a-time command execution--}%
                                %{--onkeyup="if (jQuery('#quickAddTextField').val().search(';')== -1){jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextField').val()))}"--}%
                                %{--onblur="jQuery('#hintAreaOneAtATime').html('')"--}%


                    <div class="uk-grid uk-grid-small"  uk-grid>
%{--                                onkeyup="verifyCommand()"--}%
%{--                                onfocus="jQuery('#hintAreaOneAtATime').load('${createLink(controller: 'generics', action: 'commandBarAutocompleteOneAtATime')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextField').val()))"--}%
                    <div class=uk-form-controls">
                                <g:textArea cols="120" rows="5" name="block" id="quickAddTextField"
                                            autocomplete="off" style="height: 200px;"
                                            onkeydown="localStorage['myscratch'] = jQuery('#quickAddTextField').val();"
                                            class="commandBarTexField uk-textarea uk-width-expand"/>
</div>
                    </div>

                    &nbsp;
                    &nbsp;
                                <g:submitButton name="batch" value="Execute"
                                                style="height: 40px !important;"
                                                id="quickAddXcdSubmitExecute"
                                                class="uk-button-primary uk-width-expand"/>


                                <div id="quickAddTextFieldInfoNotes" style="color: darkgreen; font-size: medium; font-style: italic; padding: 5px 5px; display: inline-block"></div>
                            </td>
                            %{--<td style="width: 25px !important ; padding: 0px; margin: 0px;">--}%

                        </tr>

                    </table>

                </g:formRemote>
                <script type="application/javascript">
                    function verifyCommand() {
                        if (jQuery('#quickAddTextField').val().search(';')== -1){
                            jQuery('#hintAreaOneAtATime').load('${createLink(controller: 'generics', action: 'commandBarAutocompleteOneAtATime')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextField').val()))}
                    }
                </script>

                <br/>
                <br/>



            </div>

        </td>
        <td style="width: 40%">
            <div id="hintAreaOneAtATime" style="font-size: 12px; padding: 0px; margin: 0px; "></div>
        </td>
    </tr>
</table>



<script type="text/javascript">
//   jQuery('#commandBars').addClass('navHidden')
jQuery('#quickAddTextField').val(localStorage['myscratch']);
</script>
