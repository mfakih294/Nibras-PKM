<%@ page import="mcs.Course; mcs.parameters.ResourceStatus; ker.OperationController; mcs.Writing; mcs.Book; cmn.Setting; org.apache.commons.lang.StringEscapeUtils; app.Payment; app.IndicatorData; app.IndexCard; mcs.Excerpt; java.text.DecimalFormat; mcs.parameters.WorkStatus; mcs.Goal; mcs.parameters.JournalType; mcs.Journal; mcs.Planner; mcs.Task" %>
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

<g:render template="/gTemplates/staticRecord" model="[record: record]"/>


</g:if>
<g:else>


    %{--margin: 4px 15px 5px 15px;--}%
            <table class="recordLine recordContainer recordCard" style="width: 100% !important; border: 1px solid darkgray; border-radius: 4px; border-collapse: collapse"
                   id="${entityCode}Record${record.id}">
                <tbody>
                <tr>
                    <td colspan="3" style="min-width: 230px; padding: 3px; padding-bottom: 7px; background: rgba(250, 250, 250, 0.94)"
                        class="${(record.class.declaredFields.name.contains('language') && record.language && OperationController.getPath('repository.languages.RTL').contains(record.language)) ? 'RTLText' : 'LRTText'}">

                       <span class="product-gallery" style="float: right;">

                            <span class="gallery-img" id="recordImage${record.id}">
                                <img class="Photo" style="height: 140px; width: auto; display:inline; padding: 7px;" onerror="this.style.display='none'"
                                     src="${createLink(controller: 'generics', action: 'viewRecordImage', id: record.id, params: [entityCode: entityCode, date: new Date()])}"/>

                            </span>
                        </span>
                        <script type="text/javascript">
                            %{--jQuery('#recordImage${record.id}').Am2_SimpleSlider();--}%
                        </script>


                        <g:if test="${record.class.declaredFields.name.contains('name')}">
                            <span title="${record.name}">
                                <b>${record.name}</b>
                            </span>

                        </g:if>





                        <g:if test="${record.class.declaredFields.name.contains('bookmarked')}">
                            <g:if test="${!record.bookmarked}">
                                <a name="bookmark${record.id}${entityCode}"
                                   title="Toggle bookmark"
                                   class="quickBookmarkButton"
                                   value="${record.bookmarked}"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/quickBookmark/${entityCode}-${record.id}')">
                                    %{--<span class="icon-star-gm"></span>--}%
                                    <span class="uk-icon-button" uk-icon="star"></span>
                                </a>
                            </g:if>

                        %{--</td>--}%
                        %{--<td> --}%

                            <g:if test="${record.bookmarked}">
                                <a name="bookmark${record.id}${entityCode}"
                                   title="Toggle bookmark"
                                   value="${record.bookmarked}"
                                   class="quickBookmarkButton"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/quickBookmark/${entityCode}-${record.id}')">
                                    %{--<span class="icon-starred-gm"></span>--}%
                                    <span class="uk-icon" uk-icon="icon: bookmark; ratio: 1.5"></span>
                                </a>
                            </g:if>
                        </g:if>
                        &nbsp;


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






                            <g:remoteLink controller="page" action="panel"
                                          tabindex="-1"
                                          class="openPanelButton"
                                          params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                          update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                          style="padding: 2px; font-size: 1em; font-weight: bold;"
                                          before="myLayout.open('east'); jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">
                            %{--class="${record.class.declaredFields.name.contains('priority') ? 'priorityText' + record.priority : ''}"--}%


                                <g:if test="${!record.summary}">
                                    ...
                                </g:if>
                                <g:if test="${record.summary}">
                                    <span title="${record.summary}" style="font-family: Lato !important; color: black; font-weight: normal; font-size: 1.1em;"

                                         class="${(record.class.declaredFields.name.contains('language') && record.language && OperationController.getPath('repository.languages.RTL').contains(record.language)) ? 'RTLText' : 'LRTText'} ${record.class.declaredFields.name.contains('status') && record.status ? 'status-' + record?.status?.code : ''}">
                                        %{--<g:if test="${entityCode == 'E'}">--}%
                                        %{--<br/>--}%
                                        %{--</g:if>--}%
                                        %{--<g:if test="${record.class.declaredFields.name.contains('publishedNodeId') && record.publishedNodeId && record.status?.code != 'repub'}">--}%
                                        %{--<span style="font-size: large; color: darkgreen"> &copy; </span>--}%
                                        %{--</g:if>--}%
                                        %{--<g:elseif  test="${record.class.declaredFields.name.contains('publishedNodeId') && record.publishedNodeId && record.status?.code == 'repub'}">--}%
                                        %{--<span style="font-size: 1em; color: darkred"> &copy; </span>--}%
                                        %{--</g:elseif>--}%

                                        %{--<bdi>--}%
                                        <pkm:summarize text="${record.summary ?: ''}"
                                                       length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/>


                                        %{--</bdi>--}%
                                        %{--<br/>--}%
                                    </span>
                                </g:if>
                            </g:remoteLink>




                        </g:if>

                        <g:if test="${entityCode == 'R'}">

                            <g:remoteLink controller="page" action="panel"
                                          tabindex="-1"
                                          class="openPanelButton ${(record.class.declaredFields.name.contains('language') && record.language && OperationController.getPath('repository.languages.RTL').contains(record.language)) ? 'RTLText' : 'LRTText'}"
                                          params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                          update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                          before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);"
                                          style="padding: 4px; font-size: 1.2em; font-weight: normal;">


                                <pkm:summarize text="${(record.title ?: '...')}"
                                               length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/>

                                <g:if test="${record.author}">
                                    <br/>
                                    <i style="font-size: 0.95em; color: #2d2d2d"><pkm:summarize
                                            text="${record.author ?: ''}"
                                            length="${OperationController.getPath('summary.summarize.threshold')?.toInteger()}"/></i>
                                </g:if>

                            %{--</bdi>--}%
                                <g:if test="${record.legacyTitle}">
                                    <br/>
                                    <i style="text-decoration: line-through;">${record.legacyTitle}</i>
                                </g:if>

                                <g:if test="${record.url}">
                                    <br/>
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





                        <g:if test="${record.class.declaredFields.name.contains('task') && record.task}">
                            <div class="recordsTask">T ${record.task}</div>
                        </g:if>


                        <g:if test="${record.class.declaredFields.name.contains('shortDescription') && record.shortDescription}">
                            <div class="shortDescription">
                                <g:remoteLink controller="page" action="panel"
                                              tabindex="-1"
                                              params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                              update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"

                                              before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">
                                    ${record?.shortDescription?.replaceAll('\n', '<br/>')?.decodeHTML()?.replaceAll('\n', '<br/>')}
                                %{--?.replaceAll("\\<.*?>", "")--}%
                                </g:remoteLink>
                            </div>
                        </g:if>
                        <g:if test="${record.class.declaredFields.name.contains('description') && record.description}">
                        %{--<br/>--}%
                            <g:if test="${record.class.declaredFields.name.contains('language') && record.language && record.language}">
                                <div class="${(record.class.declaredFields.name.contains('language') && record.language && OperationController.getPath('repository.languages.RTL').contains(record.language)) ? 'RTLText' : 'LRTText'}">
                            </g:if>
                            <div style="font-size: 0.95em !important; color: #272727 !important; padding: 5px; line-height: 1.4em;">
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
                                                      style="padding: 4px; font-size: 0.95em;"
                                                      before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">
                                            ${raw(record?.description?.trim()?.replaceAll('\n', '<br/>')?.decodeHTML()?.replaceAll('\n', '<br/>')?.replace('Product Description', '')?.trim())}
                                        %{--?.replaceAll("\\<.*?>", "")--}%
                                        </g:remoteLink>
                                    </g:if>


                                    <g:if test="${record.description?.length() > OperationController.getPath('description.summarize.threshold')?.toInteger()}">

                                        <g:remoteLink controller="page" action="panel"
                                                      tabindex="-1"
                                                      params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"
                                                      update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"
                                                      style="padding: 5px; font-size: 0.95em;"
                                                      before=" myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0});">


                                        %{--?.replaceAll("\\<.*?>", "")--}%
                                            <pkm:summarize
                                                    text="${record?.description?.replace('Product Description', '').encodeAsHTML()}"
                                                    length="${OperationController.getPath('description.summarize.threshold')?.toInteger()}"/>
                                            (${new DecimalFormat("#").format(Math.floor(record.description?.count(' ') / 200))}')
                                        </g:remoteLink>

                                    </g:if>
                                </g:else>
                            </div>
                            <g:if test="${record.class.declaredFields.name.contains('language')}">
                                </div>
                            </g:if>


                        </g:if>



                        <g:if test="${record.class.declaredFields.name.contains('fullText') && record.fullText}">

                            %{--<g:remoteLink controller="page" action="panel"--}%
                                          %{--tabindex="-1"--}%
                                          %{--params="${[id: record.id, entityCode: entityCode, mobileView: mobileView]}"--}%
                                          %{--update="${mobileView == 'true' ? 'below' + entityCode+ 'Record' + record.id : '3rdPanel'}"--}%
                                          %{--style="padding: 4px; font-size: 0.95em;"--}%
                                          %{--before="myLayout.open('east');jQuery('.recordSelected').removeClass('recordSelected');jQuery('#${entityCode}Record${record.id}').addClass('recordSelected'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);">--}%

                                <span style="font-size: 0.95em; font-style: italic; color: #435d59">
                                    <pkm:summarize text="${record.fullText?.trim()}"
                                                   length="${OperationController.getPath('description.summarize.threshold')?.toInteger()}"/>
                                    %{--(${record.fullText?.count(' ')})--}%

                                    (${new DecimalFormat("#").format(Math.floor(record.fullText?.count(' ') / 200))}')
                                </span>
                            %{--</g:remoteLink>--}%
                        </g:if>



                        <g:if test="${'N'.contains(entityCode)}">

                            <g:if test="${record.pages}">
                                <i>pg. ${record.pages}</i>
                            </g:if>
                        </g:if>

    <g:if test="${((!OperationController.getPath('metadataLine.hidden') || OperationController.getPath('metadataLine.hidden') == 'no') && params.reportType != 'tab') && record.class.declaredFields.name.contains('notes') && record.notes}">
                            <br/>
                            <span style="color:#7588b2 ">
                                <pkm:summarize text="${record.notes}"
                                               length="${OperationController.getPath('notes.summarize.threshold')?.toInteger()}"/>
                                %{--(${record.notes?.count(' ')})--}%

                                (${new DecimalFormat("#").format(Math.floor(record.notes?.count(' ') / 200))}')
                            </span>
                        %{--</g:if>--}%
                        </g:if>

                        <g:if test="${'JPT'.contains(entityCode) && record?.startDate}">
                            <div class="endDate"
                                 title="${record?.startDate?.format('EEE dd.MM.yyyy HH:mm')} - ${record?.endDate?.format('HH:mm')}">
                                <b style="font-size: large; color: darkgreen">&loz;</b>
                                ${record?.startDate?.format('EEE dd.MM HH:mm')}
                                %{--<br/>--}%
                                %{--${record?.endDate ? '-> ' + record?.endDate?.format('dd.MM.yyyy HH:mm'): ''}--}%
                            </div>
                        %{--(<i><prettytime:display--}%
                        %{--date="${record?.startDate}"></prettytime:display></i>)--}%
                        </g:if>

                        <g:if test="${record.class.declaredFields.name.contains('endDate') && record.endDate}">
                            <div  class="en En english"
                                  title="e${record.endDate?.format(OperationController.getPath('datetime.format'))}"
                                  style="display: inline-block; margin: 3px; font-size: 0.95em; padding: 2px; border-radius: 5px; border: 1px solid darkgray; direction: ltr; text-align: left;">
                                %{--<pkm:weekDate date="${record?.endDate}"/>--}%
                                %{--                            &gt;--}%
                                %{--<b>End date:</b>--}%
                                <b style="font-size: large; color: darkorange" class="${'T'.contains(entityCode) && record.endDate < new Date() - 1 && record.completedOn == null ? 'overDueDate' : ''}">&loz;</b>
                                <span style="padding: 4px;" title="${record?.endDate?.format('EE MMM dd, yyyy HH:mm')}">
                                    ${record?.startDate  && record?.endDate - record?.startDate == 0 ? record?.endDate?.format('HH:mm') : record?.endDate?.format('EE dd.MM HH:mm')}
                                </span>
                            </div>
                        %{--<span title="s${record.endDate?.format(OperationController.getPath('datetime.format'))}">--}%
                        %{--<pkm:weekDate date="${record?.endDate}"/>--}%
                        %{--</span>--}%
                        %{--</g:else>--}%
                        </g:if>


    <g:if test="${(!OperationController.getPath('metadataLine.hidden') || OperationController.getPath('metadataLine.hidden') == 'no') && params.reportType != 'tab'}">
                        <g:if test="${record.class.declaredFields.name.contains('tags') && record.tags}">
                            <br/> &nbsp;
                            <g:render template="/tag/tags" model="[instance: record, entity: entityCode]"/>
                        </g:if>
                        <g:if test="${record.class.declaredFields.name.contains('contacts') && record.contacts}">
                            <br/>
                            &nbsp;
                            <g:render template="/tag/contacts" model="[instance: record, entity: entityCode]"/>
                        </g:if>
    </g:if>


                    %{--<br/>--}%

                    %{--<br/>--}%

                        %{--<a style="float: right;"--}%
                           %{--title="Actions"--}%
                           %{--class="fg-button ui-widget ui-state-default ui-corner-all" style="padding: 3px 5px; margin: 5px;"--}%
                           %{--onclick="jQuery('.temp44').addClass('hiddenActions');jQuery('#actionsButtons${entityCode}Record${record.id}').removeClass('hiddenActions')">--}%
                        %{--&hellip;--}%
                        %{--</a>--}%


                    </td>
                </tr>

<g:if test="${(!OperationController.getPath('metadataLine.hidden') || OperationController.getPath('metadataLine.hidden') == 'no') && params.reportType != 'tab'}">
                <tr style="color: white; margin-bottom: 3px; padding: 6px; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2);">
                    <td style="width: 23%; background: #e5eaed;">

                        <div class="record-id" style="vertical-align: top; color: white;">
                        %{--<table border="0">--}%
                        %{--<tr>--}%

                        %{--<td style="padding-right: 3px; line-height: 1.4em;">--}%

                            <g:remoteLink controller="generics" action="showSummary"
                                          tabindex="-1"
                                          class="refresh "
                                          params="${[id: record.id, entityCode: entityCode]}"
                                          update="${entityCode}Record${record.id}"
                                          style="margin-left: 3px;padding-bottom: 1px; display: inline"
                                          title="ID ${record.id}. Click to refresh">


                                <span class="${entityCode}-bkg  ${entityCode == 'N' && record.entityCode != null ? 'non-genuineNote' : ''} ${entityCode == 'T' && record.isTodo ? 'todoTask' : ''} ${entityCode == 'O' ? (record.validOn == true ? 'correctCommand' : 'wrongCommand') : ''} ID-bkg"
                                          style="padding: 2px; margin-right: 2px; color: white; display: inline; border-radius: 4px;" title="${new DecimalFormat("#,###").format(record.id)}">
                                <span style="display: inline-block; color: white; padding: 4px;">
                                    <b>${entityCode}</b>


                                </span>
                            </g:remoteLink>




                        &nbsp;
                            %{--<sup style="color: black;font-size: x-small; ">--}%

                             %{--</sup>--}%

                            %{--<sub style="position: relative; top: 0.2em; left: -0.5em;color: black;font-size: x-small; ">--}%

                            <span class="departmentName">
                            ${record.class.declaredFields.name.contains('department') && record.department ? record.department?.code: ''}
                        </span>
                            &nbsp;

                            <span class="priorityNumber">
                                ${record.class.declaredFields.name.contains('priority') && record.priority ? record.priority: ''}
                            </span>
                        &nbsp;

                            <g:if  test="${record.class.declaredFields.name.contains('context') && record.context}">
                                <span class="contextName">
                                    @${record.context?.code} </span>
                            </g:if>

                            %{--</sub>--}%

                            %{--                                    <span style="font-size: x-small">--}%
                            %{--                                        ${new DecimalFormat("#,###").format(record.id)}--}%
                            %{--                                    </span>--}%


                            %{--                                <g:if test="${record.class.declaredFields.name.contains('type') && record.type}">--}%
                            %{--                                    <div style="font-size: smaller;margin: 3px; padding: 2px; border-radius: 0px; border: 1px solid darkgray; color: white; font-weight: bold; background: #695b7e; font-family: monospace">${record.type?.code}</div>--}%
                            %{--                                </g:if>--}%


                            %{--</td>--}%



                            %{--</tr>--}%
                            %{----}%
                            %{--</table>--}%

                            %{--</g:if>--}%
                        </div>

                    </td>
                <td style="width: 53%; background: #EDF2F4; border-left: 0px solid white;">

                %{--before="jQuery('#accordionEast').accordion({ active: 0});jQuery('#3rdPanel').scrollTop(0)"--}%

                    <!-- meta region -->

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




                        <g:if test="${record.class.declaredFields.name.contains('status') && record.status}">
        <span class="statusName">
            ?${record.status?.code}
        </span>
    </g:if>

    <span class="typeName">
        ${record.class.declaredFields.name.contains('type') && entityCode != 'O' && '#' + record.type ? record.type?.code : ''}
    </span>

   <g:if test="${record.class.declaredFields.name.contains('course' +
            '') && record.course}">
        <span class="courseName">
            ${record.course?.code ? '<b>' + record.course?.code + '</b> '  : record.course}</span>
       %{--+ record.course?.summary--}%
   </g:if>


%{--</span>--}%

    <g:if test="${record.class.declaredFields.name.contains('entity')}">
        <span title="${record.entity}">
            <i>${record.entity}</i>
        </span>
    </g:if>



%{--<g:if test="${record.class.declaredFields.name.contains('context') && record.context}">--}%
%{--<b>@</b><span style="margin: 2px; padding: 2px; border-radius: 5px; border: 1px solid darkolivegreen; color: darkblue; font-style: italic; font-size: normal">@${record.context?.code}</span>--}%
%{--<br/>--}%
%{--</g:if>--}%




    <g:if test="${entityCode == 'X' && ker.OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">


        <g:if test="${record.queryType == 'hql'}">

            %{--<g:remoteLink controller="generics" action="executeSavedSearch"--}%
                          %{--style=" color: gray"--}%
                          %{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
                          %{--id="${record.id}" params="[reportType: 'random']"--}%
                          %{--update="centralArea">--}%
                %{--rand.--}%

            %{--</g:remoteLink>--}%


            <g:link controller="generics" action="executeSavedSearch"
                    style=" color: gray"
                    id="${record.id}" params="[reportType: 'tab']"
                    target="_blank">
                tab
            </g:link>


         %{--   <g:if test="${record.calendarEnabled}">

                    <g:link controller="generics" action="executeSavedSearch"
                            style=" color: gray"
                            id="${record.id}" params="[reportType: 'cal']"
                            target="_blank">
                        cal
                    </g:link>
            </g:if>--}%

        </g:if>


    </g:if>





    <g:if test="${record.class.declaredFields.name.contains('value')}">
        <span title="${record.value}">
            <i>${record.value}</i>
        </span>

    </g:if>


    <g:if test="${entityCode == 'C'}">
        <b>${record.numberCode}</b>

    </g:if>



    %{--<g:if test="${record.class.declaredFields.name.contains('reality') && record.reality}">--}%
        %{--<span style="color:#b22222 ">--}%
            %{--${record.reality}--}%
        %{--</span>--}%
    %{--</g:if>--}%






    <g:if test="${record.class.declaredFields.name.contains('readOn') && record.readOn}">
        <img src="${resource(dir: '/images', file: 'edx-check.png')}" style="width: 15px;"
             title="${record.readOn?.format('dd.MM HH:mm')}"/>
    %{--Read ${record.readOn?.format('dd.MM.yyyy')}--}%
    </g:if>

    <g:if test="${record.class.declaredFields.name.contains('reviewCount') && record.reviewCount}">
        &nabla; <sup>${record.reviewCount}</sup>
    </g:if>

    %{--<g:if test="${record.class.declaredFields.name.contains('chapters') && record.chapters}">--}%
        %{--&nbsp; ---}%
         %{--ch ${record.chapters}--}%
    %{--</g:if>--}%

    %{--<g:if test="${record.class.declaredFields.name.contains('fileName') && record.fileName}">--}%
        %{--&nbsp; ---}%
         %{--f:${record.fileName}--}%
    %{--</g:if>--}%






    <g:if test="${record.class.declaredFields.name.contains('code') && record.code}">
        =<span
            style="color: #004499; font-style: italic; font-family: monospace">${record.code}</span>
    </g:if>



    <g:if test="${context}">
        <b>Context:</b>
        ${context} <br/>
    </g:if>


   <g:if test="${entityCode == 'Q'}">
        !<b style="color: darkred;">${record?.category?.code}</b>
        [${new DecimalFormat('#,###').format(record.amount)}]
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
              title="Created ${record.class.declaredFields.name.contains('dateCreated') ? record?.dateCreated?.format('dd.MM.yyyy') : ''}">

    <g:if test="${record.class.declaredFields.name.contains('completedOn') && record.completedOn}">

        <div title="${record.completedOn?.format(OperationController.getPath('datetime.format'))}"
                                            style="display: inline-block; margin: 3px; font-size: 0.95em; padding: 2px; border-radius: 3px; border: 1px solid darkgreen; direction: ltr; text-align: left; text-decoration: line-through;" class="english en En">

    %{--c<pkm:weekDate date="${record?.completedOn}"/>--}%
    %{--Completed on:--}%
        <b style="font-size: large; color: darkgray">&loz;</b>
        ${record?.completedOn?.format('EE dd.MM HH:mm')}
        </div>
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


%{--<g:if test="${session['showFullCard'] == 'on'  || showFull}">--}%


%{--</g:if>--}%

                    </td>
                <td style="width: 23%; background: #DEE2E6; color: black; text-align: right !important; border-left: 0px solid white;">

                    <!-- statistics region -->

                    <g:if test="${'R'.contains(entityCode) && record?.publishedNodeId && record?.publishedOn}">

                        <span style="margin: 2px; padding: 2px; border-radius: 3px; border: 1px solid darkgray;">
                        %{--                                &ang;--}%
                    &para;
                        ${record?.publishedOn?.format('dd.MM.yyyy')}

                    </span>
                    %{--(<i><prettytime:display--}%
                    %{--date="${record?.startDate}"></prettytime:display></i>)--}%
                    </g:if>


                    <g:if test="${record.class.declaredFields.name.contains('isPrivate') && record.isPrivate == false}">
                        <span style="margin: 2px; padding: 2px; border-radius: 3px;">
                        &hearts;
                        </span>
                    </g:if>

                    <g:if test="${record.class.declaredFields.name.contains('user') && !record.user}">
                        <span style="margin: 2px; padding: 2px; border-radius: 3px; color: red;">
                            No username!
                        </span>
                    </g:if>


                    <%
                        // just a comment
                    %>

                    <div id="statisticsSpan"
                         style="padding-left: 5px; padding-right: 5px;">
<g:render template="/gTemplates/statistics" model="[record: record]"/>

                        <a class="uk-button-default" style="border: 1px solid darkgray; padding: 1px 3px 1px 3px; margin: 1px 3px 1px 3px; border-radius: 5px; vertical-align: middle;"
                           title="Actions"
                           onclick="jQuery('.temp44').addClass('hiddenActions'); jQuery('#actionsButtons${entityCode}Record${record.id}').removeClass('hiddenActions');"
                        >...</a>

                        <g:checkBox name="select-${record.id}-${entityCode}"
                                    title="Select record"
                                    value="${org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().getSession()[entityCode + record.id] == 1}"
                                    style="height: 20px !important; width: 20px !important; float: right;"
                                    class="uk-checkbox"
                                    onclick="jQuery('#selectBasketRegion').load('${request.contextPath}/generics/select/${entityCode}${record.id}')" />


                    </div>





                </td>
                </tr>
</g:if>
                <tr>
                    <td colspan="3">
                    <div class="recordContainer"
                         id="2ndLine${entityCode}${record.id}"
                         style="opacity: 0.95; padding: 0px; margin: 0px; display: inline;">
                        %{-- class += hiddenActions--}%

                        <div style="margin: 0 0px 0px 0px;" id="below${entityCode}Record${record.id}">
                        </div>
                        <div id="actionsButtons${entityCode}Record${record.id}"
                             class="temp44 hiddenActions actionsButtons"
                             style="text-align: left; direction: ltr; line-height: 20px;font-size: 0.95em !important; color: darkslategrey !important; column-count: 2">







                        ID:  <span style="color: darkslategrey; font-size: small;">${record.id}</span>
<br/>
                        <b>Edit:</b>
                            <g:remoteLink controller="generics" action="fetchAddForm" class="fullEditButton"
                                          tabindex="-1"
                                          id="${record.id}"
                                          params="[entityController: record.class.name,
                                                   updateRegion    : entityCode + 'Record' + record.id,
                                                   finalRegion     : entityCode + 'Record' + record.id]"

                                          update="3rdPanel"
                                          title="Edit">
                                          %{--update="${entityCode}Record${record.id}"--}%
                            %{--<i style="font-size: 0.95em;">--}%
                                full (e)
                            %{--</i>--}%
                            </g:remoteLink>

                            <g:remoteLink controller="generics" action="fetchQuickAddForm"
                                          style="padding: 2px; font-size: 0.95em;"
                                          class="quickEditButton"
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




                        <g:remoteLink controller="generics" action="showTags"
                                      params="${[id: record.id, entityCode: entityCode]}"
                                      class="addTagButton"
                                      update="below${entityCode}Record${record.id}"
                                      title="Details">
                            tag (t)
                        </g:remoteLink>

                          <br/>

                        <g:if test="${record.class.declaredFields.name.contains('type') && entityCode != 'O'}">
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
                                        {showButtons: true, mode: 'popup', placement: 'right', dataType: 'json', success: function (responce, newValue) {
                                    jQuery('.recordSelected .refresh').click();
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
                                   style="${record.status ? record.status?.style : ''}; border-bottom: 0.5px solid #808080; font-size: 1em; font-style: italic; padding-left: 1px; padding-right: 1px; "
                                   data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
                                   data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                                   data-title="Edit ${field}">
                                    ${record[field] ? '?' + record[field]?.code : '?'}
                                </a>
                            </div>
                            <script type="text/javascript">
                                jQuery("#${field}${record.id}").editable(
                                        {showButtons: true, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                        console.log('in editable');
                                    jQuery('.recordSelected .refresh').click();
                                }}

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
                               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&rid=${record.id}&date=${new Date().format('hhmmssDDMMyyyy')}"
                               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
                               data-title="Edit ${field}">
                                ${record[field] ? (record[field].code ? 'c_' + record[field].code : 'c_' + record.course) : 'c--'}
                            </a>
                            <script type="text/javascript">

                                jQuery("#${field}${record.id}").editable(
                                        {showButtons: true, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                    jQuery('.recordSelected .refresh').click();
                                }}
                                );

                            </script>
                        </g:if>



%{--                        <g:if test="${record.class.declaredFields.name.contains('priority')}">--}%
%{--                            <span style="font-size: 0.95em; color: #003366">--}%
%{--                                p${record.priority}--}%



%{--                            </span>--}%
%{--                        </g:if>--}%


<%
  // just a comment
%>


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
                                %{--<!--jQuery("#${field}${record.id}").editable();-->--}%

                                jQuery("#${field}${record.id}").editable(
                                        {showButtons: true, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                    jQuery('.recordSelected .refresh').click();
                                }}
                                );
                            </script>

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
                                jQuery("#${field}${record.id}").editable( {showButtons: true, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                    jQuery('.recordSelected .refresh').click();
                                }});
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







                        <g:if test="${entityCode == 'I'}">
                        Indicator:    ${record.indicator?.code}
                        </g:if>

                        %{--<g:if test="${entityCode == 'Q'}">--}%

                        %{--</g:if>--}%


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
                                        jQuery("#2${field}${record.id}").editable( {showButtons: true, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                    jQuery('.recordSelected .refresh').click();
                                }});
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
                                        jQuery("#${field}${record.id}").editable( {showButtons: true, mode: 'popup', placement: 'right', success: function (responce, newValue) {
                                    jQuery('.recordSelected .refresh').click();
                                }});
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

