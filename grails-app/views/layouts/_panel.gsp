%{--
  - Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
  -
  - This program is free software: you can redistribute it and/or modify
  - it under the terms of the GNU General Public License as published by
  - the Free Software Foundation, either version 3 of the License, or
  - (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  - GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License
  - along with this program.  If not, see <http://www.gnu.org/licenses/>
  --}%

<%@ page import="java.time.format.DateTimeFormatter; mcs.Department;  cmn.DataChangeAudit; ker.OperationController; app.Indicator; mcs.Goal; mcs.Task; mcs.Planner; mcs.Journal; mcs.Writing; app.IndexCard; mcs.Excerpt; mcs.Book; mcs.Course;" %>

%{--<r:require module="fileuploader"/>--}%
<r:layoutResources/>


<style>
    .demo {
        height: auto !important;
    }
    .message {
        display: none;
    }
    .demo-dropable {
    display: none;
    }

</style>

%{--tomorrow:--}%
%{--<prettytime:display date="${new Date() + 1}" />--}%

%{--<markdown:renderHtml>This is a *test* **of** __markdown__.</markdown:renderHtml>--}%


<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>


<g:remoteLink controller="page" action="panel"
              params="${[id: record.id, entityCode: entityCode]}"
              update="3rdPanel"
              title="Click to refresh">

    <span style="padding: 1px; font-size: 15px; margin: 3px; line-height: 20px; text-align: justify">
        <span class="${entityCode}-bkg ID-bkg ${record.class.declaredFields.name.contains('deletedOn') && record.deletedOn ? 'deleted' : ''}"
              style="padding: 3px; margin-right: 3px; color: gray;">
            <b style="color: white;">${entityCode}</b>
        </span>
    </g:remoteLink>

        <span style="color: black;">${record.id}</span>
&nbsp;

           &nbsp;

<g:remoteLink controller="generics" action="fetchQuickAddForm"
              style="padding: 2px; font-size: 12px;"
              class="${record.class.declaredFields.name.contains('priority') ? 'priorityText' + record.priority : ''}"
              id="${record.id}"
              params="[entityController: record.class.name,
                       updateRegion    : '3rdPanel',
                       finalRegion     : '3rdPanel']"
              update="3rdPanel"
              before=" myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0});jQuery('#3rdPanel').scrollTop(0)"
              title="Edit">
    <b>    Edit</b>
</g:remoteLink>
&nbsp;

<g:if test="${record.class.declaredFields.name.contains('orderNumber') && record.orderNumber}">
    # ${record.orderNumber}
</g:if>
<br/>
<div style="direction: rtl !important; text-align: right !important; line-height: 25px;" >
    <g:remoteLink controller="page" action="panel"
                  params="${[id: record.id, entityCode: entityCode]}"

				  class="${record.class.declaredFields.name.contains('language') ? 'text' + record.language : ''}"
                  update="3rdPanel"
                  title="Click to refresh">
				  <g:if test="${record.class.declaredFields.name.contains('summary')}">
				  ${record.summary}
				  </g:if>
				  <g:if test="${record.class.declaredFields.name.contains('title')}">
				  ${record.title}
				  </g:if>
				  </span>
</g:remoteLink>
</div>




    %{--<% Calendar cal = new GregorianCalendar(); cal.setLenient(false); cal.setMinimalDaysInFirstWeek(4);--}%
    %{--cal.setFirstDayOfWeek(java.util.Calendar.MONDAY)--}%
    %{--%>--}%
    %{--<b>أ${cal.get(Calendar.WEEK_OF_YEAR)}</b>--}%
    <td>
<br/>
<br/>
<b>Upload files to record <i>rps1</i> folder (${typeSandboxPath}):</b>
<br/>
<br/>
%{--${typeSandboxPath?.replace('/', '-')?.replaceAll(/\\/, '-')}--}%
<uploadr:add id="uploader${new Date()?.format('ddMMyyyyHHmmss')}"
             name="uploader${new Date()?.format('ddMMyyyyHHmmss')}"
             controller="import" action="upload" path="d:/"
             placeholder="Behold: the drop area!" fileselect="Behold: the fileselect!"
             noSound="true"
             direction="down" maxVisible="5" unsupported="${request.contextPath}/upload/warning" maxConcurrentUploads="1" class="demo">
    <uploadr:onSuccess>
        jQuery('#spinner2').hide();
        jQuery('.info-badge').html('Done uploading files.');
        </uploadr:onSuccess>

</uploadr:add>


<br/>
<br/>
Open:
&nbsp;
<g:remoteLink controller="generics" action="openRpsFolder"
              params="${[id: record.id, entityCode: entityCode, repository: 1]}"
              update="${entityCode}Record${record.id}OpenLog"
              title="Open new folder: ${OperationController.getPath('root.rps1.path')}">
    <b> rps 1</b>
</g:remoteLink>
&nbsp;/&nbsp;
<g:remoteLink controller="generics" action="openRpsFolder"
              params="${[id: record.id, entityCode:  entityCode, repository: 2]}"
              update="${entityCode}Record${record.id}OpenLog"
              title="Open rps folder: ${OperationController.getPath('root.rps2.path')}">
    <b> rps 2</b>
</g:remoteLink>
&nbsp;
%{--<g:remoteLink controller="generics" action="openLibFolder"--}%
%{--              params="${[id: record.id, entityCode: entityCode]}"--}%
%{--              update="${entityCode}Record${record.id}"--}%
%{--              title="Open lib folder: ${OperationController.getPath('root.rps3.path')}">--}%
%{--    <b> rps 3 </b>--}%
%{--</g:remoteLink>--}%

folder.

        <g:if test="${record.class.declaredFields.name.contains('nbFiles')}">
        <g:if test="${record.nbFiles}">
        %{--<g:if test="${record.nbFiles}">--}%
            <br/>
            <br/>
            <b> Nb files: </b><span title="${record.filesList}" style="">${record.nbFiles ?: ''}</span>.
        </g:if>
        <g:remoteLink controller="operation" action="countResourceFiles" id="${record.id}" params="[entityCode: entityCode]"
                      update="${entityCode}Record${record.id}OpenLog" style=""
                      title="Update files count">
            <b>&circlearrowright;</b>
        </g:remoteLink>
                         &nbsp;
                <g:remoteLink controller="operation" action="copyToRps1"
                              params="${[id: record.id, entityCode: entityCode]}"
                              update="${entityCode}Record${record.id}OpenLog"
                              title="Copy files from rps2 (${OperationController.getPath('root.rps2.path')}) to rps1 (${OperationController.getPath('root.rps1.path')})">
                 <b>   &darr;
                    &darr;</b>
                </g:remoteLink>

        <br/>
        <br/>
        &nbsp;<span id="${entityCode}Record${record.id}OpenLog"></span>
        </g:if>

