

%{--todo: move to panel--}%
%{--<g:if test="${record.class.declaredFields.name.contains('password')}">--}%
%{--<span style="font-size: 0.95em; color: #8A5C69">--}%
%{--${record.password}--}%
%{--</span>--}%
%{--</g:if>--}%

%{--<g:if test="${record.publisher}">--}%
%{--<br/>--}%
%{--<i>${record.publisher ?: ''}</i>--}%
%{--</g:if>--}%




<g:if test="${entityCode == 'Blog'}">
    <a href="${createLink(controller: 'operation', action: 'htmlPublishedPosts')}" style="border: 1px solid darkgray; margin: 3px;"
       target="_blank">
        Export W ?pub
    </a>
</g:if>


<g:if test="${justUpdated || justSaved}">
    <script type="application/javascript">
        jQuery("#${entityCode}Record${record.id}").hide('fast');
        jQuery("#${entityCode}Record${record.id}").fadeIn('slow');
        %{--jQuery("#${entityCode}Record${record.id}").slideLeft('slow');--}%
    </script>
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


<g:if test="${'O'.contains(entityCode)}">

    <br/>
%{--<g:remoteLink controller="generics" action="verifyOperation"--}%
%{--id="${record.id}"--}%
%{--update="below${entityCode}Record${record.id}"--}%

%{--title="Show parent entity">--}%
%{--<b>Verify</b>--}%
%{--</g:remoteLink>--}%


    <pkm:operationRecordFiles fileClass="himFile"  recordId="${record.id}"/>
%{-- changes for the operation module w08.2022 --}%
%{--update="underQuickEditForm"--}%

    <br/>
    <g:remoteLink controller="generics" action="executeOperation"
                  id="${record.id}"
                  class="executeOperation"
                  update="${entityCode}Record${record.id}"
                  style="padding: 2px; border: 1px solid darkgreen; border-radius: 5px; text-align: center; font-size: 1em; width: 20%;"
                  title="Show parent entity">
        <b>Execute (x)</b>
    </g:remoteLink>

</g:if>



<tr style="background: #f2f2f2; margin-bottom: 3px; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.2);">

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





    <td class="record-summary ${record.class.declaredFields.name.contains('isMerged') && record.isMerged ? 'merged' : '' }  ${record.class.declaredFields.name.contains('deletedOn') && record.deletedOn ? 'deleted' : '' }  text${record.class.declaredFields.name.contains('language') ? record.language : (entityCode == 'E' ? record?.book?.language : '')} ${record.class.declaredFields.name.contains('status') && record.status ? 'status-' + record?.status?.code : ''}"

        style="width: 98%; font-size: 0.95em; vertical-align: middle; line-height: 1.4em; color: #105CB6; padding-right: 4px; padding-left: 4px; padding-bottom: 2px; padding-top: 2px; text-align: justify !important;">








    </td>




    <td class="" style="">

        %{--<table border="0" style="border: 0">--}%
        %{--<tr>--}%
        %{--<td>--}%



    </td>


%{--<g:if test="${new File(OperationController.getPath('root.rps1.path') + '/' + entityCode + '/' + record.id + '/' +  'cover.jpg')?.exists() ||--}%
%{--new File(OperationController.getPath('root.rps2.path') + '/' + entityCode + '/' + record.id + '/' +  'cover.jpg')?.exists()}">--}%

%{--<td style="">--}%



%{--</td>--}%

%{--</g:if>--}%
%{--legacy case--}%


    <g:if test="${entityCode.length() == 1 && (new File(OperationController.getPath('root.rps1.path') + "/${entityCode}/" + record.id  + '/' +
            record.id +  entityCode.toLowerCase() + '.jpg')?.exists() || new File(OperationController.getPath('root.rps2.path') + "/${entityCode}/" + record.id  + '/' +
            record.id + entityCode.toLowerCase() + '.jpg')?.exists())}">

        <td style="width: 55px;">

            <ul class="product-gallery">
                <li class="gallery-img" id="recordImageCover${record.id}">
                    <img class="recordCover Photo"
                         style="height: 80px; display:inline"
                         src="${createLink(controller: 'indexCard', action: 'viewImage', id: record.id, params: [entityCode: entityCode, date: new Date()])}"/>
                </li>
            </ul>
            <script type="text/javascript">
                jQuery('#recordImageCover${record.id}').Am2_SimpleSlider();
            </script>
        </td>
    </g:if>


%{--</td>--}%

</tr>

