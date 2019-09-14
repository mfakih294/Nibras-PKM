
<div id="graph${1}" style="width: 500px; height: 350px; margin: 3px auto 0 auto;"></div>
<div id="graph${2}" style="width: 500px; height: 350px; margin: 3px auto 0 auto;"></div>

<script type="text/javascript">

    var day_data = [
        <%   datesTc.eachWithIndex(){ h, i -> if (i != datesTc.size() - 1) { %>
        {"date": "${h.key}", "newTasks": ${h.value['newTasks']?: 0},
            "completedTasks": ${h.value['completedTasks']?: 0}
        },
        <% } else { %>
        {"date": "${h.key}", "newTasks": ${h.value['newTasks']?: 0},
            "completedTasks": ${h.value['completedTasks']?: 0}
        }
        <% }}  %>
        //        {"period":"2012-09-10", "pln total":12, "pln completed":10}
    ];
    Morris.Line({
        element: 'graph${1}',
        data: day_data,
        xkey: 'date',
        ykeys: ['newTasks', 'completedTasks'],
        ymin: 'auto',
        labels: ['New tasks','Completed tasks'],
        /* custom label formatting with `xLabelFormat` */
        xLabelFormat: function (d) {
           return d.getDate() + '.' + (d.getMonth() + 1) //+ '/' + d.getDate() + '/' + d.getFullYear();
        }
        ,
        /* setting `xLabels` is recommended when using xLabelFormat */
        xLabels: 'date'
    });
  var day_data2 = [
        <%   datesNr.eachWithIndex(){ h, i -> if (i != datesNr.size() - 1) { %>
        {"date": "${h.key}", "newNotes": ${h.value['newNotes']?: 0},
            "readNotes": ${h.value['readNotes']?: 0}
        },
        <% } else { %>
        {"date": "${h.key}", "newNotes": ${h.value['newNotes']?: 0},
            "readNotes": ${h.value['readNotes']?: 0}
        }
        <% }}  %>
        //        {"period":"2012-09-10", "pln total":12, "pln completed":10}
    ];
    Morris.Line({
        element: 'graph${2}',
        data: day_data2,
        xkey: 'date',
        ykeys: ['newNotes', 'readNotes'],
        ymin: 'auto',
//        hideHover: 'true',
        labels: ['New notes','Read notes'],
        /* custom label formatting with `xLabelFormat` */
        xLabelFormat: function (d) {
           return d.getDate() + '.' + (d.getMonth() + 1) //+ '/' + d.getDate() + '/' + d.getFullYear();
        }
        ,
        /* setting `xLabels` is recommended when using xLabelFormat */
        xLabels: 'date'
    });

</script>


