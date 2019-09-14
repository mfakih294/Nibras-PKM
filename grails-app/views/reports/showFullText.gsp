
<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
</head>

<div class="fullTextPopup">
    ${fullText?.encodeAsHTML()?.replaceAll('\n', '<br/>')}
</div>