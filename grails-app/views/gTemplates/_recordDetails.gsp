<%@ page import="mcs.Writing; mcs.Book; org.apache.commons.lang.StringUtils; ker.OperationController; app.parameters.Blog; cmn.Setting;  mcs.Journal; app.Payment; app.IndicatorData; app.IndexCard; mcs.Excerpt; mcs.Planner; java.text.DecimalFormat" %>
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>

<g:if test="${!session['showFullCard'] || session['showFullCard'] == 'on'}">
    <g:render template="/gTemplates/2ndLine" model="[record: record, entityCode: entityCode]"/>
</g:if>

%{--<r:require module="fileuploader"/>--}%
%{--<r:layoutResources/>--}%


<div class="recordDetailsBody" style="margin-left: 5px;" id="detailsRegion${entityCode}${record.id}">

<g:if test="${entityCode.length() == 1}">
    <div id="relationshipRegion${entityCode}${record.id}">
        <g:render template="/gTemplates/relationships" model="[record: record, entity: entityCode]"/>
    </div>
</g:if>




%{-- todo check <g:each in="${app.IndexCard.findAllByEntityCodeAndRecordId(entityCode, record.id)}" var="c">--}%
%{--<g:render template="/gTemplates/recordSummary" model="[record: c]"/>--}%
%{--</g:each>--}%


<g:if test="${entityCode == 'L'}">

    <g:render template="/gTemplates/recordListing"
              model="[list: Payment.findAllByCategory(record, [sort: 'date', order: 'desc'])]"/>

</g:if>

<g:elseif test="${entityCode == 'K'}">

    <div id="graph${record.id}" style="width: 500px; height: 200px; margin: 3px auto 0 auto;"></div>

    <script type="text/javascript">

        var day_data = [
            <% IndicatorData.findAllByIndicator(record).eachWithIndex(){ h, i -> if (i != IndicatorData.countByIndicator(record) - 1) { %>
            {"date": "${h.date.format('yyyy-MM-dd')}", "Value": ${h.value}},
            <% } else { %>
            {"date": "${h.date.format('yyyy-MM-dd')}", "Value": ${h.value}}
            <% }}  %>
            //        {"period":"2012-09-10", "pln total":12, "pln completed":10}
        ];
        Morris.Line({
            element: 'graph${record.id}',
            data: day_data,
            xkey: 'date',
            ykeys: ['Value'],
            ymin: 'auto',
            hideHover: 'true',
            labels: ['Value'],
            /* custom label formatting with `xLabelFormat` */
            xLabelFormat: function (d) {
                return  d.getDate() + '.' + (d.getMonth() + 1) //+ '/' + d.getDate() + '/' + d.getFullYear();
            },
            /* setting `xLabels` is recommended when using xLabelFormat */
            xLabels: 'day'
        });

    </script>


    <g:render template="/gTemplates/recordListing"
              model="[list: IndicatorData.findAllByIndicator(record, [sort: 'date', order: 'desc'])]"/>

</g:elseif>

<g:elseif test="${entityCode == 'P'}">

    <g:if test="${record.completedOn}">
        Completed on: ${record.completedOn?.format('dd.MM.yyyy')}
    </g:if>
    <g:if test="${record.task}">
        <g:render template="/gTemplates/recordSummary" model="[record: record.task]"/>
    </g:if>
    <g:if test="${record.goal}">
        <g:render template="/gTemplates/recordSummary" model="[record: record.goal]"/>
    </g:if>
</g:elseif>

<g:elseif test="${entityCode == 'T'}">
    <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByTask(record)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByTask(record)]"/>
</g:elseif>

<g:elseif test="${entityCode == 'R'}">

    <g:render template="/gTemplates/recordListing" model="[list: Excerpt.findAllByBook(record)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByBook(record)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByBook(record)]"/>

</g:elseif>

<g:elseif test="${entityCode == 'E'}">
    <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByExcerpt(record)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByExcerpt(record)]"/>

</g:elseif>

