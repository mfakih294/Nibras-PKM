
<g:set var="entityCode"
       value="${record.metaClass.respondsTo(record, 'entityCode') ? record.entityCode() : record.class?.name?.split(/\./).last()}"/>




<script type="text/javascript">
jQuery("#appendTextFor${entityCode}${record.id}").focus();
</script>
