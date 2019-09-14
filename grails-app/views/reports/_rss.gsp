<g:set var="list" value="${[
        [code: 'G', name: 'Goals'],
        [code: 'T', name: 'Tasks'],
        [code: 'P', name: 'Planner'],
        [code: 'J', name: 'Journal'],
        [code: 'W', name: 'Writing'],
        [code: 'C', name: 'Notes'],
        [code: 'B', name: 'Resources']
]}"/>
%{--</g:else>--}%

<g:each in="${list}" var="f">
    <li>
        <a href="${createLink(controller: 'rss', action: 'feeds', params: [type: f.code])}" target="_blank">
            <span class="rssIcon"></span>
            ${f.name}
        </a>
    </li>

</g:each>
