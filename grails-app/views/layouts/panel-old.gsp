

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



            <g:if test="${record.entityCode().length() == 120 && mobileView != 'true'}">
                <div style="display: inline; text-align: right;">
                    <table border=0 width="95%">
                        <tr>
                            <td width="50%" style="vertical-align: top;">
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



            <g:if test="${1 == 2 && OperationController.getPath('upload-cover.enabled')?.toLowerCase() == 'yes' ? true : false}">

                <br/>
                <br/>

                <b>Upload cover</b>:
                <uploadr:add id="uploadCover${record.id}"
                             name="uploaderCover${new Date()?.format('ddMMyyyyHHmmss')}"
                             controller="import" action="uploadCover2" path="${coverPath}"
                             noSound="true"
                             direction="down" maxVisible="5" unsupported="${request.contextPath}/upload/warning" maxConcurrentUploads="1">
                    <uploader:onSuccess>
                        jQuery('#subUploadInPanel').html('Cover uploaded.')//load('/pkm/generics/showSummary/' + responseJSON.id + '?entityCode=' +  responseJSON.entityCode)
                    </uploader:onSuccess>
                    Upload...
                </uploadr:add>
            </g:if>



        %{--&nbsp;/--}%
        %{--&nbsp;--}%
            <g:if test="${1 == 2}">
                <g:if test="${entityCode == 'R'}">
                    <br/>
                    <br/>
                    opf    ${OperationController.getPath('root.rps1.path')}R/${record.type?.code}/${(record.id / 100).toInteger()}/${record.id}
                    <br/>
                    opf    ${OperationController.getPath('root.rps2.path')}R/${record.type?.code}/${(record.id / 100).toInteger()}/${record.id}
                </g:if>
                <g:else>
                    <br/>
                    <br/>
                    opf    ${OperationController.getPath('root.rps1.path')}${entityCode}/${record.id}
                    <br/>
                    opf    ${OperationController.getPath('root.rps2.path')}${entityCode}/${record.id}
                </g:else>
            </g:if>

        </div>


    </li>

