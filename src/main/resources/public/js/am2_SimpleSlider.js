/*
* jQuery Slider Plugin
* Version : Am2_SimpleSlider.js
* author  :amit & amar
* website :
* Date    :06-2-2014
 
* NOTE : "jQuery v1.8.2 used while developing"
*/

(function ($) {

    jQuery.fn.Am2_SimpleSlider = function () {
        //popup div
        $div = $('<div class="product-gallery-popup"> <div class="popup-overlay"></div> <div class="product-popup-content"> <div class="product-image"> <img id="gallery-img" src="" alt="" /> <div class="gallery-nav-btns"> <a id="nav-btn-next" class="nav-btn next" ></a> <a id="nav-btn-prev" class="nav-btn prev" ></a></div> </div><div class="product-information"> <p class="product-desc"></p></div> <div class="clear"></div><a href="#" class="cross">X</a></div></div>').appendTo('body');

        //on image click   
        $(this).click(function () {
            $('.product-gallery-popup').fadeIn(0);
            $('body').css({ 'overflow': 'hidden' });
            $('.product-popup-content .product-image img').attr('src', $(this).find('img').attr('src'));
            $('.product-popup-content .product-information p').text($(this).find('div').attr('data-desc'));
            $Current = $(this);
            $PreviousElm = $(this).prev();
            $nextElm = $(this).next();
            if ($PreviousElm.length === 0) { $('.nav-btn.prev').css({ 'display': 'none' }); }
            else { $('.nav-btn.prev').css({ 'display': 'block' }); }
            if ($nextElm.length === 0) { $('.nav-btn.next').css({ 'display': 'none' }); }
            else { $('.nav-btn.next').css({ 'display': 'block' }); }
        });
        //on Next click
        $('.next').click(function () {
            $NewCurrent = $nextElm;
            $PreviousElm = $NewCurrent.prev();
            $nextElm = $NewCurrent.next();
            $('.product-popup-content .product-image img').clearQueue().animate({ opacity: '0' }, 0).attr('src', $NewCurrent.find('img').attr('src')).animate({ opacity: '1' }, 500);
          
          
            
            $('.product-popup-content .product-information p').text($NewCurrent.find('div').attr('data-desc'));
            if ($PreviousElm.length === 0) { $('.nav-btn.prev').css({ 'display': 'none' }); }
            else { $('.nav-btn.prev').css({ 'display': 'block' }); }
            if ($nextElm.length === 0) { $('.nav-btn.next').css({ 'display': 'none' }); }
            else { $('.nav-btn.next').css({ 'display': 'block' }); }
        });
        //on Prev click
        $('.prev').click(function () {
            $NewCurrent = $PreviousElm;
            $PreviousElm = $NewCurrent.prev();
            $nextElm = $NewCurrent.next();
            $('.product-popup-content .product-image img').clearQueue().animate({ opacity: '0' }, 0).attr('src', $NewCurrent.find('img').attr('src')).animate({ opacity: '1' }, 500);
            
            $('.product-popup-content .product-information p').text($NewCurrent.find('div').attr('data-desc'));
            if ($PreviousElm.length === 0) { $('.nav-btn.prev').css({ 'display': 'none' }); }
            else { $('.nav-btn.prev').css({ 'display': 'block' }); }
            if ($nextElm.length === 0) { $('.nav-btn.next').css({ 'display': 'none' }); }
            else { $('.nav-btn.next').css({ 'display': 'block' }); }
        });
        //Close Popup
        $('.cross,.popup-overlay').click(function () {
            $('.product-gallery-popup').fadeOut(0);
            $('body').css({ 'overflow': 'initial' });
        });

        //Key Events
        $(document).on('keyup', function (e) {
            e.preventDefault();
            //Close popup on esc
            if (e.keyCode === 27) { $('.product-gallery-popup').fadeOut(0); $('body').css({ 'overflow': 'initial' }); }
            //Next Img On Right Arrow Click
            if (e.keyCode === 39) { NextProduct(); }
            //Prev Img on Left Arrow Click
            if (e.keyCode === 37) { PrevProduct(); }
        });

        function NextProduct() {
            if ($nextElm.length === 1) {
                $NewCurrent = $nextElm;
                $PreviousElm = $NewCurrent.prev();
                $nextElm = $NewCurrent.next();
                $('.product-popup-content .product-image img').clearQueue().animate({ opacity: '0' }, 0).attr('src', $NewCurrent.find('img').attr('src')).animate({ opacity: '1' }, 500);
                
                $('.product-popup-content .product-information p').text($NewCurrent.find('div').attr('data-desc'));
                if ($PreviousElm.length === 0) { $('.nav-btn.prev').css({ 'display': 'none' }); }
                else { $('.nav-btn.prev').css({ 'display': 'block' }); }
                if ($nextElm.length === 0) { $('.nav-btn.next').css({ 'display': 'none' }); }
                else { $('.nav-btn.next').css({ 'display': 'block' }); }
            }

        }

        function PrevProduct() {
            if ($PreviousElm.length === 1) {
                $NewCurrent = $PreviousElm;
                $PreviousElm = $NewCurrent.prev();
                $nextElm = $NewCurrent.next();
                $('.product-popup-content .product-image img').clearQueue().animate({ opacity: '0' }, 0).attr('src', $NewCurrent.find('img').attr('src')).animate({ opacity: '1' }, 500);
        
                $('.product-popup-content .product-information p').text($NewCurrent.find('div').attr('data-desc'));
                if ($PreviousElm.length === 0) { $('.nav-btn.prev').css({ 'display': 'none' }); }
                else { $('.nav-btn.prev').css({ 'display': 'block' }); }
                if ($nextElm.length === 0) { $('.nav-btn.next').css({ 'display': 'none' }); }
                else { $('.nav-btn.next').css({ 'display': 'block' }); }
            }

        }
    };

} (jQuery));
