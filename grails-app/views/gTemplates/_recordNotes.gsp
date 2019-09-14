<g:each in="${record.notes?.split(/\|\|/)}" var="n">
    Note on ${n}
    <br/>
</g:each>
