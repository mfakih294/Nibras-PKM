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

<%@ page import="app.parameters.ResourceType; cmn.Setting; mcs.parameters.PlannerType; mcs.parameters.JournalType; mcs.Planner; mcs.Journal; mcs.parameters.ResourceStatus; mcs.Book" %>

<r:require module="fileuploader"/>
<r:layoutResources/>

<h3>Add records through smart files</h3>
<uploader:uploader id="yourUploaderIdAdd"
                   url="${[controller: 'import', action: 'importSmartFilesAjax']}">
    Upload smart files for import
    <uploader:onComplete>
        jQuery('#centralArea').load('/nibras/generics/showSummary/' + responseJSON.id + '?entityCode=' +  responseJSON.entityCode)
    </uploader:onComplete>
</uploader:uploader>

%{--<h3>Update records through smart files</h3>--}%
%{--<uploader:uploader id="yourUploaderIdUpdate"--}%
                   %{--url="${[controller: 'import', action: 'importSmartFilesAjaxUpdate']}">--}%
    %{--Upload smart files for import--}%
    %{--<uploader:onComplete>--}%
        %{--jQuery('#centralArea').load('/nibras/generics/showSummary/' + responseJSON.id + '?entityCode=' +  responseJSON.entityCode)--}%
    %{--</uploader:onComplete>--}%
%{--</uploader:uploader>--}%




<r:layoutResources/>