%{--&nbsp;/--}%
%{--&nbsp;--}%
<g:if test="${1 == 2}">
<g:if test="${entityCode == 'R'}">
    <br/>
    <br/>
opf    ${OperationController.getPath('root.rps1.path')}R/${record.type.code}/${(record.id / 100).toInteger()}/${record.id}
    <br/>
opf    ${OperationController.getPath('root.rps2.path')}R/${record.type.code}/${(record.id / 100).toInteger()}/${record.id}
</g:if>
<g:else>
    <br/>
    <br/>
opf    ${OperationController.getPath('root.rps1.path')}${entityCode}/${record.id}
    <br/>
opf    ${OperationController.getPath('root.rps2.path')}${entityCode}/${record.id}
</g:else>
</g:if>
    %{--<h4>Files</h4>--}%
<g:render template="/gTemplates/filesListing" model="[record: record, entityCode: record.entityCode()]"/>

%{--<uploader:uploader id="addToRecordFolder${record.id}"--}%
                   %{--url="${[controller: 'import', action: 'addToRecordFolder']}"--}%
                   %{--params="${[recordId: record.id, entityCode: record.entityCode()]}">--}%
    %{--Add to record folder--}%
%{--</uploader:uploader>--}%

%{--ToDo--}%
        <g:if test="${record.entityCode().length() == 120 && mobileView != 'true'}">
            <div style="display: inline; text-align: right;">
                <table border=0 width="95%">
                    <tr>
                        <td width="50%">
                        Upload cover
                        <uploader:uploader id="uploadCover${record.id}"
                        url="${[controller: 'import', action: 'uploadCover']}"
                        params="${[recordId: record.id, entityCode: record.entityCode()]}">
                        <uploader:onComplete>
                        jQuery('#subUploadInPanel').load('${request.contextPath}/generics/showSummary/' + responseJSON.id + '?entityCode=' +  responseJSON.entityCode)
                        </uploader:onComplete>
                        Upload...
                        </uploader:uploader>
                        </td>

                        <td>
                            Add to wrk folder ('${OperationController.getPath('root.rps1.path')}'):
                            <g:if test="${new File(OperationController.getPath('root.rps1.path')).exists()}">
                                <uploader:uploader id="addToRecordFolder${record.id}"
                                                   url="${[controller: 'import', action: 'addToRecordFolder']}"
                                                   params="${[recordId: record.id, entityCode: record.entityCode()]}">
                                    Add to record folder
                                </uploader:uploader>
                            </g:if>
                            <g:else>
                                Folder 'root.rps1.path' does not exist.
                                 Set: <g:render template="/forms/updateSetting" model="[settingValue: 'root.rps1.path']"/>.
                            </g:else>


                            <g:if test="${!new File(OperationController.getPath('tmp.path')).exists()}">
                                <br/>
                                Folder 'tmp.path' not found. Set:
                                <g:render template="/forms/updateSetting" model="[settingValue: 'tmp.path']"/>
                            </g:if>

                        </td>
                    </tr>
                </table>

            </div>

            <div id="subUploadInPanel"></div>
        </g:if>


        <g:if test="${entityCode == 'T'}">

    <g:set value="recurringInterval" var="field"></g:set>

    <a href="#" id="${field}${record.id}" class="${field}"
       data-type="select"
       data-value="${record[field]}"
       data-name="${field}-${record.entityCode()}"
       data-source="${request.contextPath}/operation/getQuickEditValues?entity=${record.entityCode()}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
       data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
       data-title="Edit ${field}">
        ${record[field] ? 'rci-' + record[field] : 'rci-'}
    </a>
    <script>
        jQuery("#${field}${record.id}").editable();
    </script>



    &nbsp;
    &nbsp;
</g:if>


        <g:if test="${source}">
<span style="color: green">
Source: ${source}
</span>
        </g:if>

<g:if test="${authors}">
<br/>
<span style="color: green">
Authors: ${authors}
</span>
    </g:if>






