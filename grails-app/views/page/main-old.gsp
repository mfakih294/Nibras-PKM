%{--
  - Copyright (c) 2018. Mohamad F. Fakih (mail@khuta.org)
  -
  - This program is free software: you can redistribute it and/or modify
  - it under the terms of the GNU General Public License as published by
  - the Free Software Foundation, either version 3 of the License, or
  - (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  - GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License
  - along with this program.  If not, see <http://www.gnu.org/licenses/>
  --}%

<%@ page import="ker.OperationController; cmn.Setting" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
%{--<meta name="layout" content="main"/>--}%

<title>${OperationController.getPath('app.name') ?: 'Pomegranate PKM'} v<g:meta name="app.version"/></title>


<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon-32px.png')}" type="image/png"/>




<link rel="stylesheet" href="${resource(dir: 'css', file: 'uploader.css')}"/>


<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'personalization.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.autocomplete.css')}"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'prettyPhoto.css')}"/>



<link rel="stylesheet" href="${resource(dir: 'css', file: 'fg.menu.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'layout-mine.css')}"/>

%{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'ui.achtung-min.js')}"></script>--}%
%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.achtung-min.css')}"/>--}%



%{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.autocomplete.min.js')}"></script>--}%

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.9.2.custom.min.js')}"></script>



%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'fileuploader.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.flipcountdown.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>



<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.layout-latest_min.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.purr.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'fg.menu.js')}"></script>

%{--<link rel="stylesheet" href="${resource(dir: 'css/minimal', file: 'minimal.css')}"/>--}%
%{--<link rel="stylesheet" href="${resource(dir: 'css/minimal', file: 'grey.css')}"/>--}%
<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.continuousCalendar.css')}"/>


%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'icheck.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.continuousCalendar-latest.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.prettyPhoto.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'raphael-min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'morris.js')}"></script>


%{--<r:layoutResources/>--}%

%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>--}%


