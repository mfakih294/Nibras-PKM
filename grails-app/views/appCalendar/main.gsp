<%@ page import="ker.OperationController" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
  <title style="direction: ltr; text-align: left;">${ker.OperationController.getPath('app.name') ? OperationController.getPath('app.name') + ' /Calendar': 'Nibras PKM /Calendar'}</title>

  <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'calendar.ico')}" type="image/png"/>


  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>


  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'jquery.qtip.css')}"/>

  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.qtip.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'moment.min.js')}"></script>



  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main5.js')}"></script>


  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main1.js')}"></script>
  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main1.css')}"/>

<script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main1.js')}"></script>

  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main2.css')}"/>
<script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main2.js')}"></script>

  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main3.css')}"/>
<script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main3.js')}"></script>


  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main6.css')}"/>
  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main6.js')}"></script>



  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main4.css')}"/>

  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main4.js')}"></script>



  <script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      isRTL: false,
    //  locale: 'ar',
      plugins: ['bootstrap', 'interaction', 'dayGrid', 'timeGrid', 'list' ],

        height: 'parent',
      fixedWeekCount: false,
      // shouldRedistribute: true,
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,dayGridWeek,timeGridDay'
      },
      views: {
        dayGridMonth: {
          buttonText: 'Month',
          columnHead: true
        },timeGridWeek: {
          buttonText: 'Week (grid)',
          columnHead: true
        },dayGridWeek: {
          buttonText: 'Week (list)',
          columnHead: true
        }
//        ,listWeek: {
//          buttonText: 'Week (list)',
//          columnHead: true
//        }
        ,timeGridDay: {
          buttonText: 'Day',
          columnHead: true
        }
//        ,
//        basicDay: {
//          buttonText: 'basicDay',
//          columnHead: false

      },
      defaultView: 'dayGridMonth',
        allDaySlot: true,
        nowIndicator: true,
        timeGridEventMinHeight: true,


        // defaultDate: '2019-06-12',
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: false, // allow "more" link when too many events
      firstDay: 1,
      themeSystem: 'standard',
      // eventOrder: 'start,-duration,allDay,title',
      eventOrder: 'start,-duration,allDay,title',
      timeFormat: 'HH(:mm)', // uppercase H for 24-hour clock
       // columnHeaderFormat:// like 'Mon 9/7', for week views
           //{ weekday: 'short', week: 'numeric', month: 'short', day: 'numeric', omitCommas: true },
       columnHeaderText: function(date) {
          // if (date.getDay() === 5) {
          //     return 'Friday!';
          // } else {
              return moment(date).format('ddd D');
          // }
      },
         // month:'dd', // Mon
        // week:'ddd.dd' // Mon 19.07
        // day:''  // Monday 19.07
      // },
      // lazyFetching: true,
      // firstHour: 5,
      // minTime: 5,
      minTime: '05:00',
      slotDuration: '00:30',
      // showNonCurrentDates: false,
      // dayCount: 31,
      weekNumbers: true,
      weekNumbersWithinDays: true,
      weekNumberCalculation: 'ISO',
      events:"/nibras/export/allCalendarEvents",
      selectable: true,
      selectHelper: true,

      select: function (arg) {

        var title = prompt('Event title or command (e.g. p -- title):');

        var eventData;

        if (title) {
          eventData = {
            title: title,
            start: arg.start,
            end: arg.end
          };
          jQuery('#logArea').html(title);
          jQuery('#logArea2').load('/nibras/operation/addFromCalendar', {
            title: title,
            start: moment(arg.start).format('DD.MM.YYYY HH:mm'),//arg.start.getDate() + '.' + arg.start.getMonth() + '.'+ (parseInt(arg.start.getYear()) + 1900),
            end: moment(arg.end).format('DD.MM.YYYY HH:mm')//,//arg.start.getDate() + '.' + arg.start.getMonth() + '.'+ (parseInt(arg.start.getYear()) + 1900),
            // end: arg.end.getDate() + '.' + arg.end.getMonth() + '.'+ (parseInt(arg.end.getYear()) + 1900)
          }, function (responce) {
            eventData.title = responce;
            // renderEvent(eventData, true); // stick? = true
            // renderEvent(arg.jsEvent, true); // stick? = true
            // calendar.addEvent(arg.jsEvent); // stick? = true
              calendar.addEvent({
                  title: title,
                  description: '...',
                  start: arg.start,
                  end: arg.end,
                  allDay: false
              });
          });
        }
        calendar.unselect();
      },

        eventClick: function(info) {
            info.jsEvent.preventDefault(); // don't let the browser navigate

            if (info.event.url) {
                window.open(info.event.url, '_default');
            }
        },
      eventRender: function(info) {
        // var tooltip = new Tooltip(info.el, {
        //  $(info.el).tooltip(info.event.extendedProps.description);
        // $(info.el).title(info.event.extendedProps.description)
       //   console.log('here   ... ' + info.event.extendedProps.description)
          // title: info.event.extendedProps.description,
          // placement: 'top',
          // trigger: 'hover',
          // container: 'body'
        // });
      //  $(info.el).attr('title', info.event.extendedProps.description);

       // $(info.element).tooltip(event.description);

        ///$(element).title = "2344"//event.description;
      //  console.log('here   ... ' + event.title)
           $(info.el).qtip({
                     content: {text: info.event.extendedProps.description.split('|')[1], title: info.event.extendedProps.description.split('|')[0]},
               style: 'qtip-light qtip-bootstrap qtip-blue',
               width: 200,
               position: {
                 my: 'center',
                 at: 'center',
                 target: jQuery('#calendar')
               }
           })

      },
      // eventRender: function (event, element) {
      //   element.qtip({
      //     content: {text: event.description, title: event.title},
      //     style: 'qtip-light qtip-bootstrap qtip-blue',
      //     width: 200,
      //     position: {
      //       my: 'center',
      //       at: 'center',
      //       target: jQuery('#calendar')
      //     }
      //   })
      // },

      loading: function (bool) {
        if (bool) jQuery('#loading').show();
        else jQuery('#loading').hide();
      }


    });

    calendar.render();
  });

</script>
<style>

  html, body {
    /*overflow: auto; !* don't do scrollbars *!*/
    font-family: tahoma, Helvetica Neue, Helvetica, sans-serif;
    font-size: 13px;
    text-align: right;

  }
  td{
    direction: rtl;
    text-align: right;
  }

  #calendar-container {
    position: fixed;
    top: 1px;
    left: 5px;
    right: 5px;
    bottom: 5px;
  }

  .fc-header-toolbar {
    /*
    the calendar will be butting up against the edges,
    but let's scoot in the header's buttons
    */
  padding-top: 0.5em;
    padding-left: 2em;
    padding-right: 2em;
  }

  /*.hover-end{padding:0;margin:0;font-size:75%;text-align:center;position:absolute;bottom:0;width:100%;opacity:.8}*/

</style>
</head>
<body>

<div id="logArea" style="background: lightgoldenrodyellow; font-size: 14px;">
</div>

<div id="logArea2" style="display: none">
</div>

<div class="body">

</div>

  <div id="calendar-container" style="margin: 10px; text-align: right;">
    <div id='calendar' ></div>
  </div>



</body></html>