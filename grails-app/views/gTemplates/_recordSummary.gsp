<%@ page import="mcs.parameters.ResourceStatus; ker.OperationController; mcs.Writing; mcs.Book; cmn.Setting; org.apache.commons.lang.StringEscapeUtils; app.Payment; app.IndicatorData; app.IndexCard; mcs.Excerpt; java.text.DecimalFormat; mcs.parameters.WorkStatus; mcs.Goal; mcs.parameters.JournalType; mcs.Journal; mcs.Planner; mcs.Task" %>
<!-- gTemplates/recordSummary -->
%{--todo: open to become slideOpen--}%
%{--${grailsApplication.config.dataSource.dialect.name}--}%

<g:hasErrors bean="${record}">
    <div class="errors" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
        <g:renderErrors bean="${record}" as="list"/>
    </div>
</g:hasErrors>

%{--<g:if test="${record?.id && OperationController.getPath('private_mode') == 'on' && record.class.declaredFields.name.contains('keepSecret') && record.keepSecret}">--}%
%{--    &notin;--}%
%{--</g:if>--}%
%{--<g:elseif test="${record?.id}">--}%

    <g:set var="entityCode"
           value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode()?.split(/\./).last() : record.class?.name?.split(/\./).last()}"/>

%{--onmouseout="jQuery('.temp44').addClass('hiddenActions');--}%
%{--jQuery('.temp442').addClass('hiddenActions');--}%
%{--jQuery('#2ndLine${entityCode}${record.id}').addClass('hiddenActions');"--}%


    %{--<div id="" style="" tabindex="0">--}%

        %{--${justUpdated ? 'justUpdated' : ''} todo--}%

%{--        onmouseover="jQuery('.temp44').addClass('hiddenActions');--}%
%{--        jQuery('#actionsButtons${entityCode}${record.id}').removeClass('hiddenActions')"--}%

        %{--<div class=""--}%
             %{--onxxxmouseout="jQuery('.temp44').addClass('hiddenActions');"--}%
             %{-->--}%

<g:if test="${expanded}">

<div style="line-height: 30px;" class="text${record.class.declaredFields.name.contains('language') ? record.language : (entityCode == 'E' ? record?.book?.language : '')}">
                             [${entityCode}${record.id}]
                                <g:if test="${record.class.declaredFields.name.contains('summary') && record.summary}">
                                    <b>${record.summary}</b>
                                    </g:if>
    <g:if test="${record.class.declaredFields.name.contains('title') && record.title}">
        <b>${record.title}</b>
    </g:if>
        <g:if test="${record.class.declaredFields.name.contains('description') && record.description}">
            <br/>        desc               ${raw(record.description?.replaceAll('\n', '<br/>'))}
                                    </g:if>
    <g:if test="${record.class.declaredFields.name.contains('fullText') && record.fullText}">
        <br/>full${record.fullText?.replaceAll('\n', '<br/>')}
    </g:if>
     <g:if test="${record.class.declaredFields.name.contains('notes') && record.notes}">
         <br/>       notes <i>${record.notes?.replaceAll('\n', '<br/>')?.decodeHTML()}</i>
    </g:if>
        <br/>
        <br/>
        <hr/>
    </div>
    </g:if>
<g:else>
            <table class="recordLine recordContainer recordCard" style="width: 100% !important; padding: 0px !important;  margin-bottom: 10px; border-radius: 0px; border-collapse: collapse" id="${entityCode}Record${record.id}">
                <tbody>

                <tr style="background: #f2f2f2;  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2);">

                    %{--<td class="record-id" style="width: 15px" >--}%



                    %{--<g:remoteLink controller="generics" action="toggleSelection"--}%
                    %{--params="${[id: record.id, entityCode: (record.class.declaredFields.name.contains('entityCode') ? record.entityCode : record.class.name)]}"--}%
                    %{--update="${(record.class.declaredFields.name.contains('entityCode') ? record.entityCode : record.class.name)}Record${record.id}"--}%
                    %{--title="Edit">--}%
                    %{--<g:if test="${session['record' + (record.class.declaredFields.name.contains('entityCode') ? record.entityCode : record.class.name) + record.id] == '1'}">--}%
                    %{--<i><b style="font-size: 10px;">${(record.class.declaredFields.name.contains('entityCode') ? record.entityCode : record.class.name)}</b></i>--}%
                    %{--</g:if>--}%
                    %{--<g:else>--}%


                    %{--<sup style="color: #6E6E6E; font-size: 10px; padding-top: 3px;">${record.id}</sup>--}%

                    %{--</g:else>--}%



                    %{--</g:remoteLink>--}%

                    %{--</td>--}%

                    <td class="record-id" style="line-height: 2.8em; vertical-align: top;">
                    <table border="0">
                        <tr>

                            <td style="padding-right: 3px; line-height: 1.4em;">

                                <div style="font-size: xx-small;">
                                    ${record.class.declaredFields.name.contains('type') && record.type ? record.type?.code : ''}
                                </div>
                                <g:remoteLink controller="generics" action="showSummary"
                                              tabindex="-1"
                                              class="refresh"
                                              params="${[id: record.id, entityCode: entityCode]}"
                                              update="${entityCode}Record${record.id}"
                                              style="margin-left: 3px;padding-bottom: 1px; display: inline"
                                              title="ID ${record.id}. Click to refresh">


                                    <span class="${entityCode}-bkg  ${entityCode == 'N' && record.entityCode != null ? 'non-genuineNote' : ''} ${entityCode == 'T' && record.isTodo ? 'todoTask' : ''} ${entityCode == 'O' ? (record.validOn == true ? 'correctCommand' : 'wrongCommand') : ''} ID-bkg"
                                          style="padding: 2px; margin-right: 2px; color: white; display: inline; border-radius: 4px;" title="${new DecimalFormat("#,###").format(record.id)}">
                                        <span style="display: inline-block; color: white; padding: 4px;">
                                            <b>${entityCode}</b><sup style="color: black;font-size: x-small; ">${record.class.declaredFields.name.contains('priority') && record.priority ? record.priority: ''}</sup><sub style="position: relative; top: 0.2em; left: -0.5em;color: black;font-size: x-small; ">${record.class.declaredFields.name.contains('department') && record.department ? record.department?.code: ''}</sub>
                                        </span></g:remoteLink>
%{--                                    <span style="font-size: x-small">--}%
%{--                                        ${new DecimalFormat("#,###").format(record.id)}--}%
%{--                                    </span>--}%


%{--                                <g:if test="${record.class.declaredFields.name.contains('type') && record.type}">--}%
%{--                                    <div style="font-size: smaller;margin: 3px; padding: 2px; border-radius: 0px; border: 1px solid darkgray; color: white; font-weight: bold; background: #695b7e; font-family: monospace">${record.type?.code}</div>--}%
%{--                                </g:if>--}%


                            </td>



                        </tr>

                    </table>

                        %{--</g:if>--}%
                    </td>



                    <td class="record-summary ${record.class.declaredFields.name.contains('isMerged') && record.isMerged ? 'merged' : '' }  ${record.class.declaredFields.name.contains('deletedOn') && record.deletedOn ? 'deleted' : '' }  text${record.class.declaredFields.name.contains('language') ? record.language : (entityCode == 'E' ? record?.book?.language : '')} ${record.class.declaredFields.name.contains('status') && record.status ? 'status-' + record?.status?.code : ''}"

                        style="width: 98%; font-size: 0.95em; vertical-align: middle; line-height: 1.4em; color: #105CB6; padding-right: 4px; padding-left: 4px; padding-bottom: 7px; padding-top: 7px; text-align: justify !important;">

                    %{--<g:remoteLink controller="generics" action="showDetails"--}%
                    %{--params="${[id: record.id, entityCode: entityCode]}"--}%
                    %{--update="below${entityCode}Record${record.id}"--}%
                    %{--title="Details">--}%
                    %{--<g:render template="/gTemplates/summaryField" model="[record: record, entityCode: entityCode]"/>--}%
                    %{----}%
                    %{--</g:remoteLink>--}%










                    %{--<g:if test="${record.class.declaredFields.name.contains('type') && entityCode.length() == 1}">--}%
                    %{--<g:set value="type" var="field"></g:set>--}%
                    %{--<span style="min-width: 60px;">--}%
                    %{--<a href="#" id="${field}${record.id}" class="${field}" data-type="select" data-value="${record[field]?.id}"--}%
                    %{--style="${record.type ? record.type?.style : ''};font-size: 0.9em; font-weight: bold;margin-left: 5px;"--}%
                    %{--data-name="${field}-${entityCode}"--}%
                    %{--data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"--}%
                    %{--data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2" data-title="Edit ${field}">--}%
                    %{--<br/>  ${record[field]?.code ?: ''}--}%
                    %{--</a>--}%
                    %{--</span>--}%
                    %{--<script>--}%
                    %{--$('#${field}${record.id}').editable();--}%
                    %{--</script>--}%
                    %{--</g:if>--}%



                    %{--<span style="float: right">--}%
                    %{--<a class="fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
                    %{--onclick="jQuery('#appendRow${entityCode}-${record.id}').removeClass('navHidden'); jQuery('#appendTextFor${entityCode}${record.id}').select(); jQuery('#appendTextFor${entityCode}${record.id}').focus();">--}%
                    %{--<span class="ui-icon ui-icon-arrowreturn-1-e"></span>--}%
                    %{--</a>--}%


                    %{--<g:remoteLink controller="page" action="panel"--}%
                    %{--params="${[id: record.id, entityCode: entityCode]}"--}%
                    %{--update="3rdPanel"--}%
                    %{--before="jQuery('#accordionEast').accordion({ active: 0});"--}%
                    %{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
                    %{--title="Go to page">--}%
                    %{--<span class="ui-icon ui-icon-extlink"></span>--}%

                    %{--</g:remoteLink>--}%



                    %{--<g:remoteLink controller="generics" action="fetchAddForm"--}%
                    %{--params="[entityController: i.controller, updateRegion: 'centralArea']"--}%
                    %{--update="centralArea">--}%
                    %{--+ note--}%
                    %{--</g:remoteLink>--}%




                    %{--<td  colspan="10" class="record-summary text${record.class.declaredFields.name.contains('language') ? record.language : ''} ${record.class.declaredFields.name.contains('status') && record.status ? 'status-' + record?.status?.code: ''}"--}%
                    %{--onmouseover="jQuery('.temp44').addClass('actionsButtons'); jQuery('#actionsButtons${record.id}').removeClass('actionsButtons')"--}%
                    %{--style="font-family: Arial; font-size: 0.95em; color: #105CB6; padding-right: 3px; padding-left: 3px; padding-bottom: 3px; padding-top: 2px;">--}%


                    %{--<g:render template="/gTemplates/summaryField" model="[record: record, entityCode: entityCode]"/>--}%


                        %{--before="jQuery('#accordionEast').accordion({ active: 0});jQuery('#3rdPanel').scrollTop(0)"--}%

                        <g:remoteLink controller="page" action="panel"
                                      tabindex="-1"
                                      params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                      update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                      title="Go to page">
                            <g:if test="${record.class.declaredFields.name.contains('keepSecret')}">
                                <g:if test="${record.keepSecret}">
                                    <b>&notin;&notin;</b>
                                </g:if>
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('occurence') && record.occurence}">
                                o${record.occurence}
                            </g:if>







                        %{--todo fix and simplify display of start and end dates--}%
                        %{--<g:if test="${record.class.declaredFields.name.contains('startDate') && record.startDate}">--}%
                        %{--<span title="s${record.startDate?.format(OperationController.getPath('datetime.format'))} e${record.endDate?.format(OperationController.getPath('datetime.format'))}">--}%


                        %{--<g:if test="${'JP'.contains(entityCode)}">--}%

                        %{--<g:if test="${record.level != 'd'}">--}%
                        %{--<div style="display: inline; padding: 2px; margin: 3px;" class="record-level level${record.level}"--}%
                        %{--title="Level">--}%
                        %{--l<sup>${record.level}</sup>--}%
                        %{--</div>--}%

                        %{--</g:if>--}%


                        %{--<g:if test="${record.level == 'm'}">--}%
                        %{--<span class="hour">${record.startDate?.format('HH')}</span>--}%
                        %{--&larr;<span--}%
                        %{--class="hour">${record.endDate?.format('HH')}</span>--}%
                        %{--&nbsp;--}%
                        %{--<i><pkm:weekDate date="${record?.startDate}"/></i>--}%

                        %{--</g:if>--}%
                        %{--<g:elseif test="${'rMWA'.contains(record.level)}">--}%
                        %{--<i><pkm:weekDate date="${record?.startDate}"/></i>--}%
                        %{--&larr;<pkm:weekDate date="${record?.endDate}"/>--}%
                        %{--(${record.level})--}%
                        %{--</g:elseif>--}%
                        %{--<g:else>--}%
                        %{--<i><pkm:weekDate date="${record?.startDate}"/></i>--}%
                        %{--(${record.level})--}%
                        %{--</g:else>--}%

                        %{--</span>--}%

                        %{--</g:if>--}%
                        %{--<g:else>--}%
                        %{--<span title="${record.startDate?.format(OperationController.getPath('datetime.format'))}">--}%
                        %{--<i><pkm:weekDate date="${record?.startDate}"/></i>--}%
                        %{--</span>--}%
                        %{--</g:else>--}%
                        %{--</g:if>--}%


                            <g:if test="${record.class.declaredFields.name.contains('status') && record.status}">
                                <span style="margin: 2px; padding: 2px; border-radius: 5px; border: 1px solid darkgray; color: darkorange; font-style: italic; font-weight: normal;">${record.status?.code}</span>
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('summary')}">

                            %{--<g:remoteLink controller="generics" action="fetchQuickAddForm"--}%
                            %{--style="padding: 2px; font-size: 0.95em;"--}%
                            %{--class="${record.class.declaredFields.name.contains('priority') ? 'priorityText' + record.priority : ''}"--}%
                            %{--id="${record.id}"--}%
                            %{--params="[entityController: record.class.name,--}%
                            %{--updateRegion    : '3rdPanel',--}%
                            %{--finalRegion     : '3rdPanel']"--}%
                            %{--update="3rdPanel"--}%
                            %{--before="jQuery('#accordionEast').accordion({ active: 0});jQuery('#3rdPanel').scrollTop(0)"--}%
                            %{--title="Edit">--}%
                            %{--<i style="font-size: 10px;">--}%
                            %{--...--}%
                            %{--</i>--}%
                            %{--</g:remoteLink>--}%

                                <g:if test="${record.class.declaredFields.name.contains('course' +
                                        '') && record.course}">
                                    <span style="padding: 1px 2px; margin: 0px 2px; font-size: small; border-radius: 3px; border-bottom: 1px solid darkgray; color: black; font-weight: bold; font-family: monospace">
                                        ${record.course?.code ? record.course?.code : record.course}</span>
                                </g:if>


                                <g:remoteLink controller="page" action="panel"
                                              tabindex="-1"
                                    class="openPanelButton"
                                              params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                              update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                              style="padding: 2px; font-size: 1em;"
                                              before="myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">
                                %{--class="${record.class.declaredFields.name.contains('priority') ? 'priorityText' + record.priority : ''}"--}%
                                    <g:if test="${!record.summary}">
                                        ...
                                    </g:if>
                                    <g:if test="${record.summary}">
                                        <span title="${record.summary}" style="font-family: Lato !important; font-weight: normal; font-size: 1em;">
                                            <g:if test="${entityCode == 'E'}">
                                                <br/>
                                            </g:if>
                                            <g:if test="${record.class.declaredFields.name.contains('publishedNodeId') && record.publishedNodeId && record.status?.code != 'repub'}">
                                                <span style="font-size: large; color: darkgreen"> &copy; </span>
                                            </g:if>
                                            <g:elseif  test="${record.class.declaredFields.name.contains('publishedNodeId') && record.publishedNodeId && record.status?.code == 'repub'}">
                                                <span style="font-size: 0.95em; color: darkred"> &copy; </span>
                                            </g:elseif>
                                            <g:if  test="${record.class.declaredFields.name.contains('context') && record.context}">
                                                <span style="background: 1px solid darkyellow; font-size: 0.95em; font-weight: bold;color: darkgreen"> @${record.context?.code} </span>
                                            </g:if>
                                        %{--<bdi>--}%
                                            <pkm:summarize text="${record.summary ?: ''}"
                                                           length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/>


                                        %{--</bdi>--}%
%{--                                        <br/>--}%
                                        </span>
                                    </g:if>
                                </g:remoteLink>

                            </g:if>

                            <g:if test="${entityCode == 'Blog'}">
                            <a href="${createLink(controller: 'operation', action: 'htmlPublishedPosts')}" style="border: 1px solid darkgray; margin: 3px;"
                               target="_blank">
                                Export W ?pub
                            </a>
                            </g:if>


                            <g:if test="${entityCode == 'X' && ker.OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">


                                <g:if test="${record.queryType == 'hql'}">


                                    <g:remoteLink controller="generics" action="executeSavedSearch"
                                                  tabindex="-1"
                                                  style=" color: gray"
                                                  before="jQuery.address.value(jQuery(this).attr('href'));"
                                                  id="${record.id}" params="[reportType: 'random']"
                                                  update="centralArea">
                                        rand

                                    </g:remoteLink>

                                    <g:link controller="generics" action="executeSavedSearch"
                                            style=" color: gray"
                                            id="${record.id}" params="[reportType: 'tab']"
                                            target="_blank">
                                        tab
                                    </g:link>
                                    </sup>

                                    <g:if test="${record.calendarEnabled}">
                                        <sub>
                                            <g:link controller="generics" action="executeSavedSearch"
                                                    style=" color: gray"
                                                    id="${record.id}" params="[reportType: 'cal']"
                                                    target="_blank">
                                                cal
                                            </g:link>

                                        </sub>
                                    </g:if>

                                </g:if>


                            </g:if>


                        %{--<g:if test="${record.class.declaredFields.name.contains('slug') && record.slug}">--}%
                        %{--<span style="color: #004499; font-family: monospace">${record.slug}</span>--}%
                        %{--</g:if>--}%

                            <span style="direction: rtl; text-align: right;">
%{--<g:if test="${record.class.declaredFields.name.contains('department') && record.department}">--}%
%{--                        <span style="margin: 2px; font-size: 1.2em; padding: 3px; border-radius: 4px; color: white; font-weight: bold; background: #0d4f98; font-family: monospace">--}%
%{--                            ${record.department?.code}--}%
%{--                        </span>--}%
%{--    &nbsp;--}%
%{--                        </g:if>--}%


%{--                                <br/>--}%



                                <g:if test="${record.class.declaredFields.name.contains('task') && record.task}">
                        <span style="margin: 2px; padding: 2px; border-radius: 5px; border: 1px solid darkolivegreen; color: darkgreen; font-style: italic; font-size: normal">T ${record.task}</span>
                        </g:if>

                            </span>

                            <g:if test="${record.class.declaredFields.name.contains('entity')}">
                                <span title="${record.entity}">
                                    <i>${record.entity}</i>
                                </span>
                            </g:if>




                            <g:if test="${record.class.declaredFields.name.contains('name')}">
                                <span title="${record.name}">
                                    <b>${record.name}</b>
                                </span>

                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('value')}">
                                <span title="${record.value}">
                                    <i>${record.value}</i>
                                </span>

                            </g:if>


                            <g:if test="${entityCode == 'C'}">
                                <b>${record.numberCode}</b>

                            </g:if>



                            <g:if test="${'N'.contains(entityCode)}">
                            %{--<g:if test="${record.fileName}">--}%
                            %{--<a href="${createLink(controller: 'operation', action: 'downloadNoteFile', id: record.id)}"--}%
                            %{--target="_blank">--}%
                            %{--<span style="font-size: 0.9em; font-style: italic; text-decoration: underline">--}%
                            %{--${record.fileName}--}%
                            %{--</span>--}%
                            %{--</a>--}%
                            %{--</g:if>--}%



                                %{--<g:if test="${record.source}">--}%
                                    %{--<i style="font-size: smaller"><pkm:summarize text="${record.source}"--}%
                                                                                 %{--length="30"/></i>--}%
                                %{--</g:if>--}%


                                %{--<g:if test="${record.sourceFree}">--}%
                                    %{--<i style="font-size: smaller"><pkm:summarize text="${record.sourceFree}"--}%
                                                                                 %{--length="30"/></i>--}%
                                %{--</g:if>--}%

                            </g:if>

                            <g:if test="${record.class.declaredFields.name.contains('reality') && record.reality}">
                                <span style="color:#b22222 ">
                                    ${record.reality}
                                </span>
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('trackSequence') && record.trackSequence}">
                                <b>${record.trackSequence}</b>
                            </g:if>





                            <g:if test="${record.class.declaredFields.name.contains('readOn') && record.readOn}">
                                <img src="${resource(dir: '/images', file: 'edx-check.png')}" style="width: 15px;"
                                     title="${record.readOn?.format('dd.MM.yyyy HH:mm')}"/>
                            %{--Read ${record.readOn?.format('dd.MM.yyyy')}--}%
                            </g:if>

                            <g:if test="${record.class.declaredFields.name.contains('reviewCount') && record.reviewCount}">
                                &nabla; <sup>${record.reviewCount}</sup>
                            </g:if>

                            <g:if test="${record.class.declaredFields.name.contains('chapters') && record.chapters}">
                                &nbsp; -
                                 ch ${record.chapters}
                            </g:if>

     <g:if test="${record.class.declaredFields.name.contains('fileName') && record.fileName}">
                                &nbsp; -
                                 f:${record.fileName}
                            </g:if>



                            <g:if test="${entityCode == 'R'}">

                                <g:remoteLink controller="page" action="panel"
                                              tabindex="-1"
                                              class="openPanelButton"
                                              params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                              update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                              before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);"
                                              style="padding: 4px; font-size: 1em; font-weight: normal">


                                    <pkm:summarize text="${(record.title ?: '...')}"
                                                   length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/>
                                    <i style="font-size: 0.95em; color: #2d2d2d"><pkm:summarize
                                            text="${record.author ?: ''}"
                                            length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/></i>
                                    ${record.publisher ?: ''}

                                %{--</bdi>--}%
                                    <g:if test="${record.legacyTitle}">
                                        <i style="text-decoration: line-through;">${record.legacyTitle}</i>
                                    </g:if>

                                    <g:if test="${record.url}">

                                        <a style="font-size: smaller" href="${record.url}" target="_blank">
                                            <pkm:summarize text="${record.url}" length="30"/></a>
                                    </g:if>


                                    <g:if test="${record.class.declaredFields.name.contains('publicationDate') && record.publicationDate}">
                                        <span style="font-size: 0.95em; text-weight: bold;">
                                            &nbsp;    ${record.publicationDate}
                                        </span>
                                    </g:if>
                                    <g:if test="${record.class.declaredFields.name.contains('year') && record.year}">
                                        <span style="font-size: 0.95em; text-weight: bold;">
                                            &nbsp;    ${record.year}
                                        </span>
                                    </g:if>

                                </g:remoteLink>
<br/>
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('code') && record.code}">
                                =<span
                                    style="color: #004499; font-style: italic; font-family: monospace">${record.code}</span>
                            </g:if>


                            <g:if test="${'J'.contains(entityCode) && new File(OperationController.getPath('jrn.sns.path') + '/J/' + record.id).exists()}">
                                <b style="color: darkgreen">sns</b> &nbsp;
                            </g:if>

                            <g:if test="${'J'.contains(entityCode) && new File(OperationController.getPath('jrn.rcd.path') + '/J/' + record.id).exists()}">
                                <b style="color: darkgreen">rcd</b> &nbsp;
                            </g:if>
                            <g:if test="${'J'.contains(entityCode) && new File(OperationController.getPath('jrn.vjr.path') + '/J/' + record.id).exists()}">
                                <b style="color: darkgreen">vjr</b> &nbsp;
                            </g:if>






                            <g:if test="${record.class.declaredFields.name.contains('excerpt') && record.excerpt}">

                                <g:remoteLink controller="generics" action="showSummary" id="${record.excerpt.id}"
                                              tabindex="-1"
                                              params="[entityCode: 'R']"
                                              update="below${entityCode}Record${record.id}"
                                              title="Go to record">
                                    <b>E-${record.excerpt?.title}</b>
                                </g:remoteLink>

                            </g:if>






                            <g:if test="${entityCode == 'R' && record.isPublic}">
                                <span>shared</span>
                            </g:if>


                            <g:if test="${context}">
                                ${context} <br/>
                            </g:if>







                            <g:if test="${entityCode == 'Q'}">
                                !<b style="color: darkred;">${record?.category?.code}</b>
                                [${new DecimalFormat('#,###').format(record.amount)}]
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('description') && record.description}">
                                %{--<br/>--}%
                                <g:if test="${record.class.declaredFields.name.contains('language') && record.language}">
                                    <span class="${OperationController.getPath('repository.languages.RTL').contains(record.language) ? 'RTLText' : 'LRTText'}">
                                </g:if>
                                <span style="font-size: 0.95em !important; color: #272727 !important; padding: 3px; line-height: 1.4em;">
                                    <g:if test="${entityCode == 'N' && record?.type?.code == 'word'}">
                                        <span id="descriptionArea${record.id}">
                                            <g:remoteLink controller="generics" action="showAnswer"
                                                          tabindex="-1"
                                                          id="${record.id}"
                                                          params="[entityCode: entityCode]"
                                                          update="descriptionArea${record.id}"
                                                          title="Show answer">
                                                &nbsp;show&nbsp;
                                            </g:remoteLink>
                                        </span>
                                    </g:if>
                                    <g:else>
                                        <g:if test="${record.description?.length() < OperationController.getPath('description.summarize.threshold')?.toInteger() && record.description != '?'}">
                                            <g:remoteLink controller="page" action="panel"
                                                          tabindex="-1"
                                                          params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                                          update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                                          style="padding: 2px; font-size: 0.95em;"
                                                          before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">
                                                ${record?.description?.replaceAll("\\<.*?>", "")?.replaceAll('\n', '\n')?.decodeHTML()?.replaceAll('\n', '\n')?.replace('Product Description', '')}
                                            </g:remoteLink>
                                        </g:if>


                                        <g:if test="${1 == 2 && record.description?.length() < OperationController.getPath('description.summarize.thresholdMax')?.toInteger() &&
                                                record.description?.length() > OperationController.getPath('description.summarize.threshold')?.toInteger()}">

                                            <span id="descriptionArea${record.id}">
                                                <g:remoteLink controller="generics" action="showFullDescription"
                                                              tabindex="-1"
                                                              id="${record.id}"
                                                              params="[entityCode: entityCode]"
                                                              update="descriptionArea${record.id}"
                                                              title="Show full description">
                                                    <pkm:summarize
                                                            text="${record?.description?.replace('Product Description', '')?.replaceAll("\\<.*?>", "")}"
                                                            length="${OperationController.getPath('description.summarize.threshold')?.toInteger()}"/>
                                                    (${record.description?.count(' ')})
                                                </g:remoteLink>
                                            </span>

                                        </g:if>
                                        <g:if test="${record.description?.length() > OperationController.getPath('description.summarize.threshold')?.toInteger()}">

                                            <g:remoteLink controller="page" action="panel"
                                                          tabindex="-1"
                                                          params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                                          update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                                          style="padding: 4px; font-size: 0.95em;"
                                                          before=" myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0});">

                                                <pkm:summarize
                                                        text="${record?.description?.replace('Product Description', '')?.replaceAll("\\<.*?>", "")}"
                                                        length="${OperationController.getPath('description.summarize.threshold')?.toInteger()}"/>
                                                (${record.description?.count(' ')})
                                            </g:remoteLink>

                                        </g:if>
                                    </g:else>
                                </span>
                                <g:if test="${record.class.declaredFields.name.contains('language')}">
                                    </span>
                                </g:if>

                            </g:if>



                            <g:if test="${record.class.declaredFields.name.contains('fullText') && record.fullText}">

                                <g:remoteLink controller="page" action="panel"
                                              tabindex="-1"
                                              params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                              update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                              style="padding: 4px; font-size: 0.95em;"
                                              before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">

                                    <span style="font-size: 0.95em; font-style: italic; color: #435d59">
                                        <pkm:summarize text="${record.fullText}"
                                                       length="${OperationController.getPath('description.summarize.threshold')?.toInteger()}"/>
                                        (${record.fullText?.count(' ')})
                                    </span>
                                </g:remoteLink>
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('password')}">
                                <span style="font-size: 0.95em; color: #8A5C69">
                                    ${record.password}
                                </span>
                            </g:if>


                            <g:if test="${'N'.contains(entityCode)}">

                                <g:if test="${record.pages}">
                                    <i>pg. ${record.pages}</i>
                                </g:if>
                            </g:if>


                            <g:if test="${record.class.declaredFields.name.contains('notes') && record.notes}">
                                <span style="color:#7588b2 ">
                                    <pkm:summarize text="${record.notes}"
                                                   length="${OperationController.getPath('notes.summarize.threshold')?.toInteger()}"/>
                                    (${record.notes?.count(' ')})
                                </span>
                            </g:if>



                            <g:if test="${record.class.declaredFields.name.contains('nbFiles') && record.nbFiles}">
                            %{--<g:if test="${record.nbFiles}">--}%
                                <span title="${record.filesList}" style="font-weight: bold">${record.nbFiles ?: ''}</span> files
                            </g:if>

