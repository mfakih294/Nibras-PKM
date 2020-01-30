<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'calendar.ico')}" type="image/png"/>

    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'fullcalendar-2.6.1.css')}"/>
    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'jquery.qtip.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'moment.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'fullcalendar-2.6.1.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.qtip.js')}"></script>

    <title>${title}</title>

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {


            $('#calendar').fullCalendar({
                isRTL: true,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek'
                },
                editable: true,

                dayNames: ['الأحد', 'الأثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'],
                dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],

                eventDrop: function (event, delta, reverFunc) {
                    alert(event.title + ' - ' + event.id + ' drop : ' + delta);

                    $('#logArea2').load('${request.contextPath}/task/addFromCalendar',

                            {
                                title: title, start: start.format('DD.MM.YYYY HH:mm'),
                                end: end.format('DD.MM.YYYY HH:mm')
                            },
                            function (responce) {

                            })
                },

//                eventResize: function (event, jsEvent, ui, view) {
//                    alert(event.title + ' - ' + event.id + ' resize : ' + event.end.format());
//                },

                defaultView: 'month',
                firstDay: 1,
                slotDuration: '00:30:00',
                slotLabelInterval: '00:60:00',
                slotLabelFormat: 'HH',

                defaultTimedEventDuration: '00:30:00',
                defaultAllDayEventDuration: {days: 0},

                weekNumbers: true,
                weekNumberCalculation: "ISO",
                contentHeight: 550,
                firstHour: 12,
                minTime: '06:00',
                maxTime: '22:00',

                timeFormat: 'HH(:mm)', // uppercase H for 24-hour clock
                columnFormat: {
                    month: 'dddd', // Mon
                    week: 'ddd DD', // Mon 19.07
                    day: 'ddd'  // Monday 19.07
                },
                displayEventTime: false,

                selectable: true,
                selectHelper: true,
                select: function (start, end) {

                    var title = prompt('Event Title:');

                    var eventData;

                    if (title) {
                        eventData = {
                            title: title,
                            start: start,
                            end: end
                        };
                        $('#logArea').html(title);
                        $('#logArea2').load('${request.contextPath}/task/addFromCalendar', {
                            title: title,
                            start: start.format('DD.MM.YYYY HH:mm'),
                            end: end.format('DD.MM.YYYY HH:mm')
                        }, function (responce) {
                            eventData.title = responce;
                            $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
                        });
                    }
                    $('#calendar').fullCalendar('unselect');
                }
                ,


                aspectRatio: 1.8,

                events: "${request.contextPath}/export/calendarEvents/${savedSearchId}",
                eventRender: function (event, element) {
                    element.qtip({
                        content: {text: event.description, title: event.title},
                        style: 'qtip-light qtip-bootstrap qtip-blue',
                        width: 200,
                        position: {
                            my: 'center',
                            at: 'center',
                            target: jQuery('#calendar')
                        }
                    })
                },

                loading: function (bool) {
                    if (bool) jQuery('#loading').show();
                    else jQuery('#loading').hide();
                }   ,

                	editable: false
                //	eventLimit: true // allow "more" link when too many events


            });

        });


        //    setInterval(function() {
        //        $('#calendar').fullCalendar('refetchEvents');
        //     },
        //     30000);

    </script>

</head>

<body style="font-family: tahoma; ">

<div style="font-size: 11px; font-family: tahoma; line-height: 20px; text-align: center; padding-bottom: 10px;">
%{--<g:each in="${(2004..2009)}" var="y">--}%
%{--<sup>--}%
%{--<g:each in="${1..6}" var="m">--}%
%{--<a onclick="jQuery('#calendar').fullCalendar('gotoDate', ${y}, ${m})">${m}</a>--}%
%{--</g:each>--}%
%{--</sup>--}%
%{--<a onclick="jQuery('#calendar').fullCalendar('gotoDate', ${y})">--}%
%{--<b>${y}--}%
%{--</b></a>--}%


%{--<sup>--}%
%{--<g:each in="${7..12}" var="m">--}%
%{--<a onclick="jQuery('#calendar').fullCalendar('gotoDate', ${y}, ${m} )">${m}</a>--}%
%{--</g:each>--}%
%{--</sup>|--}%
%{--&nbsp;--}%
%{--</g:each>--}%
%{--<br/>--}%
    <g:each in="${(2012..(new Date().year + 1900))}" var="y">
        <sub>
            <g:each in="${1..6}" var="m">
                <a onclick="jQuery('#calendar').fullCalendar('gotoDate', '${y}-0${m}')">${m}</a>
            </g:each>
        </sub>
        <a onclick="jQuery('#calendar').fullCalendar('gotoDate', '${y}-01')">
            <b>${y}
            </b></a>


        <sub>
            <g:each in="${7..9}" var="m">
                <a onclick="jQuery('#calendar').fullCalendar('gotoDate', '${y}-0${m}')">${m}</a>
            </g:each>
            <g:each in="${10..12}" var="m">
                <a onclick="jQuery('#calendar').fullCalendar('gotoDate', '${y}-${m}')">${m}</a>
            </g:each>
        </sub>|
         &nbsp;
    </g:each>

</div>

<div id="logArea" style="background: lightgoldenrodyellow; font-size: 14px;">
</div>

<div id="logArea2" style="display: none">
</div>

<div class="body">

</div>


<div id='calendar' style='margin:0px;font-size:13px; direction: rtl; text-align: right;'></div>

<g:if test="${savedSearchId == 65}">
<g:each in="${mcs.parameters.PlannerType.list([sort: 'code'])}" var="t">
    <g:if test="${mcs.Planner.countByType(t)}">
        <span style="font-size: 11px;color:'black'; ${t.style}">${t.code} (${mcs.Planner.countByType(t)})</span>
        &nbsp;
    </g:if>
</g:each>
</g:if>
<g:else>
    <g:each in="${mcs.parameters.JournalType.list([sort: 'code'])}" var="t">
        <g:if test="${mcs.Journal.countByType(t)}">
            <span style="font-size: 11px;color:'black'; ${t.style}">${t.code} (${mcs.Journal.countByType(t)})</span>
            &nbsp;
        </g:if>
    </g:each>
</g:else>
<r:layoutResources/>

</body>
</html>
