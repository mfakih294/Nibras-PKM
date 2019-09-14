<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>

    %{--<link rel="shortcut icon" href="${resource(dir: 'images', file: 'cal.png')}" type="image/png"/>--}%
    <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'calendar.ico')}" type="image/png"/>

    <r:require modules="application"/>
    <r:require modules="jquery"/>
    %{--<r:require modules="jquery-ui"/>--}%

    <r:layoutResources/>

    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'fullcalendar.css')}"/>


    <script type="text/javascript" src="${resource(dir: 'js', file: 'fullcalendar.js')}"></script>

    <title>&nbsp;Calendar ${title}</title>

    <script language="javascript" type="text/javascript">
        jQuery(document).ready(function () {

            jQuery('#fullCalendar').fullCalendar({
                header:{
                    left:'prev,next today',
                    center:'title',
                    right:'agendaDay,agendaWeek,month'
                },
                allDayDefault:false,
                editable:false,
                theme:false,
                defaultEventMinutes: 60,
                        firstDay: 1,
                slotMinutes: 60,
                defaultView: 'month',
                weekNumbers: true,
                axisFormat: 'HH(:mm)',
                weekNumberCalculation: "iso",
                contentHeight: 620,
                firstHour: 6,
                minTime: 6,

//                dayClick: function (date, allDay, jsEvent, view) {
//
//
//                    $(this).changeView('agendaDay')
//                },
                timeFormat: 'HH(:mm)', // uppercase H for 24-hour clock
                        columnFormat:{
                    month:'dddd', // Mon
                    week:'ddd dd', // Mon 19.07
                    day:''  // Monday 19.07
                },
//                timeFormat:'hh(:mm)', // default 'h(:mm)t'

                aspectRatio:1.8,

                events:"export/calendarEvents/?id=${type}&jp=${jp}",
                loading:function (bool) {
                    if (bool) jQuery('#loading').show();
                    else jQuery('#loading').hide();
                }
            });

        });
    </script>

</head>

<body>
<div id='fullCalendar' style='margin-top:7px;font-size:13px'></div>

<div class="body">

</div>

<r:layoutResources/>

</body>
</html>
