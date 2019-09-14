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
    
    <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
    <th>${d.code}</th>
    
    </g:each>
    
    </thead> 


    <tr>

    
    <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
      <td id="kanban">
      
       <g:each in="${mcs.Task.executeQuery('from Task p where p.bookmarked = ? and p.department = ? and p.status.code != ? and p.status.code != ? order by priority desc',
                    [true, d, 'completed', 'dismissed'])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>
            
      </td>
    
    </g:each>
    
    
    

    </tr>


   
</table>
</div>