%{--                            <span style="">--}%
%{--                                <g:if test="${record.class.declaredFields.name.contains('orderInBook')}">--}%
%{--                                    <g:if test="${record.orderInBook}">--}%
%{--                                        <span style="font-size: 0.95em;">ib ${record.orderInBook}</span>--}%
%{--                                    </g:if>--}%
%{--                                </g:if>--}%
%{--                            </span>--}%

                        </g:remoteLink>

                        <span id="datesSpan" style="direction: ltr !important; text-align: left !important;">

                            <g:remoteLink controller="page" action="panel"
                                          tabindex="-1"
                                          params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                          update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                          style="padding: 1px; font-size: 0.95em;"
                                          before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);"
                                          title="Created ${record?.dateCreated?.format('dd.MM.yyyy')}">

                                <g:if test="${record.class.declaredFields.name.contains('completedOn') && record.completedOn}">

                                    <span
                                            title="${record.completedOn?.format(OperationController.getPath('datetime.format'))}"
                                            style="font-size: 0.95em; font-style: italic;">

                                        c<pkm:weekDate date="${record?.completedOn}"/>
                                    </span>
                                </g:if>


                            %{--<g:if test="${'R'.contains(entityCode)}">--}%
                            %{--<g:if test="${record.publicationDate}">--}%
                            %{--<b>    ${record.publicationDate ?: record.year}--}%
                            %{--</b>--}%
                            %{--</g:if>--}%
                            %{--</g:if>--}%




                                <g:if test="${'I'.contains(entityCode)}">
                                    <pkm:weekDate date="${record?.date}"/>
                                </g:if>
                                <g:elseif test="${'Q'.contains(entityCode)}">
                                    <pkm:weekDate date="${record?.date}"/>
                                </g:elseif>

                            %{--<g:else>--}%

                            %{--<g:else>--}%
                            %{--<i>--}%
                            %{--<prettytime:display--}%
                            %{--date="${record?.dateCreated}"></prettytime:display>--}%
                            %{--</i>--}%
                            %{--</g:else>--}%
                            %{--<pkm:weekDate date="${record?.dateCreated}"/>--}%
                            %{----}%
                            %{--</g:else>--}%
                            </g:remoteLink>
                        </span>

                        <g:if test="${record.class.declaredFields.name.contains('tags') && record.tags}">
