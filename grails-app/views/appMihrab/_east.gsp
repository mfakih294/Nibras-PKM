<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<div id="accordionEast" class="basic">

        <h3><a href="#">
            <g:message code="ui.details"></g:message>

        </a></h3>

        <div id="3rdPanel">

        </div>


        <h3 class="accordionPanelAdd"><a href="#">
            <g:message code="ui.add.full.note"></g:message>

        </a></h3>

        <div id='addXcd'>

            <g:formRemote name="addXcdFormNgs" id="addXcdFormNgs"
                          url="[controller: 'indexCard', action: 'addXcdFormNgs']"
                          update="centralArea"
                          onComplete="clearFormFields()"
                          method="post">

                <g:select name="language" from="${['ar', 'fr', 'en', 'de', 'fa']}"
                          id="language"
                          value="ar"
                          noSelection="${['null': '']}"/>

                <g:select name="priority" from="${(1..4)}"
                          id="priorityNote"
                          value="${2}"/>


                <g:select name="department.id" from="${Department.list([sort: 'code'])}"
                          optionKey="id" id="department"
                          optionValue="code"
                          noSelection="${['null': 'd-']}"/>

                <g:select name="course.id"
                          from="${Course.executeQuery('from Course c where c.bookmarked = true order by c.department.orderNumber asc, c.orderNumber asc')}"
                          optionKey="id"
                          id="courseNote"
                          class="chosen chosen-rtl"
                          optionValue="summary"
                          noSelection="${['null': 'No course']}"/>
                <br/>
                <pkm:datePicker name="writtenOn" placeholder="Date" id="34563453" value="${new Date()}"/>
                %{--~<g:checkBox name="approximateDate" id="approximateDate" value=""/>--}%

                <g:select name="type.id" from="${WritingType.list([sort: 'code'])}"
                          optionKey="id"
                          id="typeNote"
                          class="chosen chosen-rtl"
                          optionValue="code"
                          value="${WritingType.findByCode('usr')?.id}"
                          noSelection="${['null': 'No type']}"/>

                <a onclick="clearFormFields()">Clear</a>

                <br/>

                %{--<g:select name="writing.id"--}%
                          %{--from="${Writing.executeQuery('from Writing w where w.course.bookmarked = ? order by w.course.department.orderNumber asc, w.course.orderNumber asc, w.orderNumber asc', [true])}"--}%
                          %{--optionKey="id"--}%
                          %{--id="writingNote"--}%
                          %{--optionValue="summary"--}%
                          %{--class="chosen chosen-rtl"--}%
                          %{--style="width: 48%; text-align: right; direction:rtl"--}%
                          %{--value="${null}"--}%
                          %{--noSelection="${['null': 'No writing']}"/>--}%
                %{----}%



            %{--<g:select name="contact.id"--}%
            %{--from="${app.Contact.executeQuery('from Contact c order by c.summary asc')}"--}%
            %{--optionKey="id"--}%
            %{--id="contactNote"--}%
            %{--optionValue="summary"--}%
            %{--class="chosen chosen-rtl"--}%
            %{--style="width: 48%; text-align: right; direction:rtl"--}%
            %{--value="${null}"--}%
            %{--noSelection="${['null': '']}"/>--}%


             %{----}%
                %{--<br/>--}%
                %{--<g:select name="book.id"--}%
                          %{--from="${Book.executeQuery('from Book r where r.status.code = ? order by r.course.department.orderNumber asc, r.course.orderNumber asc, r.orderNumber asc', ['mkt'])}"--}%
                          %{--id="bookId"--}%
                          %{--optionKey="id"--}%
                          %{--optionValue="title"--}%
                          %{--class="chosen chosen-rtl"--}%
                          %{--style="width: 99%; text-align: right; direction:rtl"--}%
                          %{--value="${null}"--}%
                          %{--noSelection="${['null': '']}"/>--}%

         %{----}%

                <g:textField placeholder="Summary" name="summary" id="summary" value=""
                             style="background: #e8efe7; width: 100%; ;" dir="auto"/>

                <g:textArea cols="80" rows="12" placeholder="Description" name="description" id="description"
                            value="" dir="auto"
                            style="font-family: tahoma; font-size: small; background: #f7fff6; width: 100%; height: 150px !important;"/>
                <br/>

                %{--<g:textField placeholder="pages" name="pages" id="pages" value="" style="width: 100%;"/>--}%
                %{--<br/>--}%
                <g:textField placeholder="url" name="url" id="url" value="" placehoder="url" style="width: 100%;"/>
            %{--<br/>--}%
            %{--<br/>--}%
            %{--<g:select name="chosenTags" from="${Tag.list()}" multiple=""--}%
            %{--size="80" style="min-width: 200px; min-height: 50px;"--}%
            %{--value="" optionKey="id"--}%
            %{--class="chosen chosen-rtl" id="chosenTags"--}%
            %{--optionValue="name"--}%
            %{--noSelection="${['null': '']}"/>--}%

                <br/>

                <g:submitButton name="save" value="Save"

                                style="height: 35px; margin: 0px; width: 100% !important; background: #efece0"
                                id="45634523"
                                class="fg-button ui-widget ui-state-default"/>
            </g:formRemote>

        </div>


    </div>