<g:if test="${'R'.contains(entityCode)}">
%{--<b>${record.title?.encodeAsHTML()?.replaceAll('\n', '<br/>')}</b>--}%
%{--<br/>--}%
    <div style="padding: 2px; font-size: 12px; font-family: tahoma; margin: 2px; line-height: 20px;">
        <g:if test="${record.legacyTitle}">
            <span style="font-size: small">
                <br/>    <b>Legacy title:</b>  ${record.legacyTitle}
                <br/>
            </span>
        </g:if>
        <g:if test="${record.author}">
            <b>Author</b>   : ${record.author}
            <br/>
        </g:if>
        <g:if test="${record.isbn}">
            <b>ISBN</b>   : ${record.isbn}
            <br/>
        </g:if>

    %{--Extension: ${record.ext}--}%
    %{--<br/>--}%
        <g:if test="${record.publisher}">
            <b>Publisher</b>: ${record.publisher}
            <br/>
        </g:if>
        <g:if test="${record.journal}">
            <b>Journal</b>: ${record.journal}
            <br/>
        </g:if>
        <g:if test="${record.edition}">
            <b>Edition</b>: ${record.edition}
            <br/>
        </g:if>
        <g:if test="${record.publicationDate}">
            <b>Publication date</b>: ${record.publicationDate}
            <br/>
        </g:if>
       <g:if test="${record.year}">
            <b>Year</b>: ${record.year}
            <br/>
        </g:if>
       <g:if test="${record.month}">
            <b>Month</b>: ${record.month}
            <br/>
        </g:if>
        <g:if test="${record.volume}">
            <b>Volume</b>: ${record.volume}
            <br/>
        </g:if>
       <g:if test="${record.series}">
            <b>Series</b>: ${record.series}
            <br/>
        </g:if>
        <g:if test="${record.number}">
            <b>Number</b>: ${record.number}
            <br/>
        </g:if>



       <g:if test="${record.publicationCity}">
            <b>City</b>: ${record.publicationCity}
            <br/>
        </g:if>
     <g:if test="${record.sourceFree}">
            <b>Source</b>: ${record.sourceFree}
            <br/>
        </g:if>

   <g:if test="${record.nbPages}">
            <b>Nb. pages</b>: ${record.nbPages}
            <br/>
        </g:if>
   <g:if test="${record.pages}">
            <b>Pages</b>: ${record.pages}
            <br/>
        </g:if>


        <g:if test="${record.url}">
            <span style="">
                <b>URL :</b>
                <span id="linkBloc${record.id}"
                ${record.url}
            </span>
            <br/>
        %{--${record.author},${record.title ?: record.legacyTitle} ${record.edition} ed--}%
        %{--(${record.publisher},--}%
        %{--${record.publicationDate})--}%
        </g:if>

        %{--<g:if test="${'R'.contains(entityCode)}">--}%
            %{--<br/>--}%



    %{--<g:if test="${record?.type?.code == 'link'}">--}%
    %{--<g:if test="${record?.url}">--}%
    %{--<br/>--}%
    %{--<g:remoteLink controller="import" action="scrapHtmlPage" id="${record.id}"--}%
    %{--update="RRecord${record.id}"--}%
    %{--class="actionLink"--}%
    %{--title="Scrap HTML">--}%
    %{--Scrape HTML page--}%
    %{--</g:remoteLink>--}%
    %{--<br/>--}%
    %{--<br/>--}%
    %{--</g:if>--}%







        <g:if test="${1 == 2 && record.isbn}">
            <g:remoteLink controller="operation" action="addBibtex" id="${record.id}"
                          update="bibTexBloc${record.id}"
                          class="actionLink"
                          title="Update metadata">
                Fetch Bib entry
            </g:remoteLink>
        </g:if>
    %{--Amazon tags: ${record.tags}--}%

        <g:if test="${record.withAudiobook}">
            <br/><i>With audiobook</i>
        </g:if>
        <g:if test="${record.isAudiobook}">
            <br/><i>Is audiobook</i>
        </g:if>
        <g:if test="${record.isPaperOnly}">
            <br/><i>Paper format only</i>
        </g:if>

        <g:if test="${record.isRead}">
            <br/><i>Has been read</i>
        </g:if>

        <g:if test="${record.isPublic}">
            <br/><i>To be shared</i>
        </g:if>
    </div>
</g:if>


        <g:if test="${'G'.contains(entityCode)}">
            <g:if test="${record.percentCompleted}">
                <b>Percent completed</b>: ${record.percentCompleted}
                <br/>
            </g:if>
            %{--<g:if test="${record.totalSteps}">--}%
                %{--<b>Total steps</b>: ${record.totalSteps}--}%
                %{--<br/>--}%
            %{--</g:if>--}%
                <g:if test="${record.class.declaredFields.name.contains('completedSteps')}">

                <g:formRemote name="saveCompletedSteps" url="[controller: 'operation', action: 'updateCompletedSteps', id: record.id]"
                              update="displayCompletedSteps"
                              style="display: inline;">
                %{--<g:hiddenField name="id" value="${record.id}"/>--}%
                    <g:hiddenField name="entityCode" value="${entityCode}"/>
                %{--placeholder="ما اُنجز"--}%
                    <b>Completed steps</b>:  <g:textField id="saveCompletedSteps${entityCode}${record.id}" name="text" class="ui-corner-all" cols="80"

                                                      rows="5"
                                                      style="width:20%;  display: inline; " value="${record.completedSteps}"/>
                    <g:submitButton name="add" value="=" style="display:none;"
                                    class="fg-button ui-widget ui-state-default ui-corner-all navHidden"/>
                %{--<br/>--}%
                </g:formRemote>
                &nbsp;    <span id="displayCompletedSteps"></span>


                <br/>
            </g:if>

            <g:if test="${record.class.declaredFields.name.contains('totalSteps')}">
            <g:formRemote name="saveTotalSteps" url="[controller: 'operation', action: 'updateTotalSteps', id: record.id]"
                          update="displayTotalSteps"
                          style="display: inline;">
                %{--<g:hiddenField name="id" value="${record.id}"/>--}%
                <g:hiddenField name="entityCode" value="${entityCode}"/>
                <b>Total steps</b>:
                %{--placeholder="عدد الخطوات"--}%
                <g:textField id="saveTotalSteps${entityCode}${record.id}" name="text" class="ui-corner-all" cols="80"
                             rows="5"
                             style="width:20%;  display: inline; " value="${record.totalSteps}"/>
                <g:submitButton name="add" value="=" style="display:none;"
                                class="fg-button ui-widget ui-state-default ui-corner-all navHidden"/>
                %{--<br/>--}%
            </g:formRemote>
        &nbsp;    <span id="displayTotalSteps"></span>

        </g:if>
        </g:if>


    %{--<g:if test="${record.class.declaredFields.name.contains('percentCompleted')}">--}%
    %{--<a name="bookmark${record.id}${entityCode}" title="percent++"--}%
    %{--value="${record.percentCompleted}"--}%
    %{--onclick="jQuery('#displayTotalSteps').load('${request.contextPath}/generics/increasePercentCompleted/${entityCode}${record.id}')">--}%
    %{--Step++--}%
    %{--</a>--}%
        %{--<br/>--}%
    %{--</g:if>--}%



        <g:if test="${record.class.declaredFields.name.contains('reviewHistory') && record.reviewHistory}">
            <b>Review history:</b> ${record.reviewHistory}
            <br/>
        </g:if>
  <g:if test="${record.class.declaredFields.name.contains('stepsHistory') && record.stepsHistory}">
            <b>Steps history:</b>
      <br/>${record.stepsHistory?.replace('-', '<br/>')}
            <br/>
        </g:if>



        <pkm:listPictures fileClass="snsFile"
                  folder="${OperationController.getPath('root.rps1.path')}/${record.entityCode()}/${record.id}"
                  initial=""/>

