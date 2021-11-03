<%@ page import="ker.OperationController; java.text.DecimalFormat; cmn.Setting; grails.util.Metadata" %>

<table id="rssList" border="0" dir="ltr" cellspacing="2px" style="line-height: 15px;text-align: left; width: 95%">
    <tr>
        %{--<td>--}%
        %{--&nbsp; <img src="${resource(dir: 'images', file: 'favicon-transparent.png')}" width="16px;"/>--}%
        %{--&nbsp;--}%
        %{--</td>--}%
        <td style="padding-right: 1px !important; text-align: center;">
        &nbsp;
        &nbsp;
            <g:remoteLink controller="report" action="homepageSavedSearches"

                          update="centralArea" title="Homepage saved searches">
            %{--<span class="ui-icon ui-icon-calendar"></span>--}%



                <span style="margin-right: 1px;">
                    <b style="font-size: 1.4em;">
%{--                        ${OperationController.getPath('app.name') ?: 'Nibras'} /Study </b>--}%
%{--Course--}%
                        Pile</b>
                </span>
            </g:remoteLink>

        </td>

        %{--<g:link controller="page" action="main"--}%
        %{--title="">--}%

        %{--<g:meta name="app.version"/>--}%
        %{--todo--}%
        %{--</g:link>--}%
        %{--<g:if test="${OperationController.getPath('show.textlogo')?.toLowerCase() == 'yes' ? true : false}">--}%
        %{--<sub>--}%
        %{--<a href="http://pomegranate-pkm.org" target="_blank">--}%
        %{--<i style="font-size: 10px; color: #ffffff">A Pomegranate PKM system</i>--}%
        %{--</a>--}%
        %{--</sub>--}%
        %{--</g:if>--}%
        <td style="padding-right: 5px !important;">
            %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
            <% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);
            c.setFirstDayOfWeek(java.util.Calendar.MONDAY) %>
            <b style="color: white">
%{--                Week ${c.get(Calendar.WEEK_OF_YEAR)}--}%
            </b>
        </td>
        %{--</sec:ifAnyGranted>--}%





        %{--<g:remoteLink controller="report" action="detailedAdd"--}%
        %{--update="centralArea"--}%
        %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
        %{--style=""--}%
        %{--title="Add using forms">--}%
        %{--<g:message code="ui.addRecords"></g:message>--}%
        %{--</g:remoteLink>--}%

        <td style="padding: 1px !important; margin-left: 9px; color: white;">

            <g:formRemote name="batchAdd3"
                          url="[controller: 'generics', action: 'quickQuranSearch']"
                          update="centralArea" style="display: inline"
                          before="jQuery('#testTitle5').text('[3]: ' + jQuery('#testField5').val());"
                          method="post">

            %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
                <g:submitButton name="batch" value="Execute"
                                style="margin: 0px; display: none"
                                id=" "
                                class="ui-widget ui-state-default"/>

                <g:textField name="input" value="" id="speedsearch"
                             autocomplete="off"
                             style="float: right; display: inline;  width: 220px !important; height: 24px; padding: 2px; margin: 1px; font-size: 11px;"
                             placeholder="Search..."
                             class=""/>

            </g:formRemote>

        </td>

        %{--<td style="padding: 1px !important; margin-left: 9px; color: white;">--}%

            %{--<a href="${request.contextPath}/sync/rssPile"--}%
               %{--class="fg-button-icon-left"--}%
               %{--style="" target="_blank">--}%
                %{--<span style="color: white" class="ui-icon ui-icon-signal"></span>--}%
                %{--<g:message code="ui.menu.RSS"></g:message>--}%
            %{--</a>--}%
        %{--</td>--}%

        <td style="padding: 1px !important; margin-left: 9px; color: white;">

            <a href="http://khuta.org/nibras-doc/index.html"
               style="" target="_blank">
%{--                <span style="color: white" class="ui-icon ui-icon-help"></span>--}%
                <g:message code="ui.menu.help"></g:message>
            </a>
        </td>
        %{--<td>--}%
        %{--بالصفحة--}%

        %{--</td>--}%

        %{--<li>--}%
        %{----}%
        %{--نسخه <i>--}%
        %{----}%
        %{--</i><g:meta name="app.version"/>--}%
        %{--</li>--}%

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