<%@ page import="ker.OperationController; java.text.DecimalFormat; cmn.Setting; grails.util.Metadata" %>

<table id="rssList" border="0" dir="ltr" cellspacing="2px" style="line-height: 15px;text-align: left; width: 100%">
    <tr>
        <td>


        <td style="padding: 1px !important; margin-left: 2px; color: white; min-height: 30px; min-width: 200px;">
        
        
    RPP
          
%{--                        noSelection="${['null': '']}"--}%
                        <g:select name="resultType"
                                  from="${[1, 2, 3, 4, 5, 6, 7, 8,9, 10, 15, 20, 30, 40, 50, 100, 250]}"
                                  style="direction: ltr; text-align: left; padding: 2px; margin: 0;"
                                  onchange="jQuery('#notificationArea').load('${request.contextPath}/generics/setPageMax/' + this.value);"
                                  value="${cmn.Setting.findByNameLike('savedSearch.pagination.max.link')?.value ?: 4}"/>
                        <span id="notificationArea" style=""></span>
                        <span style="display: none" id="notificationAreaHidden"></span>

%{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
            <g:formRemote name="batchAdd3"
                          url="[controller: 'generics', action: 'quickTextSearch']"
                          update="centralArea" style="display: inline"
                          before="jQuery('#testTitle5').text('[3]: ' + jQuery('#testField5').val());"
                          method="post">

            %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
                <g:submitButton name="batch" value="Execute"
                                style="margin: 0px; display: none"
                                id=" "
                                class="ui-widget ui-state-default"/>

                <g:select name="resultType"
                          from="${[[id: '*']] + types}"
                    optionKey="id"
                    optionValue="id"
                          style="float: right;direction: ltr; text-align: left; padding: 2px; margin: 0;"
                          value="N"/>

                <g:textField name="input" value="" id="speedsearch"
                             autocomplete="off"
                             style="float: right; display: inline;  width: 250px !important; padding: 2px; margin: 1px;"
                             placeholder="Search (Esc)..."
                             class=""/>

            </g:formRemote>
%{--</sec:ifAnyGranted>--}%
        </td>

    </tr>
</table>




%{--<div id="dialog" title="Basic dialog">--}%
%{--<p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>--}%
%{--</div>--}%

<script>
    //    $("#dialog").dialog();

    function dualDisplay() {
        document.getElementById("centralArea").id = "temp1q";
        document.getElementById("sandboxPanel").id = "centralArea";
        console.log('dual')
        jQuery('#accordionEast').accordion({active: 3});

    }

    function singleDisplay() {
        document.getElementById("temp1q").id = "centralArea";
        document.getElementById("centralArea").id = "sandboxPanel";
        console.log('single')
    }


    $('#selectAll').click(function (e) {
        $("input[name^='select-']").each(function () {
//        this['value'] = 'on'
            this['checked'] = true
//        console.log(this.attr('value'));
            jQuery('#logRegion').load('${request.contextPath}/generics/selectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
        });
    })

    $('#deselectAll').click(function (e) {
        $("input[name^='select-']").each(function () {
            this['checked'] = false
//        console.log(this.attr('value'));
            jQuery('#logRegion').load('${request.contextPath}/generics/deselectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
        });
    })
</script>