<pkm:listPictures fileClass="snsFile"
                  folder="${OperationController.getPath('root.rps2.path')}/${record.entityCode()}/${record.id}"
                  initial=""/>

<pkm:listPictures fileClass="snsFile"
                  folder="${OperationController.getPath('root.rps1.path')}/${record.entityCode()}"
                  initial="${record.id}"/>

<pkm:listPictures fileClass="snsFile"
                  folder="${OperationController.getPath('root.rps2.path')}/${record.entityCode()}"
                  initial="${record.id}"/>

<g:if test="${record.entityCode() == 'R'}">

    <g:if test="${(new File(OperationController.getPath('root.rps1.path') + '/cvr/' +
            record?.type?.code + '/' + record.id + '.jpg')?.exists() || new File(OperationController.getPath('root.rps2.path') + '/cvr/' + record?.type?.code + '/' + record.id + '.jpg')?.exists())}">

        <a href="${createLink(controller: 'book', action: 'viewImage', id: record.id)}"
           target="_blank">
            <img class="Photo" style="width: 80px; height:120px; display:inline"
                 src="${createLink(controller: 'book', action: 'viewImage', id: record.id, params: [date: new Date()])}"/>
        </a>
    </g:if>

</g:if>





<g:if test="${record.class.declaredFields.name.contains('shortDescription')}">
    <div class="${record.class.declaredFields.name.contains('language') ? 'text' + record.language : ''}"
         style="background: #dce5e5; border: 1px solid darkgray; ${ker.OperationController.getPath('description.style')};  text-align: justify !important;">
<span style=" ;  font-style: normal; color: darkred">
 ${record?.shortDescription?.replaceAll('\n', '<br/>')}
</span>
    </div>
</g:if>



%{--direction: ${record?.source?.language == 'ar' ? 'rtl' : 'ltr'}--}%
%{--todo--}%







%{--direction: ${record?.source?.language == 'ar' ? 'rtl' : 'ltr'}; text-align: ${record?.source?.language == 'ar' ? 'right' : 'left'}--}%
%{--todo--}%

%{--</div>--}%





%{--<g:each in="${app.IndexCard.findAllByEntityCodeAndRecordId(entityCode, record.id)}" var="c">--}%
%{--<g:render template="/gTemplates/box" model="[record: c]"/>--}%
%{--</g:each>--}%

%{--<g:if test="${'R'.contains(record.entityCode())}">--}%
%{--<g:each in="${app.IndexCard.findAllByBook(record)}" var="c">--}%
%{--<g:render template="/gTemplates/box" model="[record: c]"/>--}%
%{--</g:each>--}%
%{--</g:if>--}%
%{--<g:if test="${'W'.contains(record.entityCode())}">--}%
%{--<g:each in="${app.IndexCard.findAllByWriting(record)}" var="c">--}%
%{--<g:render template="/gTemplates/box" model="[record: c]"/>--}%
%{--</g:each>--}%
%{--</g:if>--}%





<g:if test="${record.entityCode() == 'todoR'}">
    <div id="type-4" style="">

        <g:if test="${'R'.contains(record.entityCode())}">
        %{--<h4>Notes</h4>--}%

            <h4>Excerpts</h4>
            <g:each in="${Excerpt.findAllByBook(record)}" var="r">

                <g:render template="/gTemplates/recordSummary" model="[record: r, expandedView: false]"/>
            </g:each>
        %{--<g:each in="${Planner.findAllByBook(record)}" var="r">--}%
        %{----}%
        %{--<g:render template="/gTemplates/recordSummary" model="[record: r]"/>--}%
        %{--</g:each>--}%

        </g:if>

    </div>
</g:if>


