<%@ page import="app.IndexCard; mcs.Writing" %>
%{--${app.IndexCard.executeQuery('select count(*) from IndexCard i where i.type.code = ? and i.writing.status.code = ? and i.isNewSection = ?', ['aya', 'revised', true])[0]}--}%
%{--cards--}%
%{--<g:each in="${mcs.Writing.executeQuery('from Writing i where i.type.code = ?  order by i.orderInBook', ['surah'])}" var="w"><g:set var="count" value="${1}"/> \section{${w.orderInBook + ' ' + w.summary} (\#${app.IndexCard.executeQuery('select count(*) from IndexCard i where i.recordId = ? and i.type.code = ? and i.isNewSection = ?', [w.id.toString(), 'aya', true])[0] + 1})} [{${count++}]<g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ? order by i.orderInWriting', [w.id.toString(), 'aya'])}"  var="r">  <g:if test="${r.isNewSection}"> $\large{\P}$ \normalsize \newline [${count++}] </g:if>${r.shortDescription} \small{\emph{(${r.orderInWriting})}\normalsize}</g:each>$\large\S$ \newpage\normalsize</g:each>--}%
%{--\newline--}%
<g:each in="${mcs.Writing.executeQuery('from Writing i where i.type.code = ?  order by i.orderInBook', ['surah'])}" var="w"><g:set var="count" value="${1}"/>
    \section{${w.orderInBook + ' سورة ' + w.summary}} [${count++}]
    <g:each in="${app.IndexCard.executeQuery('from IndexCard i where i.recordId = ? and i.type.code = ? order by i.orderInWriting', [w.id.toString(), 'aya'])}"  var="r">  <g:if test="${r.isNewSection}"> $\large\S$ \newpage \normalsize  [${count++}] </g:if>  ${r.shortDescription} \small{(${r.orderInWriting})}</g:each> \normalsize

</g:each>
