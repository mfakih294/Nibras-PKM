<%@ page import="ker.OperationController; app.IndexCard; mcs.*" %>

%{--<h2>Dashboard</h2>--}%

<h2>Data entry over the days</h2>

<div id="graph${1}" style="width: 500px; height: 250px; margin: 3px auto 0 auto;"></div>

<table>
    <tr>

        <td style="width: 30%"></td>
        <td>
            <h3>Last 24 hours' records</h3>

            ${app.IndexCard.countByDateCreatedGreaterThan(new Date() - 1)} notes <br/>
            ${mcs.Journal.countByDateCreatedGreaterThan(new Date() - 1)} journal<br/>
            ${mcs.Planner.countByDateCreatedGreaterThan(new Date() - 1)} planner<br/>
            ${Task.countByDateCreatedGreaterThan(new Date() - 1)} new tasks <br/>
            ${Task.countByCompletedOnGreaterThan(new Date() - 1)} completed tasks <br/>

        </td>

        <td>
            <h3>Last 7 days' records</h3>

            ${IndexCard.countByDateCreatedGreaterThan(new Date() - 7)} notes <br/>
            ${Journal.countByDateCreatedGreaterThan(new Date() - 7)} journal<br/>
            ${Planner.countByDateCreatedGreaterThan(new Date() - 7)} planner <br/>
            ${Task.countByDateCreatedGreaterThan(new Date() - 7)} new tasks <br/>
            ${Task.countByCompletedOnGreaterThan(new Date() - 7)} completed tasks <br/>


        </td>
    </tr>
</table>




<br/>
<br/>

<table>

    <tr>
        <td >1</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">${Course.executeQuery('from Course where bookmarked = true').department.unique().size()}</span>
            <span class="dashboardLabel">D*</span>
        </td>

        <td class="dashboardCell">
            <span class="dashboardNumber">${mcs.Course.executeQuery('select count(*) from Course where bookmarked = true')[0]}</span>
            <span class="dashboardLabel">C*</span>
        </td>




        <td></td>
    </tr>
    <tr>
        <td>E</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('from Excerpt e where e.book.course.bookmarked = true and e.readOn != null').size()}
                /
                ${Course.executeQuery('from Excerpt e where e.book.course.bookmarked = true and e.readOn = null').size()}
                /
                ${Course.executeQuery('from Excerpt e where e.book.course.bookmarked = true').size()}
            </span>
            <span class="dashboardLabel">read/unread/total</span>

        </td>
        <td class="dashboardCell">

             <span class="dashboardNumber">

                ${Course.executeQuery('select sum(e.reviewCount) from Excerpt e where e.book.course.bookmarked = true and e.readOn != null')[0]}

            </span>
            <span class="dashboardLabel">reviews</span>



        </td>


        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>R</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('from Book e where e.bookmarked = true and e.course.bookmarked = true').size()}

            </span>
            <span class="dashboardLabel">total</span>

        </td>
     <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('select count(*) from Book e where e.bookmarked = true and e.course.bookmarked = true and e.completedOn != null')[0]}

            </span>
            <span class="dashboardLabel">read res.</span>

        </td>

    </tr>

    <tr>
        <td>G</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('from Goal e where e.course.bookmarked = true and e.bookmarked = true and e.completedOn = null').size()}
                / ${Course.executeQuery('from Goal e where e.course.bookmarked = true and e.bookmarked = true').size()}

            </span>
            <span class="dashboardLabel">uncompleted / t</span>

        </td> 
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('select e.completedOn from Goal e where e.course.bookmarked = true order by e.completedOn desc')[0]?.format('dd.MM')}
             </span>
            <span class="dashboardLabel">last done</span>

        </td>

    </tr>
    
    <tr>
        <td>T</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('from Task e where e.course.bookmarked = true and e.bookmarked = true and e.completedOn = null').size()}
                / ${Course.executeQuery('from Task e where e.course.bookmarked = true and e.bookmarked = true').size()}

            </span>
            <span class="dashboardLabel">uncompleted / t</span>

        </td> 
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('select e.completedOn from Task e where e.course.bookmarked = true order by e.completedOn desc')[0]?.format('dd.MM')}
             </span>
            <span class="dashboardLabel">last done</span>

        </td>

    </tr>

    <tr>
        <td>E</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('select e.readOn from Excerpt e where e.book.course.bookmarked = true order by e.readOn desc')[0]?.format('dd.MM')}
            </span>
            <span class="dashboardLabel">last read </span>

        </td>
    <td class="dashboardCell">
            <span class="dashboardNumber">
          ${Course.executeQuery('select e.lastReviewed from Excerpt e where e.book.course.bookmarked = true order by e.lastReviewed desc')[0]?.format('dd.MM')}
            </span>
            <span class="dashboardLabel"> reviewed date </span>

        </td>

    </tr>
    <tr>
        <td>N</td>
        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('from IndexCard e where e.course.bookmarked = true and e.lastReviewed != null').size()}

            </span>
            <span class="dashboardLabel">reviewed</span>

        </td>

        <td class="dashboardCell">
            <span class="dashboardNumber">
                ${Course.executeQuery('from IndexCard e where e.course.bookmarked = true and e.lastReviewed = null').size()}

            </span>
            <span class="dashboardLabel"> total</span>

        </td>

    </tr>