<g:if test="${record.class.declaredFields.name.contains('description')}">
    <div class="${record.class.declaredFields.name.contains('language') ? 'text' + record.language : ''}"
         style="background: #eef7e5;  ${ker.OperationController.getPath('description.style')};  text-align: justify !important;">

        %{--ToDo didn't work--}%
        <div id="descriptionBloc${record.id}">
            ${raw(record.description?.replaceAll('\n', '<br/>')?.replace('Product Description', ''))}
            %{--${?.encodeAsHTML()?.replaceAll('\n', '<br/>')}--}%
        </div>

        %{--${WikiParser.renderXHTML(record.description)?.replaceAll('\n', '<br/>')?.decodeHTML()}--}%

    </div>
</g:if>


%{--<table style="border: 0px solid; vertical-align: top; border-collapse: collapse; width: 99%" border="0">--}%
    %{--<tr>--}%
        %{--<td style="vertical-align: top; width: 99%">--}%

            %{--<g:if test="${'B'.contains(record.entityCode())}">--}%
            %{--<b>Description</b>--}%
            %{--<br/>--}%
            %{----}%

            <div style="padding: 1px; font-size: 13px; text-align: justify !important; margin: 1px; line-height: 20px; ; white-space: wrap;">

                <g:if test="${record.class.declaredFields.name.contains('notes') && record.notes}">
                    %{--<br/>--}%
                %{--Notes:--}%
                    <div class="${record.class.declaredFields.name.contains('language') ? 'text' + record.language : ''}"
					style="${ker.OperationController.getPath('description.style')}; text-align: justify !important; line-height: 170%>
                        <div style="color: #003366 !important">${raw(record.notes?.replace(' وَ ', ' وَ')?.replaceAll(/\nوَ /, ' وَ')
                        .replaceAll(/\nوَ /, ' وَ')
                        .replaceAll(/^و /, ' و').replaceAll(/\nو / , '\nو' )
                        .replace(/^وَ /, '\n وَ').replace(' و ', ' و').replace('ی', 'ي').replace('ک', 'ك').replaceAll('\n', '<br/>'))}</div>
                    </div>
                    %{--<br/>--}%
                    <br/>
                </g:if>

            %{--</g:if>--}%
            %{--<br/>--}%

                <g:if test="${'R'.contains(record.entityCode())}">
                    <div style="font-family: tahoma; text-align: justify; line-height: 20px; font-size: 14px; margin: 5px;">
                        <g:if test="${record.highlights}">
                            <div class="text${record.class.declaredFields.name.contains('language') ? record.language : ''}">


                                <i style="color: #48802C">
                                    ${record.highlights?.replaceAll('\n', '<br/>')}
                                </i>
                                <br/>
                            </div>
                        </g:if>
                        <g:if test="${record.comments}">
                            <br/>
                            <i style="color: #1d806f">${record.comments?.replaceAll('\n', '<br/>')}</i>
                        %{--<br/><hr/><br/>--}%
                            <br/><hr/><br/>
                        </g:if>
                        <g:if test="${record.fullText}">
                            <div class="${record.language == 'ar' ? 'arabicText' : ''}"
                                 style="${ker.OperationController.getPath('description.style')}; text-align: justify !important; line-height: 170%">
                                <br/><hr/>  ${raw(record.fullText?.replaceAll('\n', '<br/>'))}
                            </div>
                        </g:if>
                    </div>
                </g:if>
            </div>

        %{--</td>--}%
%{----}%
    %{--</tr>--}%
%{--</table>--}%
%{----}%
%{----}%
<div id="type-7" style="">

</div>




<br/>




<g:if test="${record.entityCode() == 'D'}">
    <div id="OrderTheFields" style="-moz-columns-count:1">
        <h4>Order the courses</h4>
        <table id="table1">
        %{--<ul id="item_list" >--}%
            <g:each in="${mcs.Course.findAllByDepartment(mcs.Department.get(record.id), [sort: 'orderNumber', order: 'asc'])}"
                    var="c">
                <tr id="${c.id}">
                    <td>
                        #${c.orderNumber} C-${c.id} - ${c.summary}
                    </td></tr>
            </g:each>
        </table>
        <a style="font-size: 10px; text-align: right;" href="#"
           onclick='jQuery("#OrderTheFields").load("${request.contextPath}/operation/orderRecords?type=D&child=C&tableId=1", jQuery("#table1").tableDnDSerialize())'>
            Sort</a>

        <hr/>
    </div>

    <script type="text/javascript">
        jQuery("#table1").tableDnD();
    </script>
</g:if>

<g:if test="${record.entityCode() == 'C'}">

<ol style="dir: rtl; text-align: right;">
     <g:each in="${mcs.Writing.findAllByCourseAndPriorityGreaterThan(record, 2, [sort: 'orderNumber', order: 'asc'])}"
                    var="c">
                <li style="font-weight: normal;">
                   
                       W-${c.id} - <b>${c.summary}
                %{--r${c.reviewCount}--}%
                </li>
<ol style="dir: rtl; text-align: right;">
                            <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.entityCode = ? and i.priority >= 2 order by i.orderNumber asc',
                    [c.id.toString(), 'W'])}"
                    var="n">
                                <li style="font-weight: normal;">
                   N-${n.id} - ${n.summary}
                        %{--<pkm:summarize text="${c.description}"  length="80"/>--}%
                  </li>
            </g:each>
            
            </ol>
            
            
            </g:each>



    <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.course = ? and i.priority > ? order by orderNumber asc' ,[null, record, 2])}"
            var="n">

        <li>
           N-${n.id} - ${n.summary}
           %{--r${n.reviewCount}--}%
            %{--<pkm:summarize text="${c.description}"  length="80"/>--}%
        </li>
    </g:each>



    </ol>        
            
            



    <div id="OrderTheFields" style="-moz-columns-count:1">
        <h4>Order the goals</h4>
        <table id="table1">
        %{--<ul id="item_list" >--}%
            <g:each in="${mcs.Goal.findAllByCourse(Course.get(record.id), [sort: 'orderNumber', order: 'asc'])}"
                    var="c">
                <tr id="${c.id}">
                    <td>
                        #${c.orderNumber} G-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"
                                                                                  length="80"/>
                    </td></tr>
            </g:each>
        </table>
        <br/>
        <a style="font-size: 10px; text-align: right;" href="#"
           onclick='jQuery("#OrderTheFields").load("${request.contextPath}/operation/orderRecords?type=C&child=G&tableId=1", jQuery("#table1").tableDnDSerialize())'>
            Sort</a>

        <hr/>

        <table id="table2">
            %{--<ul id="item_list" >--}%
            <h4>Order the writings</h4>
            <g:each in="${mcs.Writing.findAllByCourseAndPriorityGreaterThan(Course.get(record.id), 2, [sort: 'orderNumber', order: 'asc'])}"
                    var="c">
                <tr id="${c.id}">
                    <td>
                        #${c.orderNumber} W-${c.id} - <b>${c.summary}</b>

                        %{--<pkm:summarize--}%
                        %{--text="${c.description}"--}%
                        %{--length="80"/>--}%
                    </td>
                </tr>
            </g:each>
        </table>
        <br/>
        <a style="font-size: 10px; text-align: right;" href="#"
           onclick='jQuery("#OrderTheFields").load("operation/orderRecords?type=C&child=W&tableId=2", jQuery("#table2").tableDnDSerialize())'>
            Sort</a>

        <hr/>

        <table id="table3">
            <h4>Order the resources</h4>
            <g:each in="${mcs.Book.findAllByCourse(Course.get(record.id), [sort: 'orderNumber', order: 'asc'])}"
                    var="c">
                <tr id="${c.id}">
                    <td>
                        #${c.orderInCourse} B-${c.id} - ${c.title} ${c.legacyTitle}<pkm:summarize
                                text="${c.description}" length="80"/>
                    </td></tr>
            </g:each>
        </table>
        <br/>
        <a style="font-size: 10px; text-align: right;" href="#"
           onclick='jQuery("#OrderTheFields").load("operation/orderRecords?type=C&child=R&tableId=3", jQuery("#table3").tableDnDSerialize())'>
            Sort</a>



        <table id="table4">
            %{--<ul id="item_list" >--}%
            <h4>Order the excerpts</h4>
            <g:each in="${mcs.Excerpt.executeQuery('from Excerpt r where r.book.course = ? order by orderNumber asc', [Course.get(record.id)])}"
                    var="c">
                <tr id="${c.id}">
                    <td>
                        #${c.orderNumber} R-${c.id} - <b>${c.book?.title} ${c.book?.legacyTitle}</b>:${c.chapters} ${c.summary}
                    </td></tr>
            </g:each>
        </table>
        <br/>
        <a style="font-size: 10px; text-align: right;" href="#"
           onclick='jQuery("#OrderTheFields").load("operation/orderRecords?type=C&child=E&tableId=4", jQuery("#table4").tableDnDSerialize())'>
            Sort</a>

        <table id="table5">
            %{--<ul id="item_list" >--}%
            <h4>Order the tasks</h4>
            <g:each in="${mcs.Excerpt.executeQuery('from Task r where r.course = ? and r.bookmarked = ? order by orderNumber asc', [Course.get(record.id), true])}"
                    var="c">
                <tr id="${c.id}">
                    <td>
                        #${c.orderNumber} T-${c.id} - <b>${c?.summary}
                    </td></tr>
            </g:each>
        </table>
        <input type="button" id="sortButton5" value="Save sort"
               onclick='jQuery("#OrderTheFields").load("operation/orderRecords?type=C&child=T&tableId=5", jQuery("#table5").tableDnDSerialize())'/>






        <script type="text/javascript">
            jQuery("#table1").tableDnD();
            jQuery("#table2").tableDnD();
            jQuery("#table3").tableDnD();
            jQuery("#table4").tableDnD();
            jQuery("#table5").tableDnD();
        </script>
    </div>
