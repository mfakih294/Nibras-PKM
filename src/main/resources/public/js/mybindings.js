

Mousetrap.bind('space', function (e) {
	jQuery('.temp44').addClass('hiddenActions');
	jQuery('.recordSelected .actionsButtons').removeClass('hiddenActions');
	return false;
});

//Mousetrap.bind(['R', 'ُ'], function (e) {
//	myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);
//	jQuery('.recordSelected .openPanelButton').click();
//	return false;
//});

Mousetrap.bind(['e', 'ث'], function (e) {
	jQuery(".recordSelected  .fullEditButton").click();
});
Mousetrap.bind(['', 'ث'], function (e) {
	jQuery(".recordSelected  .fullEditButton").click();
});


Mousetrap.bind('8', function (e) {
	jQuery(".recordSelected .quickBookmarkButton").click();
});

Mousetrap.bind('c', function (e) {
	//jQuery('.temp44').addClass('hiddenActions');
	//jQuery('.recordSelected #actionsButtons').removeClass('hiddenActions');
	jQuery(".recordSelected .course").editable('show');


});

Mousetrap.bind('#', function (e) {
	jQuery(".recordSelected .type").editable('show');
});

Mousetrap.bind('?', function (e) {
	jQuery(".recordSelected .status").editable('show');

});


Mousetrap.bind(['q', 'ض'], function (e) {
	jQuery(".recordSelected  .quickEditButton").click();
});
Mousetrap.bind(['t','ف'], function (e) {
	jQuery(".recordSelected .addTagButton").click();
	jQuery(".recordSelected  .newTagField").focus();
});
Mousetrap.bind(['a','ش'], function (e) {
	jQuery(".recordSelected .appendToDescription").click();
	jQuery(".recordSelected  .appendTextFor}").focus();
});
Mousetrap.bind(['ق','r'], function (e) {
	jQuery(".recordSelected  .refresh").click();
	myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0);
	jQuery('.recordSelected .openPanelButton').click();
	return false;
	//jQuery(".recordSelected  .openPanelButton").click();


});
Mousetrap.bind(['D','shift+ي'], function (e) {
	jQuery(".recordSelected  .doneButton").click();
});

Mousetrap.bind(['ctrl+X','ctrol+ْ'], function (e) {
	jQuery(".recordSelected  .dismissedButton").click();
});
Mousetrap.bind('0', function (e) {
	jQuery(".recordSelected .setTodayButton").click();
});

Mousetrap.bind(['shift+n','shift+ى'], function (e) {
	jQuery(".recordSelected .appendToNotes").click();
	jQuery(".recordSelected  .appendTextFor").focus();
});

Mousetrap.bind(['N','shift+ى'], function (e) {
	jQuery(".recordSelected  .addNoteButton").click();

});

Mousetrap.bind(['l a','م ش'], function (e) {
	jQuery(".recordSelected .setLanguageArabic").click();
});
Mousetrap.bind(['l e','م ث'], function (e) {
	jQuery(".recordSelected .setLanguageEnglish").click();
});
Mousetrap.bind(['j','ت'], function (e) {
	jQuery(".addJPButton").click();
});
Mousetrap.bind(['_'], function (e) {
//	jQuery(".recordSelected  .dump").click();
	jQuery(".recordSelected  .physicalDelete").click();
});

Mousetrap.bind(['x','ء'], function (e) {
//	jQuery(".recordSelected  .dump").click();
	jQuery(".recordSelected  .executeOperation").click();
});
Mousetrap.bind(['f 1','ب 1'], function (e) {
	jQuery(".recordSelected  .openFolderButton1").click();
});

Mousetrap.bind(['f 2','ب 2'], function (e) {
	jQuery(".recordSelected  .openFolderButton2").click();
});


Mousetrap.bind('=', function (e) {
	jQuery('.recordSelected .increasePriorityButton').click()
});
Mousetrap.bind('-', function (e) {
	jQuery('.recordSelected .decreasePriorityButton').click()
});


Mousetrap.bind('up', function (e) {
	let t = jQuery('.recordSelected')
if (jQuery('.recordSelected').prevAll('table').size() >= 1) {
jQuery('.recordSelected').prevAll('table').eq(0).addClass('recordSelected');
t.removeClass('recordSelected');
}

	//document.getElementByClass('.recordSelected').scrollIntoView(); //{behavior: 'smooth', block: 'center'}
	jQuery('.recordSelected')[0].scrollIntoView({block: "center", inline: "nearest", behavior: "smooth", });

	return false;
});

