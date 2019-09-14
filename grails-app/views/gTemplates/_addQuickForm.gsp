<%@ page import="app.parameters.Blog;mcs.Department; mcs.parameters.WorkStatus;" %>

%{--<g:if test="${record}">--}%
    %{--<g:render template="/gTemplates/recordSummary" model="[record: record]"/>--}%
%{--</g:if>--}%

<g:formRemote name="genericSearch" id="genericSearch22" url="[controller: 'generics', action: 'saveViaQuickForm']"
              update="${updateRegion}" method="post" style="display: inline;" onComplete="">

    <g:hiddenField name="entityController" value="${entityController}"/>
    <g:hiddenField name="updateRegion" value="${updateRegion}"/>

    <g:hiddenField name="id" value="${record?.id}"/>


    <table>





            <g:if test="${fields.contains('name')}">
                <tr>
                    <td>

                    <g:textField name="name" placeholder="Name" title="Name" class="ui-corner-all"
                                 style="width: 99%;"
                                 value="${record?.name}"/>
                </td>
                </tr>
            </g:if>



            <g:if test="${fields.contains('value')}">
                <tr>
                <td>
                    <g:textArea id="value" name="value" placeholder="Value" title="Value"
                                style="width: 99%;"
                                class="ui-corner-all"
                                rows="5" cols="80"
                                value="${record?.value}"/>
                </td>
                </tr>
            </g:if>

            <g:if test="${fields.contains('summary')}">
                <tr>
                    <td>
                <g:if test="${fields.contains('code')}">
                        <g:textField name="code" placeholder="Code" title="Code" class="ui-corner-all"
                                     style="width: 10%;"
                                     value="${record?.code}"/>
                    </g:if>

                    <g:textField id="sumamryField" name="summary" title="summary" value="${record?.summary}" placeholder="Summary"
                                 style="width: 89%;"/>
                </td>

                </tr>
            </g:if>





            <g:if test="${fields.contains('title')}">
                <tr>      <td>
                    <g:textField placeholder="Title" name="title" title="title" value="${record?.title}"
                        placeholder="Title"
                                 style="width: 99%;"/>

                %{--<g:if test="${fields.contains('authorInfo')}">--}%
                    %{--<g:textField placeholder="Author infor" name="authorInfo" title="Author info" value="${record?.authorInfo}"--}%
                                 %{--style="width: 95%;"/>--}%
                    %{--</g:if>--}%
                </td> </tr>
            </g:if>






            <g:if test="${fields.contains('shortDescription')}">
                <tr>      <td>
                    <g:textArea cols="80" rows="5" placeholder="Short description" title="Short description" name="shortDescription"
                                value="${record?.shortDescription}"
                                style="width: 99%; height: 60px;"/>
                </td></tr>
            </g:if>


            <g:if test="${fields.contains('description')}">
                <tr>      <td>
                    <g:textArea cols="80" rows="5" placeholder="Description" title="Description" name="description"
                                value="${record?.description}"
                                style="width: 99%; height: 160px;"/>
                </td></tr>
            </g:if>
   <g:if test="${fields.contains('descriptionHTML')}">
                <tr>      <td>
                    <g:textArea cols="80" rows="5" placeholder="Description HTML" title="Description HTML" name="descriptionHTML"
                                value="${record?.descriptionHTML}"
                                style="width: 99%; height: 60px;"/>
                </td></tr>
            </g:if>


        <tr>
            <g:if test="${fields.contains('fullText')}">
                <td>
                    <g:textArea cols="80" rows="5" placeholder="Full text" title="Full text" name="fullText"
                                value="${record?.fullText}"
                                style="width: 99%;  height: 100px;"/>
                </td>
            </g:if>

        </tr>
        %{--<tr>--}%
            %{--<g:if test="${fields.contains('shortDescription')}">--}%
                %{--<td>--}%
                    %{--<g:textArea cols="80" rows="5" placeholder="Short description"--}%
                                %{--title="Short description" name="shortDescription"--}%
                                %{--value="${record?.shortDescription}"--}%
                                %{--style="width: 95%;  height: 100px;"/>--}%
                %{--</td>--}%
            %{--</g:if>--}%
  %{--<g:if test="${fields.contains('descriptionHTML')}">--}%
                %{--<td colspan="2">--}%
                    %{--<g:textArea cols="80" rows="5" placeholder="descriptionHTML"--}%
                                %{--title="Description HTML" name="descriptionHTML"--}%
                                %{--value="${record?.descriptionHTML}"--}%
                                %{--style="width: 95%;  height: 100px;"/>--}%
                %{--</td>--}%
            %{--</g:if>--}%


        %{--</tr>--}%

        %{--<tr>--}%

        %{--<g:if test="${fields.contains('newFilesPath')}">--}%
        %{--<td>--}%
        %{--new    <g:textField placeholder="Path of its location in the new folder"--}%
        %{--id="newFilesPath" name="newFilesPath"--}%
        %{--style="width: 200px"--}%
        %{--class="ui-corner-all"--}%
        %{--value="${record?.newFilesPath ?: null}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%
        %{--</tr>--}%
        <tr>
        %{--<g:if test="${fields.contains('repositoryPath')}">--}%
        %{--<td>--}%
        %{--rps    <g:textField--}%
        %{--placeholder="Path of its location in the repository"--}%
        %{--id="repositoryPath" name="repositoryPath" style="width: 200px"--}%
        %{--class="ui-corner-all"--}%
        %{--value="${record?.repositoryPath ?: null}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%


        %{--<g:if test="${fields.contains('blog')}">--}%
        %{--<td>--}%
         %{--todo <g:select name="blog.id" style="width: 150px;"--}%
        %{--from="${Blog.list([sort: 'code'])}" optionKey="id" optionValue="summary"--}%
        %{--value="${record?.blog?.id}"--}%
        %{--noSelection="${['null': 'No blog']}"/>--}%
        %{--</td>--}%
        %{--</g:if>--}%

        </tr>

        <tr>
            <g:if test="${fields.contains('notes')}">

                <td colspan="2">
                    <g:textArea cols="80" rows="5" id="notes" placeholder="Notes" title="Notes"
                                name="notes" style="width: 99%;" class="ui-corner-all"
                                value="${record?.notes}"/>
                </td>

            </g:if>
        </tr>
   <tr>
            <g:if test="${fields.contains('mainHighlights')}">
                <td colspan="2">
                    <g:textArea cols="80" rows="5" id="mainHighlights" placeholder="Highlights" title="mainHighlights"
                                name="mainHighlights" style="width: 99%; background: lightgreen;" class="ui-corner-all"
                                value="${record?.mainHighlights}"/>
                </td>

            </g:if>
        </tr>



        <tr>




            %{--<g:if test="${fields.contains('totalSteps')}">--}%
                %{--<td>--}%
                    %{--Total steps<g:textField name="totalSteps" value="${fieldValue(bean: record, field: 'totalSteps')}"--}%
                                            %{--placeholder="# total steps"--}%
                                            %{--title="# total steps"--}%
                                            %{--style="width: 20px;"/>--}%
                    %{--<br/>--}%
                    %{--Completed steps<g:textField name="completedSteps"--}%
                                                %{--value="${fieldValue(bean: record, field: 'completedSteps')}"--}%
                                                %{--placeholder="# actual steps"--}%
                                                %{--title="# actual steps"--}%
                                                %{--style="width: 20px;"/>--}%

                %{--</td>--}%
            %{--</g:if>--}%

            %{--<g:if test="${fields.contains('percentCompleted')}">--}%
                %{--<td>--}%
                    %{--%<g:select name="percentCompleted" placeholder="percentCompleted" style="width: 50px;"--}%
                               %{--from="${[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]}"--}%
                               %{--noSelection="${['null': '0']}"--}%
                               %{--value="${record?.percentCompleted ?: 0}"/>--}%
                %{--</td>--}%
            %{--</g:if>--}%

        </tr>


    </table>
    <g:submitButton class="fg-button ui-icon-left ui-widget ui-state-default ui-corner-all" name="submit"
                    style="width: 99%; height: 25px; text-align: center; background: #f0f0f0;"
                    value="Update"
                    onsubmit=""/>

</g:formRemote>

%{--<g:if test="${savedRecord && !record}">--}%
    %{--<g:render template="/gTemplates/recordSummary" model="[record: savedRecord]"/>--}%
%{--</g:if>--}%
