<%@ page import="mcs.parameters.SavedSearch"%>


<script language="javascript" type="text/javascript">
jQuery(document).ready(function() {
        if (window.isHidden)
            jQuery(".content").hide();
        
		jQuery(".heading").click(function() {
            jQuery(this).next(".content").slideToggle(200);

            if (!window.isHidden)
                window.isHidden = true;
            else
                window.isHidden = false;
    });
});
</script>


<div id="searchResults"></div>

<div class="body">

<h1> Saved Search</h1>
<hr/>


  <g:hasErrors bean="${savedSearchInstance}">
    <div class="errors">
      <g:renderErrors bean="${savedSearchInstance}" as="list"/>
    </div>
  </g:hasErrors>
  
<div class="heading"><h2>Add new record...</h2></div>
<div class="content">
	<g:formRemote name="save" url="[controller: 'savedSearch', action:'save']" update="centralArea" method="post" onComplete="">
  
  <div class="dialog">
      <g:render template="/savedSearch/form" model="[savedSearchInstance:savedSearchInstance]"/>
    </div>
    <g:submitButton name="create" value="${message(code: 'button.save')}"
            class="fg-button ui-widget ui-state-default ui-corner-all"/>
    </g:formRemote>
</div>


<h2>List of records (${total})</h2>
  <div class="list">
  <g:render template="/savedSearch/table" model="[list: list, total: total]"/>
 </div>
 
</div>
