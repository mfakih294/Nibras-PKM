<%@ page import="mcs.parameters.SavedSearch"%>

<div id="actionsBox" style="padding-top:8px; margin:0px;">

<a tabindex="0" href="#actions" class="fg-button fg-button-icon-right ui-widget ui-state-default ui-corner-all"
      id="actions${recordId}">Edit saved search <span class="ui-icon ui-icon-triangle-1-s"></span></a>
<div id="#actions" class="hidden">
    <ul>

<li>

    <g:remoteLink controller="generics" action="fetchAddForm" id="${recordId}"
                  params="[entityController: 'mcs.parameters.SavedSearch',
                          updateRegion: 'centralArea',
                          finalRegion: 'centralArea']"
                  update="centralArea"
                  title="Edit">
        Edit
	</g:remoteLink>

</li>

	<li>
	<g:remoteLink controller= "savedSearch"
                  action="delete" id="${recordId}"
                  before="if(!confirm('Are you sure you want to permanently delete the saved search record')) return false"
                  update="notificationArea" on404="alert('not found');">
		Delete
	</g:remoteLink>
	   
</li>

    </ul>
</div>

<script>
    jQuery("#actions${recordId}").menu({content: jQuery("#actions${recordId}").next().html(), showSpeed: 200});
</script>

</div><!-- actions box end -->