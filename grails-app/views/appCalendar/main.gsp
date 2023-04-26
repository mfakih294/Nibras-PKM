<%@ page import="mcs.Task; mcs.Goal; ker.OperationController; java.time.temporal.ChronoUnit; mcs.parameters.JournalType; mcs.Journal; mcs.Planner; mcs.parameters.PlannerType" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
  <title style="direction: ltr; text-align: left;">

%{--      ${ker.OperationController.getPath('app.name') ? OperationController.getPath('app.name') + ' /Calendar': 'Nibras PKM /Calendar'}--}%
  Calendar
  </title>

  <link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'calendar.ico')}" type="image/ico"/>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen.css')}"/>


  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jqueryui-editable.min.js')}"></script>


  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'jquery.qtip.css')}"/>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'jquery.modal.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'chosen.jquery.min.js')}"></script>

  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.modal.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.qtip.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'moment.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'simpleSlider.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'am2_SimpleSlider.js')}"></script>

%{--  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main5.js')}"></script>--}%
%{--  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main1.js')}"></script>--}%
%{--  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main1.css')}"/>--}%
%{--<script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main1.js')}"></script>--}%
%{-- <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main2.css')}"/>--}%
%{--<script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main2.js')}"></script>--}%
%{--  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main3.css')}"/>--}%
%{--<script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main3.js')}"></script>--}%


%{--  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main6.css')}"/>--}%
%{--  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main6.js')}"></script>--}%



%{--  <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar', file: 'main4.css')}"/>--}%

%{--  <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar', file: 'main4.js')}"></script>--}%

    <link rel="stylesheet" href="${resource(dir: 'layout', file: 'layout-default.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'layout', file: 'jquery.layout_and_plugins.js')}"></script>



    <script type="text/javascript" src="${resource(dir: 'uikit-min/js', file: 'uikit.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'uikit-min/js', file: 'uikit-icons.js')}"></script>
    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-ui-1.7.2.custom.min.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'chosen.jquery.min-new.js')}"></script>--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen1.8.7.css')}"/>--}%


    <link rel="stylesheet" href="${resource(dir: 'uikit-min/css', file: 'uikit.css') }"/>





    <script type="text/javascript" src="${resource(dir: 'plugins/fullcalendar/560', file: 'main.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'plugins/fullcalendar/560', file: 'main.css')}"/>

    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'main-calendar.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'personalization.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'mybindings.js')}"></script>


    <script>


        (function ($) {
            var _ = $.layout;

// make sure the callbacks branch exists
            if (!_.callbacks) _.callbacks = {};

            _.callbacks.resizePaneAccordions = function (x, ui) {
                // may be called EITHER from layout-pane.onresize OR tabs.show
                var $P = ui.jquery ? ui : $(ui.newPanel || ui.panel);
                // find all VISIBLE accordions inside this pane and resize them
                $P.find(".ui-accordion:visible").each(function () {
                    var $E = $(this);
                    if ($E.data("accordion"))		// jQuery < 1.9
                        $E.accordion("resize");
                    if ($E.data("ui-accordion"))	// jQuery >= 1.9
                        $E.accordion("refresh");
                });
            };
        })(jQuery);



        $(document).ready(function () {

            // this layout could be created with NO OPTIONS - but showing some here just as a sample...
            // myLayout = $('body').layout(); -- syntax with No Options

            myLayout = $('body').layout({

                //	reference only - these options are NOT required because 'true' is the default
                closable: true	// pane can open & close
                , resizable: true	// when open, pane can be resized
                , slidable: true	// when closed, pane can 'slide' open over other panes - closes on mouse-out
                , livePaneResizing: true
                , onresize: $.layout.callbacks.resizePaneAccordions
                //	some resizing/toggling settings
                , north__slidable: true	// OVERRIDE the pane-default of 'slidable=true'
//                , north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
                , north__spacing_closed: 20		// big resizer-bar when open (zero height)
//		,	north__size:				50
                , south__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , west__spacing_open: 0		// no resizer-bar when open (zero height)
                , west__spacing_closed: 25		// big resizer-bar when open (zero height)
                , south__spacing_closed: 0		// big resizer-bar when open (zero height)
                , east__spacing_closed: 0		// big resizer-bar when open (zero height)
                , south__initClosed: true
                , west__initClosed: true
                , east__initClosed: true
                //	some pane-size settings
                , west__minSize: 350
                , west__size: 350


                , east__size: 350
//					, west__togglerContent_closed: '<<'

                , east__minSize: 350
                , east__maxSize: .5 // 50% of layout width
                , west__maxSize: .5 // 50% of layout width
                , center__minWidth: 100

                //	some pane animation settings
                , west__fxName_close: "none"	// NO animation when closing west-pane
                , west__fxName_open: "none"	// NO animation when closing west-pane
                /*
                 ,	west__animatePaneSizing:	false
                 ,	west__fxSpeed_size:			"fast"	// 'fast' animation when resizing west-pane
                 ,	west__fxSpeed_open:			1000	// 1-second animation when opening west-pane
                 ,	west__fxSettings_open:		{ easing: "easeOutBounce" } // 'bounce' effect when opening
                 ,	west__fxName_close:			"none"	// NO animation when closing west-pane
                 */


                //	enable showOverflow on west-pane so CSS popups will overlap north pane
                , west__showOverflowOnHover: true

                //	enable state management
                , stateManagement__enabled: false // automatic cookie load & save enabled by default

                , showDebugMessages: false// log and/or display messages from debugging & testing code
            });

        });


            var calendar
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    calendar = new FullCalendar.Calendar(calendarEl, {
      direction: 'ltr',
    //  locale: 'ar',
    //  plugins: ['bootstrap', 'interaction', 'dayGrid', 'timeGrid', 'list'],
      //  aspectRatio: 1,
     //   contentHeight: 800,
    //    height: 'auto',
        contentHeight:"auto",
        handleWindowResize:true,
   //     themeSystem:'bootstrap3',
   //   fixedWeekCount: false,
       shouldRedistribute: true,
        headerToolbar : {
        left: 'prev next today slotDuration15,slotDuration30,slotDuration60',
        center: 'title',
//        right: 'dayGrid,timeGridWeek,dayGridWeek,timeGridDay,dayGridMonth,agenda'
        right: 'timeGridDay,agenda,dayGrid,timeGridWeek,dayGridMonth'
            // listWeek
      },

        customButtons: {
            slotDuration15: {
                text: '15 min',
                click: function() {
                    calendar.setOption('slotDuration', '00:15:00')
                }
            },
            slotDuration30: {
                text: '30 min',
                click: function() {
                    calendar.setOption('slotDuration', '00:30:00')
                }
            },
            slotDuration60: {
                text: '1 hour',
                click: function() {
                    calendar.setOption('slotDuration', '00:60:00')
                }
            }

        },

        buttonText: { today: 'Today', prev: '<- P', next: 'N ->'},
      views: {
        dayGridMonth: {
          buttonText: 'Month',
          columnHead: true
        },
          timeGridWeek: {
          buttonText: 'Week',
          columnHead: true
        },
//          dayGridWeek: {
//          buttonText: '7 days',
//          columnHead: true
//        }
//        ,listWeek: {
//          buttonText: 'Week (list)',
//          columnHead: true
//        }
        timeGridDay: {
          buttonText: 'Day',
          columnHead: true
        },
          dayGrid: {
          buttonText: 'Agenda',
          columnHead: true,
          visibleRange: function(currentDate) {
                  // Generate a new date for manipulating in the next step
                  var startDate = new Date(currentDate.valueOf());
                  var endDate = new Date(currentDate.valueOf());

                  // Adjust the start & end dates, respectively
                  startDate.setDate(startDate.getDate() - 1); // One day in the past
                  endDate.setDate(endDate.getDate() + 1); // Three days into the future

                  return { start: startDate, end: endDate }
              }
          },

          agenda: {
          buttonText: '3 Days', // (reloadable)
              type: 'timeGrid',
//              duration: { days: 4 },
          columnHead: true,
          visibleRange: function(currentDate) {
                  // Generate a new date for manipulating in the next step
                  var startDate = new Date(currentDate.valueOf());
                  var endDate = new Date(currentDate.valueOf());

                  // Adjust the start & end dates, respectively
                  startDate.setDate(startDate.getDate() - 1); // One day in the past
                  endDate.setDate(endDate.getDate() + 1); // Three days into the future

                  return { start: startDate, end: endDate }
              }
          }
          //,
//          listWeek: {
//          buttonText: 'Week Column',
//          columnHead: true
//          }
//        ,
//        basicDay: {
//          buttonText: 'basicDay',
//          columnHead: false
      },


        initialView : 'timeGridWeek',
      allDaySlot: true,
      nowIndicator: true,
        stickyHeaderDates: true,
      timeGridEventMinHeight: true,
        slotLabelFormat: {
            hour: 'numeric',
            minute: '2-digit',
            omitZeroMinute: true,
            meridiem: 'short'
        },

        // defaultDate: '2019-06-12',
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      dayMaxEventRows: false, // allow "more" link when too many events
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
       firstHour: '05:00',
      // minTime: 5,
      slotMinTime: '05:00',
      slotDuration: "${OperationController.getPath('calendar.options.slotDuration') ?: '00:60'}",
      // showNonCurrentDates: false,
      // dayCount: 31,
      weekNumbers: true,
      // weekNumbersWithinDays: false,
      weekNumberCalculation: 'ISO',
      events:"${request.contextPath}/export/allCalendarEvents",
      selectable: true,
      selectHelper: true,



      select: function (arg) {

//          var title = window.prompt('Event title or command (e.g. p -- title):');

          var modal = jQuery('#login-form').modal();
          $('#login-form').on($.modal.AFTER_CLOSE, function(event, modal) {
//              window.location.href = window.location;
              calendar.refetchEvents()

          });

//
          jQuery('#title').val('');
          jQuery('#description').val('');
          jQuery('#title').focus();
          jQuery('#title').select();
          jQuery('#start').val(moment(arg.start).format('DD.MM.YYYY HH:mm'));
          jQuery('#end').val(moment(arg.end).format('DD.MM.YYYY HH:mm'));
//          jQuery('#newEventModalField').val(arg.start + ' ' + arg.end);
//          var title =
//          console.log('title ' + title)

        var eventData;

        if (title && 1 == 2) {
          eventData = {
            title: title,
            start: moment(arg.start).format('DD.MM.YYYY HH:mm'),
            end: arg.end
          };
          jQuery('#logArea').html(title);
          jQuery('#logArea2').load('${request.contextPath}/operation/addNewFromCalendar', {
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
        eventDrop: function(info){
//                    alert(info.event.title + ' - ' + info.event.id + ' drop : ' + info.event.start);


            jQuery('#logArea').load('${request.contextPath}/operation/rescheduleEvent',

                    {title: info.event.id, entityCode: info.event.url.split('=')[1],
                        //start: event.start.format('DD.MM.YYYY hh:mm'),
                        //end: event.end.format('DD.MM.YYYY hh:mm'),
                        newStartTime: moment(info.event.start).format('DD.MM.YYYY HH:mm')},
                    function(responce) {

                    })
        },
        eventResize: function(info) {
//                    alert(info.event.title + " end is now " + info.event.end.toISOString());

            jQuery('#logArea').load('${request.contextPath}/operation/resizeEvent',
                  {title: info.event.id,
                      end: moment(info.event.end).format('DD.MM.YYYY HH:mm')},
                  function(responce) {
                  })
//                    if (!confirm("is this okay?")) {
//                        info.revert();
//                    }
      },

      eventDidMount : function(info) {
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

                     content: {text: info.event.extendedProps.description.split('|')[1], title: moment(info.event.start).format('HH:mm') + (info.event.end ? '-' + moment(info.event.end).format('HH:mm'): '') + ' ' + info.event.extendedProps.description.split('|')[0]},
               style: 'qtip-light qtip-bootstrap qtip-blue',
               hide: {fixed: true, distance: 15},
               width: 200,
               position: {
//                 my: 'center',
//                 at: 'center',
                   target: 'mouse'
//                 target: jQuery('#calendar')
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



      $.fn.editable.defaults.mode = 'inline';
      $.fn.editable.defaults.showbuttons = false;




      setInterval(function() {

      jQuery.ajax({
          type: 'GET',
          url: '${request.contextPath}/page/heartbeat',
          dataType: 'html',
          success: function(html, textStatus) {
              // console.log('here' + jQuery('#calendar').fullCalendar.view);
              // console.log('here2' + calendarEl.view.title);


              if (html == 'ok============' && calendar.view.type == 'agenda') {
                  window.location.href = window.location;
                  jQuery('#logArea2').html("<span style='background: darkgray; color: darkgreen'>Online</span>");
              }
          },
          error: function(xhr, textStatus, errorThrown) {
              jQuery('#logArea2').html("<span style='background: darkgray; color: darkred'>Offline</span>");
//                        console.log('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
          }
      });
  }, ${ker.OperationController.getPath('calendar.reload.interval').toInteger()});


 var clearFormFields = function () {

        jQuery('#goal').val('')
        jQuery('#department').val('')
        jQuery('#task').val('')
        jQuery('#title').val('')
        jQuery('#description').val('')
    }


  </script>
<style>

  html, body {
    /*overflow: auto; !* don't do scrollbars *!*/
    font-family: tahoma, Helvetica Neue, Helvetica, sans-serif;
    font-size: 12px;
    /*text-align: right;*/
      background: #ffffea;

  }
  td{
    /*direction: rtl;*/
    text-align: right;
  }
 .dashboard table{
    /*direction: rtl;*/
    border: 0px lightgrey !important;
    text-align: right;
  }

  .dashboard td{
    /*direction: rtl;*/
      font-size: small !important;
    border: 1px lightgrey !important;
    text-align: right;
  }  .dashboard td ol li{
    /*direction: rtl;*/
      font-size: small !important;
    border: 1px lightgrey !important;
    text-align: right;
  }
.dashboard ol{
    /*direction: rtl;*/
    margin: 2px;
    text-align: right;
    padding: 2px;
  }

  .dashboard h3{
    /*direction: rtl;*/
    margin: 3px !important;
    text-align: right;
    padding: 2px !important;
  }

  #calendar-container {
    /*position: fixed;*/
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
  .fc-content{
      direction: rtl !important;
  }

  .completed  div span {
      /*text-line-through: single;*/
      text-decoration: line-through;
  }

  .fc-time {
      font-size: large;
  }
  .fc .fc-timegrid .fc-daygrid-body {
      z-index: 1 !important;
  }
  /*.prompt  {*/
      /*width: 500px;*/
      /*height: 200px;*/
      /*background: black;*/
      /*color: #FFA500;*/
  /*}*/

  /*.hover-end{padding:0;margin:0;font-size:75%;text-align:center;position:absolute;bottom:0;width:100%;opacity:.8}*/

</style>
</head>
<body>

<div class="ui-layout-north" onmouseover="myLayout.allowOverflow('north')" onmouseout="myLayout.resetOverflow(this)">

    %{--<g:render template="/appMain/north"/>--}%

    <g:if test="${ker.OperationController.getPath('hijriDate.enabled')?.toLowerCase() == 'yes' ? true : false}">




        <div style="direction: rtl; text-align: center;">



            %{--   <g:set var="aya1"--}%
            %{--                               value="${app.IndexCard.executeQuery('from IndexCard i where i.priority >= ? and i.type.code = ? and length(i.summary) < 800', [4, 'aya'], [offset: random - 1])[0]}"/>--}%
            <g:set var="aya2"
                   value="${app.IndexCard.executeQuery('from IndexCard i where i.priority >= ? and i.type.code = ? and length(i.summary) > 80 and length(i.summary) < 800', [4, 'aya'], [offset: random])[0]}"/>
            %{--    <g:set var="aya3"--}%
            %{--                               value="${app.IndexCard.executeQuery('from IndexCard i where i.priority >= ? and i.type.code = ? and length(i.summary) < 800', [4, 'aya'], [offset: random + 1])[0]}"/>--}%
            <div style="font-family: 'verdana tahoma'; font-size: large; margin-bottom: 10px; line-height: 29px;">
                بسم الله الرحمن الرحيم
                %{--                        ${aya1.shortDescription}--}%
                %{--   (${aya1.orderInWriting})--}%

                {${aya2?.shortDescription}}
                (${mcs.Writing.get(aya2.recordId)?.summary} ${aya2?.orderInWriting})
                %{--              ${aya3.shortDescription}--}%
                %{--              (${aya3.orderInWriting})--}%



            </div>

            <div class="prayersBlock">
                <g:each in="${prayersText.split('\n')}" var='l'>
                    <span style="margin-left: 15px; margin-top: 15px;">
                        <b>${raw(l)?.split(': ')[0]}</b>:
                    ${raw(l)?.split(': ')[1]}
                    </span>


                </g:each>

                ${persianDateToday}



            </div>






            %{--<b>--}%
            %{--<b>${((java.time.chrono.HijrahDate.now().plus(ker.OperationController.getPath('hijri.adjustment') ? ker.OperationController.getPath('hijri.adjustment').toInteger(): 0, java.time.temporal.ChronoUnit.DAYS))).format(java.time.format.DateTimeFormatter.ofPattern("dd MMMM").withLocale(Locale.forLanguageTag('ar')))}</b>:--}%
            %{--                            &nbsp;&nbsp; ${new Date().format("E dd HH:mm")}: &nbsp;--}%
            %{--</b>--}%
            %{--&nbsp;--}%

            %{--          <g:set var="aya"--}%
            %{--                 value="${app.IndexCard.executeQuery('from IndexCard i where i.priority >= ? and i.type.code = ? and length(i.summary) < 80', [4, 'aya'], [offset: Math.floor(Math.random()*100)])[0]}"/>--}%
            %{--          {--}%
            %{--          ${aya.shortDescription}--}%
            %{--          }--}%
            %{--          (${mcs.Writing.get(aya.recordId)?.summary}--}%
            %{--          ${aya.orderInWriting})--}%
            %{--      --}%

                         %{--Slot duration:--}%


        </div>
    </g:if>


</div>

<!-- allowOverflow auto-attached by option: west__showOverflowOnHover = true -->
<div class="ui-layout-west">

    <g:render template="/appCalendar/west"/>

</div>

<div class="ui-layout-south southRegion">

    %{--<g:render template="/appMain/south" model="[ips: ips]"/>--}%

</div>

<div class="ui-layout-east" >


    %{--<g:render template="/appMain/east"/>--}%

</div>

<div class="ui-layout-center" style="background: #f6f9f1;">


<div id="logArea" style="background: lightgoldenrodyellow; font-size: 14px;">
</div>

<div id="logArea2" style="">

</div>

<div class="body">

</div>
%{--<table border="0" style="border: 0px;">--}%
    %{--<tr>--}%
        %{--<td style="vertical-align: top; width: 70%;">--}%
            <div id="calendar-container" style="margin: 20px; text-align: left; height: 95vh">




            %{--<br/>--}%
                <div id='calendar'></div>
    <br/>
    <br/>
    %{--<h4>Calendar slot duration: </h4>--}%

    %{--<ul class="uk-subnav uk-subnav-pill" uk-switcher="animation: uk-animation-fade">--}%
        %{--<li>--}%
            %{--<a onclick="calendar.setOption('slotDuration', '00:30:00')" href="#">30 min</a>--}%
        %{--</li>--}%
        %{--<li>--}%
            %{--<a onclick="calendar.setOption('slotDuration', '00:15:00')" href="#">15 min</a>--}%
        %{--</li>--}%
        %{--<li>--}%
            %{--<a onclick="calendar.setOption('slotDuration', '00:60:00')" href="#">1 hour</a>--}%
        %{--</li>--}%
    %{--</ul>--}%

    <br/>



<b>Note:</b>
    <div class="uk-info">
    To edit the default slot duration, modify the setting "calendar.options.slotDuration" from the main screen, by entering the command: "f y -- calendar.options.slotDuration".
    </div>

    <br/>
    <br/>
    <br/>
    <br/>



            </div>
        %{--</td>--}%
        %{--<td style="vertical-align: top; ">--}%
        %{--</td>--}%
    %{--</tr>--}%
%{--</table>--}%


<div id="login-form" class="modal" style="z-index:1000; height: 500px; width: 600px; border: 1px solid darkgray; margin: 5px; padding: 15px !important;">
    %{--Event title or command (e.g. p -- title):--}%
    %{--<br/>--}%
    %{--<br/>--}%
    <g:formRemote name="batchAdd2" class="commandBarInPanel"
                  url="[controller: 'operation', action: 'addFromCalendar']"
                  update="logAreaModal"
                  onComplete="clearFormFields();"
                  method="post">
          <table border="0" style="width: 90%; text-align: center;">
              <tr>
                  <td style="text-align: left; margin: 3px; direction: ltr">Type:
                      <br/>
                      <g:select name="type" from="${['J', 'P']}" id="typeField" value="${session['lastCalendarEntryType'] ?: 'P'}"/>
                  </td>
                  <td style="text-align: left; margin: 3px; direction: ltr"> Start time:
                      <br/><g:textField name="start" value="" id="start" style="width: 120px"></g:textField></td>
                  <td style="text-align: left; direction: ltr; margin: 3px;">End time:
                      <br/>
                      <g:textField name="end" value="" id="end"  style="width: 120px"></g:textField></td>

              </tr>
          </table>

        <div style="float: left">
        Goal:
        <br/>
        <g:select name="goal" from="${mcs.Goal.findAllByBookmarked(true, [sort: 'summary', order: 'asc'])}" id="goal"
                  optionKey="id" optionValue="summary"
            style="width: 99% !important; direction: rtl; text-align: right;"
                  noSelection="${['null': '']}" value=""/>
        </div>
        <div style="float: left">
        Department:
        <br/>
        <g:select name="department" from="${mcs.Department.findAll([sort: 'code', order: 'asc'])}" id="department"
                  optionKey="id" optionValue="code"
            style="width: 99% !important; direction: ltr; text-align: left;"
                  noSelection="${['null': '']}" value=""/>
        </div>
        <div style="float: right">
        Task:
        <br/>
        <g:select name="task" from="${mcs.Task.findAllByBookmarked(true, [sort: 'summary', order: 'asc'])}" id="task"
                  optionKey="id" optionValue="summary"
                  style="width: 99%  !important; direction: rtl; text-align: right;"
                  noSelection="${['null': '']}" value=""/>
</div>
        <div style="clear: both;"/>
        Summary or Nibras command*:
        <br/>
        <g:textField name="title" value="" id="title"
                     style=" text-align: start  !important; unicode-bidi: plaintext !important; display: inline;  font-family: tahoma ; width: 95% !important;"
                     placeholder=""
                     class="commandBarTexFieldTop"/>
                  <br/>
                Description:
       <g:textArea name="description" value="" id="description" rows="5" columns="80"
                    placeholder=""
                     style="width: 95% !important; height: 100px; text-align: start  !important; unicode-bidi: plaintext !important;  display: inline;  font-family: tahoma ; "
                     class="commandBarTexFieldTop"/>
                  <br/>
                  <br/>
        <g:submitButton name="batch" value="Save"
                        style="height: 32px  !important; margin: 3px; width: 30% !important;"
                        id="quickAddXcdSubmitTop3"
                        class="fg-button ui-widget ui-state-default"/>
    </g:formRemote>
    <br/>
    <br/>
    <div id="logAreaModal"></div>
              <br/>
              <br/>

    </div>
<g:if test="${1==2}">
<table class="dashboard" style="width: 90%; margin: 0 4%; position: absolute; bottom: 5px;" border="0">
    <tr>
        <td colspan="3">
            <div style="text-align: center !important;">
                ${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('fcs'), true, [sort: 'startDate', order: 'desc', max: 1])[0].summary}
                ${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('fcs'), true, [sort: 'startDate', order: 'desc', max: 1])[0].description}
            </div>  
        </td>
    </tr>
    
    <tr>
        <td style="width: 33%">


            <h3>
                %{--                    مواقيت الصلاة--}%
                C *
            </h3>


            <ol style="direction: rtl; text-align: right;">
                <g:each in="${mcs.Course.findAllByBookmarked(true, [sort: 'department', order: 'desc'])}" var="j">
                    <li>
                        [${j.code}]
                        ${j.summary}
                    </li>

                </g:each>
            </ol>

            <h3>
                G* p4
            </h3>

            <ol style="direction: rtl; text-align: right; line-height: 12px;">
                <g:each in="${mcs.Goal.findAllByBookmarkedAndPriorityGreaterThan(true, 3, [sort: 'department', order: 'desc'])}" var="j">
                    <li>
                        [${j.course?.code}]
                        <i>${j.summary}</i>
                        %{--                                <pkm:prettyDuration date1="${j.endDate ?: j.startDate}"/>--}%
                    </li>

                </g:each>
            </ol>

        </td>
        <td style="width: 33%">

            <h3>
                T* p4
            </h3>


            <ol style="direction: rtl; text-align: right; ">
                <g:each in="${mcs.Task.findAllByBookmarkedAndPriorityGreaterThan(true, 3, [sort: 'summary', order: 'desc'])}" var="j">
                    <li>
                        %{--                                <u>${j.endDate?.format('dd.MM')}:</u>--}%
                        [${j.course?.code}]
                        ${j.summary}
                    </li>

                </g:each>
            </ol>


            <h3>

                R* p4
            </h3>

            <ol style="direction: rtl; text-align: right; ">
                <g:each in="${mcs.Book.findAllByBookmarkedAndPriorityGreaterThan(true, 3, [sort: 'department', order: 'desc', max: 5])}" var="j">
                    <li>
                        [${j.course?.code}]
                        ${j.title}
                    </li>

                </g:each>
            </ol>
            
        </td>
        <td style="width: 33%">

            <h3>mls</h3>

            <ol style="direction: rtl; text-align: right; ">
                <g:each in="${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('milestone'), true, [sort: 'startDate', order: 'desc'])}" var="j">
                    <li>
                        <pkm:prettyDuration date1="${j.endDate ?: j.startDate}"/>:
                        ${j.summary}

                    </li>

                </g:each>
            </ol>

            <h3>plc</h3>


            <ol style="direction: rtl; text-align: right; ">
                <g:each
                        in="${Planner.findAllByTypeAndBookmarked(PlannerType.findByCode('policy'), true, [sort: 'startDate', order: 'desc', max: 1])}" var="j">
                    <li>
                        <i>${j.summary}</i>:<br/>
                        <i>${j.description?.replace('\n', '<br/>')}</i>
                    </li>

                </g:each>
            </ol>
            
            
        </td>
    </tr>

</table>
</g:if>
</div>

</body>

<script>
    jQuery(".chosen").chosen({allow_single_deselect: true, search_contains: true, no_results_text: "None found"});
</script>
</html>