<br/>
<b>Relations:</b>
%{--<g:if test="${mcs.Relationship.countByEntityACodeAndRecordA(entityCode, record.id)}">--}%
                        <g:remoteLink controller="generics" action="showRelate"
                                      params="${[id: record.id, entityCode: entityCode]}"
                                      update="below${entityCode}Record${record.id}Relations2"
                                      title="Details">
                            ${mcs.Relationship.countByEntityACodeAndRecordA(entityCode, record.id)} rel.
                        </g:remoteLink>
%{--ToDo: fix, entityA is entitymapping and not entityCode!!! --}%
                        <div id="below${entityCode}Record${record.id}Relations2"></div>
%{--</g:if>--}%


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
                                End date:
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
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=0')">
                                    today  (0)
                                </a>        &nbsp;
                                <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   title="Set the end date 1 day from now"
                                   class="setDueDate1"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=1')">
                                    1
                                </a>
                                  <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   title="Set the end date 2 days from now"
                                   class="setDueDate2"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=2')">
                                    2
                                </a>
                                  <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   class="setDueDate3"
                                   title="Set the end date 3 days from now"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=3')">
                                    3
                                </a>
                                 <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   class="setDueDate4"
                                   title="Set the end date 4 days from now"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=4')">
                                    4
                                </a>
                                  <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   class="setDueDate7"
                                   title="Set the end date 3 days from now"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=7')">
                                    7
                                </a>
                                 <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   class="setDueDate14"
                                   title="Set the end date 14 days from now"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setEndDate/${entityCode}${record.id}?i=14')">
                                    14
                                </a>
                                  <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   style=""
                                   title="Decrease end date or set it to yesterday, if not set"
                                   onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/decreaseEndDate/${entityCode}${record.id}')">
                                    --
                                </a>
                                <a name="bookmark${record.id}${entityCode}"
                                   value="${record.endDate}"
                                   class="clearEndDate"
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
                                 <g:remoteLink controller="generics" action="markPublic"
                                              id="${record.id}"
                                              class="publicButton"
                                              params="[entityCode: entityCode]"
                                              update="${entityCode}Record${record.id}"
                                              title="Mark as public">
                                    <b>public (P)</b>
                                </g:remoteLink>

                                   <g:remoteLink controller="generics" action="unmarkCompleted"
                                              id="${record.id}"
                                              class="undoneButton"
                                              params="[entityCode: entityCode]"
                                              update="${entityCode}Record${record.id}"
                                              title="Mark uncompleted">
                                    <b>undone (U)</b>
                                </g:remoteLink>
                                %{--<g:remoteLink controller="generics" action="markDismissed"--}%
                                              %{--id="${record.id}"--}%
                                              %{--class="dismissedButton"--}%
                                              %{--params="[entityCode: entityCode]"--}%
                                              %{--update="${entityCode}Record${record.id}"--}%
                                              %{--title="Mark completed">--}%
                                    %{--<b>dismissed (ctrl+D)</b>--}%
                                %{--</g:remoteLink>--}%
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

                            <%
  // just a comment
