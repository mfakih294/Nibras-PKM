<%@ page import="app.parameters.Blog;mcs.Department; mcs.parameters.WorkStatus;" %>

%{--<g:if test="${record}">--}%
    %{--<g:render template="/gTemplates/recordSummary" model="[record: record]"/>--}%
%{--</g:if>--}%

<div id="underQuickEditForm"></div>


<g:formRemote name="genericSearch" id="genericSearch22" url="[controller: 'generics', action: 'saveViaQuickForm']"
              class="uk-form-stacked"
              update="${updateRegion}" method="post" style="display: inline;" onComplete="">

    <g:hiddenField name="entityController" value="${entityController}"/>
    <g:hiddenField name="updateRegion" value="${updateRegion}"/>

    <g:hiddenField name="id" value="${record?.id}"/>


    <table>

            <g:if test="${fields.contains('name')}">
                <tr>
                    <td>

                        <label class="uk-form-label">
                            Name
                        </label>
                    <g:textField name="name" placeholder="Name" title="Name"
                                 style="width: 99%;"
                                 class="uk-input"
                                 onblur="jQuery('#submitUpdate').click();"
                                 value="${record?.name}"/>
                </td>
                </tr>
            </g:if>



            <g:if test="${fields.contains('value')}">
                <tr>
                <td>

                    <label class="uk-form-label">
                        Value
                    </label>
                    <g:textField id="value" name="value" placeholder="Value" title="Value"
                                class="uk-input uk-width-1-1"
                                onblur="jQuery('#submitUpdate').click();"
                                value="${record?.value}"/>
                </td>
                </tr>
            </g:if>

            <g:if test="${fields.contains('summary')}">
                <tr>
                    <td>
                <g:if test="${fields.contains('code')}">

                    <label class="uk-form-label">
                        Code
                    </label>
                        <g:textField name="code" placeholder="Code" title="Code"
                                     class="uk-input uk-width-1-1"
                                     style="width: 20%;"
                                     onblur="jQuery('#submitUpdate').click();"
                                     value="${record?.code}"/>
                    </g:if>


                        <label class="uk-form-label" for="sumamryField">
                            Summary
                        </label>
                        <div class=uk-form-controls">

                        <g:textField id="sumamryField" name="summary" title="summary" value="${record?.summary}" placeholder="Summary"
                                 onblur="jQuery('#submitUpdate').click();"
                                 class="uk-input uk-width-1-1"
                                 />
                        </div>
                </td>

                </tr>
            </g:if>

     <g:if test="${fields.contains('recurringCron')}">
                <tr>
                    <td>

                        <label class="uk-form-label">
                        Recurrence cron expression
                            <br/>
                            (min h dom mon dow)
                        </label>

                    <g:textField id="recurringCron" name="recurringCron"
                                 title="Recurrence Cron expression"
                                 value="${record?.recurringCron}"
                                 placeholder="min h dom mon dow, e.g. 0 8 * * 1"
                                 onblur="jQuery('#submitUpdate').click();"
                                 class="uk-input uk-width-1-1"
                                 />
                </td>

                </tr>
            </g:if>





            <g:if test="${fields.contains('title')}">
                <tr>      <td>
                    <label class="uk-form-label">
                        Title
                    </label>
                    <div class=uk-form-controls">

                        <g:textField placeholder="Title" name="title" title="title" value="${record?.title}"
                                 onblur="jQuery('#submitUpdate').click();"
                                 class="uk-input uk-width-1-1"/>
                        </div>

                </td> </tr>
            </g:if>

    <g:if test="${fields.contains('url')}">
        <tr>      <td>

        <label class="uk-form-label">
                        URL
                    </label>

    <g:textField placeholder="URL"
                 class="uk-input uk-width-1-1"
                 name="url" title="URL" value="${record?.url}"/>
    </g:if>






            <g:if test="${fields.contains('shortDescription')}">
                <tr>      <td>

                    <label class="uk-form-label">
                        Short description
                    </label>
                    <g:textArea cols="80" rows="5" placeholder="Short description" title="Short description" name="shortDescription"
                                value="${record?.shortDescription}"
                                class="uk-width-1-1 uk-textarea"
                                onblur="jQuery('#submitUpdate').click();"
                                style="height: 60px;"/>
                </td></tr>
            </g:if>


            <g:if test="${fields.contains('description')}">
                <tr>      <td>
                    <label class="uk-form-label">
                        Short Description
                    </label>
                    <g:textArea cols="80" rows="5" placeholder="Description" title="Description" name="description"
                                value="${record?.description}"
                                class="uk-width-1-1 uk-textarea"
                                onblur="jQuery('#submitUpdate').click();"
                                style="height: 200px;"/>
                </td></tr>
            </g:if>

   %{--<g:if test="${fields.contains('descriptionHTML')}">--}%
                %{--<tr>      <td>--}%
                    %{--Description (in HTML)--}%
                    %{--<g:textArea cols="80" rows="5" placeholder="Description HTML" title="Description HTML" name="descriptionHTML"--}%
                                %{--value="${record?.descriptionHTML}"--}%
                                %{--style="width: 99%; height: 60px;"/>--}%
                %{--</td></tr>--}%
            %{--</g:if>--}%


        <tr>
            <g:if test="${fields.contains('fullText')}">
                <td>

                    <label class="uk-form-label">
                        Full text
                    </label>
                    <g:textArea cols="80" rows="5" placeholder="Full text" title="Full text" name="fullText"
                                class="uk-width-1-1 uk-textarea"
                                value="${record?.fullText}"
                                onblur="jQuery('#submitUpdate').click();"
                                style="height: 160px;"/>
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
        %{--<tr>--}%
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

        %{--</tr>--}%

        <tr>
            <g:if test="${fields.contains('notes')}">

                <td colspan="2">


                    <label class="uk-form-label">
                        Notes
                    </label>
                    <g:textArea cols="80" rows="5" id="notes" placeholder="Notes" title="Notes"
                                name="notes"
                                class="uk-width-1-1 uk-textarea"
                                onblur="jQuery('#submitUpdate').click();"
                                value="${record?.notes}"/>
                </td>

            </g:if>
        </tr>
   <tr>
            <g:if test="${fields.contains('mainHighlights')}">
                <td colspan="2">
                    <label class="uk-form-label">
                        Highlights
                    </label>
                    <g:textArea cols="80" rows="5" id="mainHighlights" placeholder="Highlights" title="mainHighlights"
                                name="mainHighlights" style="background: lightgreen;" class="uk-textarea uk-width-1-1"
                                onblur="jQuery('#submitUpdate').click();"
                                value="${record?.mainHighlights}"/>
                </td>

            </g:if>
        </tr>



        %{--<tr>--}%




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

        %{--</tr>--}%


    </table>
    <g:submitButton class="uk-width-1-1 uk-button uk-button-primary" name="submit"
                    value="Update"
                    style="height: 40px"
        id="submitUpdate"
                    onsubmit=""/>
</g:formRemote>

%{--<g:if test="${savedRecord && !record}">--}%
    %{--<g:render template="/gTemplates/recordSummary" model="[record: savedRecord]"/>--}%
%{--</g:if>--}%


