<%@ page import="ker.OperationController; cmn.Setting;" %>


<table id="rssList" border="0" dir="ltr" cellspacing="2px" style="line-height: 15px;text-align: left; width: 100%">
    <tr>
        %{--<td>--}%
        %{--&nbsp; <img src="${resource(dir: 'images', file: 'favicon-transparent.png')}" width="16px;"/>--}%
        %{--&nbsp;--}%
        %{--</td>--}%
        <td style="padding-right: 1px !important;">
            &nbsp;
            &nbsp;


            %{--<g:remoteLink controller="report" action="homepageSavedSearches"--}%
            %{--update="centralArea" title="Homepage saved searches">--}%
            %{--<span class="ui-icon ui-icon-calendar"></span>--}%
            <a href="${createLink(controller: 'page', action:'appMain')}" target="_blank">

                <span style="margin-right: 1px;">
                    <b style="font-size: 1em; font-family: Lato, sans-serif;">
                        ${OperationController.getPath('app.name') ?: 'Nibras'}</b>
                    <i>
                        &nbsp;
                        v${grailsApplication.metadata.getApplicationVersion()}
                        %{--<g:meta name="app.version"/>--}%
                    </i>
                </span>
            </a>

        </td>
        <g:if test="${OperationController.getPath('mihrab.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <td style="padding-right: 3px !important;">
                <a href="${createLink(controller: 'page', action:'appMihrab')}" target="_blank">
                    Mihrab
                    %{--            &nearr;--}%
                </a>
            </td>
        </g:if>

    %{--   <td style="padding-right: 1px !important;">--}%
    %{--            <a href="${createLink(controller: 'page', action:'appLight')}" target="_blank">--}%
    %{--                Light--}%

    %{--            </a>--}%
    %{--        </td>--}%
    %{--<g:if test="${OperationController.getPath('notes.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
        <td style="padding-right: 1px !important;">
            <a href="${createLink(controller: 'page', action:'appPile')}" target="_blank">
                Reader
            </a>
        </td>
    %{--</g:if>--}%
        <g:if test="${OperationController.getPath('notes.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <td style="padding-right: 1px !important;">
                <a href="${createLink(controller: 'page', action:'appNotes')}" target="_blank">
                    Notes
                </a>
            </td>
        </g:if>

        <g:if test="${1 == 2 && OperationController.getPath('scans.enabled')?.toLowerCase() == 'yes' ? true : false}">

            <td style="padding-right: 1px !important;">
                <a href="${createLink(controller: 'operation', action:'processScans')}" target="_blank">
                    Scans
                </a>
            </td>
        </g:if>

    %{--<g:if test="${OperationController.getPath('tasks.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
    %{--<td style="padding-right: 1px !important;">--}%
    %{--<a href="${createLink(controller: 'page', action:'appKanban')}" target="_blank">--}%
    %{--Tasks--}%
    %{--</a>--}%
    %{--</td>--}%
    %{--</g:if>--}%


    <!--td style="padding-right: 1px !important;">
            <a href="${createLink(controller: 'page', action:'appDashboard')}" target="_blank">
                Board

            </a>
        </td-->


        <g:if test="${OperationController.getPath('calendar.enabled')?.toLowerCase() == 'yes' ? true : false}">
            <td style="padding-right: 1px !important;">
                <a href="${createLink(controller: 'page', action:'appCalendar')}" target="_blank">
                    Calendar
                </a>
            </td>
        </g:if>

    %{--<td style="padding-right: 3px !important;">--}%

    %{--</td>--}%

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
        <td style="padding-right: 1px !important;">
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
                              style="padding-right: 2px !important;"
                              title="Import local files (Path: root.rps1.path)">

                %{--<span class="ui-icon ui-icon-arrow-2-e-w"></span>--}%
                %{--<g:message code="ui.importFiles"></g:message>--}%
                    Import <span id="importFileCount"></span>
                %{--<pkm:checkFolder name='rps1' display='Import (<span id="importFileCount"></span>)'--}%
                %{--path="${ker.OperationController.getPath('root.rps1.path')}"/>--}%
                </g:remoteLink>
                <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
                %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
                    <g:remoteLink controller="import" action="advancedRecordImport"
                                  update="centralArea"
                                  style="padding-right: 2px !important;"
                                  title="Import local files (Path: root.rps1.path)">
                    %{--<span class="ui-icon ui-icon-arrow-2-e-w"></span>--}%
                    %{--<g:message code="ui.importFiles"></g:message>--}%
                        ++
                    %{--<pkm:checkFolder name='rps1' display='Import (<span id="importFileCount"></span>)'--}%
                    %{--path="${ker.OperationController.getPath('root.rps1.path')}"/>--}%
                    </g:remoteLink>
                </g:if>
            </td>
        </g:if>






    %{--<g:link controller="page" action="publish" target="_blank"--}%
    %{--params="${[id: record.id, entityCode: entityCode]}"--}%
    %{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
    %{--title="Publish">--}%
    %{--<span class="ui-icon ui-icon-script"></span>--}%
    %{--</g:link>--}%

    %{--<td>--}%
    %{--<a href="${request.contextPath}/generics/showCalendar/Tcal"--}%
    %{--style="" target="_blank">--}%
    %{--<span class="ui-icon ui-icon-calendar"></span>--}%
    %{--<g:message code="ui.tasksCalendar"></g:message>--}%
    %{--</a>--}%

    %{--</td>--}%

    %{--<td>--}%
    %{--<a href="${request.contextPath}/generics/showCalendar/Pcal"--}%
    %{--style="" target="_blank">--}%
    %{--<span class="ui-icon ui-icon-calendar"></span>--}%
    %{--<g:message code="ui.plannerCalendar"></g:message>--}%
    %{--</a>--}%

    %{--</td>--}%

    %{--<td>--}%
    %{--<a href="${request.contextPath}/generics/showCalendar/Jcal" style="" target="_blank">--}%
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
            <g:if test="${1 == 2}">
                <g:remoteLink controller="generics" action="recentRecords"
                              style="padding-right: 2px !important;"
                              update="centralArea" title="Records entered within last week">
                %{--<span class="ui-icon ui-icon-calendar"></span>--}%
                    <g:message code="ui.recent"></g:message>
                    (<span id="recentRecordsCount"></span>)

                %{--(${mcs.Journal.countByType(mcs.parameters.JournalType.findByCode('pkm'))})--}%
                </g:remoteLink>
            </g:if>

            <g:if test="${1 == 2 && OperationController.getPath('today-report.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <g:remoteLink controller="generics" action="todaysRecords"
                              style="padding-right: 2px !important;"
                              update="centralArea" title="Today's records">
                %{--<span class="ui-icon ui-icon-calendar"></span>--}%
                %{--                <g:message code="ui.today"></g:message>--}%
                    Today
                %{--                (<span id="recentRecordsCount"></span>)--}%

                %{--(${mcs.Journal.countByType(mcs.parameters.JournalType.findByCode('pkm'))})--}%
                </g:remoteLink>
            </g:if>
        </td>


        <g:if test="${OperationController.getPath('review.enabled')?.toLowerCase() == 'yes' ? true : false}">

            <td style="padding-right: 3px !important;">
                <g:remoteLink controller="report" action="reviewPile"
                              update="centralArea"
                              style="padding-right: 2px !important;"
                              title="Review pile">
                    <g:message code="ui.review"></g:message>
                    (${reviewPileSize})
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
    %{--        <td style="border: 0px dashed darkgray; padding-left: 15px !important; padding-top: 0; padding-bottom: 0; background: #8e8e97">--}%


    %{--        </td>--}%
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

        <td style="padding: 1px !important; margin-left: 2px; color: white; min-height: 30px; min-width: 200px;">


            %{--Records per page--}%

            %{--                        noSelection="${['null': '']}"--}%


            %{--<g:select name="resultType"--}%
            %{--from="${[1, 2, 3, 4, 5, 6, 7, 8,9, 10, 15, 20, 30, 40, 50, 100, 250]}"--}%
            %{--style="direction: ltr; text-align: left; padding: 2px; margin: 0;"--}%
            %{--onchange="jQuery('#notificationArea').load('${request.contextPath}/generics/setPageMax/' + this.value);"--}%
            %{--value="${cmn.Setting.findByNameLike('savedSearch.pagination.max.link')?.value ?: 4}"/>--}%
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

        <td style="padding: 1px !important; margin-left: 4px; color: white;">
            <g:remoteLink controller="page" action="manageUser"
                          update="centralArea"
                          title="Manager user account">
                <u>${username}</u>
            %{--دقات--}%
            %{--</g:remoteLink>--}%
            %{--style="" target="_blank">--}%
            %{--<span style="color: white" class="ui-icon ui-icon-signal"></span>--}%
            %{--<g:message code="ui.menu.RSS"></g:message>--}%
            </g:remoteLink>
        </td>

        <td style="padding: 1px !important; margin-left: 9px; color: white;">

            <a href="${request.contextPath}/logoff"
               style="">
                Logout
                %{--<g:message code="ui.menu.help"></g:message>--}%
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


%{--/* ********* */--}%
%{--/* ********* */--}%
%{--/* ********* */--}%
%{--/* ********* */--}%
%{--/* ********* */--}%
%{--/* ********* */--}%
%{--/* ********* */--}%


<div class="nav nonPrintable"
     style="width: 98%; font-family: tahoma; font-size: 14px; padding: 3px; direction: rtl;">

    &nbsp;
    <img src="${resource(dir: 'images', file: 'favicon-transparent.png')}" width="15px;"/>
&nbsp;
    <g:link controller="page" action="main"
            title="Reload the application">
        <span style="color: #fff;">
            <b style="font-size: 14px; font-family: tahoma, sans-serif;">
                ${OperationController.getPath('app.name') ?: 'Nibras'}</b>
            %{--<i></i><g:meta name="app.version"/>--}%
        </span>
    </g:link>
    %{--<g:if test="${OperationController.getPath('show.textlogo')?.toLowerCase() == 'yes' ? true : false}">--}%
        %{--<sub>--}%
            %{--<a href="http://pomegranate-pkm.org" target="_blank">--}%
                %{--<i style="font-size: 10px; color: #ffffff"></i>--}%
            %{--</a>--}%
        %{--</sub>--}%
    %{--</g:if>--}%

%{--&nbsp;--}%
    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
        %{--<% Calendar c = new GregorianCalendar(); c.setLenient(false); c.setMinimalDaysInFirstWeek(4);--}%
        %{--c.setFirstDayOfWeek(java.util.Calendar.MONDAY)--}%
        %{--%>--}%
        %{--<b>أ${c.get(Calendar.WEEK_OF_YEAR)}</b>--}%
        %{--&nbsp;--}%
    %{--</sec:ifAnyGranted>--}%


    <g:remoteLink controller="report" action="detailedAdd"
                  update="centralArea"
                  before="jQuery.address.value(jQuery(this).attr('href'));"
                  style="color: white !important"
                  title="Add using forms">
        +
    </g:remoteLink>



    <g:if test="${OperationController.getPath('import.enabled')?.toLowerCase() == 'yes' ? true : false}">
        <g:remoteLink controller="import" action="importLocalFiles"
                      update="centralArea"
                      before="jQuery.address.value(jQuery(this).attr('href'));"
                      style="color: white !important"
                      title="Import local files">
            <g:message code="ui.import"></g:message>

        </g:remoteLink>
    </g:if>


&nbsp;
    <a href="${request.contextPath}/generics/executeSavedSearch/65?reportType=cal" style="color: white !important" target="_blank">
        <g:message code="ui.planner"></g:message>

    </a>
    &nbsp;
    <a href="${request.contextPath}/generics/executeSavedSearch/79?reportType=cal" style="color: white !important" target="_blank">
    <g:message code="ui.journal"></g:message>

    </a>
&nbsp;



    <g:remoteLink controller="report" action="reviewPile"
                  update="centralArea"
                  style="color: white !important"
                  title="Review pile">
        <g:message code="ui.review"></g:message>

    </g:remoteLink>

&nbsp;



    <g:remoteLink controller="report" action="wordsForReview"
                  update="centralArea"
                  style="color: white !important"
                  title="Review words">
        <g:message code="ui.anki"></g:message>

    </g:remoteLink>


%{--<sec:ifLoggedIn>--}%
        %{--<g:link controller='logout' style="color: #ffffff !important;">Logout &nbsp;</g:link>--}%
    %{--</sec:ifLoggedIn>--}%

    <sec:ifNotLoggedIn>
        <a href='#' id='loginLink'>Login</a>
    </sec:ifNotLoggedIn>

&nbsp;


    <g:formRemote name="batchAdd2"
                  url="[controller: 'generics', action: 'actionDispatcher']"
                  update="centralArea" style="display: inline"
                  method="post">

        <g:hiddenField name="sth2" value="${new java.util.Date()}"/>
        <g:submitButton name="batch" value="Execute"
                        style="height: 20px; margin: 0px; width: 100px !important; display: none"
                        id="quickAddXcdSubmitTop"
                        class="fg-button ui-widget ui-state-default"/>

        <g:textField name="input" id="quickAddTextFieldBottomTop" value=""
                     autocomplete="off"
                     style="display: inline;  width: 600px !important; background: #E5F6FE; color: white; border: 1px solid #003a69"
                     placeholder="Command bar"
                     onkeyup="if (jQuery('#quickAddTextFieldBottomTop').val().search(';')== -1){jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))}"
                     onfocus="jQuery('#hintArea').load('${createLink(controller: 'generics', action: 'commandBarAutocomplete')}?hint=1&q=' + encodeURIComponent(jQuery('#quickAddTextFieldBottomTop').val()))"
                     onblur="jQuery('#hintArea').html('')"
                     class="commandBarTexFieldTop"/>

    </g:formRemote>

</div>
