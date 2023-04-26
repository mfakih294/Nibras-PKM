<style type="text/css">


.placeholder {
    outline: 1px dashed #4183C4;
}

.mjs-nestedSortable-error {
    background: #fbe3e4;
    border-color: transparent;
}

#tree {
    width: 550px;
    margin: 0;
}

ol.sortable,ol.sortable ol {
    list-style-type: none;
}

.sortable li div {
    border: 1px solid #d4d4d4;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    cursor: move;
    border-color: #D4D4D4 #D4D4D4 #BCBCBC;
    margin: 0;
    padding: 3px;
}

li.mjs-nestedSortable-collapsed.mjs-nestedSortable-hovering div {
    border-color: #999;
}

.disclose, .expandEditor {
    cursor: pointer;
    width: 20px;
    display: none;
}

.sortable li.mjs-nestedSortable-collapsed > ol {
    display: none;
}

.sortable li.mjs-nestedSortable-branch > div > .disclose {
    display: inline-block;
}

.sortable span.ui-icon {
    display: inline-block;
    margin: 0;
    padding: 0;
}

.menuDiv {
    background: #EBEBEB;
}

.menuEdit {
    background: #FFF;
}

.itemTitle {
    vertical-align: middle;
    cursor: pointer;
}

.deleteMenu {
    float: right;
    cursor: pointer;
}




</style>


<input id="serialize" name="serialize" type="submit" value=
"Save"></p>
<div id="serializeOutput"></div>
<pre id="serializeOutput2"></pre>


<ol class="sortable ui-sortable mjs-nestedSortable-branch mjs-nestedSortable-expanded">
    %{--<g:each in="${app.IndexCard.findAllByCourseAndWbsParentIsNull(record, [sort: 'orderNumber', order: 'asc'])}"--}%
    <g:each in="${app.IndexCard.executeQuery('from IndexCard where priority >= 2 and course = ? and wbsParent is null order by orderNumber asc' , [record])}"
            var="n">
    %{--<g:if test="${!n.wbsNumber?.contains('.')}">--}%
        <li style="display: list-item;" class="mjs-nestedSortable-branch mjs-nestedSortable-expanded" id="menuItem_${n.id}">
        <div >
%{--            class="text${n.language}"--}%
            %{--<span title="Click to show/hide children" class="disclose ui-icon ui-icon-minusthick">abc--}%
            %{--</span>--}%

            <b color="darkbblue">${n.wbsNumber}</b>
%{--            #${n.orderNumber}--}%
            ${n.summary}
        <g:remoteLink controller="page" action="panel"
                      params="${[id: n.id, entityCode: n.entityCode()]}"
                      update="3rdPanel"
                      style="padding: 2px; font-size: 12px;"
                      before=" myLayout.slideOpen('east'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0)">
            i${n.id}
        </g:remoteLink>
        </div>
    %{--</g:if>--}%
    %{--<g:else>--}%
    %{--<li style="display: list-item;" class="mjs-nestedSortable-branch mjs-nestedSortable-expanded" id="menuItem_3">--}%
    %{--<div>Some content3</div>--}%
    %{--<g:if test="${IndexCard.countByCourseAndWbsParent(record, n) > 0}">--}%
    %{--<ol>--}%
    %{--<g:each in="${IndexCard.findAllByCourseAndWbsParent(record, n, [sort: 'orderNumber', order: 'asc'])}" var="ch">--}%

    %{--<li style="display: list-item;" class="mjs-nestedSortable-branch mjs-nestedSortable-expanded" id="menuItem_${ch.id}">--}%
    %{--<div> <b color="darkbblue">${ch.wbsNumber}</b> #${ch.orderNumber} ${ch.summary}--}%

    %{--<g:remoteLink controller="page" action="panel"--}%
    %{--params="${[id: ch.id, entityCode: ch.entityCode()]}"--}%
    %{--update="3rdPanel"--}%
    %{--style="padding: 2px; font-size: 12px;"--}%
    %{--before=" myLayout.open('east'); jQuery('#accordionEast').accordion({ active: 0}); jQuery('#3rdPanel').scrollTop(0)">--}%
    %{--i${ch.id}--}%
    %{--</g:remoteLink>--}%
    %{--</div>--}%
    %{--</li>--}%

        <g:render template="/appCourse/childrenofNotes" model="[record: record, parent: n]"/>
    %{--</g:each>--}%
    %{--</ol>--}%
    %{--</li>--}%
    %{--</g:if>--}%
    %{--<g:else>--}%
    %{--</li>--}%
    %{--</g:else>--}%
    </g:each>
</ol>




<script>

    $('.sortable').nestedSortable({
        forcePlaceholderSize: true,
        handle: 'div',
        helper:	'clone',
        items: 'li',
        opacity: .6,
        placeholder: 'placeholder',
        revert: 250,
        tabSize: 25,
        tolerance: 'pointer',
        toleranceElement: '> div',
        maxLevels: 6,
       isTree: true,
        expandOnHover: 700,
        startCollapsed: false
//        change: function(){
//            console.log('Relocated item');
//        }

    });

    //    $('.disclose').attr('title','Click to show/hide children');

    //    $('.disclose').on('click', function() {
    //        $(this).closest('li').toggleClass('mjs-nestedSortable-collapsed').toggleClass('mjs-nestedSortable-expanded');
    //        $(this).toggleClass('ui-icon-plusthick').toggleClass('ui-icon-minusthick');
    //    });

    $('#serialize').click(function () {
        serialized = $('ol.sortable').nestedSortable('serialize');
//        jQuery('#serializeOutput').load('/nibra/operation/sortNotes/' + serialized');

        jQuery.ajax({
            type: 'POST',
            url: '${request.contextPath}/operation/sortNotes2',
            dataType: 'html',

            data: 'crs=${record.id}&id=' + serialized.replace(/,/g, '-').replace(/&/g, '_'),
            success: function (html, textStatus) {
                jQuery('#serializeOutput').text(html);
//                        console.log('resp timeout: ' + html)
            }
        });


        // $('#serializeOutput2').text(serialized + '\n\n');
    })

</script>