</g:if>

<g:if test="${record.entityCode() == 'W'}">
    <h4>Order the notes</h4>

    <div id="OrderTheFields" style="direction: rtl; text-align: right !important;">

        <table id="table1">
        %{--<ul id="item_list" >--}%
            %{--<g:each in="${app.IndexCard.findAllByWriting(Writing.get(record.id), [sort: 'orderNumber', order: 'asc'])}"--}%
                    %{--var="c">--}%
                %{--<tr id="${c.id}">--}%
                    %{--<td>--}%
                        %{--#${c.orderNumber} C-${c.id} - ${c.summary} <pkm:summarize text="${c.description}"--}%
                                                                                     %{--length="80"/>--}%
                    %{--</td></tr>--}%
            %{--</g:each>--}%
            <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.entityCode = ? and i.priority >= 2 order by i.orderNumber asc',
                    [record.id.toString(), 'W'])}"
                    var="c">
                <tr id="${c.id}">
                    <td  style="direction: rtl; text-align: right !important; margin: 5px;">
                        #${c.orderNumber} p${c.priority} W-${c.id} - ${c.summary}
                        %{--<pkm:summarize text="${c.description}"  length="80"/>--}%
                    </td>
                </tr>
            </g:each>
        </table>
        <br/>
        <a style="font-size: 10px; text-align: right;" href="#"
           onclick='jQuery("#OrderTheFields").load("operation/orderRecords?type=W&child=N&tableId=1", jQuery("#table1").tableDnDSerialize())'>
            Sort</a>

        <script type="text/javascript">
            jQuery("#table1").tableDnD();
        </script>
    </div>

</g:if>





&nbsp;
<br/>
<br/>







        <div class="actionsButtons">


        <g:link controller="page" action="record" target="_blank"
                params="${[id: record.id, entityCode: record.entityCode()]}"
                class="fg-button ui-widget ui-state-default ui-corner-all"
                title="Go to page">
            Ext.

        </g:link>

            <g:if test="${'R'.contains(entityCode)}">
                <g:remoteLink controller="operation" action="generateBibEntry" id="${record.id}"
                              update="bibTexBloc${record.id}"
                              class="actionLink"
                              title="${record.bibEntry?.replace('"', '\'')}">
                    Generate bib entry
                </g:remoteLink>

                <span id="bibTexBloc${record.id}">




                </span>





            </g:if>

            <g:if test="${'T'.contains(entityCode)}">

                <g:remoteLink controller="task" action="markRecurring"
                              id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="${entityCode}Record${record.id}"
                              title="Mark recurring">
                    <b>rcr.</b>
                    <g:if test="${record.isRecurring}">
                        rci:${record.recurringInterval}
                    </g:if>
                </g:remoteLink>
            </g:if>

<g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <g:if test="${'RN'.contains(entityCode)}">
                <g:remoteLink controller="generics" action="fixedFarsiArabic" id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="descriptionBloc${record?.id}"
                              title="descriptionBlocrecord"
                              style="">
                    Fix text
                </g:remoteLink>
            </g:if>
            </g:if>


            <g:if test="${entityCode.size() == 1}">
            %{--|| (record.class.declaredFields.name.contains('deletedOn') && record.deletedOn != null)--}%
                <g:remoteLink controller="generics" action="physicalDelete"
                              params="${[id: record.id, entityCode: entityCode]}"
                              update="${entityCode}Record${record.id}"
                              before="if(!confirm('Are you sure you want to permanantly physically delete the record?')) return false"
                              class="fg-button ui-widget ui-state-default ui-corner-all"
                              title="Delete record permanantly">
                    Delete
                </g:remoteLink>
            </g:if>


        %{--<g:if test="${entityCode.size() > 1}">--}%
        %{--<g:remoteLink controller="generics" action="physicalDelete"--}%
        %{--params="${[id: record.id, entityCode: entityCode]}"--}%
        %{--update="${entityCode}Record${record.id}"--}%
        %{--title="Delete record permanantly">--}%
        %{--Delete--}%
        %{--</g:remoteLink>--}%
        %{--</g:if>--}%
            <g:if test="${entityCode == 'C'}">

            %{--<g:link url="[controller: 'export', action: 'generateCourseWritingsAsHtml', id: record.id]"--}%

            %{--target="_blank"--}%
            %{--title="Convert to HTML">--}%
            %{--===--}%
            %{--</g:link>--}%
            %{--<br/>--}%
                <g:remoteLink controller="export" action="combineCourseWritings"
                              id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="${entityCode}CheckoutLog${record.id}"
                              class="fg-button ui-widget ui-state-default ui-corner-all"
                              title="Compline course with its writings and their notes">
                    md &crarr;
                </g:remoteLink>
                &nbsp;&nbsp;
                <g:remoteLink controller="export" action="combineCourseWritingsAsTex"
                              id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="${entityCode}CheckoutLog${record.id}"
                              class="fg-button ui-widget ui-state-default ui-corner-all"
                              title="Comdine course with its writings and their notes">
                    tex &crarr;
                </g:remoteLink>


            %{----}%
            %{--<br/>--}%
            %{--<br/>--}%
            %{--<g:link url="[controller: 'export', action: 'generateCoursePresentation', id: record.id]"--}%
            %{--class="actionLink"--}%
            %{--target="_blank"--}%
            %{--title="Convert to HTML">--}%
            %{--Generate presentation (new tab)--}%
            %{--</g:link>--}%

            </g:if>




            <g:if test="${OperationController.getPath('1=2pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">
                <g:if test="${record.class.declaredFields.name.contains('keepSecret')}">
