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
<html xmlns="http://www.w3.org/1999/xhtml" >
%{--xml:lang="ar" lang="ar" dir="rtl"--}%
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    %{--<meta name="layout" content="main"/>--}%


    %{--<b style="color: white">--}%


    <title style="direction: rtl; text-align: right;">

    ${OperationController.getPath('app.name') ?: 'Nibras PKM'}
    <g:meta name="app.version"/>

    </title>


    %{--<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon-transparent.png')}" type="image/png"/>--}%
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'calendar.ico')}" type="image/ico"/>



    <link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.22.custom.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.continuousCalendar.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqueryui-editable.css')}"/>
%{--    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout-mine.css')}"/>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'personalization.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'simpleSlider.css')}"/>

%{--    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uploader.css')}"/>--}%




    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.11.0_min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.4.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'chosen.jquery.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'am2_SimpleSlider.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.address-1.5.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.continuousCalendar-latest.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.layout-latest_min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.purr.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.relatedselects.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.tablednd_0_5.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jqueryui-editable.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'morris.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.idletimeout.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.idletimer.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'mousetrap-global-bind.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.qtip.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'raphael-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'typeahead.bundle.js')}"></script>


%{--    <asset:javascript src="uploadr.manifest.js"/>--}%
%{--    <asset:javascript src="uploadr.demo.manifest.js"/>--}%
%{--    <asset:stylesheet href="uploadr.manifest.css"/>--}%
%{--    <asset:stylesheet href="uploadr.demo.manifest.css"/>--}%


    <script type="text/javascript" src="${resource(dir: 'plugins/uploader', file: 'jquery.tipTip.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'plugins/uploader', file: 'jquery.uploadr.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'plugins/uploader', file: 'jquery.uploadr.css')}"/>



   %{--<r:layoutResources/>--}%

    <script type="text/javascript">

  
        //    $.address.state('${request.contextPath}/')
        $.address.externalChange(function (event) {
            // do something depending on the event.value property, e.g.
            // $('#content').load(event.value + '.xml');
            // console.log('fired ' + event.value)
            //

            // commented 03.07.2019
            // if (event.value != '/')
                //jQuery('#centralArea').load(event.value)
        });

        /**
         *    UI Layout Callback: resizePaneAccordions
         *
         *    This callback is used when a layout-pane contains 1 or more accordions
         *    - whether the accordion a child of the pane or is nested within other elements
         *    Assign this callback to the pane.onresize event:
         *
         *    SAMPLE:
         *    < jQuery UI 1.9: $("#elem").tabs({ show: $.layout.callbacks.resizePaneAccordions });
         *    > jQuery UI 1.9: $("#elem").tabs({ activate: $.layout.callbacks.resizePaneAccordions });
         *    $("body").layout({ center__onresize: $.layout.callbacks.resizePaneAccordions });
         *
         *    Version:    1.2 - 2013-01-12
         *    Author:        Kevin Dalman (kevin.dalman@gmail.com)
         */
        ;
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


        jQuery(document).ready(function () {

         //   for (var i = 0; i < localStorage.length; i++) {
                // do something with localStorage.getItem(localStorage.key(i));
         //       var key = localStorage.key(i)
         //       var value = localStorage[key]


//            console.log('key ' + key + 'value' + value)
//            if ((typeof value == 'string' || value instanceof String) && !value.contains('datum'))
//            if (value.contains('pkm-'))
//            document.getElementById('commandHistory').options.add(new Option(value, localStorage.key(i)))


         //   }




            myLayout = $('body').layout({
                west__size: 300,
                east__size: 380,
                 east__initClosed: true,
                east__togglerContent_closed: '<<',
                // RESIZE Accordion widget when panes resize
                west__onresize: $.layout.callbacks.resizePaneAccordions,
                east__onresize: $.layout.callbacks.resizePaneAccordions,
                onresize: $.layout.callbacks.resizePaneAccordions,
                north__closable: true,
                south__closable: true,
                north__spacing_closed: 5		// big resizer-bar when open (zero height)
                , north__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , south__resizable: false	// OVERRIDE the pane-default of 'resizable=true'
                , east__slidable: true	// OVERRIDE the pane-default of 'resizable=true'
                , north__spacing_open: 5		// no resizer-bar when open (zero height)
                , south__spacing_open: 5		// no resizer-bar when open (zero height)
                , south__spacing_closed: 5		// big resizer-bar when open (zero height)

                , east__spacing_open: 5		// no resizer-bar when open (zero height)
                , east__spacing_closed: 5		// big resizer-bar when open (zero height)
                , west__spacing_open: 5		// no resizer-bar when open (zero height)
                , west__spacing_closed: 15		// big resizer-bar when open (zero height)
//            , west__initClosed: true
                , west__slideTrigger_open: 'click'
                , east__slideTrigger_open: 'mouseover'


            });


            $.fn.editable.defaults.mode = 'inline';
            $.fn.editable.defaults.showbuttons = false;

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
                    browser: match[1] || "",
                    version: match[2] || "0"
                };
            };

            matched = jQuery.uaMatch(navigator.userAgent);
            browser = {};

            if (matched.browser) {
                browser[matched.browser] = true;
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
        jQuery('#tagCloud').load('${request.contextPath}/report/tagCloud')

// jQuery('#centralArea').load('${request.contextPath}/generics/recentRecords')

//        jQuery('#quickAddTextField').select();
//        jQuery('#quickAddTextField').focus();





$("#accordionCenter").accordion({
                heightStyle: "fill",
                header: "h6",
                fillSpace: true,
                event: "click",
                active: 0,
                collapsible: false,
                icons: {
                    header: "ui-icon-circle-arrow-e",
                    headerSelected: "ui-icon-circle-arrow-s"
                }

            });



            jQuery("#accordionWest").accordion({
                heightStyle: "fill",
                fillSpace: true,
                header: "h3",
                event: "click",
                active: ${ker.OperationController.getPath('accordion.west.default.panel')?: '0'},
                collapsible: true,
                icons: {
                    header: "ui-icon-circle-arrow-e",
                    headerSelected: "ui-icon-circle-arrow-s"
                }

            });

/*
            $("#accordionEast").accordion({
                heightStyle: "fill",
                header: "h3",
                fillSpace: true,
                event: "click",
                active: ${ker.OperationController.getPath('accordion.east.default.panel')?: '1'},
                collapsible: true,
                icons: {
                    header: "ui-icon-circle-arrow-e",
                    headerSelected: "ui-icon-circle-arrow-s"
                }
            });
*/


//            setTimeout(function() {
//                window.location.href = window.location;
//            }, 300000);

              /*

            jQuery.idleTimeout('#idletimeout', '#idletimeout a', {
            idleAfter: -1,
            pollingInterval: 2,
            keepAliveURL: '${request.contextPath}/page/heartbeat',
            serverResponseEquals: 'ok',
            onIdle: function () {
                jQuery.ajax({
                    type: 'GET',
                    url: '${request.contextPath}/page/heartbeat',
                    dataType: 'html',
                    success: function(html, textStatus) {
                    jQuery('#onlineLog').html("<span style='background: darkgray; color: darkgreen'>Online</span>");
//                        console.log('resp idle: ' + html)
                        if (html == 'ok')
                        alert('still online '  + html + ' ' + textStatus);
                        else {
//                            confirm('Session lost!')
//                        confirm('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
//                            alert('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
                            alert('now offline '  + html + ' ' + textStatus);
                        }

                    },

                    error: function(xhr, textStatus, errorThrown) {
                        jQuery('#onlineLog').html("<span style='background: darkgray; color: darkred'>OFFLINE</span>");
//                        confirm('Session lost!')
//                        confirm('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
                        alert('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
                    }
                });
            },
            onTimeout: function () {
//                confirm('Your session has timeout.');
                jQuery.ajax({
                    type: 'GET',
                    url: '${request.contextPath}/page/heartbeat',
                    dataType: 'html',
                    success: function(html, textStatus) {
//                    jQuery('body').append(html);
                        jQuery('#onlineLog').html('Online');
//                        console.log('resp timeout: ' + html)
                    },
                    error: function(xhr, textStatus, errorThrown) {
                        confirm('Session timeout!')
                        jQuery('#onlineLog').html('OFFLINE');
//                        alert('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
                    }
                });
            }
        });
            */

 jQuery.idleTimeout('#importFileCount','#importFileCount', {
            idleAfter: 10,
            pollingInterval: 15,
            keepAliveURL: '${request.contextPath}/page/importbeat',
            serverResponseEquals: 'ok',
     AJAXTimeout: 5,
     onTimeout: function () {
//                confirm('Your session has timeout.');
                jQuery.ajax({
                    type: 'GET',
                    url: '${request.contextPath}/page/importbeat',
                    dataType: 'html',

                    success: function(html, textStatus) {
                    jQuery('#importFileCount').text(html);
//                        console.log('resp timeout: ' + html)
                    }
                });
            }
        });

            jQuery('#contactPanel').load('${request.contextPath}/generics/contactCloud');
            jQuery('#tagsPanel').load('${request.contextPath}/generics/tagCloud');
            jQuery('#importFileCount').load('${request.contextPath}/page/importbeat');
            jQuery('#recentRecordsCount').load('${request.contextPath}/generics/countRecentRecords');
//            jQuery('#centralArea').load('${request.contextPath}/generics/recentRecords');

        Mousetrap.bindGlobal('ctrl+1', function (e) {
                jQuery('#accordionCenter').accordion({ active: 0});
            });
          Mousetrap.bindGlobal('ctrl+2', function (e) {
                jQuery('#accordionCenter').accordion({ active: 1});
            });
          Mousetrap.bindGlobal('ctrl+3', function (e) {
                jQuery('#accordionCenter').accordion({ active: 2});
            });
          Mousetrap.bindGlobal('ctrl+4', function (e) {
                jQuery('#accordionCenter').accordion({ active: 3});
            });

            Mousetrap.bindGlobal('f7', function (e) {
//                jQuery('#accordionCenter').accordion({ active: 0});
                jQuery('#quickAddTextFieldBottomTop').select();
                jQuery('#quickAddTextFieldBottomTop').focus();
            });
            Mousetrap.bindGlobal('shift+esc', function (e) {
//                jQuery('#accordionCenter').accordion({ active: 0});
                jQuery('#quickAddTextFieldBottomTop').select();
                jQuery('#quickAddTextFieldBottomTop').focus();
            });
     Mousetrap.bindGlobal('esc', function (e) {
//            jQuery("html, body").animate({ scrollTop: 0 }, "fast");
//            jQuery('#centralArea').html('');
                jQuery('#speedsearch').select();
                jQuery('#speedsearch').focus();
//                jQuery('#quickAddTextFieldBottomTop').select();
//                jQuery('#3rdPanel').html('');
//                jQuery('#sandboxPanel').html('');
//			jQuery('#commandBars').addClass('navHidden');
                //	jQuery('#accordionEast').accordion({ active: 3});
                //	jQuery('#accordionWest').accordion({ active: 3});
//            jQuery('#quickAddTextField').scrollTop(0);
            });

//        Mousetrap.bindGlobal('esc', function (e) {
//
////            jQuery('#centralArea').html('');
////            jQuery('#quickAddTextField').focus();
////            jQuery('#quickAddTextField').select();
//            jQuery('#quickAddRecordTextArea').select().focus();
//
//        });

//            Mousetrap.bindGlobal('f6', function (e) {
//                jQuery('#centralArea').html('');
//                jQuery('#quickAddTextField').focus();
//                jQuery('#quickAddTextField').select();
//
//            });
      /*
            Mousetrap.bindGlobal('f2', function (e) {
                jQuery('#accordionEast').accordion({ active: 6});
//                jQuery('#addXcdFormDaftarSubmit').click();
                jQuery('#quickAddRecordTextArea').select().focus();

                jQuery('#descriptionDaftar').focus();
            });
            */


  Mousetrap.bindGlobal('f2', function (e) {
                jQuery('#quickAddXcdSubmitExecute').click();
                jQuery('#quickAddTextField').select().focus();
//                jQuery('#quickAddTextField').focus();
            });

            Mousetrap.bindGlobal('shift+f2', function (e) {
//                jQuery('#accordionEast').accordion({ active: 5});

                jQuery('#addXcdFormDaftarSubmit').click();
                jQuery('#descriptionDaftar').focus();
                                jQuery('#quickAddRecordTextArea').select().focus();
            });
//
//

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



            setInterval(function() {
                jQuery.ajax({
                    type: 'GET',
                    url: '${request.contextPath}/page/heartbeat',
                    dataType: 'html',
                    success: function(html, textStatus) {
                        if (html == 'ok'){
                            jQuery('body').removeClass("offline");
                            jQuery('#onlineLog').html("<span style='padding: 1px 3px; background: darkgreen; color: white'>Online</span>");
                        }
                    },
                    error: function(xhr, textStatus, errorThrown) {
                        jQuery('#onlineLog').html("<span style='padding: 1px 3px; background: darkred; color: white'>OFFLINE</span>");
                        jQuery('body').addClass("offline");
                        alert('Nibras PKM is offline now!')
//                        console.log('An error occurred! ' + ( errorThrown ? errorThrown :   xhr.status ));
                    }
                });
            }, 30000);



//            Mousetrap.bindGlobal('f2', function (e) {
//      jQuery('#quickAddXcdSubmit').click();
//                jQuery('#addXcdFormDaftarSubmit').click();
//                jQuery('#descriptionDaftar').focus();
//            jQuery('#quickAddXcdField').focus();
//            });

            //Todo how to disable formRemote submission
            // document.forms.quickAddForm['submit'].disabled = true;


            jQuery(window).bind('beforeunload', function () {
                return 'Are you sure you want to leave the application?';
            });


            jQuery.ajaxSetup({
                beforeSend: function () {
                    $('#spinner2').show();
                },
                complete: function () {
                    $('#spinner2').hide();
                }
                ,
                success: function () {
                    $('#spinner2').hide();
                }
            });

            jQuery(document).ajaxComplete(function () {
                $('#spinner2').hide();
            });

            jQuery(document).ajaxStop(function () {
                $('#spinner2').hide();
            });
            jQuery(document).ajaxSuccess(function () {
                $('#spinner2').hide();
            });

            $(document).ajaxError(function () {
                $('#spinner2').hide();
            });

            jQuery('#descriptionDaftar').focus();
        });

    </script>

</head>

<body>

<g:render template="/appMain/regions" model="[htmlContent: htmlContent, ips: ips, recentRecords: recentRecords]"/>
<div id="idletimeout"></div>




</body>
</body>
</html>