%{--                            <br/> &nbsp;--}%
                            <g:render template="/tag/tags" model="[instance: record, entity: entityCode]"/>
                        </g:if>
                        <g:if test="${record.class.declaredFields.name.contains('contacts') && record.contacts}">
                            &nbsp; <g:render template="/tag/contacts" model="[instance: record, entity: entityCode]"/>
                        </g:if>


                        %{--<br/>--}%

                        %{--<br/>--}%

                        <span id="statisticsSpan"
                              style="padding-left: 5px; padding-right: 5px;">

                            <g:remoteLink controller="generics" action="showChildren"
                                          tabindex="-1"
                                          params="${[id: record.id, entityCode: entityCode]}"
                                          update="below${entityCode}Record${record.id}"
                                          title="Children">
                                <g:if test="${entityCode == 'R'}">
                                    <g:if test="${Excerpt.countByBook(record)}">
                                        E <sup>${Excerpt.countByBook(mcs.Book.get(record.id))}</sup>
                                    </g:if>
                                    <g:if test="${Book.countByBook(record) > 0}">
                                        _R<sup>${Book.countByBook(mcs.Book.get(record.id))}</sup>
                                    </g:if>

                                    <g:if test="${IndexCard.countByBook(record)}">
                                        N<sup>${IndexCard.countByBook(mcs.Book.get(record.id))}</sup>
                                    </g:if>
                                    <g:if test="${Planner.countByBook(record)}">
                                        P<sup>${Planner.countByBook(record)}</sup>
                                    </g:if>
                                    <g:if test="${Journal.countByBook(record)}">
                                        J <sup>${Journal.countByBook(record)}</sup>
                                    </g:if>

                                </g:if>

                                <g:if test="${entityCode == 'C'}">

                                    <g:if test="${Planner.countByCourse(record) > 0}">
                                        P <sup>${Planner.countByCourse(record)}</sup>
                                    </g:if>
                                    <g:if test="${Journal.countByCourse(record) > 0}">
                                        J <sup>${Journal.countByCourse(record)}</sup>
                                    </g:if>
                                    <g:if test="${Writing.countByCourse(record) > 0}">
                                        W <sup>${Writing.countByCourse(record)}</sup>
                                    </g:if>
                                    <g:if test="${IndexCard.countByCourse(record) > 0}">
                                        N <sup>${IndexCard.countByCourse(record)}</sup>
                                    </g:if>
                                    <g:if test="${Book.countByCourse(record) > 0}">
                                        R <sup>${Book.countByCourse(record)}</sup>
                                    </g:if>
                                    <g:if test="${Goal.countByCourse(record) > 0}">
                                        G <sup>${Goal.countByCourse(record)}</sup>
                                    </g:if>
                                    <g:if test="${Task.countByCourse(record) > 0}">
                                        T <sup>${Task.countByCourse(record)}</sup>
                                    </g:if>
                                </g:if>


                                <g:if test="${entityCode == 'T'}">

                                    <g:if test="${Planner.countByTask(record) > 0}">
                                        P <sup>${Planner.countByTask(record)}</sup>
                                    </g:if>
                                    <g:if test="${Journal.countByTask(record) > 0}">
                                        J <sup>${Journal.countByTask(record)}</sup>
                                    </g:if>