<g:elseif test="${entityCode == 'G'}">
%{--<h4>J & P</h4>--}%
    <g:render template="/gTemplates/recordListing" model="[list: Planner.findAllByGoal(record)]"/>
    <g:render template="/gTemplates/recordListing" model="[list: Journal.findAllByGoal(record)]"/>

</g:elseif>



<table style="border-collapse: collapse; width: 99%" border="0">
<tr style="width: 99%">
<td style="width: 60%; vertical-align: top">

<g:if test="${1 == 2}">

    <g:if test="${record.entityCode() == 'R'}">
        <pkm:listPictures fileClass="snsFile"
                          folder="${record.type?.newFilesPath}/${(record.id / 100).toInteger()}/${record.id}"
                          initial=""/>

        <pkm:listPictures fileClass="snsFile"
                          folder="${record.type?.repositoryPath}/${(record.id / 100).toInteger()}/${record.id}"
                          initial=""/>

    </g:if>


    <pkm:listPictures fileClass="snsFile"
                      folder="${OperationController.getPath('module.sandbox.' + record.entityCode() + '.path')}/${record.id}"
                      initial=""/>

    <pkm:listPictures fileClass="snsFile"
                      folder="${OperationController.getPath('module.repository.' + record.entityCode() + '.path')}/${record.id}"
                      initial="${record.id}"/>

    <pkm:listPictures fileClass="snsFile"
                      folder="${OperationController.getPath('module.sandbox.' + record.entityCode() + '.path')}"
                      initial="${record.id}"/>

    <pkm:listPictures fileClass="snsFile"
                      folder="${OperationController.getPath('module.repository.' + record.entityCode() + '.path')}"
                      initial="${record.id}"/>

</g:if>


<g:if test="${'N'.contains(entityCode) && record.sourceFree}">
    <i><a href="${record.sourceFree}">${StringUtils.abbreviate(record.sourceFree, 30)}</a></i>
</g:if>

<g:if test="${'T'.contains(entityCode)}">
%{--<g:render template="/tag/addContact" model="[instance: record, entity: entityCode]"/>--}%
</g:if>

<div style="padding: 8px; font-size: 11px; font-family: georgia; margin: 2px; line-height: 20px; text-align: justify">
    <g:if test="${record.class.declaredFields.name.contains('description')}">
        <g:remoteLink controller="page" action="panel"
                      params="${[id: record.id, entityCode: entityCode]}"
                      update="3rdPanel"
                      before="jQuery('#accordionEast').accordion({ active: 0});"
                      title="Read the full text">
            ${StringUtils.abbreviate(record.description?.replaceAll('\n', '<br/>')?.replace('Product Description', '')?.decodeHTML(), 240)}
        </g:remoteLink>
    </g:if>
</div>



<h4>Notes</h4>

<div id="panelComments${entityCode}Record${record.id}">
    <g:render template="/indexCard/add"
              model="[recordId: record.id, recordEntityCode: entityCode, language: (entityCode == 'R' ? record.language : 'ar')]"/>
</div>


<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>




%{--<br/>--}%
%{--<g:if test="${record.publishedNodeId}">--}%
%{--<br/>--}%
%{--Posted on ${record.blogCode} with ID ${record.publishedNodeId} on ${record.publishedOn?.format('dd.MM.yyyy HH:mm')}--}%
%{--<br/>--}%
%{--</g:if>--}%



<br/>
<br/>

</td>

