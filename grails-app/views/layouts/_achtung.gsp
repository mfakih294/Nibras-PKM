<link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.achtung-min.js')}"></script>

%{--<script type="text/javascript">--}%
    %{--jQuery.achtung({message: '${message}', timeout: 5});--}%
%{--</script>--}%

<script type="text/javascript">
  var notice = '<div class="notice">'
+ '<div class="notice-body">'
//+ '<img src="../static/images/icons/info.png"/>'
//+ '<h3></h3>'
+ '<p>${message}</p>'
+ '</div>'
+ '<div class="notice-bottom">'
+ '</div>'
+ '</div>';
  // jQuery(notice).purr(
  //         {
  //             fadeInSpeed: 100,
  //             fadeOutSpeed: 1000,
  //             removeTimer: 1000
  //         }
  // );

  jQuery.achtung({message: "${message}", timeout: 3,
    animateClassSwitch: true,
    showEffectDuration: 1000,
    hideEffectDuration: 3000});



</script>