%{--                                    <g:if test="${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id) > 0}">--}%
%{--                                        N <sup>${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id)}</sup>--}%
%{--                                    </g:if>--}%

                                </g:if>
                                <g:if test="${entityCode == 'G'}">

                                    <g:if test="${Task.countByGoal(record) > 0}">
                                        T <sup>${Task.countByGoal(record)}</sup>
                                    </g:if>
                                </g:if>

                                <g:if test="${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id) > 0}">
                                    N <sup>${app.IndexCard.countByEntityCodeAndRecordId(record.entityCode(), record.id)}</sup>
                                </g:if>



                                <g:if test="${entityCode == 'K'}">
                                    <i>(${IndicatorData.countByIndicator(record)})</i>
                                </g:if>

                            %{--<g:if test="${entityCode == 'Q'}">--}%
                            %{--# <sup>${PaymentData.countByCategory(record)}</sup>--}%
                            %{--todo--}%
                            %{--</g:if>--}%
                            %{--</g:if>--}%
                            %{--</span>--}%
                            %{--</td>--}%






                            %{--<g:if test="${'CW'.contains(entityCode)}">--}%

                            %{--<td class="actionTd">--}%

                            %{--<g:link controller="page" action="publish" target="_blank"--}%
                            %{--params="${[id: record.id, entityCode: entityCode]}"--}%
                            %{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
                            %{--title="Publish">--}%
                            %{--<span class="ui-icon ui-icon-script"></span>--}%
                            %{--</g:link>--}%

                            %{--<g:link controller="page" action="presentation" target="_blank"--}%
                            %{--params="${[id: record.id, entityCode: entityCode]}"--}%
                            %{--class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"--}%
                            %{--title="presentation">--}%
                            %{--<span class="ui-icon ui-icon-script"></span>--}%

                            %{--</g:link>--}%




                            %{--</td>--}%


                            %{--</g:if>--}%





                            %{--<tdclass="actionTd">--}%
                            %{----}%
                            %{--</td>--}%
                            </g:remoteLink>

                        </span>
                        %{--<g:if test="${session['showFullCard'] == 'on'  || showFull}">--}%


                        %{--</g:if>--}%
                    </td>




                    <td class="" style="">

<table border="0" style="border: 0">
    <tr>
        <td>  <g:if test="${record.class.declaredFields.name.contains('bookmarked')}">
    <g:if test="${!record.bookmarked}">
        <a name="bookmark${record.id}${entityCode}"
           title="Toggle bookmark"
            class="quickBookmarkButton"
           value="${record.bookmarked}"
           onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/quickBookmark/${entityCode}-${record.id}')">
            <span class="icon-star-gm"></span>
        </a>
    </g:if></td>
        <td>  <g:if test="${record.bookmarked}">
            <a name="bookmark${record.id}${entityCode}"
               title="Toggle bookmark"
               value="${record.bookmarked}"
               class="quickBookmarkButton"
               onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/quickBookmark/${entityCode}-${record.id}')">
                <span class="icon-starred-gm"></span>
            </a>
        </g:if>
    </g:if>
    </td>
        <td>  <a
                title="Actions"
                class="fg-button ui-widget ui-state-default ui-corner-all" style="padding: 0px 3px; margin: 2px;"
                onclick="jQuery('.temp44').addClass('hiddenActions');jQuery('#actionsButtons${entityCode}Record${record.id}').removeClass('hiddenActions')">
            &hellip;
        </a>
        </td>
    </tr>
</table>




                    </td>


                    %{--<g:if test="${new File(OperationController.getPath('root.rps1.path') + '/' + entityCode + '/' + record.id + '/' +  'cover.jpg')?.exists() ||--}%
                            %{--new File(OperationController.getPath('root.rps2.path') + '/' + entityCode + '/' + record.id + '/' +  'cover.jpg')?.exists()}">--}%

                        <td style="width: 95px !important;">

                            <ul class="product-gallery">

                                <li class="gallery-img" id="recordImage${record.id}">
                                    <img class="Photo" style="height: 90px; width: auto; display:inline" onerror="this.style.display='none'"
                                         src="${createLink(controller: 'generics', action: 'viewRecordImage', id: record.id, params: [entityCode: entityCode, date: new Date()])}"/>

                                </li>
                            </ul>
                            <script type="text/javascript">
                                jQuery('#recordImage${record.id}').Am2_SimpleSlider();
                            </script>

                        </td>

                    %{--</g:if>--}%
%{--legacy case--}%
                    <g:if test="${entityCode == 'R'}">
                        <g:if test="${(new File(OperationController.getPath('root.rps1.path') + "/${entityCode}/cvr/" +
                                '/' + record.id + '')?.exists() ||
                                new File(OperationController.getPath('root.rps2.path') +
                                        "/${entityCode}/cvr/" + '/' + record.id + '')?.exists())}">
                            <td style="width: 85px;">
                                <ul class="product-gallery">
                                    <li class="gallery-img" id="recordImageCover${record.id}">
                                        <img class="Photo" style="width: 60px; height: 80px; display:inline"
                                             src="${createLink(controller: 'book', action: 'viewImage', id: record.id, params: [date: new Date()])}"/>
                                    </li>
                                </ul>
                                <script type="text/javascript">
                                    jQuery('#recordImageCover${record.id}').Am2_SimpleSlider();
                                </script>
                            </td>
                        </g:if>
                    </g:if>

                <g:elseif test="${entityCode.length() == 1 && (new File(OperationController.getPath('root.rps1.path') + "/${entityCode}/" + record.id  + '/' +
                record.id +  entityCode.toLowerCase() + '.jpg')?.exists() || new File(OperationController.getPath('root.rps2.path') + "/${entityCode}/" + record.id  + '/' +
                record.id + entityCode.toLowerCase() + '.jpg')?.exists())}">

                <td style="width: 55px;">

                <ul class="product-gallery">
                <li class="gallery-img" id="recordImageCover${record.id}">
                <img class="Photo"
                     style="height: 80px; display:inline"
                src="${createLink(controller: 'indexCard', action: 'viewImage', id: record.id, params: [entityCode: entityCode, date: new Date()])}"/>
                </li>
                </ul>
                <script type="text/javascript">
                jQuery('#recordImageCover${record.id}').Am2_SimpleSlider();
                </script>
                </td>
                </g:elseif>

                    <g:if test="${entityCode == 'E'}">

                        <g:if test="${(new File(OperationController.getPath('covers.sandbox.path') + '/exr/' +
                                record?.id + '.jpg')?.exists() || new File(OperationController.getPath('covers.repository.path') + '/exr/' + record?.id + '.jpg')?.exists())}">
                            <td>

                                <ul class="product-gallery">

                                    <li class="gallery-img" id="recordImageCover${record.id}">
                                        <img class="Photo" style="width: 50; height: 70; display:inline"
                                             src="${createLink(controller: 'book', action: 'viewExcerptImage', id: record.id, params: [date: new Date()])}"/>

                                    </li>
                                </ul>
                                <script type="text/javascript">
                                    jQuery('#recordImageCover${record.id}').Am2_SimpleSlider();
                                </script>

                            </td>
                        </g:if>

                    </g:if>

                %{--</td>--}%

                </tr>

                <tr>
                    <td colspan="4">
                    <div class="recordContainer"
                         id="2ndLine${entityCode}${record.id}"
                         style="opacity: 0.95; padding: 0px; margin: 0px; display: inline;">
                        %{-- class += hiddenActions--}%

                        <div style="margin: 0 0px 0px 0px;" id="below${entityCode}Record${record.id}">
                        </div>
                        <div id="actionsButtons${entityCode}Record${record.id}"
                             class="temp44 hiddenActions actionsButtons"
                             style="text-align: left; direction: ltr; line-height: 20px;font-size: 0.95em !important; color: darkslategrey !important; column-count: 2">

                        <g:if test="${record.class.declaredFields.name.contains('context') && record.context}">
                                  <b>Context:</b>    <span style="margin: 2px; padding: 2px; border-radius: 5px; border: 1px solid darkolivegreen; color: darkblue; font-style: italic; font-size: normal">@${record.context?.code}</span>
                            <br/>   </g:if>

                        <g:if test="${'JPT'.contains(entityCode) && record?.startDate}">
                            <br/>
                            <span style="margin: 0px; font-size: 0.95em; padding: 2px; border-radius: 3px; border-bottom: 0px solid darkgray; direction: ltr; text-align: left;"
                                  title="${record?.startDate?.format('HH:mm')} - ${record?.endDate?.format('HH:mm')}">
                          <b>Start date:</b>
                                <u>${record?.startDate?.format('EEE dd.MM.yyyy')}</u>
                            </span>
                        %{--(<i><prettytime:display--}%
                        %{--date="${record?.startDate}"></prettytime:display></i>)--}%
                        </g:if>
                        <g:if test="${'R'.contains(entityCode) && record?.publishedOn}">
                            <br/>     <span style="margin: 2px; padding: 2px; border-radius: 3px; border-bottom: 1px solid darkgray;">
                                %{--                                &ang;--}%
                                p ${record?.publishedOn?.format('dd.MM.yyyy')}
                            </span>
                        %{--(<i><prettytime:display--}%
                        %{--date="${record?.startDate}"></prettytime:display></i>)--}%
                        </g:if>

                        <g:if test="${record.class.declaredFields.name.contains('endDate') && record.endDate}">
                            &nbsp;
                            <span class="${ 'T'.contains(entityCode) && record.endDate < new Date() - 1 && record.completedOn == null ? 'overDueDate' : ''}"
                                  title="e${record.endDate?.format(OperationController.getPath('datetime.format'))}">
                                %{--<pkm:weekDate date="${record?.endDate}"/>--}%
                                <span style="font-size: 0.95em; margin: 2px; padding: 2px; border-radius: 3px; border-bottom: 0px solid darkgray;">
                                    %{--                            &gt;--}%
                                    Due date: ${record?.startDate  && record?.endDate - record?.startDate == 0 ? record?.endDate?.format('HH:mm') : record?.endDate?.format('EE dd.MM.yyyy')}
                                </span>
                            </span>
                            <br/>
                        %{--<span title="s${record.endDate?.format(OperationController.getPath('datetime.format'))}">--}%
                        %{--<pkm:weekDate date="${record?.endDate}"/>--}%
                        %{--</span>--}%
                        %{--</g:else>--}%
                        </g:if>




                        ID:  <span style="color: darkslategrey; font-size: small;">${record.id}</span>
