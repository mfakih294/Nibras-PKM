<%@ page import="mcs.UtilsController; app.Indicator" %>

<style type="text/css">
   #kanban table th {
        font-weight: bold !important;
       background: #7ba1b9;
       color: #ffffff;
    }

   #kanban table td {
        vertical-align: top;
        width: 14%;
    }
</style>

%{--<h2>Kanban board</h2>--}%
<div id="kanban">
<table  border="1" style="width: 98%; border: #496779; border-collapse: collapse;">

    <thead>
    <th>High priority</th>
    <th>Focus</th>
    <th>This week</th>

    
    <th>Today</th>
    <th>In progress</th>
    <th>Overdue</th>
    <th>Completed</th>
    
    </thead> 


    <tr>

        <td id="kanban3">

            <g:each in="${mcs.Task.executeQuery('from Task p where p.priority = ? and p.status.code != ?',
                    [4, 'completed'])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>

        </td>
        <td id="kanban1">

                %{--<g:each in="${mcs.Planner.executeQuery('from Planner p where p.status.code like ? and p.startDate between ? and ?',--}%
                        %{--['not-started', Utils.fromWeekDateAsDateTimeFullSyntax(Utils.getNextWeek() + '1_0'), Utils.fromWeekDateAsDateTimeFullSyntax(Utils.getNextWeek() + '7_2359')])}"--}%
                        %{--var="p">--}%

                    %{--<g:render template="/planner/box" model="[p: p]"></g:render>--}%

                %{--</g:each>--}%

            <g:each in="${mcs.Goal.executeQuery('from Goal r where r.bookmarked = ?', [true])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>


            <g:each in="${mcs.Task.executeQuery('from Task r where r.bookmarked = ?', [true])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>


                <g:each in="${mcs.Course.executeQuery('from Course p where p.bookmarked = ?', [true])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>



        </td>
        <td id="kanban2">
                <g:each in="${mcs.Planner.executeQuery('from Planner p where p.status.code like ? and p.startDate between ? and ?',
                        ['not-started', Utils.fromWeekDateAsDateTimeFullSyntax(Utils.getCurrentWeek() + '1_0'), Utils.fromWeekDateAsDateTimeFullSyntax(Utils.getCurrentWeek() + '7_2359')])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>
        </td>

      
        <td id="kanban5">

                <g:each in="${mcs.Planner.executeQuery('from Planner p where p.status.code = ? and p.startDate between ? and ?',
                        ['not-started', Utils.fromWeekDateAsDateTimeFullSyntax(Utils.getCurrentWeekDate() + '_0'), Utils.fromWeekDateAsDateTimeFullSyntax(Utils.getCurrentWeekDate() + '_2359')])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>


        </td>
        <td id="kanban6">

                <g:each in="${mcs.Planner.executeQuery('from Planner p where p.status.code = ?', ['in-progress'])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>


                   <g:each in="${mcs.Planner.executeQuery('from Task p where p.status.code = ?', ['in-progress'])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>

                
        </td>
        
          <td id="kanban4">

                <g:each in="${mcs.Planner.executeQuery('from Planner p where p.status.code != ? and p.startDate < ?',
                        ['completed', new Date()])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>

        </td>
        
        
        <td id="kanban7">
                <g:each in="${mcs.Planner.executeQuery('from Planner p where p.status.code = ?', ['completed'])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>
                
                   <g:each in="${mcs.Planner.executeQuery('from Task p where p.status.code = ?', ['completed'])}"
                        var="p">
                    <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                </g:each>

                

        </td>

    </tr>


   
</table>
</div>