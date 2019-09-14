
<g:if test="${record.class.declaredFields.name.contains('language')}">
    <div class="text${record.language}">
</g:if>
<div style="font-size: 18px !important; line-height: 25px; color: #4A5C69 !important; padding: 3px;">

${raw(record?.description?.replaceAll("\\<.*?>", "")?.replaceAll('\n', '<br/>')?.decodeHTML()?.replaceAll('\n', '<br/>')?.replace('Product Description', ''))}

</div>



<g:if test="${record.class.declaredFields.name.contains('language')}">
    </div>
</g:if>