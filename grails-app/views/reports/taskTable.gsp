<%@ page import="mcs.Task" %>
<!DOCTYPE Html>
<html lang="en">
<head>
    <title>
        Nibras Active Tasks
(${mcs.Task.countByBookmarked(true)})
        </title>
    <meta charset="UTF-8">


    <!-- UIkit CSS -->
    %{--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.13.7/dist/css/uikit.min.css" />--}%
    <!-- UIkit JS -->
    %{--<script src="https://cdn.jsdelivr.net/npm/uikit@3.13.7/dist/js/uikit.min.js"></script>--}%


    <link rel="stylesheet" href="${resource(dir: 'js/datatables', file: 'uikit.min.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'js/datatables', file: 'uikit.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/datatables', file: 'uikit-icons.min.js')}"></script>

    %{--<script src="https://cdn.jsdelivr.net/npm/uikit@3.13.7/dist/js/uikit-icons.min.js"></script>--}%
    <!-- Datatables.net -->
    <script type="text/javascript" src="${resource(dir: 'js/datatables', file: 'jquery-3.5.1.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/datatables', file: 'jquery.dataTables.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/datatables', file: 'dataTables.uikit.min.js')}"></script>
    %{--<script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>--}%
    %{--<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>--}%
    %{--<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.5/js/dataTables.uikit.min.js"></script>--}%

    <style>
.uk-table td {
    padding: 6px 8px;
}
</style>

    <script type="text/javascript" class="init">
        $(document).ready(function() {
            $('#awesome-datatable').DataTable( {
                //~ dom: "<'bottom'flp><'clear'>i",
                serverSide: false,
                ordering: true,
                pageLength: 100,
                searching: false,
                //~ data:           data,
                deferRender:    true,
//                scrollY:        500,
                scrollCollapse: false,
                scroller:       false,
                stateSave: false,
                paging:   false,
                info:     true,
                order: [[ 0, "desc" ]]
            } );
        } );
    </script>
</head>
<body>
<div class="uk-container uk-width-expand uk-margin-left uk-margin-right">
    <table id="awesome-datatable" class="uk-table   uk-table-hover uk-table-striped">
        %{--<colgroup>--}%
            %{--<col style="width: 20%;">--}%
            %{--<col style="width: 40%;">--}%
            %{--<col style="width: 40%;">--}%
        %{--</colgroup>--}%
        <thead>
        <tr>
            <th><strong>ID</strong></th>
            <th><strong>Dept.</strong></th>
            %{--<th><strong>Course</strong></th>--}%
            %{--<th><strong>Goal</strong></th>--}%
            <th><strong>Priority</strong></th>
            <th><strong>Task</strong></th>
            <th><strong>Due date</strong></th>
            <th><strong>Context</strong></th>
            <th><strong>Status</strong></th>
            <th><strong>Actions</strong></th>


        </tr>
        </thead>
        <tbody>

        <g:each in="${mcs.Task.findAllByBookmarked(true, [sort: 'id', order: 'desc'])}" var="t">
        <tr>

            <td>
<div id="TRecord${t.id}">
                <a name="bookmark${t.id}T"
                   title="Toggle bookmark"
                   class="quickBookmarkButton"
                   value="${t.bookmarked}"
                   onclick="jQuery('#TRecord${t.id}').load('${request.contextPath}/generics/quickBookmarkSilent/T-${t.id}')">
                    %{--<span class="icon-star-gm"></span>--}%
                    <span class="uk-icon-button" uk-icon="star"></span>
                </a>
</div>




            </td>
            <td>
                ${t.department?.code}
            %{--</td>--}%
            %{--<td>--}%
                ${t.course?.code}
            %{--</td>--}%
            %{--<td>--}%
                ${t.goal ? '[G ' + t.goal + ']' : ''}
            </td>
            <td>
                ${t.priority}
            </td>
            <td style="unicode-bidi: plaintext;">

                <a href="${contextPath}/page/record/${t.id}" title="ID ${t.id}">

                ${t.summary}
            </a>
            </td>
            <td>
                ${t.endDate ? t.endDate - new Date() : ''}
                ${t.endDate ? '(' + t.endDate?.format('EEE dd MMM') + ')': '' }
            </td>
           <td>
                ${t.context?.code}
            </td>
            <td>
                ${t.status?.code}
            </td>
<td>

    <span id="doneLog${t.id}">
    <g:remoteLink controller="generics" action="quickMarkCompleted"
                  id="${t.id}"
                  class="uk-button"
                  params="[entityCode: 'T']"
                  update="doneLog${t.id}"
                  title="Mark completed">
        <span class="uk-icon-button" uk-icon="check"></span>
    </g:remoteLink>
</span>
  <span id="startLog${t.id}">
    <g:remoteLink controller="generics" action="startTask"
                  id="${t.id}"
                  class="uk-button"
                  params="[entityCode: 'T']"
                  update="startLog${t.id}"
                  title="Start the task">
        <span class="uk-icon-button" uk-icon="play-circle"></span>
    </g:remoteLink>
</span>
  <span id="stopLog${t.id}">
    <g:remoteLink controller="generics" action="stopTask"
                  id="${t.id}"
                  class="uk-button"
                  params="[entityCode: 'T']"
                  update="stopLog${t.id}"
                  title="Stop the task">
        <span class="uk-icon-button" uk-icon="history"></span>
    </g:remoteLink>

</span>

</td>



        </tr>

        </g:each>

        </tbody>
    </table>
</div>
</body>
</html>