<td style="width: 40%; vertical-align: top">

    <g:if test="${record.class.declaredFields.name.contains('tags')}">
        <g:render template="/tag/addTag" model="[instance: record, entity: entityCode]"/>
        <g:render template="/tag/addContact" model="[instance: record, entity: entityCode]"/>
    </g:if>

    <g:if test="${'TGRE'.contains(entityCode)}">
        <br/><b>+ J/P</b>
        <br/> 
        <g:formRemote name="scheduleTask" url="[controller: 'task', action: 'assignRecordToDate']"
                      style="display: inline;" update="below${entityCode}Record${record.id}"
                      method="post">
            <!-- Type/Level/Weight -->

            <g:select name="type" from="['J', 'P']" value="P"/>
            <g:select name="level" from="['e', 'y', 'M', 'W', 'd', 'm']" value="d"/>
            <g:select name="weight" from="${1..4}" value="1"/>
            <input type="text" name="date" title="Format: wwd [hh]" placeholder="Date"
                   style="width: 70px;"
                   value="${mcs.UtilsController.toWeekDate(new Date())}"/>
            <input type="text" name="summary" title=""
                   style="min-width: 500px !important;"
                   value=""/> 


            <g:hiddenField name="recordType" value="${entityCode}"/>
            <g:hiddenField name="recordId" value="${record.id}"/>
            <g:submitButton name="scheduleTask" value="ok" style="display: none;"
                            class="fg-button ui-widget ui-state-default ui-corner-all"/>
        </g:formRemote>
        <br/>
        <br/>
    </g:if>

    <g:if test="${entityCode.length() == 1}">
        <!--br/><b>Relate</b-->
        <br/>
        <span id="addRelationship${record.id}" style="display: inline;">
            <g:render template="/gTemplates/addRelationships"
                      model="[record: record, entity: entityCode]"/>
        </span>
    </g:if>


    <div id="publish${record.id}" style="display: inline;  margin-left: 10px;">
    <!--todo-->
        <g:if test="${'N'.contains(entityCode)}">
            <div id="postResult${record.id}" style="display: inline">
                <g:if test="${record.blog?.code}">
                    <g:remoteLink controller="generics" action="publish" id="${record.id}"
                                  params="[entityCode: entityCode]"
                                  update="postResult${record?.id}"
                                  title="Publish record"
                                  class="fg-button ui-widget ui-state-default ui-corner-all">
                        Publish on <b>${record.blog?.code}</b>
                    </g:remoteLink>
                </g:if>
            </div>


            <br/><br/>

            <div id="syncResult${record.id}" style="display: inline">

                <g:if test="${record.pomegranate?.code}">
                    <g:remoteLink controller="export" action="syncNote" id="${record.id}"
                                  params="[entityCode: entityCode]"
                                  update="syncResult${record?.id}"
                                  title="Sync record"
                                  class="fg-button ui-widget ui-state-default ui-corner-all">
                        Sync on <b>${record.pomegranate?.code}</b>
                    </g:remoteLink>
                </g:if>

            </div>
        </g:if>


        <g:if test="${'JWN'.contains(entityCode) && record.blog}">

            <td class="actionTd">

                <g:remoteLink controller="generics" action="publish" id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="notificationArea"
                              title="Post to blog ${record.blog}">
                    <span class="ui-icon ui-icon-circle-arrow-e"></span>
                </g:remoteLink>
            </td>

        </g:if>




        <g:link controller="page" action="record" target="_blank"
                params="${[id: record.id, entityCode: entityCode]}"
                class=" fg-button fg-button-icon-solo ui-widget ui-state-default ui-corner-all"
                title="Go to page">
            <span class="ui-icon ui-icon-extlink"></span>

        </g:link>


        <g:if test="${1 == 2}">
            <g:formRemote name="setBlogCode" style="display: inline"
                          url="[controller: 'generics', action: 'setRecordBlog', params: [id: record.id, entityCode: entityCode]]"
                          update="notificationArea"
                          title="Post info">
                <g:select from="${Blog.list()}" name="blog.id" title="Blog"
                          value="${record.blog?.id}"/>
                <g:textField id="publishedNodeId" name="publishedNodeId" style="width: 30px"
                             class="ui-corner-all"
                             title="Post ID" placeholder="Post ID"
                             value="${record?.publishedNodeId}"/>
                <g:textField id="publishedOn" name="publishedOn" style="width: 80px"
                             class="ui-corner-all" placeholder="Post date" title="Post date"
                             value="${record.publishedOn ? record.publishedOn?.format('dd.MM.yyyy') : new Date().format('dd.MM.yyyy')}"/>

                <g:submitButton name="add" value="Set" style=""
                                class="fg-button  ui-widget ui-state-default ui-corner-all"/>
            </g:formRemote>
        </g:if>
    </div>





    <g:if test="${new File(OperationController.getPath('covers.sandbox.path') + '/' +
            entityCode + '/' + record.id + '.jpg')?.exists() || new File(OperationController.getPath('covers.repository.path') + '/' + entityCode + '/' + record.id + '.jpg')?.exists()}">
        <br/><br/>
        <a href="${createLink(controller: 'book', action: 'viewImage', id: record.id)}"
           target="_blank">
            <img class="Photo" style="width: 100; height: 130; display:inline"
                 src="${createLink(controller: 'book', action: 'viewImage', id: record.id, params: [date: new Date()])}"/>
        </a>
    </g:if>


    <g:if test="${entityCode == 'R' && (new File(OperationController.getPath('covers.sandbox.path') + '/' +
            record?.type?.code + '/' + record.id + '.jpg')?.exists() || new File(OperationController.getPath('covers.repository.path') + '/' + record?.type?.code + '/' + record.id + '.jpg')?.exists())}">
        <br/><br/>
        <a href="${createLink(controller: 'book', action: 'viewImage', id: record.id)}"
           target="_blank">
            <img class="Photo" style="width: 100; height: 130; display:inline"
                 src="${createLink(controller: 'book', action: 'viewImage', id: record.id, params: [date: new Date()])}"/>
        </a>
    </g:if>
    <br/>
    <br/>
    <g:if test="${Setting.findByName('aws.secret.key') && entityCode == 'R'}">
        <g:remoteLink controller="book" action="updateBookInfo" id="${record.id}"
                      update="RRecord${record.id}"
                      class="actionLink"
                      title="Update metadata from Amazon">
            Update metadata
        </g:remoteLink>
        <br/>
        <br/>
    </g:if>