<br/>
                        <b>Edit:</b>
                            <g:remoteLink controller="generics" action="fetchAddForm" class="fullEditButton"
                                          tabindex="-1"
                                          id="${record.id}"
                                          params="[entityController: record.class.name,
                                                   updateRegion    : entityCode + 'Record' + record.id,
                                                   finalRegion     : entityCode + 'Record' + record.id]"
                                          update="${entityCode}Record${record.id}"
                                          title="Edit">
                            %{--<i style="font-size: 0.95em;">--}%
                                full (e)
                            %{--</i>--}%
                            </g:remoteLink>

                            <g:remoteLink controller="generics" action="fetchQuickAddForm"
                                          style="padding: 2px; font-size: 0.95em;"
                                          class="${record.class.declaredFields.name.contains('priority') ? 'priorityText' + record.priority : ''}  quickEditButton"
                                          id="${record.id}"
                                          params="[entityController: record.class.name,
                                                   updateRegion    : '3rdPanel',
                                                   finalRegion     : '3rdPanel']"
                                          update="3rdPanel"
                                          before="myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0});jQuery('#3rdPanel').scrollTop(0)"
                                          title="Edit">
                                quick (q)</g:remoteLink>

<br/>
                        <b>Add:</b>
                            <g:remoteLink controller="generics" action="showComment" style=""
                                          params="${[id: record.id, entityCode: entityCode]}"
                                          update="below${entityCode}Record${record.id}"
                                      class="addNoteButton"
                                          title="Comments">
                                note (N)
                            </g:remoteLink>

                       &nbsp;

