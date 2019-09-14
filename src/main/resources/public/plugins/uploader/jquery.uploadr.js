/**
 *  Uploadr, a multi-file uploader plugin
 *  Copyright (C) 2011 Jeroen Wesbeek
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
(function($){
	// methods
	var methods = {
		playNotification: function(options) {
			if (options.workvars.notificationSoundEffect) options.workvars.notificationSoundEffect.play();
		},

		playError: function(options) {
			if (options.workvars.errorSoundEffect) options.workvars.errorSoundEffect.play();
		},

		playDelete: function(options) {
			if (options.workvars.deleteSoundEffect) options.workvars.deleteSoundEffect.play();
		},

		cancel: function(event) {
			// prevent default browser behaviour
  			if (event.preventDefault) {
    			event.preventDefault();
    			event.stopPropagation();
  			}

			// IE requires false
  			return false;
		},

		dragOver: function(event) {
			methods.cancel(event);
		},

		dragEnter: function(event, obj, domObj, hoverClass, options) {
			obj.addClass(hoverClass);
			methods.cancel(event, obj, domObj, hoverClass, options);
			if (!options.workvars.gotFiles) $('.placeholder', obj).hide();
		},

		dragLeave: function(event, obj, domObj, hoverClass, options) {
			if (event.target && event.target == obj[0]) {
				obj.removeClass(hoverClass);
			}
			methods.cancel(event);
			$('.placeholder', obj).html(options.placeholderText);
			if (!options.workvars.gotFiles) $('.placeholder', obj).show();
		},

		addFile: function(domObj, file, options) {
			// add dom element for this file
			var fileDiv = methods.addFileElements(domObj, file, options, false);
			var fileDomObj = $(fileDiv);

			// got a color?
			if (file.fileColor) {
				// yes override default background color
				$('.upload-progress', fileDomObj).css('background-color', file.fileColor);
			}

			// and set to complete
			methods.onProgressHandler(fileDomObj, file, 100, options.labelDone, '', options);

			// hide the placeholder text
			$('.placeholder', domObj).hide();

			// set work var
			options.workvars.gotFiles = true;

			// add buttons
			methods.addButtons(file, fileDomObj, options);
		},

		addFileElements: function(domObj, file, options, showPercentage) {
			var fileNameDivName = (options.id + 'File' + options.workvars.files.length);

			// add file div and progress bar
			var fileDiv = document.createElement('div');
			fileDiv.setAttribute('class', 'file');

			// add a background bar div
			var backgroundDiv = document.createElement('div');
			backgroundDiv.setAttribute('class', 'background');

			// add a progress bar div
			var progressDiv = document.createElement('div');
			progressDiv.setAttribute('class', 'upload-progress');

			// add fileinfo div
			// - info
			//    +- details
			//    |     +- name
			//    |     +- size
			//    |     +- percentage
			//    +- buttons
			var infoDiv = document.createElement('div');
				infoDiv.setAttribute('class', 'info');

			var detailsDiv = document.createElement('div');
				detailsDiv.setAttribute('class', 'details');
			var fileButtonDiv = document.createElement('div');
				fileButtonDiv.setAttribute('class', 'buttons');

			var votingDiv = document.createElement('div');
				votingDiv.setAttribute('class', 'voting');

			var controlsDiv = document.createElement('div');
				controlsDiv.setAttribute('class', 'controls');
				controlsDiv.appendChild(fileButtonDiv);
				controlsDiv.appendChild(votingDiv);

			var spinnerDiv = document.createElement('div');
				spinnerDiv.setAttribute('class', 'spinner');
				spinnerDiv.style.display = 'none';

			var fileNameDiv = document.createElement('div');
				fileNameDiv.setAttribute('class', 'name');
				fileNameDiv.setAttribute('id', fileNameDivName);
			var fileNameSpan = document.createElement('span');
				fileNameSpan.setAttribute('class', 'fileName');
				fileNameSpan.innerHTML = methods.shortenFileName(options.maxFileNameLength, file.fileName);

			var fileSizeDiv = document.createElement('div');
				fileSizeDiv.setAttribute('class', 'size');
				fileSizeDiv.innerHTML = methods.bytesToSize(file.fileSize);

			var filePercentageDiv = document.createElement('div');
				filePercentageDiv.setAttribute('class', 'percentage');
				filePercentageDiv.innerHTML = ((showPercentage) ? '0%' : options.labelDone);

			var ratingDiv = document.createElement('div');
				ratingDiv.setAttribute('class', 'rating');

			var fileSpeedDiv = document.createElement('div');
				fileSpeedDiv.setAttribute('class', 'speed');

			// append child divs to infoDiv
			infoDiv.appendChild(detailsDiv);
			infoDiv.appendChild(controlsDiv);
			infoDiv.appendChild(spinnerDiv);

			fileNameDiv.appendChild(fileNameSpan);

			detailsDiv.appendChild(fileNameDiv);
			detailsDiv.appendChild(fileSizeDiv);
			detailsDiv.appendChild(filePercentageDiv);
			detailsDiv.appendChild(fileSpeedDiv);
			detailsDiv.appendChild(ratingDiv);

			// add divs to fileDiv
			fileDiv.appendChild(backgroundDiv);
			fileDiv.appendChild(progressDiv);
			fileDiv.appendChild(infoDiv);

			// append fileDiv to the parent element
			var insertIn = $('.files',domObj)[0];

			if (options.insertDirection == 'down') {
				// add to bottom
				insertIn.appendChild(fileDiv);
			} else {
				// add to top
				insertIn.insertBefore(fileDiv,insertIn.childNodes[0]);
			}

			// attach tipTip tooltips
			methods.addFileTooltip($('.fileName', $('#'+fileNameDivName)), file);

			// add this file to the files array
			if (options.insertDirection == 'up') {
				options.workvars.files.unshift(fileDiv);
				if (options.workvars.viewing > 0) options.workvars.viewing++;
			} else {
				if (!(options.workvars.files.length>0 && options.workvars.viewing < (options.workvars.files.length - 1))) {
					options.workvars.viewing = options.workvars.files.length;
				}

				options.workvars.files.push(fileDiv);
			}

			// handle pagination
			methods.handlePagination(domObj, options);

			file.obj = fileDiv;

			return fileDiv;
		},

		removeFileElement: function(domObj, options, noSound, skipFileRemoval) {
			var parent = domObj.parent();

			// play delete sound effect
			if (!noSound)
				methods.playDelete(options);

			// remove file
			domObj.animate({height: '0px'}, 200, 'swing', function() {
				if (!skipFileRemoval) {
					// remove file from files array
					for (var c = 0; c < options.workvars.files.length; c++) {
						if (options.workvars.files[c] == domObj.get(0)) {
							options.workvars.files.splice(c, 1);
							break;
						}
					}

					// change viewing parameter
					if (options.insertDirection == 'up') {
						options.workvars.viewing = (c > 0) ? c-1 : 0;
					} else {
						options.workvars.viewing = (c > (options.workvars.files.length - 1)) ? (options.workvars.files.length - 1) : c;
					}
				}

				// remove element from DOM
				domObj.remove();

				// got any files left?
				if ($('.info', parent).size() < 1) {
					// show placeholder text
					$('.placeholder', parent).show();
				}

				// handle pagination
				methods.handlePagination(options.workvars.uploadrDiv,options);
			});
		},

		handleBadge: function(count, options) {
			// increase upload count
			options.workvars.uploading += count;
			if (options.workvars.uploading < 0) options.workvars.uploading = 0;

			var badgeDiv = options.workvars.badgeDiv,
				uploading= options.workvars.uploading;

			// set badge upload count
			badgeDiv.html(uploading);

			// add tooltip
			var tooltipText = (uploading == 1) ? options.badgeTooltipSingular : options.badgeTooltipPlural;
			badgeDiv.tipTip({content: tooltipText.replace("%d", uploading)});

			// show / hide?
			if (uploading < 1 && count < 0) {
				badgeDiv.animate({opacity:0}, { duration: 1000 });
			} else if (uploading == 1 && count > 0) {
				badgeDiv.animate({opacity:1 }, { duration: 700 });

				// remove old tooltip
				badgeDiv.unbind('hover');
			}

			// if count has decreased, check if we have any paused uploads
			if (count < 0 && options.workvars.paused.length > 0) {
				var newPaused = [];

				// resume file upload(s)
				$.each(options.workvars.paused, function(index, file) {
					var canUpload = methods.canUpload(options);

					if (canUpload) {
						// start upload
						methods.startUpload(file.file, file.fileAttrs, $(file.fileDiv), options);

					} else {
						newPaused.push(file);
					}
				});

				// update paused array
				options.workvars.paused = newPaused;
			}
		},

		handlePagination: function(domObj, options) {
			var file, pages, page, v, from, to, prevButton, nextButton,pagesDiv,
				paginationDiv = $('.pagination', domObj),
				pageList = '',
				files = options.workvars.files;

			// unlimited?
			if (options.maxVisible == 0) {
				if (paginationDiv.is(':visible')) paginationDiv.hide();
				return;
			}

			// check if we have more files than can be visible
			if (files.length > options.maxVisible || paginationDiv.is(':visible')) {
				pages	= Math.ceil( files.length / options.maxVisible );
				page = Math.ceil( (options.workvars.viewing + 1) / options.maxVisible );

				// calculate which files to show
				to		= (( options.maxVisible * page) - 1);
				from	= (to - options.maxVisible + 1);

				for (v=0; v < files.length; v++) {
					file = $(files[v]);

					if (v < from || v > to) {
						if (file.is(':visible')) {
							file.hide();
						}
					} else if (file.is(':hidden')) {
						file.show();
					}
				}
			}

			// show / hide controls?
			if (!page || !pages || pages == 1) {
				// hide pagination div
				if (paginationDiv.is(':visible')) paginationDiv.hide();
			} else {
				prevButton = options.workvars.prevButton;
				nextButton = options.workvars.nextButton;
				pagesDiv = options.workvars.pagesDiv;

				// show pagination div
				if (paginationDiv.is(':hidden')) paginationDiv.show();

				// create the page list
				for (v = 1; v <= pages ; v++) {
					pageList += "<li" + ((v == page) ? ' class="current"' : '' ) + ">" + v + "</li>";
				}
				pagesDiv.html(pageList);

				// show/hide the pagination buttons
				if (page == 1) {
					prevButton.hide();
					nextButton.show();
				} else if (page == pages) {
					prevButton.show();
					nextButton.hide();
				} else {
					prevButton.show();
					nextButton.show();
				}
			}

		},

		addFileTooltip: function(domObj, file) {
			// change unix timestamp into date object
			var date = new Date();
				date.setTime(file.fileDate);

			// attach tooltip
			domObj.tipTip({
				content		: 'name: ' + file.fileName + '<br/>size: ' + methods.bytesToSize(file.fileSize) + ((file.fileDate) ? ('<br/>date: ' + date.toString()) : ''),
				maxWidth	: 600
			});
		},

		drop: function(event, obj, domObj, hoverClass, options) {
			var files = event.dataTransfer.files;

			var dropElement = obj;

			// remove class
			dropElement.removeClass(hoverClass);

			// stops the browser from redirecting off to the text.
  			if (event.preventDefault) {
    			event.preventDefault();
    			event.stopPropagation();
  			}

			// iterate through files
			if (typeof files !== "undefined") {
				// hide the placeholder text
				$('.placeholder', obj).hide();

				// set work var
				options.workvars.gotFiles = true;

				var failed = [];

				// iterate through files
				$.each(files, function(index, file) {
					// add file DOM elements
					var fileAttrs = { fileName: ((file.name) ? file.name : file.fileName), fileSize: ((file.size) ? file.size : file.fileSize), startTime: new Date().getTime(), fileRating: 0, deletable: true }
					var fileDiv = methods.addFileElements(domObj, fileAttrs, options);
					var fileDivObj = $(fileDiv);

					// check if we can upload (maximum number of concurrent uploads has been exceeded)
					if (methods.canUpload(options)) {
						// yes, start file upload
						methods.startUpload(file, fileAttrs, fileDivObj, options);
					} else if (options.maxConcurrentUploadsMethod == 'pause') {
						// no, add to paused list to upload later
						options.workvars.paused.push({
							file        : file,
							fileAttrs   : fileAttrs,
							fileDiv     : fileDiv
						});

						methods.onProgressHandler(fileDivObj, file, 0, options.labelPaused, '', options);
					} else if (options.maxConcurrentUploadsMethod == 'cancel') {
						// no, cancel upload
						methods.onProgressHandler(fileDivObj, file, 0, options.labelAborted, '', options);

						// attach tooltip on status
						var tooltipText = (options.maxConcurrentUploads == 1) ? options.maxConcurrentUploadsExceededSingular : options.maxConcurrentUploadsExceededPlural;
						tooltipText = tooltipText.replace('%d', options.maxConcurrentUploads);
						$('div.percentage', fileDivObj).tipTip({content: tooltipText, maxWidth: 600});

						// add a delete button to remove the file div
						methods.addButton(fileDivObj, 'delete', options.removeFromViewText, '', options, function() {
							methods.removeFileElement(fileDivObj, options);
						});

						// remember we failed
						fileAttrs.failed = true;

						// mark as failed
						$('.upload-progress', fileDivObj).addClass('failed');
					}
				});
			}

  			return false;
		},

		canUpload: function(options) {
			return (options.maxConcurrentUploads == 0 || options.workvars.uploading <= options.maxConcurrentUploads);
		},

		startUpload: function(file, fileAttrs, domObj, options) {
			var status = "";

			// increase upload counter
			methods.handleBadge(1,options);

			// call onStart event handler
			options.onStart(fileAttrs);

			// initialize XML Http Request
			var xhr			= new XMLHttpRequest(),
				upload		= xhr.upload,
				progressBar	= $('.upload-progress', domObj);

			// check for file extension?
			if (options.allowedExtensions.length>0) {
				var allowedExtensions = options.allowedExtensions.split(",");
				var fileName = file.name.split(".");
				var fileExtension = fileName[fileName.length - 1].toLowerCase();

				// check if extension matched the white list
				if ($.inArray(fileExtension, allowedExtensions) < 0) {
					// no, deny upload
					methods.playError(options);

					if (options.onProgress(fileAttrs, domObj, 100)) {
						methods.onProgressHandler(domObj, fileAttrs, 100, options.labelInvalidFileExtension, '', options, true);

						// attach tooltip on status
						var tooltipText = options.fileExtensionNotAllowedText.replace('%s',fileExtension);
						tooltipText = tooltipText.replace('%s',options.allowedExtensions);
						$('div.percentage', domObj).tipTip({content: tooltipText, maxWidth: 600});

						// decrease upload counter
						methods.handleBadge(-1, options);

						// add a delete button to remove the file div
						methods.addButton(domObj, 'delete', options.removeFromViewText, '', options, function() {
							methods.removeFileElement(domObj, options);
						});

						// remember we failed
						fileAttrs.failed = true;
					}

					progressBar.addClass('failed');

					options.onFailure(fileAttrs, domObj);

					return false;
				}
			}

			// check for filesize?
			if (options.maxSize && (((file.fileSize) ? file.fileSize : file.size) > options.maxSize)) {
				// too big!
				methods.playError(options);

				if (options.onProgress(fileAttrs, domObj, 100)) {
					methods.onProgressHandler(domObj, fileAttrs, 100, options.labelFileTooLarge, '', options, true);

					// attach tooltip on status
					var tooltipText = options.fileTooLargeText.replace('%s',methods.bytesToSize(((file.fileSize) ? file.fileSize : file.size)));
						tooltipText = tooltipText.replace('%s',methods.bytesToSize(options.maxSize));
					$('div.percentage', domObj).tipTip({content: tooltipText, maxWidth: 600});

					// decrease upload counter
					methods.handleBadge(-1, options);

					// add a delete button to remove the file div
					methods.addButton(domObj, 'delete', options.removeFromViewText, '', options, function() {
						methods.removeFileElement(domObj, options);
					});

					// remember we failed
					fileAttrs.failed = true;
				}

				progressBar.addClass('failed');

				// callback after failure
				options.onFailure(fileAttrs, domObj);

				return false;
			}

			// add cancel button
			methods.addButton(domObj, 'cancel', options.fileAbortText, options.fileAbortConfirm, options, function(e) {
				// abort transfer
				status = "abort";
				xhr.abort();
			});

			// attach listeners
			upload.addEventListener("progress", function(ev) {
				if (options.onProgress(fileAttrs, domObj, Math.ceil((ev.loaded / ev.total) * 100))) {
					methods.onProgressHandler(domObj, fileAttrs, Math.ceil((ev.loaded / ev.total) * 100), '', '', options);
				}
			}, false);

			// attach error listener
			upload.addEventListener("error", function (ev) {
				methods.playError(options);

				if (options.onProgress(fileAttrs, domObj, 100)) {
					methods.onProgressHandler(domObj, fileAttrs, 100, options.labelFailed, '', options, true);

					// decrease upload counter
					methods.handleBadge(-1, options);
				}

				progressBar.addClass('failed');

				// callback after failure
				options.onFailure(fileAttrs, domObj);

				// add a delete button to remove the file div
				methods.addButton(domObj, 'delete', options.removeFromViewText, '', options, function() {
					methods.removeFileElement(domObj, options);
				});
			}, false);

			// attach abort listener
			upload.addEventListener("abort", function (ev) {
				methods.playError(options);

				if (options.onProgress(fileAttrs, domObj, 100)) {
					methods.onProgressHandler(domObj, fileAttrs, 100, options.labelAborted, '', options, true);
				}

				progressBar.addClass('failed');

				// callback after abort
				options.onAbort(fileAttrs, domObj);

				// add a delete button to remove the file div
				methods.addButton(domObj, 'delete', options.removeFromViewText, '', options, function() {
					methods.removeFileElement(domObj, options);
				});
			}, false);

			// attach ready state listener
			xhr.onreadystatechange = function() {
				if (xhr.readyState != 4) { return; }

				var response = (xhr.responseText) ? JSON.parse(xhr.responseText) : {}

				// has the fileName changed in the back end?
				if (response.fileName && fileAttrs.fileName != response.fileName) {
					// yes, update it in the front end
					fileAttrs.fileName = response.fileName;
					methods.addFileTooltip($(".fileName",domObj).html(methods.shortenFileName(options.maxFileNameLength, response.fileName)), fileAttrs);
				}

				// check if everything went well
				if (xhr.status == 200) {
					if (options.onProgress(fileAttrs, domObj, 100)) {
						methods.onProgressHandler(domObj, fileAttrs, 100, '', '', options);
					}

					// show the spinner
					var spinner = $('.spinner', domObj);
					spinner.show('slow');

					// callback when done uploading
					options.onSuccess(fileAttrs, domObj, function() {
						// hide the spinner
						spinner.hide();

						// change percentage to 'done'
						methods.onProgressHandler(domObj, fileAttrs, 100, options.labelDone, '', options);

						// play notification sound?
						methods.playNotification(options);

						// decrease upload counter
						methods.handleBadge(-1,options);

						// add buttons
						methods.addButtons(fileAttrs, domObj, options);

						options.workvars.fileIterator++;
						options.files[ options.workvars.fileIterator ] = fileAttrs;
					}, response);
				} else {
					methods.playError(options);

					// whoops, we've got an error!
					if (options.onProgress(fileAttrs, domObj, 100)) {
						methods.onProgressHandler(domObj, fileAttrs, 100, options.labelFailed, response.statusText, options);

						// decrease upload counter
						methods.handleBadge(-1,options);
					}

					progressBar.addClass('failed');

					// callback after failure
					options.onFailure(fileAttrs, domObj);

					// delete file if this was an error
					if (status != "abort") options.onDelete(fileAttrs, domObj);

					return;
				}
			};

			// start data transfer
			xhr.open("POST",options.uri);
        	xhr.setRequestHeader("Cache-Control", "no-cache");
        	xhr.setRequestHeader("X-Requested-With", "Grails Uploadr");
        	xhr.setRequestHeader("X-File-Name", encodeURIComponent((file.name) ? file.name : file.fileName));
        	xhr.setRequestHeader("X-File-Size", (file.size) ? file.size : file.fileSize);
        	xhr.setRequestHeader("X-Uploadr-Name", encodeURIComponent(options.id));
			xhr.setRequestHeader("Content-Type", ((file.type) ? file.type : file.contentType) + '; charset=utf-8');
        	xhr.send(file);
		},

		onProgressHandler: function(domObj, fileAttrs, percentage, text, tooltipText, options, failed) {
			var progressMaxWidth	= domObj.parent().width();
			var progressBar			= $('.upload-progress', domObj);
			var percentageDiv 		= $('.percentage', domObj);
			var speedDiv			= $('.speed', domObj);

			// calculate speed
			var time, seconds, data, speed, average, secondsLeft;
			if (fileAttrs.startTime && percentage < 100) {
				time	= new Date().getTime();
				seconds	= Math.ceil((time - fileAttrs.startTime) / 1000);
				data	= ((fileAttrs.fileSize / 100) * percentage) / seconds;

				// calculate average
				if (fileAttrs.avg) {
					average = Math.round((fileAttrs.avg + data) / 2);
					fileAttrs.avg = average;
				} else {
					fileAttrs.avg = data;
					average = data;
				}

				// time to go
				secondsLeft = Math.ceil((fileAttrs.fileSize / average) - seconds);

				// calculate average upload speed
				speed = methods.bytesToSize(average) + '/s (about '+methods.secondsToTime(secondsLeft)+' to go)';
			} else {
				speed = '';
			}

			// show upload speed
			speedDiv.html(speed);

			// handle progressbar width
			progressBar.width((progressMaxWidth / 100) * percentage);
			percentageDiv.html((text) ? text : percentage + '%');

			// add tooltip?
			if (text && tooltipText) {
				percentageDiv.tipTip({content: tooltipText, maxWidth: 600});
			}

			// are we done uploading?
			if (percentage >= 100) {
				var ratingDiv = $('.rating', domObj);
				var cancelButton = $('.cancel', domObj);

				// set progress to complete
				progressBar.addClass('complete');

				// remove button
				cancelButton.hide();

				// use rating?
				if (options.rating && !failed) {
					// remove speed div
					speedDiv.hide();

					// remove percentage div
					percentageDiv.hide(1000, function() {
						// if jquery tabs are used with an uploadr
						// the times hide does not work. To make sure
						// the element is hidden we have to explicitly
						// call it again
						$(this).hide();
					});

					// set the rating
					methods.setRating(fileAttrs.fileRating, domObj);

					// show the rating div
					ratingDiv.show(500);

					// add tooltip
					if (fileAttrs.fileRatingText) {
						ratingDiv.tipTip({content: fileAttrs.fileRatingText, maxWidth: 600});
					}
				}

				// unset speed array to save memory
				fileAttrs.speed = null;
			}
		},

		addVotingButtons: function(file, domObj, options) {
			if (!options.voting) return true;

			var votingDiv = $('.voting', domObj);
			var likeDiv = document.createElement('div');
				likeDiv.setAttribute('class', 'like');
			var unlikeDiv = document.createElement('div');
				unlikeDiv.setAttribute('class', 'unlike');
			votingDiv[0].appendChild(likeDiv);
			votingDiv[0].appendChild(unlikeDiv);

			// add like and dislike handlers
			$(likeDiv).bind('click.uploadr', function() {
				options.onLike(file, domObj, function(rating) {
					file.fileRating = rating;
					if (!file.fileRating || file.fileRating < 0) file.fileRating = 0;
					if (file.fileRating > 1) file.fileRating = 1;
					methods.setRating(file.fileRating, domObj);
				});
			}).tipTip({content: options.likeText, maxWidth: 600});
			$(unlikeDiv).bind('click.uploadr', function() {
				options.onUnlike(file, domObj, function(rating) {
					file.fileRating = rating;
					if (!file.fileRating || file.fileRating < 0) file.fileRating = 0;
					if (file.fileRating > 1) file.fileRating = 1;
					methods.setRating(file.fileRating, domObj);
				});
			}).tipTip({content: options.unlikeText, maxWidth: 600});
		},

		addButtons: function(file, domObj, options) {
			// add view, download and delete buttons
			if (file.deletable && options.deletable) {
				methods.addButton(domObj, 'delete', options.fileDeleteText, options.fileDeleteConfirm, options, function() {
					if (options.onDelete(file, domObj)) methods.removeFileElement(domObj, options);
				});
			}
			if (options.colorPicker) {
				var colorPicker = methods.addButton(domObj, 'color', options.colorPickerText, '', options, function() {
					var p = $('.upload-progress', domObj);
					var c = p.css('background-color');
					methods.launchColorPicker(domObj, c, options, function(color) {
						// change background color
						p.css('background-color', color);

						// and call color method
						options.onChangeColor(file, domObj, color);
					});
				});
			}
			if (options.downloadable) {
				methods.addButton(domObj, 'download', options.fileDownloadText, '', options, function() {
					options.onDownload(file, domObj);
				});
			}
			if (options.viewable) {
				methods.addButton(domObj, 'view', options.fileViewText, '', options, function() {
					options.onView(file, domObj);
				});
			}
			methods.addVotingButtons(file, domObj, options);
		},

		addButton: function(domObj, type, tooltipText, confirmationText, options, handler) {
			var buttonDiv = document.createElement('div');
				buttonDiv.setAttribute('class', 'button ' + type);
				buttonDiv.setAttribute("style", "display: none");
			var buttonsDiv = $('.buttons', domObj);

			buttonsDiv[0].appendChild(buttonDiv);

			var button = $('.' + type, domObj);

			// add tooltip?
			if (tooltipText) {
				button.tipTip({content: tooltipText, maxWidth: 600});
			}

			// bind event handler
			button.bind('click.uploadr', function(event) {
			    if (!confirmationText || (confirm && confirm(confirmationText))) {
					handler();
			    }
			});

			button.show('slow');

			return button;
		},

		launchColorPicker: function(domObj, currentColor, options, callback) {
			var uploadr = domObj.parent().parent();
			var cp = $('.pickr', uploadr);
			var clickEventHandler = null;

			// got a colorpickrdiv?
			if (!cp.length) {
				// no, create it
				var arrowDiv = document.createElement('div');
					arrowDiv.setAttribute('class', 'arrow');
				var contentDiv = document.createElement('div');
					contentDiv.setAttribute('class', 'content');
				var ul = document.createElement('ul');

				// add colors to the color picker
				for (var i in options.colorPickerColors) {
					var li = document.createElement('li');
						ul.appendChild(li);
						$(li).css('background-color', options.colorPickerColors[i]);
				}

				var colorPickerDiv = document.createElement('div');
					colorPickerDiv.setAttribute('class', 'pickr');
					contentDiv.appendChild(ul);
					colorPickerDiv.appendChild(contentDiv);
					colorPickerDiv.appendChild(arrowDiv);

				// add it to the DOM and hide it
				uploadr[0].appendChild(colorPickerDiv);

				cp = $('.pickr', uploadr);
				cp.hide();
			}

			// iterate through colors
			var colors = $('li', cp);
			for (var i=0; i<colors.size(); i++) {
				var color = $(colors[i]);
				var rgb = color.css('background-color');

				// mark the current color
				if (rgb == currentColor) {
					color.addClass('current');
				} else {
					color.removeClass('current');
				}

				// remove previous bind
				color.unbind('click.uploadr');

				// and bind new handler
				color.bind('click.uploadr', function() {
					callback($(this).css('background-color'));

					// unbind the document click event
					$(document).unbind('click.uploadr');

					// hide color picker
					cp.hide(200);
				});
			}

			// position color picker
			var pos = domObj.position();
			cp.css({
				top: pos.top,
				left: pos.left + domObj.width() + 2
			});

			// show color picker
			cp.show(200, function() {
				// when color picker animation is done,
				// bind a click handler to the document
				$(document).bind('click.uploadr', function(e) {
					if (
						e.pageX < cp.position().left ||
						e.pageX > (cp.position().left + cp.width()) ||
						e.pageY < cp.position().top ||
						e.pageY > (cp.position().top + cp.height())
						) {

						// click was outside the color picker
						// unbind the click handler
						$(document).unbind('click.uploadr');

						// and hide the color picker
						cp.hide(200);
					}
				});
			});
		},

		setRating: function(rating, domObj) {
			var ratingDiv = $('.rating', domObj);
			var children = ratingDiv.children();

			// make sure rating lies between 0 and 1
			if (rating < 0 || !rating) rating = 0;
			if (rating > 1) rating = 1;

			// determine the rating
			var r = Math.round(rating * 10);
			var rr = Math.round(r/2);

			// add rating
			for (var i=1; i<=5; i++) {
				// empty, half or full rate?
				var type = (rr >= i) ? ((rr==i && (r % 2)) ? 'half' : 'full') : 'empty';

				if (children.size()) {
					$(children[i-1])[0].setAttribute('class', type);
				} else {
					var starDiv = document.createElement('div');
						starDiv.setAttribute('class', type);
					ratingDiv[0].appendChild(starDiv);
				}
			}
		},

		/**
		 * return human readable file sizes
		 * @param int bytes
		 * @returns string human readable filesize
		 */
		bytesToSize: function(bytes) {
			var sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
			if (!bytes) return "0 B";
			var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
			return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
		},

		/**
		 * change seconds into seconds, minutes and hours
		 * @param seconds
		 */
		secondsToTime: function(seconds) {
			var sizes = [' seconds', 'minutes', 'hours'];
			if (seconds == 0) return 'n/a';
			var i = parseInt(Math.floor(Math.log(seconds) / Math.log(60)));
			return Math.round(seconds / Math.pow(60, i), 2) + ' ' + sizes[i];
		},

		/**
		 * return a shortened filename
		 * @param length
		 * @param fullFileName
		 */
		shortenFileName: function(length, fullFileName) {
			var fileName    = "",
				extension   = "",
				middle      = "",
				strip       = 0,
				dot         = fullFileName.lastIndexOf(".");

			if (fullFileName.length <= length) {
				return fullFileName;
			} else if (dot) {
				fileName	= fullFileName.substring(0,dot);
				extension	= fullFileName.substring(dot+1,fullFileName.length);
				strip       = (length - 4 - extension.length);

				// check if this is a filename which is made unique
				// (hence, ending with \-[0-9]+
				if (fileName.match(/\-\d+$/)) {
					dot         = fileName.lastIndexOf("-")
					middle      = fileName.substring(dot+1,fileName.length)
					fileName    = fileName.substring(0,dot);
					strip -= middle.length;
				}
			} else {
				fileName	= fullFileName;
			}

			return fileName.substring(0, strip) + ((middle) ? ('...' + middle + '.') : '....') + extension
		},

		addFileUploadField: function(j,domObj,options) {
			// insert upload field
			var fileUploadElement = document.createElement('input');
				fileUploadElement.setAttribute('type', 'file');
				fileUploadElement.multiple = true;
			var messageDiv = document.createElement('div');
				messageDiv.setAttribute('class', 'message');
				messageDiv.innerHTML = options.fileSelectText;
			var fileInputDiv = document.createElement('div');
				fileInputDiv.setAttribute('class','fileinput');
				fileInputDiv.appendChild(messageDiv);
				fileInputDiv.appendChild(fileUploadElement);

			domObj.appendChild(fileInputDiv);
			var inputField = $('input[type=file]',j);

			// bind image click to file input click
			$('.message', j).bind('click.uploadr', function() {
				// trigger click event on file input field
				inputField[0].click();
			});

			// bind file field event handler
			inputField.bind('change.uploadr', function() {
				// iterate through files
				if (typeof this.files !== "undefined") {
					// hide the placeholder text
					$('.placeholder', domObj).hide();

					// set work var
					options.workvars.gotFiles = true;

					// iterate through files
					$.each(this.files, function(index,file) {
						// add file DOM elements
						var fileAttrs = { fileName: (file.name) ? file.name : file.fileName, fileSize: (file.size) ? file.size : file.fileSize, startTime: new Date().getTime(), fileRating: 0, deletable: true }
						var fileDiv = methods.addFileElements(domObj, fileAttrs, options);

						// and start file upload
						methods.startUpload(file, fileAttrs, $(fileDiv), options);
					});
				}
			});
		}
	};

	// class containing public methods
	var Uploadr = function(element, options, methods) {
		// clear all files from the uploadr
		this.clear = function(myOptions) {
			var myDefaults = {
				sound 	: true,
				erase	: true
			};

			// extend the jQuery options
			var myOptions = $.extend(myDefaults, myOptions);

			// store sound option locally so we can make sure the
			// delete sound will only play once when multiple files
			// are deleted
			var playSound = myOptions.sound;

			// remove and erase files
			$.each(options.files, function(index, file) {
				var div = $(file.obj);
				if (!file.erased) {
					if (myOptions.erase) {
						if (options.onDelete(file, div))
							methods.removeFileElement(div, options, !playSound);
					} else {
						methods.removeFileElement(div, options, !playSound);
					}
					playSound = false;
					file.erased = true;
				}
			});

			// remove any remaining divs
			$('.file', options.workvars.uploadrDiv).each(function() {
				methods.removeFileElement($(this), options, !playSound, true);
				playSound = false;
			});
		};

		// change any option after initialization
		this.set = function(name, value) {
			if (typeof options[name] !== "undefined") {
				options[name] = value;
			}
		};
	};

	// define the jquery plugin code
	$.fn.uploadr = function(options) {
		// default settings
		var defaults = {
			placeholderText		: 'drag and drop your files here to upload...',
			fileSelectText 		: 'Select files to upload',
			fileAbortText		: 'Click to abort file transfer',
			fileAbortConfirm	: 'Are you sure you would like to abort this transfer?',
			fileDeleteText		: 'Click to delete this file',
			fileDeleteConfirm	: 'Are you sure you want to delete this file?',
			fileDownloadText	: 'Click to download this file',
			fileViewText		: 'Click to view this file',
			fileTooLargeText	: 'The upload size of %s is larger than allowed maximum of %s',
			fileExtensionNotAllowedText : 'You tried to upload a file with extension "%s" while only files with extensions "%s" are allowed to be uploaded',
			maxConcurrentUploadsExceededSingular: 'Only 1 upload at a time allowed, please retry when the other upload is finished',
			maxConcurrentUploadsExceededPlural: 'Only %d concurrent uploads allowed, please retry when the other uploads are finished',
			likeText			: 'Click to like',
			unlikeText			: 'Click to unlike',
			colorPickerText		: 'Click to change background color',
			badgeTooltipSingular: '%d file is still being uploaded...',
			badgeTooltipPlural	: '%d files are still being uploaded...',
			removeFromViewText	: 'Click to remove this aborted transfer from your view',
			labelDone			: 'done',
			labelPaused         : 'paused',
			labelFailed 		: 'failed',
			labelAborted 		: 'aborted',
			labelFileTooLarge	: 'too large',
			labelInvalidFileExtension : 'invalid',
			dropableClass		: 'uploadr-dropable',
			hoverClass			: 'uploadr-hover',
			uri					: '/upload/uri',
			id					: 'uploadr',
			maxFileNameLength	: 34,
			maxSize				: 0,	            // 0 = unlimited
			maxVisible 			: 5,	            // 0 = unlimited
			files				: [],
			uploadField 		: true,
			insertDirection 	: 'down',
			maxConcurrentUploads: 0,                // 0 = unlimited
			maxConcurrentUploadsMethod: 'cancel',   // pause (until upload slot available) / cancel (cancel upload)
			rating 				: true,
			voting 				: true,
			colorPicker 		: true,
			deletable 			: true,	            // delete button visible?
			downloadable 		: true,	            // download button visible?
			viewable 			: true,	            // view button visible?
			allowedExtensions   : "",               // comma separated list of allowed extensions, all if empty

			// default sound effects
			notificationSound   : '',
			errorSound          : '',
			deleteSound 		: '',

			// color picker colors
			colorPickerColors 	: [
				'#bce08a',	// default green
				'#00a8e1',	// blue
				'#ff6418',	// orange
				'#c78cda',	// purple
				'#ffcb00',	// yellow
				'#e70033'	// red
			],

			// work variables, internal use only
			workvars 			: {
				gotFiles					: false,
				files						: [],
				notificationSoundEffect		: null,
				errorSoundEffect			: null,
				deleteSoundEffect 			: null,
				viewing						: 0,
				uploading					: 0,
				badgeDiv 					: null,
				uploadrDiv 					: null,
				paginationDiv 				: null,
				pagesDiv 					: null,
				nextButton 					: null,
				prevButton 					: null,
				fileIterator				: -1,
				paused                      : []
			},

			// default event handlers
			onStart 			: function(file) {},
			onProgress			: function(file, domObj, percentage) {
				// return false to cancel default progress handler
				return true;
			},
			onSuccess			: function(file, domObj, callback, response) { callback(); },
			onFailure			: function(file, domObj) { return true; },
			onAbort             : function(file, domObj) { return true; },
			onView              : function(file, domObj) { return true; },
			onDownload          : function(file, domObj) { return true; },
			onDelete            : function(file, domObj) { return true; },
			onLike				: function(file, domObj, callback) { callback(file.fileRating + 0.1); },
			onUnlike			: function(file, domObj, callback) { callback(file.fileRating - 0.1); },
			onChangeColor		: function(file, domObj, color) { return true; }
		};

		// extend the jQuery options
		var options = $.extend(defaults, options);

		return this.each(function() {
			var obj	= $(this);
			var e	= obj.get(0);
			e.style.height='100px';

			// Return early if this element already has a plugin instance
			if (obj.data('uploadr')) return;

			// add file upload field
			if (options.uploadField) methods.addFileUploadField(obj,e,options);

			// add badge
			var badgeDiv = document.createElement('div');
				badgeDiv.setAttribute('class', 'info-badge');

			// add placeholder text
			var placeholderDiv = document.createElement('div');
				placeholderDiv.setAttribute('class', 'placeholder');
				placeholderDiv.innerHTML = defaults.placeholderText;

			// add files div
			var filesDiv = document.createElement('div');
				filesDiv.setAttribute('class', 'files '+defaults.dropableClass);
				filesDiv.appendChild(placeholderDiv);

			// add pagination div
			var paginationDiv = document.createElement('div');
				paginationDiv.setAttribute('class', 'pagination');

			// add pagination elements
			var prevButtonDiv = document.createElement('div');
				prevButtonDiv.setAttribute('class', 'previous');
			var pagesDiv = document.createElement('div');
				pagesDiv.setAttribute('class', 'pages');
			var nextButtonDiv = document.createElement('div');
				nextButtonDiv.setAttribute('class', 'next');
			paginationDiv.appendChild(prevButtonDiv);
			paginationDiv.appendChild(pagesDiv);
			paginationDiv.appendChild(nextButtonDiv);

			// append divs to uploadr element
			e.appendChild(badgeDiv);
			e.appendChild(filesDiv);
			e.appendChild(paginationDiv);

			// set workvars
			options.workvars.uploadrDiv = e;
			options.workvars.badgeDiv = $(badgeDiv);
			options.workvars.paginationDiv = $(paginationDiv);
			options.workvars.pagesDiv = $(pagesDiv);
			options.workvars.nextButton = $(nextButtonDiv);
			options.workvars.prevButton = $(prevButtonDiv);

			// hide divs
			options.workvars.badgeDiv.css({ opacity: 0 });
			options.workvars.paginationDiv.hide();

			// register event handlers
			filesDiv.addEventListener('dragover', methods['dragOver'], false);
			filesDiv.addEventListener('dragenter', function(event) { methods['dragEnter'](event, $(this), e, defaults.hoverClass, options); }, false);
			filesDiv.addEventListener('dragleave', function(event) { methods['dragLeave'](event, $(this), e, defaults.hoverClass, options); }, false);
			filesDiv.addEventListener('drop', function(event) { methods['drop'](event, $(this), e, defaults.hoverClass, options); }, false);

			// register pagination event handlers
			$(prevButtonDiv).bind('click.uploadr', function() {
				options.workvars.viewing = options.workvars.viewing - options.maxVisible;
				methods.handlePagination(e,options);
			});
			$(nextButtonDiv).bind('click.uploadr', function() {
				options.workvars.viewing = options.workvars.viewing + options.maxVisible;
				methods.handlePagination(e,options);
			});
			methods.handlePagination(e,options);

			// got initial files?
			if (options.files) {
				for (var iterator in options.files) {
					methods.addFile(e, options.files[iterator], options);
					options.workvars.fileIterator = iterator;
				}
			}

			// initialize notification sounds?
			if (options.notificationSound) options.workvars.notificationSoundEffect = new Audio(options.notificationSound);
			if (options.errorSound) options.workvars.errorSoundEffect = new Audio(options.errorSound);
			if (options.deleteSound) options.workvars.deleteSoundEffect = new Audio(options.deleteSound);

			// store plugin object's public methods in this element's data so we can reference it
			obj.data('uploadr', new Uploadr(this, options, methods));
		});
	};
})(jQuery);
