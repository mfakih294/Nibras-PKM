<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<div id="accordionEast" class="basic">

        <h3><a href="#">
            <g:message code="ui.details"></g:message>

        </a></h3>

        <div id="3rdPanel">

        </div>


        <h3 class="accordionPanelAdd"><a href="#">
            Tasks

        </a></h3>

        <div>

            %{--<g:render template="/gTemplates/recordListing" model="[list: Task.findAllByCourse(record)]"/>--}%

        </div>


    </div>