<g:if test="${'O'.contains(entityCode)}">
                            <g:remoteLink controller="generics" action="verifyOperation"
                                          id="${record.id}"
                                          update="below${entityCode}Record${record.id}"
                                          title="Show parent entity">

                                <b>Verify</b>
                            </g:remoteLink>

    <g:remoteLink controller="generics" action="executeOperation"
                                          id="${record.id}"
        class="executeOperation"
                                          update="${entityCode}Record${record.id}"
                                          title="Show parent entity">

                                <b>Execute (x)</b>
                            </g:remoteLink>
</g:if>


                        <g:remoteLink controller="generics" action="showTags"
                                      params="${[id: record.id, entityCode: entityCode]}"
                                      class="addTagButton"
                                      update="below${entityCode}Record${record.id}"
                                      title="Details">
                            tag (t)
                        </g:remoteLink>

                          <br/>

                        <g:if test="${record.class.declaredFields.name.contains('type')}">
Type:
                            <g:set value="type" var="field"></g:set>
                        %{--<div style=" margin-top: 5px; padding-right: 1px;">--}%
                            <a href="#" id="2${field}${record.id}" class="${field}"
                               data-type="select"
                               data-value="${record.type?.id}"
                               data-name="${field}-${entityCode}"
                               style="font-size: 0.95em; font-weight: normal;"

                               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                               data-title="Edit ${field}">
                                ${record?.type?.code ?'#' + record?.type?.code : '#'}
                            </a>
                        %{--</div>--}%

                            %{--todo: success callback not working --}%

                            <script type="text/javascript">
                                jQuery("#2${field}${record.id}").editable(
                                        {showButtons: false, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                    jQuery('.selectedRecord .refresh').click();
                                }}
                                );
                            </script>

                        </g:if>

                    %{--<g:if test="${session['showFullCard'] == 'on'  || showFull}">--}%

                    %{--<g:if test="${session['showFullCard'] == 'on'  || showFull}">--}%
                        <g:if test="${record.class.declaredFields.name.contains('status')}">
                            <br/>
                            Status:
                            <div style="padding-right: 1px; display: inline;">
                                %{--<br/>--}%
                                <g:set value="status" var="field"></g:set>
                                %{--<div style="margin-top: 6px !important;">--}%
                                <a href="#" id="${field}${record.id}" class="${field}"
                                   data-type="select"
                                   data-value="${record[field]?.id}"
                                   data-name="${field}-${entityCode}"
                                   class="${record.class.declaredFields.name.contains('status') && record.status ? 'status-' + record?.status?.code : ''}"
                                   style="${record.status ? record.status?.style : ''}; border-bottom: 0.5px solid #808080; font-size: 1m; font-style: italic; padding-left: 1px; padding-right: 1px; "
                                   data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                                   data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                                   data-title="Edit ${field}">
                                    ${record[field] ? '?' + record[field]?.code : '?'}
                                </a>
                            </div>
                            <script type="text/javascript">
                                jQuery("#${field}${record.id}").editable(
                                        {showButtons: false, mode: 'popup', placement: 'right'}
                                );
                            </script>

                        </g:if>
<br/>
                        <g:if test="${record.class.declaredFields.name.contains('course') && ker.OperationController.getPath('courses.enabled')?.toLowerCase() == 'yes'}">

                        %{--&nbsp;--}%
                        %{--&nbsp;--}%
Course:
                            <g:set value="course" var="field"></g:set>

                            <a href="#" id="${field}${record.id}" class="${field}"
                               style="color: darkgray; font-size: 12px !important; direction: rtl; text-align: right;"
                               data-type="select"
                               data-value="${record[field]?.id}"
                               data-name="${field}-${entityCode}"
                               style=" border-radius: 3px; font-size: 0.95em; font-style: italic; padding-left: 3px; padding-right: 3px;"
                               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&rid=${record.id}&date=${new Date().format('hhmmssDDMMyyyy')}"
                               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                               data-title="Edit ${field}">
                                ${record[field] ? (record[field].code ? 'c_' + record[field].code : 'c_' + record.course) : 'c--'}
                            </a>
                            <script type="text/javascript">
                                jQuery("#${field}${record.id}").editable(
                                        {showButtons: false, mode: 'popup', placement: 'right'}
                                );
                            </script>
                        </g:if>



%{--                        <g:if test="${record.class.declaredFields.name.contains('priority')}">--}%
%{--                            <span style="font-size: 0.95em; color: #003366">--}%
%{--                                p${record.priority}--}%



%{--                            </span>--}%
%{--                        </g:if>--}%



                        <g:if test="${entityCode == 'T'}">
<br/>
                         Context:   &nbsp;
                            <g:set value="context" var="field"></g:set>

                            <a href="#" id="${field}${record.id}" class="${field}"
                               style="font-style: italic !important; color: darkgreen !important; font-size: 0.95em;"
                               data-type="select"
                               data-value="${record[field]?.id}"
                               data-name="${field}-${record.entityCode()}"
                               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${record.entityCode()}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                               data-title="Edit ${field}">
                                ${record[field]?.code ? '@' + record[field]?.code : '@'}
                            </a>
                            <script>
                                jQuery("#${field}${record.id}").editable();
                            </script>


                            &nbsp;
                        </g:if>


                        <g:if test="${record.class.declaredFields.name.contains('department') && ker.OperationController.getPath('courses.enabled')?.toLowerCase() == 'yes'}">

                            <br/>
Department:
                            <g:set value="department" var="field"></g:set>

                            <a href="#" id="${field}${record.id}" class="${field}"
                               data-type="select"
                               data-value="${record[field]?.id}"
                               data-name="${field}-${entityCode}"
                               style=" border-radius: 3px; font-size: 0.95em; font-weight: bold;font-style: italic; padding-left: 1px; padding-right: 1px;"
                               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                               data-title="Edit ${field}">
                                ${record[field] ? record[field]?.code : 'd'}
                            </a>
                            &nbsp;
                            <script type="text/javascript">
                                jQuery("#${field}${record.id}").editable();
                            </script>

                            <script type="text/javascript">
                                %{--jQuery("#${field}${recordId}").editable()--}%
                                //				{
                                //            typeahead: {
                                //                name: 'value'
                                //            }
                                //                });
                            </script>

                        </g:if>

                    %{--<g:if test="${'TG'.contains(entityCode)}">--}%

                    %{--<g:remoteLink controller="generics" action="markDismissed"--}%
                    %{--id="${record.id}"--}%
                    %{--params="[entityCode: entityCode]"--}%
                    %{--update="${entityCode}Record${record.id}"--}%
                    %{--title="Mark dismissed">--}%
                    %{--&nabla;--}%
                    %{--</g:remoteLink>--}%
                    %{--</g:if>--}%






                        <g:if test="${'E'.contains(entityCode)}">

                            Book:
                            <b style="font-family: Courier">
                                ${record?.book?.course?.code}</b>
                            <br/>
                        </g:if>




                        <g:if test="${record.class.declaredFields.name.contains('plannedDuration') && record.plannedDuration}">
                           Duration:  &nbsp;
                            <g:set value="plannedDuration" var="field"></g:set>

                            <a href="#" id="${field}${recordId}" class="${field}"
                               data-type="select"
                               data-value="${record[field] ?: 0}"
                               data-name="${field}-${record.entityCode()}"
                               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${record.entityCode()}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                               data-title="Edit ${field}">
                                +${record[field] ?: ''}
                            </a>
                            <script>
                                %{--jQuery('#${field}${recordId}').editable();--}%
                            </script>
