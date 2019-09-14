<h3>Attach documents</h3>

<div class="nonPrintable">
    <uploader:uploader id="yourUploaderId${recordId}${fragment ?: ''}"
                       url="${[controller: 'attachment', action: 'upload']}"
                       params="${[recordId: recordId, entityCode: entityCode]}">
        <uploader:onComplete>
        %{--jQuery('#notificationArea').html(responseJSON[0]);--}%
            jQuery('#notificationArea').html('Ok');
        </uploader:onComplete>
        upload
    </uploader:uploader>
</div>