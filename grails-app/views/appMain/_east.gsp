<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>
<div id="3rdPanel" tabindex=6
     style="z-index: 1000000; background: #f6f9f1;
      margin-bottom: 25px; padding: 10px; border: 0px solid darkgray;">

    %{--<uploadr:add id="addToRecordFolder"--}%
    %{--url="${[controller: 'import', action: 'addToRecordFolder2']}"--}%
    %{--params="${[recordId: '12']}">--}%
    %{--Add to record folder   ============--}%
    %{--</uploadr:add>--}%


    %{--<div >--}%

    %{--</div>--}%


    %{--<g:render template='/reports/homepageSavedSearchesHql'/>--}%




    %{--params="[variableTwo: 'foo', variableThree: 'bar', variableFour: 4, myObject: someObject]"--}%
    %{--             model="[booleanOne:true, variableTwo: 'foo', variableThree: 'bar', variableFour: 4, myObject: someObject]"--}%

</div>
%{--<div id="---accordionEast" class="basic">--}%
<br/>
<br/>
<br/>
<br/>
%{--    <h3><a href="#">--}%
%{--        <g:message code="ui.details"></g:message>--}%
%{--    </a></h3>--}%





    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<h3><a href="#">--}%
    %{--<g:message code="ui.sandbox"></g:message>--}%

    %{--</a></h3>--}%

    %{--<div id='sandboxPanel'>--}%

    %{--</div>--}%
    %{--</sec:ifAnyGranted>--}%

    %{--<h4>Add records</h4>--}%
    %{--<hr/>--}%
    %{--</sec:ifAnyGranted>--}%

%{--</div>--}%

<script type="text/javascript">



    jQuery("#addArticleFormNgs").relatedSelects({
        onChangeLoad: '${request.contextPath}/generics/fetchCoursesForDepartment',
        defaultOptionText: '',
        selects: {
            'department.id': {loadingMessage: ''},
            'course.id': {loadingMessage: ''}
        }
    });
    jQuery("#addXcdFormNgs").relatedSelects({
        onChangeLoad: '${request.contextPath}/generics/fetchWritingsForCourse',
        defaultOptionText: '',
        selects: {
            'course.id': {loadingMessage: ''},
            'writing.id': {loadingMessage: ''}
        }
    });

    function openNoteTaker()  {
        window.open('${request.contextPath}/page/appDaftar', '',
                'height=200,width=400,chrome=yes,scrollbars=yes, titlebar=no, toolbar=no, menubar=no, location=no, status=no, directories=no, resizable=yes');

    }

</script>