<br/>
                        </g:if>



                        <g:if test="${entityCode == 'I'}">
                        Indicator:    ${record.indicator?.code}
                        </g:if>

                        <g:if test="${entityCode == 'Q'}">

                        </g:if>


                        <g:if test="${entityCode == 'I'}">
                         Value:   <g:formatNumber number="${record.value}" format="#,###"/>
                        </g:if>


                        <g:if test="${entityCode == 'N'}">
                            <br/>
Parent:
                            <g:if test="${record.recordId}">

                                <g:remoteLink controller="generics" action="showSummary"
                                              id="${record.recordId}"
                                              params="[entityCode: record.entityCode]"
                                              update="below${entityCode}Record${record.id}"
                                              title="Go to parent record">
                                    <span class="ui-icon-arrow-2-e-w"></span>
                                </g:remoteLink>

                            </g:if>
                        </g:if>




                        <g:if test="${'CGR'.contains(entityCode)}">

                        </g:if>


                        <g:if test="${record.class.declaredFields.name.contains('--writtenOn') && record.writtenOn}">

                            <span style="font-size: 0.95em; font-weight: bold;  padding-right: 4px;"
                                  title="${record.writtenOn?.format(OperationController.getPath('datetime.format'))}">
                                <g:if test="${record.class.declaredFields.name.contains('approximateDate') && record.approximateDate}">
                                    ~
                                </g:if>

                                %{--${record.writtenOn?.format(OperationController.getPath('date.format'))}--}%
                                w<pkm:weekDate date="${record?.writtenOn}"/>
                            </span>
                        </g:if>




                        <span id="breadCrumSpan">

                                <g:if test="${record.class.declaredFields.name.contains('book')}">
                                    <br/>Book:
%{--                                    <g:set value="book" var="field"></g:set>--}%