%>

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
                                      title="Open rps1 folder (f 1)">
                            Open record's folder
                        </g:remoteLink>
   <g:remoteLink controller="generics" action="openRpsFolder"
                                      params="${[id: record.id, entityCode: entityCode, repository: 2]}"
                                      update="${entityCode}CheckoutLog${record.id}"
                                      class="openFolderButton2"
                                      style="background: lightgreen;"
                                      title="Open rps2 folder (f 2)">
                            rps2
                        </g:remoteLink>

  <g:remoteLink controller="generics" action="openRpsFolder"
                                      params="${[id: record.id, entityCode: entityCode, repository: 3]}"
                                      update="${entityCode}CheckoutLog${record.id}"
                                      class="openFolderButton3"
                                      style="background: lightgreen;"
                                      title="Open rps3 folder (f 3)">
                            rps3
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
                                              class="uk-button physicalDelete"
                                              title="Delete record permanantly (ctrl + -)">
                                    Delete
                                </g:remoteLink>
                            </g:if>

%{--<g:remoteLink controller="generics" action="physicalDelete"--}%
                              %{--params="${[id: record.id, entityCode: entityCode]}"--}%
                              %{--update="${entityCode}Record${record.id}"--}%
                              %{--before="if(!confirm('Are you sure you want to permanantly physically delete the record?')) return false"--}%
                              %{--class="fg-button ui-widget ui-state-default ui-corner-all"--}%
                              %{--title="Delete record permanantly">--}%
                %{--&nbsp;x&nbsp;--}%
                %{--</g:remoteLink>--}%


                        <a class="fg-button ui-widget ui-state-default ui-corner-all" title="Hide actions"
                           onclick=" jQuery('#actionsButtons${entityCode}Record${record.id}').addClass('hiddenActions');" style="float: right; color: darkgray; margin-right: 4px;">Close</a>
       <a class="fg-button ui-widget ui-state-default ui-corner-all" title="Hide all box"
                           onclick="jQuery('#${entityCode}Record${record.id}').addClass('hiddenActions');" style="float: right; color: darkgray; margin-right: 4px;">x</a>


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


%{--</div>--}%


%{--</div>--}%

%{--</g:elseif>--}%

%{--tabindex = "${tabIndex}" id ${record.id}--}%


    <script type="application/javascript">

        if ('2340' == "${tabIndex}"){
//        bindMyKeys();
            console.log('valid if ' + ${record.id})
            jQuery("#${entityCode}Record${record.id}").focus();
            %{--jQuery("#${entityCode}Record${record.id}").select();--}%
        }

        %{--function bindMyKeys${entityCode}${record.id} () {--}%

        //    if (jQuery('.recordSelected').size() > 0)
        jQuery('.recordSelected').removeClass('recordSelected');


        jQuery('#${entityCode}Record${record.id}').addClass('recordSelected');


        // to test w033.22
        jQuery('.recordSelected')[0].scrollIntoView({block: "center", inline: "nearest", behavior: "smooth", });

    </script>
%{--todo--}%
%{--<g:if test="${!noSelection}">--}%
%{--<script type="application/javascript">--}%
%{--jQuery('#${entityCode}Record${record.id}').addClass('recordSelected');--}%
%{--</script>--}%
%{--</g:if>--}%

</g:else>