</td>
</tr>
</table>


<g:if test="${1 == 2}">
    <div id="addNote${record.id}" style="display: inline; ">
        <g:formRemote name="addNote" url="[controller: 'generics', action: 'addNote']"
                      update="notes${entityCode}${record.id}"
                      style="display: inline;">
            <g:hiddenField name="id" value="${record.id}"/>
            <g:hiddenField name="entityCode" value="${entityCode}"/>
            <g:textField id="newNote${entityCode}${record.id}" name="note" class="ui-corner-all"
                         placeholder="Append to notes..."
                         style="width:100px; display: inline; " value=""/>
            <g:submitButton name="add" value="add" style="display:none;"
                            class="fg-button  ui-widget ui-state-default ui-corner-all"/>
        </g:formRemote>
    </div>
</g:if>

</div>



%{--<g:render template="/indexCard/add"--}%
%{--model="[indexCardInstance: new IndexCard(), recordEntityCode: entityCode, recordId: record.id]"/>--}%




<td class="actionTd">

</td>




<td style="width :12px; line-height: 0.4em; display: none;">

</td>



%{--<a class="actionLink" onclick="jQuery('#addRelationship${record.id}').removeClass('navHidden')">Relate...</a>--}%
%{--<a class="actionLink" onclick="jQuery('#addNote${record.id}').removeClass('navHidden')">Add note...</a>--}%
%{--<g:if test="${'JWC'.contains(entityCode)}">--}%
<!--<a class="actionLink" onclick="jQuery('#publish${record.id}').removeClass('navHidden')">Publish...</a>-->
%{--</g:if>--}%


<div class="pkmCode" style="display: none;">

    A ${entityCode} ${record.class.declaredFields.name.contains('type') && entityCode.length() == 1 && record.type ? '#' + record.type.code : ''}
    ${record.class.declaredFields.name.contains('status') && entityCode.length() == 1 && record.status ? '?' + record.status.code : ''}
    ${record.class.declaredFields.name.contains('status') && entityCode.length() == 1 && record.status ? '?' + record.status.code : ''}
    ${record.class.declaredFields.name.contains('location') && entityCode.length() == 1 && record.location ? '@' + record.location.code : ''}
    ${record.class.declaredFields.name.contains('context') && entityCode.length() == 1 && record.context ? '@' + record.context.code : ''}
    ${record.class.declaredFields.name.contains('summary') && record.summary ? ' ; ' + record.summary : ''}

    <br/>
    ${record.class.declaredFields.name.contains('description') && record.description ? StringUtils.abbreviate(record.description, 200) : ''}

</div>



<br/>