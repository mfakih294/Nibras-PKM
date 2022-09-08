<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-3.6.0.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit-icons.min.js')}"></script>


<div class="js-upload uk-placeholder uk-text-center" id="upoadForm${documentId}">
    <span uk-icon="icon: cloud-upload"></span>
    <span class="uk-text-middle">Attach binaries by dropping them here or</span>
    <div uk-form-custom>
        <input type="file" multiple>
        <span class="uk-link">selecting one</span>
    </div>
</div>

<progress id="js-progressbar" class="uk-progress" value="0" max="100" hidden></progress>


<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-3.6.0.min.js')}"></script>
<script>jQuery.noConflict();</script>

<script type="text/javascript" src="${resource(dir: 'uikit/js', file: 'uikit.min.js')}"></script>



<script type="text/javascript">

		var bar = document.getElementById('js-progressbar');

		UIkit.upload('.js-upload', {

			url: '/trn/attachment/uploadForUploadService',
			multiple: true,
			params: {id: ${documentId}, type: ''},
			beforeSend: function () {
				console.log('beforeSend', arguments);
			},
			beforeAll: function () {
				console.log('beforeAll', arguments);
			},
			load: function () {
				console.log('load', arguments);
			},
			error: function () {
				console.log('error', arguments);
			},
			complete: function () {
				console.log('complete', arguments);
			},

			loadStart: function (e) {
				console.log('loadStart', arguments);

				bar.removeAttribute('hidden');
				bar.max = e.total;
				bar.value = e.loaded;
			},

			progress: function (e) {
				console.log('progress', arguments);

				bar.max = e.total;
				bar.value = e.loaded;
			},

			loadEnd: function (e) {
				console.log('loadEnd', arguments);

				bar.max = e.total;
				bar.value = e.loaded;
			},

			completeAll: function () {
				console.log('completeAll', arguments);

				jQuery("#topDocumentCard${documentId}").load("${request.contextPath}/document/getDocumentCard/${documentId}")

				setTimeout(function () {
					bar.setAttribute('hidden', 'hidden');
				}, 1000);

				alert('Upload Completed');
			}

		});


</script>