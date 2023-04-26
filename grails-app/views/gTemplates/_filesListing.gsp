<%@ page import="ker.OperationController" %>

%{--<div class="filesRegion">--}%
%{--<g:if test="${record.entityCode() != 'R'}">--}%

    <pkm:listRecordFiles module="${entityCode}" fileClass="himFile"  recordId="${record.id}" isStatic="${isStatic}" type="${entityCode == 'R' ? record.type?.code : ''}"/>
    %{--</g:if>--}%
%{--<g:else>--}%
    %{--<pkm:listRecordFiles module="${entityCode}" resource="yes" fileClass="himFile"  recordId="${record.id}"/>--}%
%{--</g:else>--}%

        %{--<pkm:listAudios fileClass="vxrFile"--}%
                        %{--folder="${OperationController.getPath('module.sandbox.N.path')}"--}%
                        %{--initial="${record.id}n.mp3"/>--}%
    %{--</g:if>--}%
%{--<g:if test="${record.entityCode() == 'E'}">--}%
    %{--<pkm:listRecordFiles module="${entityCode}" fileClass="himFile" recordId="${record.id}"/>--}%
%{----}%
    %{--</g:if>--}%
    %{--<g:if test="${record.entityCode() == 'R'}">--}%
        %{--<pkm:listRecordFiles module="${entityCode}" fileClass="himFile" nested="yes" recordId="${record.id}" suffix="b"/>--}%
        %{--<pkm:listFiles fileClass="himFile"--}%
                       %{--folder="${record?.type?.repositoryPath}/${(record.id / 100).toInteger()}"--}%
                       %{--initial="${record.id}[a-z]"/>--}%
    %{--${record.resourceType == 'ebk' ? 'b' : (record.resourceType == 'art' ? 'a' : 'n')}--}%

        %{--<pkm:listFiles fileClass="himFile"--}%
                       %{--folder="${record?.type?.repositoryPath}/${(record.id / 100).toInteger()}/${record.id}"--}%
                       %{--initial=""/>--}%

        %{--<pkm:listFiles fileClass="vxrFile"--}%
                       %{--folder="${OperationController.getPath('video.excerpts.repository.path')}/${record.resourceType}/${record.id}"--}%
                       %{--initial=""/>--}%
    %{--<pkm:listFiles fileClass="libFile"--}%
    %{--folder="/todo/lib/${record?.type?.code}/${(record.id / 100).toInteger()}"--}%
    %{--initial="${record.id}[a-z]"/>--}%
    %{--<pkm:listFiles fileClass="libFile"--}%
    %{--folder="/todo/lib/${record?.type?.code}/${(record.id / 100).toInteger()}"--}%
    %{--initial="${record.id}[a-z]"/>--}%
        %{--<pkm:listFiles fileClass="libFile"--}%
                       %{--folder="${record?.type?.repositoryPath}/${(record.id / 100).toInteger()}/${record.id}"--}%
                       %{--initial=""/>--}%
        %{--<pkm:listFiles fileClass="himFile"--}%
                       %{--folder="${record?.type?.repositoryPath}/${record.resourceType}-${record.id}"--}%
                       %{--initial=""/>--}%
        %{--<pkm:listFiles fileClass="libFile"--}%
                       %{--folder="${record?.type?.repositoryPath}/${record.resourceType}-${record.id}"--}%
                       %{--initial=""/>--}%
        %{--<pkm:listFiles fileClass="newFile"--}%
                       %{--folder="${record?.type?.newFilesPath}/${(record.id / 100).toInteger()}"--}%
                       %{--initial="${record.id}[a-z]"/>--}%
        %{--<pkm:listFiles fileClass="newFile"--}%
                       %{--folder="${record?.type?.newFilesPath}/${(record.id / 100).toInteger()}/${record.id}"--}%
                       %{--initial=""/>--}%
        %{--<pkm:listVideos fileClass="vxrFile"--}%
                        %{--folder="${OperationController.getPath('vxr.path')}/${record.type?.code}/${record.id}"--}%
                        %{--initial=""/>--}%

        %{--<pkm:listAudios fileClass="vxrFile"--}%
                        %{--folder="${OperationController.getPath('audio.excerpts.repository.path')}/${record.type?.code}/${record.id}"--}%
                        %{--initial=""/>--}%
   %{--<g:if test="${record.withAudiobook}">--}%
            %{--<pkm:listFiles fileClass="vxrFile"--}%
                           %{--folder="${OperationController.getPath('audiobooks.repository.path')}/${record.id}"--}%
                           %{--initial=""/>--}%

            %{--<pkm:listFiles fileClass="abkFile"--}%
                           %{--folder="${OperationController.getPath('audio.excerpts.repository.path')}/${record.type?.code}/${record.id}"--}%
                           %{--initial=""/>--}%
        %{--</g:if>--}%
    %{--<br/>--}%
    %{--<pkm:listFiles--}%
    %{--folder="/new/${record.resourceType}/${new DecimalFormat('00000').format(record.id).substring(0, 2)}"--}%
    %{--initial="${new DecimalFormat('0000').format(record.id)}${record.resourceType == 'ebk' ? 'b' : 'a'}"></pkm:listFiles>--}%
    %{--</g:if>--}%
    %{--<pkm:listPictures fileClass="snsFile"--}%
                      %{--folder="${OperationController.getPath('pictures.repository.path')}/${record.entityCode()}/${record.id}"--}%
                      %{--initial=""/>--}%
%{--</div>--}%