<br/>
<br/>
                    <a name="bookmark${record.id}${entityCode}" title="Toggle privacy"
                       value="${record.keepSecret}"
                       onclick="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/togglePrivacy/${entityCode}-${record.id}')">
                        Make private &nbsp;
                    </a>
                </g:if>
            </g:if>




        %{--<g:if test="${'RWNTGJPCD'.contains(entityCode)}">--}%
%{--            <g:if test="${record.class.declaredFields.name.contains('language')}">--}%
%{--            <br/>--}%
%{--            <br/>--}%
%{--                Language:--}%
%{--                <g:select name="language" from="${OperationController.getPath('repository.languages').split(',')}"--}%
%{--                    value="${record.language}"--}%
%{--     onchange="jQuery('#${entityCode}Record${record.id}').load('${request.contextPath}/generics/setLanguage/' + '${record.id}-${entityCode}-' + this.value)"--}%
%{--  style="overflow: visible; z-index: 200; background: lightgrey" noSelection="${['': '']}"/>--}%






                %{--<g:remoteLink controller="generics" action="setArabic"--}%
                          %{--id="${record.id}"--}%
                          %{--params="[entityCode: entityCode]"--}%
                          %{--update="${entityCode}Record${record.id}"--}%
                          %{--style="background: lightgrey"--}%
                          %{--title="Mark arabic">--}%
                %{--Ar--}%
            %{--</g:remoteLink>--}%

            %{--<g:if test="${OperationController.getPath('pkm-actions.enabled')?.toLowerCase() == 'yes' ? true : false}">--}%
            %{--<g:remoteLink controller="generics" action="setPersian"--}%
                          %{--id="${record.id}"--}%
                          %{--params="[entityCode: entityCode]"--}%
                          %{--update="${entityCode}Record${record.id}"--}%
                          %{--title="Mark as Farsi">--}%
                %{--Fa--}%
            %{--</g:remoteLink>--}%
               %{--</g:if>--}%

            %{--<g:remoteLink controller="generics" action="setFrench"--}%
                          %{--id="${record.id}"--}%
                          %{--params="[entityCode: entityCode]"--}%
                          %{--update="${entityCode}Record${record.id}"--}%
                          %{--title="Mark as French">--}%
                %{--Fr--}%
            %{--</g:remoteLink>--}%
            %{--<g:remoteLink controller="generics" action="setEnglish"--}%
                          %{--id="${record.id}"--}%
                          %{--params="[entityCode: entityCode]"--}%
                          %{--update="${entityCode}Record${record.id}"--}%
                          %{--title="Mark as English">--}%
                %{--En--}%
            %{--</g:remoteLink>--}%
%{--        </g:if>--}%
%{----}%
%{--        <br/>--}%
        <br/>


    %{--todo; case of x ,y--}%




        <g:if test="${'R'.contains(entityCode)}">
            <div dir="ltr">


            <br/>
            Add excerpt:
            <g:formRemote name="appendText" url="[controller: 'book', action: 'addExcerpt']"
                          update="${entityCode}Record${record.id}"
                          style="display: inline;">
                <g:hiddenField name="id" value="${record.id}"/>
                <g:hiddenField name="entityCode" value="${entityCode}"/>
                <g:textField id="appendTextFor${entityCode}${record.id}" name="text" class="ui-corner-all" cols="80"
                             placeholder="title"
                             rows="5"
                             style="width:60%;  display: inline; " value=""/>
                <g:submitButton name="add" value="+=" style="display:none;"
                                class="fg-button ui-widget ui-state-default ui-corner-all navHidden"/>
                <br/>
            </g:formRemote>
            </div>
        </g:if>

<g:if test="${entityCode == 'N'}">
    &nbsp; &nbsp;Convert to &nbsp;
    <g:each in="${['J', 'P', 'T', 'R', 'W']}" var="t">

        <g:remoteLink controller="generics" action="convertNoteToRecord"
                      params="${[id: record.id, entityCode: entityCode, type: t]}"
                      update="${entityCode}Record${record.id}"
                      class="fg-button ui-widget ui-state-default ui-corner-all"
                      title="Convert note to ${t}">
            &nbsp;${t} &nbsp;
        </g:remoteLink>
    </g:each>
</g:if>


<g:if test="${cmn.Setting.findByName('aws.secret.key') && entityCode == 'R' && record.isbn}">
    <g:remoteLink controller="book" action="updateBookInfo" id="${record.id}"
                  update="RRecord${record.id}"
                  class="actionLink"
                  class="fg-button ui-widget ui-state-default ui-corner-all"
                  title="Update metadata from Amazon">
        Update metadata
    </g:remoteLink>
    <br/>
    <br/>
