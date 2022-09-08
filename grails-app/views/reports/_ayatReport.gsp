<style type="text/css">

.aya {
    color: black;
    font-family: 'lato';
}


.aya0 {
    font-size: 24px;
    font-family: 'lato "traditional arabic"';
    color: black;
    background: #ffdcd4;
}
.aya1 {
    font-size: 24px;
    font-family: 'lato "traditional arabic"';
    color: white;
    background: #f7b6b3;
}
.aya2 {
    font-size: 22px;
    font-family: lato;
    /*"traditional arabic";*/
    /*color: white;*/
    /*background: #f3f1cf;*/
}
.aya3 {
    font-size: 24px;
    font-family: lato;
/*"traditional arabic";*/
    font-weight: bold;
    color: black;
    background: #e8f6d4;
}

.aya4 {
    font-size: 24px;
    font-family: "traditional arabic";
    color: black;
    font-weight: bold;
    background: #dbe6fa;
}

</style>

<input type="text" style="width: 5px;" value="" id="123"></input>
<h2 class="arabicText" style="text-align: center">
<g:remoteLink controller="report" action="surahReport" id="${writing?.id}" update="centralArea">
    &sect;    ${title}
    </g:remoteLink>
</h2>




<g:if test="${list && list.size() > 0}">


    <div id="tabs">
         <ul>
           <li><a href="#tab1"><span>عرض</span></a></li>
           <li><a href="#tab2"><span>تفسير</span></a></li>

           <li><a href="#tab3"><span>حفظ</span></a></li>
    <g:if test="${writing}">
           <li><a href="#tab4"><span>سورة</span></a></li>
        </g:if>
       </ul>

    <div id="tab1">

        <div style="direction: rtl; text-align: justify; line-height: 300%;">
            <g:set var="s" value="${1}"></g:set>
            <g:each in="${list}" var="r">
                <g:if test="${r.orderInWriting == 1}">
                    <h2>
                        سورة ${mcs.Writing.get(r.recordId.toLong()).summary}
                    </h2>
                    &nbsp; <span style="padding: 5px;background: darkgray; color: white; text-weight: bold"> [${s++}] </span> &nbsp;
                </g:if>
                <g:if test="${r.isNewSection}">
                    <br/>  &nbsp; <span style="font-size: 14px; padding: 5px;background: darkgray; color: white; text-weight: bold"> [${s++}] </span> &nbsp;

                </g:if>
                <div style="color: #272727; font-size: 24px; display: inline;" title="${r.description != '?' ? r.description : ''}"
                     class="aya aya${r.priority}">
                <g:remoteLink controller="generics" action="showSummary"
                              params="${[id: r.id, entityCode: 'N']}"
                              update="belowAya0${r.id}"
                              title="${r.description}">
                    ${r.shortDescription} </g:remoteLink>
                </div>
                    (${r.orderInWriting})
                <span id="belowAya0${r.id}"></span>
            </g:each>

        </div>

    </div>
   <div id="tab2">



       <div style="box-shadow: 0px 1px 3px 0px rgba(213, 213, 213, 0.2); padding-left: 10px; margin-left: 5px;">
           <table class="arabicText" style="border-collapse: collapse; width: 95%; ">
           %{--<table>--}%
               <g:each in="${list}" var="r">

                   <g:if test="${r.orderInWriting == 1}">
                       <tr>
                           <td colspan="4" style="text-align: right;">
                               <h2>
                                   سورة ${mcs.Writing.get(r.recordId.toLong()).summary}
                               </h2>
                           </td>
                       </tr>

                   </g:if>

                   <tr>

                       <td class="arabicText"
                           style="${r.bookmarked ? 'font-weight: bold' : ''}; font-size: 8px; width: 5%; padding: 5px; border-bottom: solid 1px gray !important; color: #eeeee;">
                           <g:remoteLink controller="generics" action="showSummary"
                                         params="${[id: r.id, entityCode: 'N']}"
                                         update="belowAya${r.id}"
                                         title="">
                               ${r.orderInWriting}
                           </g:remoteLink>
                       </td>
                       <td class="arabicText aya aya${r.priority}"
                           style="color: black; vertical-align: top; padding: 5px; ${r.bookmarked ? 'font-weight: bold' : ''}; font-family: 'traditional arabic'; font-size: 23px; width: 50%; line-height: 40px;  border-bottom: solid 1px gray !important;">
                           ${r.shortDescription}
                           <br/>

                           <g:each in="[0, 1, 2, 3, 4, 5]" var="p">
                               &nbsp;
                               <a title="Set priority" style="font-size: 14px !important; text-decoration: none;"
                                  value="${r.priority}"
                                  onclick="jQuery('#AyaRecord${r.id}').load('${request.contextPath}/generics/setPriority/N${r.id}?p=' + ${p})">
                                   &nbsp;
                                   <g:if test="${r.priority == p && p != 2}">
                                       <b style='font-size: 12px; color: blue'>${p}
                                   </g:if>
                                   <g:else>
                                       ${p}
                                   </g:else>
                               </a>

                           </g:each>
                                    &nbsp;&nbsp;
                           <a title="Mark as new section" style="font-size: 17px"
                              value=""
                              onclick="jQuery('#AyaRecord${r.id}').load('${request.contextPath}/indexCard/toggleAsNewSection/N${r.id}')">
                               ${r.isNewSection == true ? raw('<b style="font-size: 14px; color: blue">&crarr;</b>') : raw('&crarr;')}
                           </a>
                           &nbsp;&nbsp;
                           <span id="AyaRecord${r.id}"></span>
                       </td>
                       <td class="arabicText"
                           style="vertical-align: top;  padding-right: 10px; font-size: 12px;line-height: 18px; width: 40%; border-bottom: solid 1px gray !important; color: darkgreen;">
                           ${r.description != '?' ? r.description : ''}

                           <g:if test="${app.IndexCard.countByEntityCodeAndRecordId(r.entityCode(), r.id) > 0}">

                               <g:remoteLink controller="generics" action="showChildren"
                                             params="${[id: r.id, entityCode: 'N']}"
                                             update="belowAya${r.id}"
                                             title="Children">
                                   ${app.IndexCard.countByEntityCodeAndRecordId('N', r.id)}
                                   </g:remoteLink>
                               <div id="belowAya${r.id}">

                               </div>

                           </g:if>

                           <g:each in="${app.IndexCard.findAllByEntityCodeAndRecordId(r.entityCode(), r.id, [max: 3, sort: 'dateCreated', order: 'desc'])}" var="n">
                               <g:render template="/gTemplates/box" model="[record: n]"/>
                           </g:each>

                           <g:if test="${r.notes}">

                               <div class="arabicText"
                                    style=" font-size: 12px ;padding: 5px; border-top: solid 1px gray !important; color: #272727;">
                                   ++ <pkm:summarize text="${r.notes}" length="200"></pkm:summarize>
                               </div>
                           </g:if>
                       </td>
                   </tr>
                   <tr>
                       <td colspan="4">
                           <div id="belowAya${r.id}"></div>

                       </td>
                   </tr>

               </g:each>

           </table>
           <br/>


           %{--<g:render template="/gTemplates/recordSummary" model="[record: writing, entityCode: 'W']"/>--}%
           <br/>
           <br/>

       </div>

   </div>
   <div id="tab3">
       <div style="direction: rtl; text-align: justify; line-height: 300%;">
           <g:each in="${list}" var="r">
               <g:if test="${r.isNewSection}">
                   <br/>
               </g:if>
               <span style="font-family: tahoma;"
                     class="aya">
                   ${r.orderInWriting}
                   <g:each in="${(0 .. ker.OperationController.getPath('aya.first.words.count').toInteger() - 1)}" var="i">
                       <g:if test="${i < r.shortDescription.split(' ')?.size()}">
                           ${r.shortDescription.split(' ')[i]}
                       </g:if>
                   </g:each>...

               </span>

           </g:each>

       </div>
   </div>
   <div id="tab4">
<g:if test="${writing}">
       <g:render template="/gTemplates/recordSummary" model="[record: writing]"/>
</g:if>
    </div>
    </div>






    <br/>
    <hr/>
    <hr/>






    <hr/>
    <br/>


</g:if>
<g:else>
    Empty list
</g:else>
<script type="application/javascript">
    jQuery('#123').focus();
    jQuery("#tabs").tabs();
</script>