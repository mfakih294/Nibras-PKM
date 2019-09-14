<%@ page import="ker.OperationController; java.text.DecimalFormat; cmn.Setting; grails.util.Metadata" %>

<table id="rssList" border="0" dir="ltr" cellspacing="2px" style="line-height: 15px;text-align: left; width: 100%">
    <tr>
        %{--<td>--}%
        %{--&nbsp; <img src="${resource(dir: 'images', file: 'favicon-transparent.png')}" width="16px;"/>--}%
        %{--&nbsp;--}%
        %{--</td>--}%
        <td style="padding-right: 1px !important;">
        &nbsp;
        &nbsp;
            <g:remoteLink controller="report" action="homepageSavedSearches"

                          update="centralArea" title="Homepage saved searches">
            %{--<span class="ui-icon ui-icon-calendar"></span>--}%



                <span style="margin-right: 1px;">
                    <b style="font-size: 12px; font-family: tahoma, sans-serif;">
                        ${OperationController.getPath('app.name') ?: 'Nibras'}</b>
                    <i>
                        ${grailsApplication.metadata.getApplicationVersion()}
                        <g:meta name="app.version"/>
                    </i>
                </span>
            </g:remoteLink>

        </td>
<g:if test="${OperationController.getPath('mihrab.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <td style="padding-right: 3px !important;">
        <a href="${createLink(controller: 'page', action:'appMihrab')}" target="_blank">
            Mihrab
            &nearr;
        </a>
        </td>
    </g:if>

        <td style="padding-right: 3px !important;">
        <a href="${createLink(controller: 'page', action:'appCalendar')}" target="_blank">
            Calendar
            &nearr;
        </a>
        </td>

        <td style="padding-right: 3px !important;">
            <a href="${createLink(controller: 'page', action:'slides')}" target="_blank">
                Slides
            &nearr;
            </a>
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
        <td style="padding-right: 3px !important;">
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

            <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <td style="padding-right: 3px !important;">
            %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
                <g:remoteLink controller="import" action="importLocalFiles"
                              update="centralArea"
                              style="padding-right: 5px !important;"
                              title="Import local files (Path: root.rps1.path)">

                %{--<span class="ui-icon ui-icon-arrow-2-e-w"></span>--}%
                %{--<g:message code="ui.importFiles"></g:message>--}%
                    Import <span id="importFileCount"></span>
                %{--<pkm:checkFolder name='rps1' display='Import (<span id="importFileCount"></span>)'--}%
                %{--path="${ker.OperationController.getPath('root.rps1.path')}"/>--}%
                </g:remoteLink>
                </td>
            </g:if>




        %{--<g:link controller="page" action="publish" target="_blank"--}%
        %{--params="${[id: record.id, entityCode: entityCode]}"--}%
        %{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
        %{--title="Publish">--}%
        %{--<span class="ui-icon ui-icon-script"></span>--}%
        %{--</g:link>--}%

        %{--<td>--}%
        %{--<a href="/nibras/generics/showCalendar/Tcal"--}%
        %{--style="" target="_blank">--}%
        %{--<span class="ui-icon ui-icon-calendar"></span>--}%
        %{--<g:message code="ui.tasksCalendar"></g:message>--}%
        %{--</a>--}%

        %{--</td>--}%

        %{--<td>--}%
        %{--<a href="/nibras/generics/showCalendar/Pcal"--}%
        %{--style="" target="_blank">--}%
        %{--<span class="ui-icon ui-icon-calendar"></span>--}%
        %{--<g:message code="ui.plannerCalendar"></g:message>--}%
        %{--</a>--}%

        %{--</td>--}%

        %{--<td>--}%
        %{--<a href="/nibras/generics/showCalendar/Jcal" style="" target="_blank">--}%
        %{--<g:message code="ui.journalCalendar"></g:message>--}%
        %{--</a>--}%
        %{--</td>--}%



            <g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
            %{--<td  style="padding: 1px !important;">--}%
                <td style="padding-right: 3px !important;">

                    <g:remoteLink controller="import" action="editBox"
                              update="centralArea"
                              style="padding-right: 2px !important;"
                              title="Edit box">
                %{--<g:message code="ui.writings"></g:message>--}%
                    Edit (<span id="editFileCount">${editFileCount ?: 0}</span>)
                </g:remoteLink>
                </td>
            %{--</td>--}%

            </g:if>

        %{--<sec:ifLoggedIn>--}%
        %{--<g:link controller='logout' style="color: #ffffff !important;">Logout &nbsp;</g:link>--}%
        %{--</sec:ifLoggedIn>--}%





        <td style="padding-right: 3px !important;">
            <g:remoteLink controller="generics" action="recentRecords"
                          style="padding-right: 2px !important;"
                          update="centralArea" title="Records entered within last week">
            %{--<span class="ui-icon ui-icon-calendar"></span>--}%
                <g:message code="ui.recent"></g:message>
                (<span id="recentRecordsCount"></span>)

            %{--(${mcs.Journal.countByType(mcs.parameters.JournalType.findByCode('pkm'))})--}%
            </g:remoteLink>
        </td>
        <td style="padding-right: 3px !important;">
            <g:remoteLink controller="report" action="reviewPile"
                          update="centralArea"
                          style="padding-right: 2px !important;"
                          title="Review pile">
                <g:message code="ui.review"></g:message>
                (${reviewPileSize})
            </g:remoteLink>

          </td>

        <g:if test="${1 ==2 }">
        <td style="padding-right: 1px !important;">

            <g:remoteLink controller="generics" action="showSelectedRecords"
                          update="centralArea"
                          style="padding-right: 0px !important"
                          before="jQuery.address.value(jQuery(this).attr('href'));"
                          title="Selected records">
                <g:message code="ui.selected"></g:message>
                (<span id="selectBasketRegion" style="color: white">${selectBasketCount ?: 0}</span>)
            </g:remoteLink>
          </td>
          <td>
            <g:remoteLink controller="generics" action="deselectAll"
                          update="selectBasketRegion"
                          style="padding-left: 0px !important; padding-right: 2px !important"
                          before="if(!confirm('Are you sure you want to deselect all selected records?')) return false"
                          title="Clear selection">
            %{--<g:message code="ui.clearAllSelection"></g:message> |--}%
                Clear
            </g:remoteLink>

            </td>
        </g:if>
        %{--<a id="selectAll"--}%
        %{--title="Select all shown records">--}%
        %{--<g:message code="ui.selectAll"></g:message>--}%
        %{--</a>--}%


        %{--<a id="deselectAll"--}%
        %{--title="Deselect all shown records">--}%

        %{--<g:message code="ui.unSelect"></g:message>--}%
        %{--</a>--}%



%{--        <sec:ifAnyGranted roles="ROLE_ADMIN">--}%
        %{--<td>--}%
        %{--<g:remoteLink controller="report" action="whereIsMyData"--}%
        %{--update="centralArea"--}%
        %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
        %{--title="Data entry activities">--}%

        %{--بياناتي--}%
        %{--</g:remoteLink>--}%



        %{--</td>--}%




        %{--<g:link controller="page" action="indicators"--}%
        %{--target="_blank"--}%
        %{--title="Indicators">--}%
        %{--<span class="ui-icon ui-icon-signal"></span> KPI--}%
        %{--</g:link>--}%
        %{--</td>--}%



        %{--<td>--}%
        %{--<g:remoteLink controller="report" action="heartbeat"--}%
        %{--update="centralArea"--}%
        %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
        %{--title="Data entry activities">--}%
        %{--دقات--}%
        %{--</g:remoteLink>--}%

        %{--</td>--}%
        %{--<td>--}%
        %{--<g:remoteLink controller="report" action="taskCompletionTrack"--}%
        %{--update="centralArea"--}%
        %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
        %{--title="Task progress track">--}%
        %{--سجل--}%
        %{--</g:remoteLink>--}%

        %{--</td>--}%



        %{--<td>--}%
        %{--<g:remoteLink controller="export" action="rss"--}%
        %{--update="centralArea"--}%
        %{--title="RSS feeds">--}%
        %{--RSS--}%
        %{--</g:remoteLink>--}%

        %{--</td>--}%

%{--        </sec:ifAnyGranted>--}%


        %{--<td>--}%
        %{--<g:remoteLink controller="generics" action="showBookmarkedRecords"--}%
        %{--update="centralArea"--}%
        %{--title="Bookmarked records">--}%
        %{--&nbsp; رزمة--}%
        %{--&nbsp;--}%

        %{--</g:remoteLink>--}%
        %{--</td>--}%

        %{--<td>--}%





        %{--<td><pkm:checkFolder folder="dbt" name='export.recordsToText.path' path="${OperationController.getPath('export.recordsToText.path')}"/></li>--}%
        %{--<li><pkm:checkFolder folder="log" name='log.path' path="${OperationController.getPath('privateMode')}"/></li>--}%
        %{--<li><pkm:checkFolder folder="tmp" name='tmp.path' path="${OperationController.getPath('tmp.path')}"/></li>--}%
        %{--<li><pkm:checkFolder folder="new" name='attachments.sandbox.path' path="${OperationController.getPath('attachments.sandbox.path')}"/></li>--}%
        %{--<li><pkm:checkFolder folder="cvr_ebk" name='covers.sandbox.path'--}%
        %{--path="${OperationController.getPath('covers.sandbox.path')}"/></li>--}%
        %{--<li><pkm:checkFolder folder="vsn" name='video.snapshots.sandbox.path' path="${OperationController.getPath('video.snapshots.sandbox.path')}"/></li>--}%
        %{--<li><pkm:checkFolder folder="vxr" name='video.excerpts.sandbox.path' path="${'video.excerpts.sandbox.path'}"/></li>--}%
        %{--<li><pkm:checkFolder folder="config" name='confiFile'--}%
        %{--path="${System.getProperty("user.home")}/.pomegranate.properties"/></li>--}%



        %{--<g:if test="${Setting.findByName('privateMode') && OperationController.getPath('privateMode') == 'on'}">--}%
        %{--<li style="color: darkgreen">Private mode</li>--}%
        %{--</g:if>--}%

        %{--<li>--}%
        %{--<g:if test="${environment == 'dev'}">--}%
        %{--DB:   ${org.codehaus.groovy.grails.commons.ConfigurationHolder.config.dataSource.url.split('/').last()}--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
        %{--Prod db--}%
        %{--</g:else>--}%
        %{--</li>--}%

        %{--<li>--}%
        %{--<g:if test="${Setting.findByName('countup.date.days')}">--}%
        %{--<span>--}%
        %{--${new Date() - Date.parse('dd.MM.yyyy', OperationController.getPath('countup.date.days'))} days--}%
        %{--</span>--}%
        %{--</g:if>--}%
        %{----}%
        %{--</li>--}%
        %{--<g:if test="${Setting.findByName('countup.date.years')}">--}%
        %{--<span>  ${new DecimalFormat('##.##').format((new Date() - Date.parse('dd.MM.yyyy', OperationController.getPath('countup.date.years'))) / 365.25)} years--}%
        %{--</span>--}%


        %{--</g:if>--}%

        %{--<sec:ifAnyGranted roles="ROLE_ADMIN------">--}%
        %{--<td>--}%



        %{--</sec:ifAnyGranted>--}%

        %{--</td>--}%
        <td style="border: 0px dashed darkgray; padding-left: 15px !important;">

            <i style="color: #ebebeb;">Kanbans:</i> &nbsp;
            <g:render template="/layouts/savedSearchesLine" model="[entity: 'F']"/>
        </td>
        %{--<td>--}%
        %{--<g:formRemote name="batchAdd3"--}%
        %{--url="[controller: 'generics', action: 'actionDispatcherPreset']"--}%
        %{--update="centralArea" style="display: inline"--}%
        %{--method="post">--}%

        %{--<g:hiddenField name="sth2" value="${new java.util.Date()}"/>--}%
        %{--<g:submitButton name="batch" value="Execute"--}%
        %{--style="margin: 0px; display: none"--}%
        %{--id="quickAddXcdSubmitTop"--}%
        %{--class="ui-widget ui-state-default"/>--}%

        %{--<g:textField name="input" value="" id="speedsearch"--}%
        %{--autocomplete="off"--}%
        %{--style="display: inline;  width: 200px !important;"--}%
        %{--placeholder="بحث..."--}%
        %{--class=""/>--}%

        %{--</g:formRemote>--}%
        %{--</td>--}%

        <td style="padding: 1px !important; margin-left: 2px; color: white;">

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

                <g:textField name="input" value="" id="speedsearch"
                             autocomplete="off"
                             style="float: right; display: inline;  width: 220px !important; height: 24px; padding: 3px; margin: 1px; font-size: 11px;"
                             placeholder="Search..."
                             class=""/>

            </g:formRemote>

        </td>

        %{--<td style="padding: 1px !important; margin-left: 9px; color: white;">--}%

            %{--<a href="/nibras/sync/rssPile"--}%
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
            jQuery('#logRegion').load('/nibras/generics/selectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
        });
    })

    $('#deselectAll').click(function (e) {
        $("input[name^='select-']").each(function () {
            this['checked'] = false
//        console.log(this.attr('value'));
            jQuery('#logRegion').load('/nibras/generics/deselectOnly/' + this['name'].split('-')[2] + this['name'].split('-')[1]);
        });
    })
</script>