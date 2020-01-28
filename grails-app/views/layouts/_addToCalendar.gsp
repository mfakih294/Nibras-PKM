<link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.achtung-min.js')}"></script>

%{--<script type="text/javascript">--}%
    %{--jQuery.achtung({message: '${message}', timeout: 5});--}%
%{--</script>--}%

<script type="text/javascript">
//  var myCalendar = jQuery('#calendar');
  var myCalendar = document.getElementById('calendar');

  var calendar = FullCalendar.Calendar(myCalendar)

//  myCalendar.fullCalendar();
  var myEvent = {
    title:"my new event",
    allDay: true,
    start: new Date(),
    end: new Date()
  };
//jQuery('#calendar').fullCalendar('renderEvent', myEvent);
//  calendar.fullCalendar( 'renderEvent', myEvent);
calendar.addEvent(myEvent)
</script>