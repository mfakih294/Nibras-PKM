<%@ page import="app.IndicatorData; app.Indicator" %>

<script type=text/javascript>

        jQuery(document).ready(function () {


        });

    </script>

%{--<g:each in="${1..13}" var="c">--}%
    %{--<h1># ${c}</h1>--}%
    <g:if test="${app.Indicator.countByBookmarked(true) > 0}">
    <g:each in="${app.Indicator.findAllByBookmarked(true)}" var="r">

        <div style="float: left; border: 1px solid lightgrey; padding: 5px">
            <b style="padding-left: 15px;">${r.name}</b>

            <div id="ind${r.id}" style="width: 300px; height: 150px !important; margin: 0px auto 0 auto"></div>
        </div>

           %{--<br/>--}%
           %{--<br/>--}%
        <script type="text/javascript">

            var day_data${r.id} = [
                <% IndicatorData.findAllByIndicatorAndDepartmentIsNull(r).eachWithIndex(){ h, i -> if (i != app.IndicatorData.countByIndicatorAndDepartmentIsNull(r) - 1) { %>
                {"date": "${h.date.format('yyyy-MM-dd')}", "Value": ${h.value}},
                <% } else { %>
                {"date": "${h.date.format('yyyy-MM-dd')}", "Value": ${h.value}}
                <% }}  %>
                //        {"period":"2012-09-10", "pln total":12, "pln completed":10}
            ];
            Morris.Line({
                element: 'ind${r.id}',
                data: day_data${r.id},
                xkey: 'date',
                ykeys: ['Value'],
                labels: ['${r.name}'],
                goals: [${r.notes}],
                ymin: 'auto',
                smooth: false,
                lineColors: 'green',
                hideHover: 'true',
                hoverCallback: function (index, options, content) {
                    var row = options.data[index];
                    return index + ": " + content;
                }
//        ,
                /* custom label formatting with `xLabelFormat` */
//        xLabelFormat: function (d) {
//            return  d.getDate() + '.' + (d.getMonth() + 1) + '.' + d.getFullYear();
//        },
                /* setting `xLabels` is recommended when using xLabelFormat */
//        xLabels: 'day'
            });

        </script>

    </g:each>
        %{--<br/><hr style="color: gray"/><br/>--}%
    </g:if>
    <div style="clear: both"/>

%{--</g:each>--}%

<br/>
<br/>
<br/>