Mousetrap.bindGlobal('down', function (e) {
	let t = jQuery('.recordSelected')
	if (jQuery('.recordSelected').nextAll('table').size() >= 1) {
		jQuery('.recordSelected').nextAll('table').eq(0).addClass('recordSelected');
//        jQuery('.selectedRecord .refresh').click();
		t.removeClass('recordSelected');
	}
	//jQuery('.recordSelected').scrollIntoView({block: "center", inline: "nearest", behavior: "smooth", });
	jQuery('.recordSelected')[0].scrollIntoView({block: "center", inline: "nearest", behavior: "smooth", });
	return false;

});




const array = ['A', 'B', 'D', 'Y', 'E', 'F', 'L', 'O', 'Z', 'H', 'I', 'V', 'T', 'U', 'S', 'K', 'X']
array.forEach( i => {
	Mousetrap.bind('d ' + i.toLowerCase(), function (e) {
//                                    console.log('in dept set: ' + 's ' + i.toLowerCase());
		jQuery('.recordSelected .setDepartment' + i).click();
	});

//Mousetrap.bind('d ' + i.toLowerCase(), function (e) {
//		jQuery('.recordSelected .setDepartment' + i).click();
//	});
}
)
const arrayConversion = ['J', 'R', 'W', 'G', 'T', 'P', 'N']
arrayConversion.forEach( i => {
	Mousetrap.bind('c ' + i.toLowerCase(), function (e) {
//                                    console.log('in dept set: ' + 's ' + i.toLowerCase());
		jQuery('.recordSelected .convertButton' + i).click();
	});

//Mousetrap.bind('d ' + i.toLowerCase(), function (e) {
//		jQuery('.recordSelected .setDepartment' + i).click();
//	});
}
)
//                return false;
//            });


const array2 = ['1', '2', '3', '4', '5']

array2.forEach( i => {
	Mousetrap.bind('p ' + i, function (e) {
//                                    console.log('in dept set: ' + 's ' + i.toLowerCase());
		jQuery('.recordSelected .setPriority' + i).click();
	})

Mousetrap.bind('ح ' + i, function (e) {
//                                    console.log('in dept set: ' + 's ' + i.toLowerCase());
		jQuery('.recordSelected .setPriority' + i).click();
	})
}
)


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

Mousetrap.bindGlobal('f2', function (e) {

//                jQuery('#accordionCenter').accordion({ active: 0});
	jQuery('#quickAddTextFieldBottomTop').select();
	jQuery('#quickAddTextFieldBottomTop').focus();
});
Mousetrap.bindGlobal('f1', function (e) {
//                jQuery('#accordionCenter').accordion({ active: 0});
	jQuery('#quickAddTextFieldBottomTop').select();
	jQuery('#quickAddTextFieldBottomTop').focus();
});


Mousetrap.bind('esc', function (e) {
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


// Mousetrap.bindGlobal('f2', function (e) {
// jQuery('#quickAddXcdSubmitExecute').click();
// jQuery('#quickAddTextField').select().focus();
//                jQuery('#quickAddTextField').focus();
//             });

Mousetrap.bindGlobal('shift+f2', function (e) {
//                jQuery('#accordionEast').accordion({ active: 5});

	jQuery('#addXcdFormDaftarSubmit').click();
	jQuery('#descriptionDaftar').focus();
//                jQuery('#quickAddRecordTextArea').select().focus();
});
//
//

Mousetrap.bind('left', function (e) {
	jQuery('.prevLink').click()
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



//            Mousetrap.bind('ctrl+s', function (e) {
//                jQuery('#addXcdFormDaftarSubmit').click();
//                return false;
//            });


/*
 For modifier keys you can use shift, ctrl, alt, option, meta, and command.
 Other special keys are backspace, tab, enter, return, capslock, esc,
 escape, space, pageup, pagedown, end, home, left, up, right, down, ins, and del.
 Any other key you should be able to reference by name like a, /, $, *, or =.

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

 */


function dosth() {
	jQuery('#quickAddTextField').removeClass('shiftEnterPressed')
}