</g:if>

        <g:if test="${record.class.declaredFields.name.contains('blog')}">
                                                                     <br/>
                                                                     <br/>
            &nbsp;

            <g:set value="blog" var="field"></g:set>
            Blog:
            <a href="#" id="${field}${record.id}" class="${field}"
               data-type="select"
               data-value="${record[field]?.id}"
               data-name="${field}-${entityCode}"
               style=" border-radius: 3px; font-size: 10px; font-style: italic; padding-left: 1px; padding-right: 1px;"
               data-source="${request.contextPath}/operation/getQuickEditValues?entity=${entityCode}&field=${field}&date=${new Date().format('hhmmssDDMMyyyy')}"
               data-pk="${record.id}" data-url="${request.contextPath}/operation/quickSave2"
               data-title="Edit ${field}">
                ${record[field] ? (record[field].code ? 'blog-' + record[field].code : 'blog' + record.blog) : 'blog-'}
            </a>
            <script type="text/javascript">
                jQuery("#${field}${record.id}").editable();
            </script>


            <span id="${entityCode}CheckoutLog${record.id}"></span>



            <g:if test="${(entityCode == 'W') || entityCode == 'N'}">
            %{--|| entityCode == 'N'--}%
            %{--<g:remoteLink--}%
            %{--url="[controller: 'generics', action: 'convertMarkupToHtml', id: record.id, params: [entityCode: entityCode]]"--}%
            %{--update="3rdPanel"--}%
            %{--before="jQuery('#accordionEast').accordion({ active: 0});"--}%
            %{--class="actionLink"--}%
            %{--title="Convert to HTML">--}%
            %{--==--}%
            %{--</g:remoteLink>--}%

                <g:remoteLink controller="generics" action="checkoutRecordText"
                              id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="${entityCode}CheckoutLog${record.id}"
                              title="Checkout record">
                    out &crarr;
                </g:remoteLink>

            </g:if>
            <g:if test="${entityCode == 'W'}">

                <g:remoteLink controller="export" action="combineWritingNotes"
                              id="${record.id}"
                              params="[entityCode: entityCode]"
                              update="${entityCode}CheckoutLog${record.id}"
                              title="Compile writing with its notes">
                    cmp &crarr;
                </g:remoteLink>

            </g:if>


            &nbsp;
            <g:remoteLink controller="operation" action="pandoc" id="${record.id}"
                          params="[entityCode: entityCode]"
                          update="postResult${record?.id}"
                          title="Publish record"
                          class="fg-button ui-widget ui-state-default ui-corner-all">
                pandoc
            </g:remoteLink>
                            &nbsp;

                <g:if test="${record.blog?.code && record.descriptionHTML}">
                    <g:remoteLink controller="generics" action="publish" id="${record.id}"
                                  params="[entityCode: entityCode]"
                                  update="postResult${record?.id}"
                                  title="Publish record"
                                  class="fg-button ui-widget ui-state-default ui-corner-all">
                        Publish on <b>${record.blog?.code}</b>
                    </g:remoteLink>
                </g:if>
            <div id="postResult${record.id}" style="display: inline">
            </div>
            <g:if test="${record.publishedNodeId}">
                Published with ID: (${record.publishedNodeId})
            </g:if>
        %{--<g:if test="${entityCode == 'W' && !record.code}">--}%
        %{--<b style="color: red">No code</b>--}%
        %{--</g:if>--}%
        </g:if>


        <br/>
        </div>
<div >
    <br/>
    <br/>

    <g:if test="${'R'.contains(entityCode)}">
        <div class="${record.class.declaredFields.name.contains('language') ? 'text' + record.language : ''}" style="font-size: 11px; background: lightgrey; padding: 3px;">
            <g:set value="${record.language == 'en' ? ',' : '،'}" var="comma"></g:set>
            <g:if test="${record.type?.code == 'ebk'}">
                ${record.author}${comma}
                ${record.title}${record.translator ? ' - ' + record.translator : ''}${record.editor ? ' - ' + record.editor: ''}${record.edition ? comma + ' ' + record.edition + ' ': ''}
                (${record.publicationCity ? record.publicationCity + ': ' : '' }${record.publisher}${comma}${record.year ?: record.publicationDate}).
            </g:if>
            <g:if test="${record.type?.code == 'art'}">
                ${record.author}${comma}
                "${record.title}" ${record.translator ? ' - ' + record.translator : ''}${record.editor ? ' - ' + record.editor: ''} ${record.journal}. ${record.volume} ${record.number} ${record.pages}
                (${record.publicationCity ? record.publicationCity + ': ' : '' }${record.publisher}${comma}${record.year ?: record.publicationDate}).
                ${record.url}${record.sourceFree}

            </g:if>
        </div>

    %{--<br/>--}%
    </g:if>

    <br/>
    <br/>
<g:if test="${record.class.declaredFields.name.contains('completedOn') && record.completedOn}">

    <b>Completed on</b> ${record.completedOn?.format(OperationController.getPath('date.format') ? OperationController.getPath('date.format') + ' HH:mm' : 'dd.MM.yyyy HH:mm')}
    %{--(<prettytime:display--}%
        %{--date="${record.completedOn}"/>)--}%

    <g:remoteLink controller="generics" action="resetCompletedOnStatus"
                  params="${[id: record.id, entityCode: entityCode]}"
                  update="resetCompletedOn"
                  title="Reset completion status">
x
    </g:remoteLink>
    <span id="resetCompletedOn"></span>


    <br/>
    <br/>
    </g:if>
   <g:if test="${record.class.declaredFields.name.contains('readOn') && record.readOn}">

    <b>Read on</b> ${record.readOn?.format(OperationController.getPath('date.format') ? OperationController.getPath('date.format') + ' HH:mm' : 'dd.MM.yyyy HH:mm')}
       %{--(<prettytime:display--}%
        %{--date="${record.readOn}"/>)--}%

       <g:remoteLink controller="generics" action="resetReadOnStatus"
                     params="${[id: record.id, entityCode: entityCode]}"
                     update="resetReadOn"
                     title="Reset reading status">
           x
       </g:remoteLink>
       <span id="resetReadOn"></span>

       <br/>
       <br/>

    </g:if>


    <b>Updated</b> ${record.lastUpdated?.format(OperationController.getPath('date.format') ? OperationController.getPath('date.format') + ' HH:mm' : 'dd.MM.yyyy HH:mm')}
%{--(<prettytime:display--}%
        %{--date="${record.lastUpdated}"/>)--}%
    <br/>
    %{--(<prettytime:display--}%
    %{--date="${record.dateCreated}"/>)--}%
    %{--by ${record.insertedBy}--}%
    %{--editedBy ${record.editedBy}--}%
    <b>Created</b> ${record.dateCreated?.format(OperationController.getPath('date.format') ? OperationController.getPath('date.format') + ' HH:mm' : 'dd.MM.yyyy HH:mm')}
%{--(${new PrettyTime()?.format(record.dateCreated)})--}%
    <br/>
    <b>Version</b> <span style="font-weight: normal">${record.version}</span>
</div>



%{--Working--}%
%{----}%


        <br/>
        <br/>



<div id="notificationArea"></div>

<r:layoutResources/>

<script type="text/javascript">
//jQuery('.uploadr[name=uploader]').data('uploadr').set('path', 'd:/test');
jQuery('#spinner2').hide();
</script>