%{--                                    <a href="#" id="${field}${record.id}" class="${field}"--}%
%{--                                       data-type="select"--}%
%{--                                       data-value="${record[field]?.id}"--}%
%{--                                       data-name="${field}-${entityCode}"--}%
%{--                                       style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 0.95em; font-style: italic; padding-left: 1px; padding-right: 1px;"--}%
%{--                                       data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&recordId=${record.id}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"--}%
%{--                                       data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"--}%
%{--                                       data-title="Edit ${field}">--}%
%{--                                        ${record[field] ? (record[field].code ?: record.book?.title) : 'r'}--}%
%{--                                    </a>--}%
%{--                                    <script type="text/javascript">--}%
%{--                                        jQuery("#${field}${record.id}").editable();--}%
%{--                                    </script>--}%

                                    <g:if test="${record.book}">

                                        <g:remoteLink controller="generics" action="showSummary"
                                                      id="${record.book?.id}"
                                                      params="[entityCode: 'R']"
                                                      update="below${entityCode}Record${record.id}"
                                                      style="font-style: italic; font-size: 0.95em;"
                                                      title="Show book">
                                            &larr;
                                        </g:remoteLink>
                                    </g:if>
                                </g:if>

                                <g:if test="${entityCode == 'N'}">

                                    <g:if test="${entityCode == 'N' && record.recordId}">
Parent:
                                        <g:remoteLink controller="generics" action="showSummary"
                                                      id="${record.recordId}"
                                                      params="[entityCode: record.entityCode]"
                                                      update="below${entityCode}Record${record.id}"
                                                      title="Show parent entity">

                                            <b>${record.entityCode}</b>
                                            <i>${record.recordId}</i>

                                        %{--<g:if test="${record.entityCode == 'W'}">--}%
                                        %{--${Writing.get(record.recordId)}--}%
                                        %{--</g:if>--}%

                                        </g:remoteLink>

                                    </g:if>
<br/>
                                    Writing:
                                    <g:set value="writing" var="field"></g:set>

                                    <a href="#" id="2${field}${record.id}" class="${field}"
                                       data-type="select"
                                       data-value="${record.recordId ?: null}"
                                       data-name="${field}-${entityCode}"
                                       style=" border-radius: 3px; font-size: 0.95em; font-style: italic; padding-left: 1px; padding-right: 1px;"
                                       data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&recordId=${record.id}&date=${new Date().format('hhmmssDDMMyyyy')}"
                                       data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                                       data-title="Edit ${field}">
                                        ${record.recordId && record.recordId != 'null' && record.entityCode == 'W' ? Writing.get(record.recordId.toLong()) : 'w'}
                                    </a>
                                    <script type="text/javascript">
                                        jQuery("#2${field}${record.id}").editable();
                                    </script>

                                </g:if>

                                <g:if test="${record.class.declaredFields.name.contains('writing') && record.writing}">
                                    <br/>W ${record.writing}
                                </g:if>




                                <g:if test="${record.class.declaredFields.name.contains('language')}">
<br/>Language:
                                    <g:set value="language" var="field"></g:set>

                                    <a href="#" id="${field}${record.id}" class="${field}"
                                       data-type="select"
                                       data-value="${record[field]}"
                                       data-name="${field}-${entityCode}"
                                       style="border-bottom: 0.5px solid #808080; border-radius: 3px; font-size: 0.95em; font-style: italic; padding-left: 1px; padding-right: 1px;"
                                       data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&recordId=${record.id}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                                       data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                                       data-title="Edit ${field}">
                                        ${record[field] ? (record[field]) : "'"}
                                    </a>
                                    <script type="text/javascript">
                                        jQuery("#${field}${record.id}").editable();
                                    </script>

                                %{--                                        <g:if test="${record.language}">--}%
                                %{--                                            '${record.language}--}%
                                %{--                                        </g:if>--}%

<g:each in="['A', 'B', 'D', 'Y', 'E', 'F', 'L', 'O', 'Z', 'H', 'I', 'V', 'T', 'U', 'S', 'K', 'X']" var="d">
                                <g:remoteLink controller="generics" action="setDepartment"
                                id="${record.id}-${entityCode}-${d}"
                                class="setDepartment${d}"
                                    style="display: none;"
                                params="[entityCode: entityCode]"
                                update="${entityCode}Record${record.id}"
                                title="Set dept. ${d}">
                                Set dept. ${d}
                                </g:remoteLink>
</g:each>


                                <g:remoteLink controller="generics" action="setLanguage"
                                id="${record.id}-${entityCode}-en"
                                class="setLanguageEnglish"

                                params="[entityCode: entityCode]"
                                update="${entityCode}Record${record.id}"
                                title="Mark as English">
                                Set En
                                </g:remoteLink>
                                    <g:remoteLink controller="generics"
                                                               action="setLanguage"
                                                               id="${record.id}-${entityCode}-ar"
                                params="[entityCode: entityCode]"
                                                               class="setLanguageArabic"
                                update="${entityCode}Record${record.id}"
                                title="Mark as Arabic">
                                Set Ar
                                </g:remoteLink>

                                </g:if>

                            </span>




                        %{--<g:remoteLink controller="generics" action="showRelate"--}%
                        %{--params="${[id: record.id, entityCode: entityCode]}"--}%
                        %{--update="below${entityCode}Record${record.id}"--}%
                        %{--title="Details">--}%
                        %{--rel (${mcs.Relationship.countByEntityACodeAndRecordA(entityCode, record.id)})--}%
                        %{--ToDo: fix, entityA is entitymapping and not entityCode!!! --}%
                        %{--</g:remoteLink>--}%



                            <g:if test="${record.class.declaredFields.name.contains('priority')}">

                                <br/>
                                Priority:
                                        &nbsp;          <a name="priority+${record.id}${entityCode}"
                                                           id="priority+${record.id}${entityCode}"
                                class="increasePriorityButton"
                                                           title="Incraese priority"
                                                   value="${record.priority}"
                                                   style="background: lightgrey"
                                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/increasePriority/${entityCode}${record.id}')">
                                <b>+ (=)</b>
                            </a>


                                <g:each in="[0, 1, 2, 3, 4, 5]" var="p">
                                    &nbsp;
                                    <a title="Set priority" style="font-size: 14px !important; text-decoration: none; display: none" class="setPriority${p}"
                                       value="${record.priority}"
                                       onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setPriority/${entityCode}${record.id}?p=' + ${p})">
                                    &nbsp;
                                        ${p}
                                    </a>

                                </g:each>

                            %{--</g:if>--}%

                            %{--<g:if test="${record.class.declaredFields.name.contains('priority')}">--}%
                                <a
                                        name="priority-${record.id}${entityCode}"
                                        id="priority-${record.id}${entityCode}"
                                        class="decreasePriorityButton"
                                        title="Decrease priority"
                                   value="${record.priority}"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/decreasePriority/${entityCode}${record.id}')">
                                    <b>- (-)</b>
                                </a>
                            </g:if>
<br/>

                            <g:if test="${record.class.declaredFields.name.contains('endDate')}">
                                Due date:
                             &nbsp;          <a name="bookmark${record.id}${entityCode}"
                                                   value="${record.endDate}"
                                                   style="background: lightgrey"
                                                   title="Increase end date or set it to tomorrow, if not already set"
                                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/increaseEndDate/${entityCode}${record.id}')">
                                +
                            </a>
                                <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style="background: lightgrey"
                                   title="Set due date to today"
                                   class="setTodayButton"
                                   id="setToday${record.id}${entityCode}"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/makeEndDateToday/${entityCode}${record.id}')">
                                    today  (0)
                                </a>        &nbsp;
                                <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   title="Decrease end date or set it to yesterday, if not set"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/decreaseEndDate/${entityCode}${record.id}')">
                                    --
                                </a>
                                <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   title="Clear end date"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/clearEndDate/${entityCode}${record.id}')">
                                    clear
                                </a>
                            </g:if>

                        %{--update="commentArea${entityCode}${record.id}"--}%





                        &nbsp;<br/>
                        <b>Append to record's:</b>
                        <br/>
                            <g:remoteLink controller="generics" action="showAppend"
                                class="appendToDescription"
                                          params="${[id: record.id, entityCode: entityCode]}"
                                          update="below${entityCode}Record${record.id}"
                                          title="Details">
                               description (d)
                            </g:remoteLink>

                            <g:remoteLink controller="generics" action="showAppendNotes"
                                          params="${[id: record.id, entityCode: entityCode]}"
                                          class="appendToNotes"
                                          update="below${entityCode}Record${record.id}"
                                          title="Details">
                                 notes (n)
                            </g:remoteLink>




                            <g:if test="${'TPGREJWN'.contains(entityCode)}">
                                <br/> <b>Mark as:</b>
                                <br/>
                                <g:remoteLink controller="generics" action="markCompleted"
                                              id="${record.id}"
                                              class="doneButton"
                                              params="[entityCode: entityCode]"
                                              update="${entityCode}Record${record.id}"
                                              title="Mark completed">
                                    <b>done (D)</b>
                                </g:remoteLink>
                                <g:remoteLink controller="generics" action="markDismissed"
                                              id="${record.id}"
                                              class="dismissedButton"
                                              params="[entityCode: entityCode]"
                                              update="${entityCode}Record${record.id}"
                                              title="Mark completed">
                                    <b>dismissed (ctrl+D)</b>
                                </g:remoteLink>
                            </g:if>
                            <g:if test="${'WNJPRE'.contains(entityCode)}">

                                <g:remoteLink controller="generics" action="markReviewed"
                                              id="${record.id}"
                                              params="[entityCode: entityCode]"
                                              update="${entityCode}Record${record.id}"
                                              title="Mark review">
                                    <b style="color: darkgreen">reviewed</b>
                                %{--${record.class.declaredFields.name.contains('reviewCount') && record.reviewCount > 0 ? '(' + record.reviewCount  + ')': ''}--}%
                                </g:remoteLink>

<br/>
                                <g:if test="${'CTGREW'.contains(entityCode) && (ker.OperationController.getPath('journal.enabled')?.toLowerCase() == 'yes' || ker.OperationController.getPath('planner.enabled')?.toLowerCase() == 'yes')}">

                                    <g:remoteLink controller="generics" action="showJP"
                                        class="addJPButton"
                                                  params="${[id: record.id, entityCode: entityCode]}"
                                                  update="below${entityCode}Record${record.id}"
                                                  title="Details">
                                        Add J/P (j)
                                    </g:remoteLink>
                                </g:if>
                            </g:if>
<g:if test="${'CTGNWR'.contains(entityCode)}">
                                <g:remoteLink controller="operation" action="dumpRecordForImport"
                                              id="${record.id}"
                                              params="[entityCode: entityCode]"
                                              update="${entityCode}CheckoutLog${record.id}"
                                              class="dump${entityCode}${record.id}"
                                              title="Dump to txt for re-importing">
                                    Export to text &crarr;
                                </g:remoteLink>

                                <span id="${entityCode}CheckoutLog${record.id}"></span>

</g:if>



                        <g:remoteLink controller="generics" action="openRpsFolder"
                                      params="${[id: record.id, entityCode: entityCode, repository: 1]}"
                                      update="${entityCode}CheckoutLog${record.id}"
                                      class="openFolderButton1"
                                      style="background: lightgreen;"
                                      title="Open rps1 folder">
                            Open record's folder
                        </g:remoteLink>
   <g:remoteLink controller="generics" action="openRpsFolder"
                                      params="${[id: record.id, entityCode: entityCode, repository: 2]}"
                                      update="${entityCode}CheckoutLog${record.id}"
                                      class="openFolderButton2"
                                      style="background: lightgreen;"
                                      title="Open rps2 folder">
                            rps2
                        </g:remoteLink>


                            <g:if test="${'NO'.contains(entityCode) && ker.OperationController.getPath('convert-records.enabled')?.toLowerCase() == 'yes'}">
                                <br/>
                                <br/>
                                &nbsp; &nbsp;<b>Convert to:</b>
                                <g:each in="${['J', 'P', 'T', 'G', 'R', 'W', 'N']}" var="t">

                                    <g:remoteLink controller="generics" action="convertNoteToRecord"
                                                  params="${[id: record.id, entityCode: entityCode, type: t]}"
                                                  update="${entityCode}Record${record.id}"
                                                  class="convertButton${t}"
                                                  title="Convert note to ${t}">
                                        &nbsp;${t} &nbsp;
                                    </g:remoteLink>
                                </g:each>
                            </g:if>


                            <g:if test="${entityCode.size() == 1}">
                            %{--|| (record.class.declaredFields.name.contains('deletedOn') && record.deletedOn != null)--}%
                                <g:remoteLink controller="generics" action="physicalDelete"                                              params="${[id: record.id, entityCode: entityCode]}"
                                              update="${entityCode}Record${record.id}"
                                              before="if(!confirm('Are you sure you want to permanantly delete the record?')) return false"
                                              class="fg-button ui-widget ui-state-default ui-corner-all physicalDelete"
                                              title="Delete record permanantly">
                                    Delete (X)
                                </g:remoteLink>
                            </g:if>


                        <a class="fg-button ui-widget ui-state-default ui-corner-all" title="Hide"
                           onclick="jQuery('#${entityCode}Record${record.id}').html('');" style="float: right; color: darkgray; margin-right: 4px;">Close</a>
                        <g:checkBox name="select-${record.id}-${entityCode}"
                                    title="Select record"
                                    value="${org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().getSession()[entityCode + record.id] == 1}"
                                    style="height: 14px !important; float: right;"
                                    onclick="jQuery('#selectBasketRegion').load('${request.contextPath}/generics/select/${entityCode}${record.id}')"
                        />

                    </div>


                    </div>
                    </td>
                </tr>
                %{--<tr>--}%
                    %{--<td colspan="10">--}%
                        %{----}%
                    %{--</td>--}%
                %{--</tr>--}%
                %{--<g:if test="${'CGR'.contains(record.entityCode()) && record.percentCompleted}">--}%
                %{--<tr>--}%
                %{--<td colspan="12" style="padding: 0; margin: 0">--}%

                %{--<pkm:progressBar percent="${record.percentCompleted}"/>--}%

                %{--</td>--}%
                %{--</tr>--}%
                %{--</g:if>--}%

                </tbody>
            </table>

</g:else>

        %{--</div>--}%


    %{--</div>--}%

%{--</g:elseif>--}%

%{--tabindex = "${tabIndex}" id ${record.id}--}%
<g:if test="${justUpdated || justSaved}">
<script type="application/javascript">
    jQuery("#${entityCode}Record${record.id}").hide('fast');
    jQuery("#${entityCode}Record${record.id}").fadeIn('slow');
    %{--jQuery("#${entityCode}Record${record.id}").slideLeft('slow');--}%
</script>
</g:if>

<script type="application/javascript">

    if ('2340' == "${tabIndex}"){
//        bindMyKeys();
        console.log('valid if ' + ${record.id})
        jQuery("#${entityCode}Record${record.id}").focus();
        %{--jQuery("#${entityCode}Record${record.id}").select();--}%
    }

    %{--function bindMyKeys${entityCode}${record.id} () {--}%

    if (jQuery('.recordSelected').size() > 0)
        jQuery('.recordSelected').removeClass('recordSelected');

        jQuery('#${entityCode}Record${record.id}').addClass('recordSelected');

	// to test w033.22
	jQuery('.recordSelected')[0].scrollIntoView({block: "center", inline: "nearest", behavior: "smooth", });

</script>