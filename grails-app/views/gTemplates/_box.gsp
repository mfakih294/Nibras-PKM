<%@ page import="ker.OperationController; java.text.DecimalFormat; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Writing; mcs.Task; mcs.Planner" %>


<div style="margin-bottom: 3px; margin-top: 3px; max-width: 95%; direction: rtl; text-align: right;"
     class="text${record.language} ">
    <g:if test="${record}">
        <table width="99%;" border="0"
               class="text${record.language}"
               style="border-collapse: collapse; border: ${record.priority ? record.priority - 1 : 1}px darkslategray solid; -moz-border-radius: 6px; margin: 1px; padding-bottom: 1px;">

            %{--<!--Id: ${plannerInstance.id} -->--}%

            <tr style="${!'GTP'.contains(record.entityCode()) ? 'background: #f1f1eb; border:0.5px solid #cccccc;' : record.status?.style} padding: 0px;"
                class="${'GTP'.contains(record.entityCode()) ? 'workStatus-' + record.status?.code : ''}">

                <td style="font-size: 0.9em; padding: 3px; line-height: 1.1em;"
                    class="text${record.class.declaredFields.name.contains('language') ? record.language : (entityCode == 'E' ? record?.book?.language : '')};">

                    <div class="" style="color: darkgray; display: inline; margin: 2px !important; ">
                        <g:remoteLink controller="generics" action="showSummary"
                                      update="underBox${record.entityCode()}${record.id}"
                                      params="${[id: record.id, entityCode: record.entityCode(), mobileView: mobileView]}"
                                      style="color: darkgray;">
                            ${record.entityCode()}
                        </g:remoteLink>
                    </div>

                %{--<sup>${record.priority}</sup>--}%

                    <g:if test="${'RE'.contains(record.entityCode())}">
                        <sup>${record.orderInCourse}</sup>
                    </g:if>


                    <g:if test="${record.class.declaredFields.name.contains('priority')}">
                        <span style="font-size: 0.8em; color: darkgray">
                            <g:if test="${record.priority == 3}">
                                &gt;
                            </g:if>
                            <g:elseif test="${record.priority == 4}">
                                <b>&gt;&gt;</b>
                            </g:elseif>
                            <g:elseif test="${record.priority == 5}">
                                <b>&gt;&gt;&gt;</b>
                            </g:elseif>
                            <g:elseif test="${record.priority == 1}">
                                <b>&darr;</b>
                            </g:elseif>
                        </span>
                    </g:if>

                    <g:if test="${record.class.declaredFields.name.contains('startDate') && record.startDate}">
                        <span title="s${record.startDate?.format(OperationController.getPath('datetime.format'))} e${record.endDate?.format(OperationController.getPath('datetime.format'))}">


                        <g:if test="${'JP'.contains(record.entityCode())}">

                        %{--<g:if test="${record.level != 'd'}">--}%
                        %{--<div style="display: inline; padding: 2px; margin: 3px;" class="record-level level${record.level}"--}%
                        %{--title="Level">--}%
                        %{--l<sup>${record.level}</sup>--}%
                        %{--</div>--}%

                        %{--</g:if>--}%


                            <g:if test="${record.level == 'm'}">
                                <span class="hour">${record.startDate?.format('HH')}</span>
                                &larr;<span
                                    class="hour">${record.endDate?.format('HH')}</span>
                                &nbsp;
                                <i><pkm:weekDate date="${record?.startDate}"/></i>

                            </g:if>
                            <g:elseif test="${'rMWA'.contains(record.level)}">
                                <i><pkm:weekDate date="${record?.startDate}"/></i>
                                &larr;<pkm:weekDate date="${record?.endDate}"/>
                                (${record.level})
                            </g:elseif>
                            <g:else>
                                <i><pkm:weekDate date="${record?.startDate}"/></i>
                                (${record.level})
                            </g:else>

                            </span>

                        </g:if>
                        <g:else>
                            <span title="${record.startDate?.format(ker.OperationController.getPath('datetime.format'))}">
                                <i><pkm:weekDate date="${record?.startDate}"/></i>
                            </span>
                        </g:else>
                    </g:if>

                    <g:if test="${record.class.declaredFields.name.contains('language')}">
                        <div class="text${record.language}" style="display: inline; width: 100%">
                    </g:if>

                    <span style="color: #003399; direction: ltr; text-align: left;">

                        <g:if test="${'G'.contains(record.entityCode())}">
                            <i style="font-size: small">${record?.type?.code} ${record.department?.code}</i>&nbsp;
                        </g:if>
                        <g:if test="${'T'.contains(record.entityCode())}">
                            <i style="font-size: small; ">
                                %{--@${record?.context?.code} --}%
                                c${record?.course?.code} d${record.department?.code}</i>&nbsp;
                            ?${record.status?.code}
                            <sup>${record.plannedDuration ? record.plannedDuration + "''" : ''}</sup>
                        </g:if>
                        <g:if test="${'P'.contains(record.entityCode())}">
                            <i style="font-size: small">${record?.type?.code} ${record.status?.code}</i>&nbsp;
                        </g:if>
                        <g:if test="${'J'.contains(record.entityCode())}">
                            <i style="font-size: small">${record?.type?.code} ${record.department?.code}</i>&nbsp;
                        </g:if>
                        <g:if test="${'W'.contains(record.entityCode())}">

                            <i style="font-size: small">${record?.type?.code} ${record.department?.code}</i>&nbsp;
                        </g:if>
                        <g:if test="${'E'.contains(record.entityCode())}">
                            <i style="font-size: small">
                                B-${record?.book?.id}
                                ${record?.book?.author},
                                ${record?.book?.title ?: record?.book?.legacyTitle} ${record?.book?.edition}
                                (${record?.book?.publisher},
                                ${record?.book?.publicationDate})
                            </i>&nbsp;

                            <i style="font-size: small">${record.class.declaredFields.name.contains('type') ? record?.type?.code : ''} ${record.class.declaredFields.name.contains('department') ? record.department?.code : ''}</i>&nbsp;
                        </g:if>
                    </span>



                    <g:remoteLink controller="generics" action="showSummary"
                                  update="underBox${record.entityCode()}${record.id}"
                                  style="font-family: tahoma; font-size: 0.9em;"
                                  class="text${record.class.declaredFields.name.contains('language') ? record.language : (entityCode == 'E' ? record?.book?.language : '')};"
                                  params="${[id: record.id, entityCode: record.entityCode(), mobileView: mobileView]}">

                        <span style=""
                              class="text${record.class.declaredFields.name.contains('language') ? record.language : (entityCode == 'E' ? record?.book?.language : '')};">

                            <g:if test="${'P'.contains(record.entityCode()) && record.task}">
                                <br/>  <span title="${record?.summary}">${record.task?.summary}</span>
                            </g:if>
                            <g:elseif test="${'N'.contains(record.entityCode())}">
                                ${record?.orderInWriting ? '#' + record?.orderInWriting + ' ' : ''}
                              <br/>  ${record?.summary}


                                <g:if test="${record.fileName}">
                                    <a href="${createLink(controller: 'operation', action: 'downloadNoteFile', id: record.id)}"
                                       target="_blank">
                                        <span style="font-size: 12px;">
                                            ${record.fileName}
                                        </span></a>
                                </g:if>

                            </g:elseif>
                            <g:elseif test="${'R'.contains(record.entityCode())}">
                                <br/>
                                ${record?.title ?: record?.legacyTitle}
                                <i>${record?.author}</i>

                            </g:elseif>

                            <g:elseif test="${'E'.contains(record.entityCode())}">
                                <br/>
                                <span style="color: gray">${record?.book?.title ?: record?.book?.legacyTitle}</span>
                                <u>${record.chapters}</u>
                                <i>${record?.summary}</i>
                            </g:elseif>

                            <g:else>
                                <br/>
                                ${record?.summary}
                            </g:else>





                        %{--<g:if test="${'C'.contains(record.entityCode())}">--}%
                        %{--<b>${record.code}--}%
                        %{--${record.code}</b>--}%
                        %{--${record.summary}--}%
                        %{--</g:if>--}%
                        </span>
                    %{--<br/>--}%
                    </g:remoteLink>




                    %{--<div style="line-height: 20px; dir: auto !important;">--}%
                    %{-- ${record.description?.encodeAsHTML()?.replaceAll('\n', '<br/>')} --}%
                    %{--</div>--}%
                    <g:if test="${record.class.declaredFields.name.contains('language')}">
                        </div>
                    </g:if>

                </td>
            </tr>
            <g:if test="${expanded}">
            <tr style="background: #fff; border-left: 0px; border-right: 0px; border-bottom: 1px #ccc !important;" >
                <td class="text${record.language}" style="padding: 3px; border: 1px darkgray dashed;">

                    <span style="color: dimgray">
                        ${record.class.declaredFields.name.contains('description') && record.description ? StringUtils.abbreviate(record.description?.encodeAsHTML(), 240) : ''}
                    </span>

                    <g:if test="${record.entityCode() == 'N' && record.recordId}">

                        <g:remoteLink controller="generics" action="showSummary"
                                      id="${record.recordId}"
                                      params="[entityCode: record.entityCode]"
                                      update="belowNRecord${record.id}"
                                      title="Show parent entity">

                            <b>${record.entityCode}</b>
                            <i>${record.recordId}</i>


                            <g:if test="${record.entityCode == 'R'}">
                                ${Book.get(record.recordId)}
                            </g:if>

                        </g:remoteLink>

                    </g:if>

                </td>

            </tr>
            </g:if>
            %{--<g:if test="${'CGR'.contains(record.entityCode()) && record.percentCompleted}">--}%
            %{--<tr>--}%
            %{--<td colspan="2"  style="padding: 0; margin: 0" class="text${record.language}">--}%
            %{--<br/>--}%
            %{--<pkm:progressBar percent="${record.percentCompleted}"/>--}%

            %{--</td>--}%
            %{--</tr>--}%
            %{--</g:if>--}%
        </table>
    </g:if>
</div>


<br/>

<p style="page-break-before: always"></p>

<div id="underBox${record.entityCode()}${record.id}"></div>

<div style="margin-left: 20px;" id="below${record.entityCode()}Record${record.id}">

</div>