<script type="text/javascript">



    function toggleLiveResizing() {
        $.each($.layout.config.borderPanes, function (i, pane) {
            var o = myLayout.options[ pane ];
            o.livePaneResizing = !o.livePaneResizing;
        });
    }
    ;

    function toggleStateManagement(skipAlert, mode) {
        if (!$.layout.plugins.stateManagement) return;

        var options = myLayout.options.stateManagement
                , enabled = options.enabled // current setting
                ;
        if ($.type(mode) === "boolean") {
            if (enabled === mode) return; // already correct
            enabled = options.enabled = mode
        }
        else
            enabled = options.enabled = !enabled; // toggle option

        if (!enabled) { // if disabling state management...
            myLayout.deleteCookie(); // ...clear cookie so will NOT be found on next refresh
            if (!skipAlert)
                alert('This layout will reload as the options specify \nwhen the page is refreshed.');
        }
        else if (!skipAlert)
            alert('This layout will save & restore its last state \nwhen the page is refreshed.');

        // update text on button
//        var $Btn = $('#btnToggleState'), text = $Btn.html();
//        if (enabled)
//            $Btn.html(text.replace(/Enable/i, "Disable"));
//        else
//            $Btn.html(text.replace(/Disable/i, "Enable"));
    };

    // set EVERY 'state' here so will undo ALL layout changes
    // used by the 'Reset State' button: myLayout.loadState( stateResetSettings )
    var stateResetSettings = {
        north__size: "auto",
        north__initClosed: false,
        north__initHidden: false,
        south__size: 20,
        south__initClosed: false,
        south__initHidden: false,
        //west__size: 200,
        west__size: "auto",
        west__initClosed: false,
        west__initHidden: false,
        east__resizable: true,
//        east__size: "auto",
        east__initClosed: false,
        east__initHidden: false
    };

    var myLayout;

    jQuery(document).ready(function () {
        var iiii = 1;
//        $("#retroclockbox1").flipcountdown({
//            size: "xs",
//            showHour:false, showMinute: true, showSecond:   true,
//                    tick: function () {
//                        return iiii++;
//                    }, speedFlip: 10
//        }
//        )


        jQuery('.fg-button').hover(
                function () {
                    jQuery(this).removeClass('ui-state-default').addClass('ui-state-focus');
                },
                function () {
                    jQuery(this).removeClass('ui-state-focus').addClass('ui-state-default');
                }
        );

        var matched, browser;

        jQuery.uaMatch = function (ua) {
            ua = ua.toLowerCase();

            var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
                    /(webkit)[ \/]([\w.]+)/.exec(ua) ||
                    /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
                    /(msie) ([\w.]+)/.exec(ua) ||
                    ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) ||
                    [];

            return {
                browser: match[ 1 ] || "",
                version: match[ 2 ] || "0"
            };
        };

        matched = jQuery.uaMatch(navigator.userAgent);
        browser = {};

        if (matched.browser) {
            browser[ matched.browser ] = true;
            browser.version = matched.version;
        }

// Chrome is Webkit, but Webkit is also Safari.
        if (browser.chrome) {
            browser.webkit = true;
        } else if (browser.webkit) {
            browser.safari = true;
        }

        jQuery.browser = browser;

        // this layout could be created with NO OPTIONS - but showing some here just as a sample...
        // myLayout = jQuery('body').layout(); -- syntax with No Options

//        jQuery('input').iCheck({
//            checkboxClass: 'icheckbox_minimal-grey',
//            radioClass: 'iradio_minimal-grey',
//            increaseArea: '-20%' // optional
//        });

//        jQuery('#searchForm').load('${request.contextPath}/generics/hqlSearchForm/T')

//        jQuery('#quickAddTextField').select();
//        jQuery('#quickAddTextField').focus();

        jQuery('#range_start').val('')
        jQuery('#range_end').val('')

        jQuery("#dateRange1").continuousCalendar({"selectToday": false,
            "weeksBefore": "40",//"1/1/2012",
            "weeksAfter": "8",
            "minimumRange": "-1",
            %{--"disabledDates": "${filledInDates}",--}%
            "disabledDatesMy": "${[]}",
            "fadeOutDuration": "0",
            isPopup: false,
            callback: function () {
                jQuery('#centralArea').load('${createLink(controller: 'report', action: 'saveDateSelection')}?date1=' +
                        jQuery('#range_start').val() + '&date2='
                        + jQuery('#range_end').val())//      + '&level=d')
            }})

        Mousetrap.bindGlobal('esc', function (e) {
            jQuery("html, body").animate({ scrollTop: 0 }, "fast");
            jQuery('#quickAddTextField').focus();
            jQuery('#quickAddTextField').select();
            jQuery('#quickAddTextField').scrollTop(0);
        });

//        Mousetrap.bindGlobal('esc', function (e) {
//
////            jQuery('#centralArea').html('');
////            jQuery('#quickAddTextField').focus();
////            jQuery('#quickAddTextField').select();
//            jQuery('#quickAddRecordTextArea').select().focus();
//
//        });

        Mousetrap.bindGlobal('f6', function (e) {
            jQuery('#centralArea').html('');
            jQuery('#quickAddXcdField').val('');
            jQuery('#quickAddTextField').val('');
            jQuery('#quickAddXcdField').select();
            jQuery('#quickAddXcdField').focus();

        });

   Mousetrap.bindGlobal('f2', function (e) {

            jQuery('#quickAddRecordTextArea').select().focus();

        });

        var collapsed = false;
        Mousetrap.bindGlobal('f9', function (e) {
            if (!collapsed) {
                jQuery('#topRegion').addClass('navHidden');
                jQuery('#navMenu').addClass('navHidden');
                jQuery('#southRegion').addClass('navHidden');
                collapsed = true
            }
            else {
                jQuery('#topRegion').removeClass('navHidden');
                jQuery('#navMenu').removeClass('navHidden');
                jQuery('#southRegion').removeClass('navHidden');
                collapsed = false
            }

        });

        Mousetrap.bind('n', function (e) {
            jQuery('.nextLink').click()
        });

        Mousetrap.bind('ctrl+s', function (e) {
            jQuery('#quickAddRecordSubmit').click()
        });

        Mousetrap.bind('p', function (e) {
            jQuery('.prevLink').click()
        });

        /*
         For modifier keys you can use shift, ctrl, alt, option, meta, and command.

         Other special keys are backspace, tab, enter, return, capslock, esc,
         escape, space, pageup, pagedown, end, home, left, up, right, down, ins, and del.

         Any other key you should be able to reference by name like a, /, $, *, or =.

         */

        jQuery("#quickAddTextField").keypress(function (e) {
            if (e.keyCode == 13 && e.shiftKey) {
                jQuery('#quickAddXcdSubmit').click();
                e.preventDefault();
//                   jQuery('#quickAddTextField').addClass('shiftEnterPressed');
//                   jQuery("#quickAddTextField").fadeOut("fast", function () {
                jQuery('#quickAddTextField').addClass('shiftEnterPressed');
                setTimeout(dosth, 400);
            }
        });
        function dosth() {
            jQuery('#quickAddTextField').removeClass('shiftEnterPressed')
        }

        Mousetrap.bindGlobal('f2', function (e) {
//      jQuery('#quickAddXcdSubmit').click();
            jQuery('#quickAddXcdField').select();
            jQuery('#quickAddXcdField').focus();
        });

        //Todo how to disable formRemote submission
        // document.forms.quickAddForm['submit'].disabled = true;





        jQuery(window).bind('beforeunload', function () {
            return 'Are you sure you want to leave the application?';
        });

        myLayout = jQuery('body').layout({
            center__paneSelector: ".outer-center",
            //	reference only - these options are NOT required because 'true' is the default
            closable: true	// pane can open & close
            , resizable: false	// when open, pane can be resized
            , slidable: true	// when closed, pane can 'slide' open over other panes - closes on mouse-out
            , livePaneResizing: true,
            spacing_closed: 0		// big resizer-bar when open (zero height)

            //	some resizing/toggling settings
            // , north__slidable: false	// OVERRIDE the pane-default of 'slidable=true'
            ,north__closable: false
            , north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
            , north__spacing_closed: 0		// big resizer-bar when open (zero height)
            , north__resizable: true	// OVERRIDE the pane-default of 'resizable=true'
            , south__resizable: true	// OVERRIDE the pane-default of 'resizable=true'
            , south__spacing_open: 0		// no resizer-bar when open (zero height)
            , south__spacing_closed: 0		// big resizer-bar when open (zero height)

            //	some pane-size settings
            , west__minSize: 100, east__minSize: 100, east__maxSize: .5 // 50% of layout width
            , west__size: 230
//            , east__size: 230
            , center__minWidth: 100
                    ,east__resizable: true
                    ,west__resizable: true

            //	some pane animation settings
//            , west__animatePaneSizing: false,
//        west__fxSpeed_size: "fast"	// 'fast' animation when resizing west-pane
//            , west__fxSpeed_open: 1000	// 1-second animation when opening west-pane
//            , west__fxSettings_open: { easing: "easeOutBounce" } // 'bounce' effect when opening
//            , west__fxName_close: "none"	// NO animation when closing west-pane

            //	enable showOverflow on west-pane so CSS popups will overlap north pane
//            , west__showOverflowOnHover: true

            //	enable state management
            , stateManagement__enabled: true // automatic cookie load & save enabled by default

            , showDebugMessages: true // log and/or display messages from debugging & testing code

            , center__childOptions: {
                center__paneSelector: ".middle-center",
//                west__paneSelector: ".middle-west",
//                east__paneSelector: ".middle-east",
//                west__size: 100, east__size: 100,
                spacing_open: 0  // ALL panes
                , spacing_closed: 0 // ALL panes

                // INNER-LAYOUT (child of middle-center-pane)
                , center__childOptions: {
                    center__paneSelector: ".inner-center",
//                    west__paneSelector: ".inner-west",
//                    east__paneSelector: ".inner-east",
                    south__paneSelector: ".inner-southInner",
                    south__resizable: true,
//                    west__size: 75, east__size: 75,
//                    north_size: 'auto',
                    spacing_open: 0  // ALL panes
                    , spacing_closed: 0  // ALL panes
//                    , west__spacing_closed: 12,
//                    east__spacing_closed: 12
                }
            }

        });

        // if there is no state-cookie, then DISABLE state management initially
        var cookieExists = !jQuery.isEmptyObject(myLayout.readCookie());
          if (!cookieExists) toggleStateManagement(true, false);

        jQuery.ajaxSetup({
            beforeSend: function () {
                $('#spinner2').show();
            },
            complete: function () {
                $('#spinner2').hide();
            },
            success: function () {
            }
        });

//    jQuery('#spinner').ajaxStart(function() {
//        jQuery(this).fadeIn();
//        console.log('adfasdfasf')
//    }).ajaxStop(function() {
//                jQuery(this).fadeOut();
//    });




    });

</script>

</head>

<body>



<browser:isIExplorer>
    Browser not supported. Please use Firefox, Chrome, Opera.
</browser:isIExplorer>

<browser:isChrome>
    <g:render template="/page/regions" model="[htmlContent: htmlContent]"/>
</browser:isChrome>

<browser:isFirefox>
    <g:render template="/page/regions" model="[htmlContent: htmlContent]"/>
</browser:isFirefox>

<browser:isOpera>
    <g:render template="/page/regions" model="[htmlContent: htmlContent]"/>
</browser:isOpera>

<browser:isMobile>
    <g:javascript>
    document.location = 'page/mobile'
    </g:javascript>
</browser:isMobile>


</body>
</html>