<g:if test="${1 == 2 && record.description?.length() < OperationController.getPath('description.summarize.thresholdMax')?.toInteger() &&
        record.description?.length() > OperationController.getPath('description.summarize.threshold')?.toInteger()}">

    <span id="descriptionArea${record.id}">
        <g:remoteLink controller="generics" action="showFullDescription"
                      tabindex="-1"
                      id="${record.id}"
                      params="[entityCode: entityCode]"
                      update="descriptionArea${record.id}"
                      title="Show full description">
        %{--?.replaceAll("\\<.*?>", "")--}%
            <pkm:summarize
                    text="${record?.description?.replace('Product Description', '')}"

                    length="${OperationController.getPath('description.summarize.threshold')?.toInteger()}"/>
            (${record.description?.count(' ')})
        </g:remoteLink>
    </span>

</g:if>


<g:if test="${entityCode == 'R'}">
    <g:if test="${(new File(OperationController.getPath('root.rps1.path') + "/${entityCode}/cvr/" +
            '/' + record.id + '')?.exists() ||
            new File(OperationController.getPath('root.rps2.path') +
                    "/${entityCode}/cvr/" + '/' + record.id + '')?.exists())}">
        <td style="width: 85px;">
            <ul class="product-gallery">
                <li class="gallery-img" id="recordImageCover${record.id}">
                    <img class="recordCover Photo" style="width: 60px; height: 80px; display:inline"
                         src="${createLink(controller: 'book', action: 'viewImage', id: record.id, params: [date: new Date()])}"/>
                </li>
            </ul>
            <script type="text/javascript">
                jQuery('#recordImageCover${record.id}').Am2_SimpleSlider();
            </script>
        </td>
    </g:if>
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



%{--<g:if test="${'J'.contains(entityCode) && new File(OperationController.getPath('jrn.sns.path') + '/J/' + record.id).exists()}">--}%
%{--<b style="color: darkgreen">sns</b> &nbsp;--}%
%{--</g:if>--}%

%{--<g:if test="${'J'.contains(entityCode) && new File(OperationController.getPath('jrn.rcd.path') + '/J/' + record.id).exists()}">--}%
%{--<b style="color: darkgreen">rcd</b> &nbsp;--}%
%{--</g:if>--}%
%{--<g:if test="${'J'.contains(entityCode) && new File(OperationController.getPath('jrn.vjr.path') + '/J/' + record.id).exists()}">--}%
%{--<b style="color: darkgreen">vjr</b> &nbsp;--}%
%{--</g:if>--}%



%{--<g:if test="${record.class.declaredFields.name.contains('slug') && record.slug}">--}%
%{--<span style="color: #004499; font-family: monospace">${record.slug}</span>--}%
%{--</g:if>--}%

%{--<span style="direction: rtl; text-align: right;">--}%
%{--<g:if test="${record.class.declaredFields.name.contains('department') && record.department}">--}%
%{--                        <span style="margin: 2px; font-size: 1.2em; padding: 3px; border-radius: 4px; color: white; font-weight: bold; background: #0d4f98; font-family: monospace">--}%
%{--                            ${record.department?.code}--}%
%{--                        </span>--}%
%{--    &nbsp;--}%
%{--                        </g:if>--}%


%{--                                <br/>--}%





%{--<g:remoteLink controller="generics" action="showDetails"--}%
%{--params="${[id: record.id, entityCode: entityCode]}"--}%
%{--update="below${entityCode}Record${record.id}"--}%
%{--title="Details">--}%
%{--<g:render template="/gTemplates/summaryField" model="[record: record, entityCode: entityCode]"/>--}%
%{----}%
%{--</g:remoteLink>--}%



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




<g:if test="${entityCode == 'E'}">

    <g:if test="${(new File(OperationController.getPath('covers.sandbox.path') + '/exr/' +
            record?.id + '.jpg')?.exists() || new File(OperationController.getPath('covers.repository.path') + '/exr/' + record?.id + '.jpg')?.exists())}">
        <td>

            <ul class="product-gallery">

                <li class="gallery-img" id="recordImageCover${record.id}">
                    <img class="recordCover Photo" style="width: 50; height: 70; display:inline"
                         src="${createLink(controller: 'book', action: 'viewExcerptImage', id: record.id, params: [date: new Date()])}"/>

                </li>
            </ul>
            <script type="text/javascript">
                jQuery('#recordImageCover${record.id}').Am2_SimpleSlider();
            </script>

        </td>
    </g:if>

</g:if>







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





%{--<g:remoteLink controller="generics" action="executeSavedSearch"--}%
%{--tabindex="-1"--}%
%{--style=" color: gray"--}%
%{--before="jQuery.address.value(jQuery(this).attr('href'));"--}%
%{--id="${record.id}" params="[reportType: 'random']"--}%
%{--update="centralArea">--}%
%{--rand--}%

%{--</g:remoteLink>--}%



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


%{--<g:if test="${record.class.declaredFields.name.contains('trackSequence') && record.trackSequence}">--}%
%{--<b>${record.trackSequence}</b>--}%
%{--</g:if>--}%


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