</table>




<script type="text/javascript">

    var day_data = [
        <%   dates.eachWithIndex(){ h, i -> if (i != dates.size() - 1) { %>
        {"date": "${h.key}", "Goal": ${h.value['Goal']?: 0},
            "Task": ${h.value['Task']?: 0},
            "Note": ${h.value['Note']?: 0},
            "Journal": ${h.value['Journal']?: 0},
            "Writing": ${h.value['Writing']?: 0}
            %{--"Resource": ${h.value['Resource']?: 0}--}%
        },
        <% } else { %>
        {"date": "${h.key}", "Goal": ${h.value['Goal']?: 0},
            "Task": ${h.value['Task']?: 0},
            "Note": ${h.value['Note']?: 0},
            "Journal": ${h.value['Journal']?: 0},
            "Writing": ${h.value['Writing']?: 0}
            %{--"Resource": ${h.value['Resource']?: 0}--}%
        }
        <% }}  %>
        //        {"period":"2012-09-10", "pln total":12, "pln completed":10}
    ];
    Morris.Line({
        element: 'graph${1}',
        data: day_data,
        xkey: 'date',
        ykeys: ['Goal','Task', 'Plan','Journal', 'Writing', 'Note'],
        ymin: 'auto',
//        hideHover: 'true',
        labels: ['Goal','Task', 'Plan','Journal', 'Writing', 'Note'],
        /* custom label formatting with `xLabelFormat` */
        xLabelFormat: function (d) {
           return d.getDate() + '.' + (d.getMonth() + 1) //+ '/' + d.getDate() + '/' + d.getFullYear();
        }
        ,
        /* setting `xLabels` is recommended when using xLabelFormat */
        xLabels: 'date'
    });

</script>


<g:if test="${ker.OperationController.getPath('order-departments.enabled')?.toLowerCase() == 'yes' ? true : false}">
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<div id="OrderTheFields" style="-moz-columns-count:1">
    <h4>Order the departments</h4>
    <table id="table1">
    %{--<ul id="item_list" >--}%
        <g:each in="${mcs.Department.list([sort: 'orderNumber', order: 'asc'])}"
                var="c">
            <tr id="${c.id}">
                <td>
                    #${c.orderNumber} D-${c.id} - ${c.summary}
                </td></tr>
        </g:each>
    </table>
    <a style="font-size: 10px; text-align: right;" href="#" onclick='jQuery("#OrderTheFields").load("${request.contextPath}/operation/orderRecords?type=D&child=D&tableId=1", jQuery("#table1").tableDnDSerialize())'>
        Sort</a>

    <hr/>
</div>

<script type="text/javascript">
    jQuery("#table1").tableDnD();
</script>
</g:if>
