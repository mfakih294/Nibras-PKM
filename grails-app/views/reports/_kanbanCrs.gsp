<%@ page import="mcs.UtilsController; app.Indicator" %>

<style type="text/css">
   .kanban table th {
       font-weight: bold !important;
       background: #dddddd;
       color: #383838;
       vertical-align: middle;
       /*text-transform: uppercase;*/

    }

   .kanban table th a {
       font-weight: bold !important;
       color: #121212;
       vertical-align: middle;

    }

   .kanban table td {
        vertical-align: top;
        width: 10% !important;
        min-width: 9% !important;

    }
</style>

%{--<h2>Kanban board</h2>--}%

<div class="kanban">
    <table border="1" style="border: #496779; border-collapse: collapse;">

        <thead>

        <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
            <th>${d.code}</th>

        </g:each>

        </thead>


        <tr>

            <g:each in="${mcs.Department.findAllByBookmarked(true, [sort: 'code'])}" var="d">
                <td id="kanban" style="vertical-align: top;">

                    %{--p.priority > 2 and--}%
                    <g:each in="${mcs.Task.executeQuery('from Task p where p.bookmarked = 1 and  p.department = ? and p.course = null and p.status.code != ? and p.status.code != ? and p.status.code != ? order by p.priority desc',
                            [d, 'completed', 'dismissed', 'deferred'])}"
                            var="p">
                            
                        <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                    </g:each>
		  <g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.department = ? and p.course = null and p.status.code != ?    and p.status.code != ? and p.status.code != ? order by p.priority desc',
					  [d, 'completed', 'dismissed', 'deferred'])}"
					  var="p">
				      <g:render template="/gTemplates/box" model="[record: p]"></g:render>
				  </g:each>


                    %{--<g:if test="${1 == 2}">--}%
                    %{--<hr/>--}%
                    <g:each in="${mcs.Book.executeQuery('from Book p where p.bookmarked = 1 and p.department = ? and p.course = null and p.status.code != ? and p.status.code != ?  and p.status.code != ? and readOn = null  order by p.priority desc',
                            [d, 'completed', 'dismissed', 'deferred'])}"
                            var="p">
                        <g:render template="/gTemplates/box" model="[record: p]"></g:render>
                    </g:each>
                    %{--</g:if>--}%


                    %{--<hr/>--}%
                



                </td>

            </g:each>

        </tr>

    </table>
</div>

<br/>
<br/>

<div class="kanban">
<table  border="1" style="max-width: 98% !important; border: #496779; border-collapse: collapse;">

    <thead>
<g:if  test="${mcs.Course.executeQuery('select count(*) from Course c where c.bookmarked = 1')[0] == 0}">
    <h1>There are no bookmarked courses yet.</h1>
    </g:if>

    <g:each in="${mcs.Course.executeQuery('from Course c where c.bookmarked = 1 order by c.department.code', [])}" var="d">
    <th>
    
     <g:link controller="page" action="record" target="_blank"
            params="${[id: d.id, entityCode: 'M']}"
            title="Go to page">

         ${d.department?.code}
         ${d.code}
  
    </g:link>

    
   
  
    </th>
    
    </g:each>
    
    </thead> 


    <tr>

        <g:each in="${mcs.Course.executeQuery('from Course c where c.bookmarked = true order by c.department.code', [])}"
                var="d">
      <td style="">
      
       
      
    
           %{--<hr/>--}%
       <g:each in="${mcs.Book.executeQuery('from Goal p where p.bookmarked = 1 and p.course = ? and p.status.code != ? and p.status.code != ?  and p.status.code != ? order by orderInCourse asc',
                    [d, 'completed', 'dismissed', 'deferred'])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>
    
    
           %{--<hr/>--}%
       <g:each in="${mcs.Book.executeQuery('from Task p where p.bookmarked = 1 and p.course = ? and p.status.code != ? and p.status.code != ?  and p.status.code != ? order by orderInCourse asc',
                    [d, 'completed', 'dismissed', 'deferred'])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>
   <g:each in="${mcs.Excerpt.executeQuery('from Excerpt p where p.bookmarked = 1  and p.book.course = ? and readOn = null order by orderInCourse asc',
                    [d])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>
            
              
          
            %{--<g:if test="${1 == 2}">--}%
            %{--<hr/>--}%
       <g:each in="${mcs.Book.executeQuery('from Book p where p.bookmarked = 1 and p.course = ? and p.status.code != ? and p.status.code != ? and readOn = null order by orderInCourse asc',
                    [d, 'completed', 'dismissed'])}"
                    var="p">
                <g:render template="/gTemplates/box" model="[record: p]"></g:render>
            </g:each>
            %{--</g:if>--}%
            
    
             
            
            
      </td>
    
    </g:each>
    
    
    

    </tr>


   
</table>
</div>