<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
<div id="accordionWest" class="basic">

        <g:if test="${Setting.findByName('quran.enabled')?.value == 'yes'}">

   <h3 style="text-align: right;"><a href="#" >
                السور القرآنية
%{--                <g:message code="ui.Quran"></g:message>--}%

            </a></h3>

            <div>





                <div style="direction: rtl;  text-align: right;  column-count: 4;  column-gap: 4px;">
                    <g:each in="${mcs.Writing.findAllByType(WritingType.findByCode('surah'), [sort: 'orderInBook'])}"
                            var="c">

                    %{--before="jQuery('#centralArea').scrollTop()" ToDo fix--}%
                        <g:remoteLink controller="report" action="surahReport" params="[id: c.id]" update="centralArea"
                                      style="${c.status?.code == 'revised' ? 'color: darkgreen' : 'color: black'}">

                        %{--style="opacity: ${1 - c.reviewCount / 10.0};"--}%

                            <span style="font-size: 12px;">${c.orderInBook}</span>

                            <span style="font-size: 12px; font-family: 'tahoma'" title="(${c.slug})">${c.summary}</span>
%{--                            <span style="font-size: 11px;">(${c.slug})</span>--}%
%{--                            <span style="font-size: 10px; color: darkorange"><sup><g:set var="count"--}%
%{--                                           value="${IndexCard.executeQuery('select count(*) from IndexCard i where i.recordId = ? and i.type.code = ? and i.notes != null ', [c.id.toString(), 'aya'])[0]}"/>--}%
%{--                                    ${count > 0 ? count : ''}--}%
%{--                                </sup>--}%
%{--                            </span>--}%
                            ${c.bookmarked ? '*' : ''}

                        </g:remoteLink>
                        <br/>

                    </g:each>
                </div>
                </div>


            <h3><a href="#">
ملاحظات على آيات
                %{--                <g:message code="ui.Quran"></g:message>--}%

            </a></h3>

                <div style="direction: rtl; text-align: right; column-count: 3;  column-gap: 2px;">


            <g:each in="${mcs.Writing.findAllByType(WritingType.findByCode('surah'), [sort: 'orderInBook'])}"
                    var="c">

                <g:if test="${IndexCard.executeQuery('select count(*) from IndexCard i where i.recordId = ? and i.type.code = ? and i.notes != null ', [c.id.toString(), 'aya'])[0]> 0}">

                <g:remoteLink controller="report" action="surahReportWithNotes" params="[id: c.id]" update="centralArea"
                              style="${c.status?.code == 'revised' ? 'color: darkgreen' : 'color: black'}">
                    <span style="font-size: 12px;">${c.orderInBook}</span>
                    <span style="font-size: 12px; font-family: 'tahoma'" title="(${c.slug})">${c.summary}</span>
                    (${IndexCard.executeQuery('select count(*) from IndexCard i where i.recordId = ? and i.type.code = ? and i.notes != null ', [c.id.toString(), 'aya'])[0]})
%{--                    <span style="font-size: 11px;">(${c.slug})</span>--}%
                </g:remoteLink>
                    <br/>
                </g:if>
            </g:each>
                </div>

            <h3><a href="#">
                الأجزاء والأرباع
                %{--                <g:message code="ui.Quran"></g:message>--}%

            </a></h3>

                <div style="direction: rtl; text-align: right;  column-count: 10;  column-gap: 5px;">
                    <g:each in="${1..30}"
                            var="j">

                        <g:remoteLink controller="report" action="readJouza" id="${j}"
                                      update="centralArea"
                                      title="">
                            <b style="border-bottom: 1px darkgray solid">ج ${j}</b>
                        </g:remoteLink>
<br/>
<br/>
                            <g:each in="${8 * (j - 1) + 1..8 * (j - 1) + 8}"
                                    var="r"><g:remoteLink controller="report" action="readRouba" id="${r}" update="centralArea">
                                ر${r}</g:remoteLink>
                                <br/>
                            </g:each>


                    </g:each>

                </div>
            <h3><a href="#">
                أدعية
                %{--                <g:message code="ui.Quran"></g:message>--}%

            </a></h3>

            <div style="direction: rtl; text-align: right; ">
<ul style=" column-count: 2;  column-gap: 3px;">
            <g:each in="${Writing.findAllByCourseAndPriorityGreaterThan(Course.findByCode('ذكر'), 2, [sort: 'orderNumber', order: 'asc'])}" var="w">
     <li>           <g:remoteLink controller="generics" action="showSubChildrenWithRecord"
                              params="${[id: w.id, entityCode: 'W', childType: 'N']}"
                              update="centralArea"
                              title="Children">
                        ${w} (${app.IndexCard.countByEntityCodeAndRecordId('W', w.id)})
                </g:remoteLink>
     </li>
            </g:each>
</ul>
<br/>
<hr/>
                <br/>
                <ul style=" column-count: 2;  column-gap: 3px;">
                    <g:each in="${IndexCard.findAllByCourseAndPriorityGreaterThan(Course.findByCode('ذكر'), 2, [sort: 'orderNumber', order: 'asc'])}" var="w">
                        <li>           <g:remoteLink controller="generics" action="showSummary"
                                                     params="${[id: w.id, entityCode: 'N']}"
                                                     update="centralArea"
                                                     title="${w}">
                            ${w}
                        </g:remoteLink>
                        </li>
                    </g:each>
                </ul>

            </div>

              <h3><a href="#">
                تقارير
                %{--                <g:message code="ui.Quran"></g:message>--}%

            </a></h3>

            <div>


                <g:remoteLink controller="report" action="quranReportToString" update="centralArea">
                    Qurani inline
                </g:remoteLink>
                <br/>      <g:remoteLink controller="report" action="staticQuranReport" update="centralArea">
                Qurani inline to file
            </g:remoteLink>
                <br/>       <g:remoteLink controller="report" action="staticQuranReportTex" update="centralArea">
                Qurani inline to Tex file
            </g:remoteLink>
                <br/>
                <g:remoteLink controller="report" action="memorizationReport" update="centralArea">
                    Memorization aid
                </g:remoteLink>
                <br/>  <g:remoteLink controller="report" action="memorizationReport" update="centralArea">
                Memorization aid
            </g:remoteLink>
                <br/>
                <g:remoteLink controller="report" action="staticMemorizationReport" update="centralArea">
                    Memorization aid to file
                </g:remoteLink>
                <br/>

                <g:remoteLink controller="report" action="matrixReport" update="centralArea">
                    Salat matrix report
                </g:remoteLink>
                <br/>


            </div>

        </g:if>

</div>