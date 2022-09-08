

<div class="uk-card uk-card-small uk-card-default uk-card-hover uk-margin uk-animation-slide-top-medium"
     style="margin: 4px 10px; width: 350px;" id="topDocumentCard${doc.id}">


    <div class="uk-card-header" >
        <div class="uk-grid uk-grid-small uk-text-large" data-uk-grid>
            <div class="uk-width-expand">
                <span class="cat-txt">

                    %{--<span class="icon" name="${app.frenchName}">--}%
                    %{--?--}%
                    %{--</span>--}%
                    ${doc.name}
                </span>
            </div>
            <div class="uk-width-auto uk-text-right">
                <span data-uk-icon="icon:cloud; ratio: 1.8"></span>
                %{--version ??--}%
            </div>
        </div>
    </div>



    %{--<div style="padding: 7px;">--}%
    %{--<div class="subtitle" style="color: darkolivegreen;">--}%
    %{--${app.englishName}--}%
    %{--</div>--}%
    %{--<div class="title" style="float: right; align: right; font-size: 1.2em;">--}%
    %{--<a style="text-transform: none;" href="${app.applicationUrl}" target="_blank">--}%
    %{--<span class="icon" name="${app.frenchName}">--}%
    %{--?--}%
    %{--</span>--}%

    %{--</a>--}%
    %{--</div>--}%
    %{--</div>--}%

    %{--<div class="card-content" style="padding: 7px; margin: 5px; font-size: 1em; text-align: right; direction: rtl; clear: both">--}%
    %{----}%
    %{--</div>--}%

    <div class="uk-card-body">
        %{--<h6 class="uk-margin-small-bottom uk-margin-remove-adjacent uk-text-bold">--}%
        %{--A BEAUTIFUL LANDSCAPE HERE--}%
        %{--</h6>--}%
        <div class="uk-text">
        <b>From:</b>    ${doc.submittedBy}
    <br/>
        <b>To:</b>    ${doc.recipients?.toString()}
    <br/>
        <b>On:</b>    ${doc.dateCreated?.format('dd.MM.yyyy HH:mm')}
        </div>
<br/>

     <div class="uk-text">

    <b>${app.Attachment.countByRecordIdAndRecordType(doc.id, 'uploadService')} files</b>

    <g:if test="${app.Attachment.countByRecordIdAndRecordType(doc.id, 'uploadService') > 0}">
        <br/>
            <g:each in="${app.Attachment.findAllByRecordIdAndRecordType(doc.id, 'uploadService')}" var="attachment">
<div id="fileDeleteArea${attachment.id}">
                <a href="${createLink(controller: 'attachment', action: 'downloadUploadedAttachment', id:  attachment.id)}"
                   target="_blank">
                    <i style="color: darkblue">
                        ${attachment.fileName}
                    </i>

                </a>
                <g:remoteLink controller= "attachment" action="deleteUploadedFile"
                              id="${attachment.id}" title="Delete file"
                              before="if(!confirm('Are you sure you want to delete the file: ${attachment.fileName}?')) return false"
                              update="fileDeleteArea${attachment.id}" on404="alert('not found');">
                    x
                </g:remoteLink>
</div>
                %{--<i style="color: darkblue">${file.name}</i>--}%

                <br/>
            </g:each>
    </g:if>
         %{--<g:else>--}%
             %{--<i>No files uploaded yet.</i>--}%
         %{--</g:else>--}%


        </div>




        <div id="attachmentCard${doc?.id}">

            <a onclick='jQuery("#attachmentCard${doc.id}").load("${request.contextPath}/document/getUploadFilesForm/${doc.id}")'>
                Upload files
            </a>

            %{--<g:remoteLink controller="document" action="getUploadFilesForm" id="${doc?.id}"--}%
                          %{--update="attachmentCard${doc?.id}"--}%
                          %{--class="fg-button fg-button-icon-right ui-widget ui-state-default ui-corner-all"--}%
                          %{--title="Upload files">--}%
                %{----}%
            %{--</g:remoteLink>--}%

        </div>


    </div>
</div>
