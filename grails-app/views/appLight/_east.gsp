<%@ page import="mcs.parameters.ResourceStatus; mcs.Goal; org.apache.commons.lang.StringUtils; mcs.Book; app.parameters.ResourceType; mcs.Writing; mcs.Department; mcs.parameters.WritingType; app.Tag; cmn.Setting; mcs.Course; mcs.Journal; mcs.Planner; app.IndexCard; mcs.Task; ker.OperationController" %>

<div id="accordionEast" class="basic">

    <h3><a href="#">
        <g:message code="ui.details"></g:message>
    </a></h3>

    <div id="3rdPanel">


        %{--<uploadr:add id="addToRecordFolder"--}%
                           %{--url="${[controller: 'import', action: 'addToRecordFolder2']}"--}%
                           %{--params="${[recordId: '12']}">--}%
            %{--Add to record folder   ============--}%
        %{--</uploadr:add>--}%


        %{--<div >--}%

        %{--</div>--}%

        <br/>
        <hr/>

        %{--Todo--}%
        <br/>






        %{--params="[variableTwo: 'foo', variableThree: 'bar', variableFour: 4, myObject: someObject]"--}%
        %{--             model="[booleanOne:true, variableTwo: 'foo', variableThree: 'bar', variableFour: 4, myObject: someObject]"--}%

    </div>



    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<h3><a href="#">--}%
    %{--<g:message code="ui.sandbox"></g:message>--}%

    %{--</a></h3>--}%

    %{--<div id='sandboxPanel'>--}%

    %{--</div>--}%
    %{--</sec:ifAnyGranted>--}%

    %{--<h4>Add records</h4>--}%
    %{--<hr/>--}%



    %{--<h3 class="accordionPanelAdd"><a href="#">--}%
        %{--<g:message code="ar.daftar"></g:message>--}%
    %{--</a></h3>--}%

    %{--<div id='daftarDiv'>--}%

        %{--<span id="topDaftarArea"--}%
              %{--style="font-style: italic; padding-right: 15px; text-align: right; font-size: small; color: darkgreen">--}%

        %{--</span>--}%


        %{--<br/>--}%

        %{--<a onclick="openNoteTaker()" href="javascript:void(0);" target="_self">--}%
        %{--&nearr;--}%
        %{--&nearr;--}%
            %{--Open in a dedicated window.--}%
        %{--</a>--}%

    %{--</div>--}%


    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<h4>Configuration</h4>--}%
    %{--<hr/>--}%

</div>

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