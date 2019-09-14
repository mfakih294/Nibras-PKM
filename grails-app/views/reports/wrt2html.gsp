<%@ page import="app.IndexCard; mcs.Course; mcs.Writing" %>


<html>
<head><title>todo</title></head>

<body>
<a id="top"></a> <br/>

%{--<h1> TOC </h1>--}%

%{--//        WritingType.findAll([sort: 'name', order: 'asc']).each() {--}%
%{--//            mtoc += """ <h2><a id="${it.id}ttoc" href="#${it.id}t"> ${it.name} (${Writing.countByType(it)})</a> </h2>--}%
%{--//      """--}%
%{--//        }--}%
%{--def body = ''--}%
%{--//        WritingType.findAll([sort: 'name', order: 'asc']).each() {type ->--}%
%{--//            toc += """ <h2><a id="${type.id}toc" href="#${type.id}t"> ${type.name} </a></h2>--}%
%{--//    <p><small><a href="#${type.id}ttoc">back</a></small></p>       <br/><br/>--}%
%{--//         """--}%

<h1>Index cards</h1>

<g:each in="${IndexCard.list([sort: 'id'])}" var="c">

    <br/><br/>
    <h2>
        %{--<b><u><a>--}%
        ${c.course ? "(" + c.course.toString() + ")" : ''}
        ${c.summary ?: c.dateCreated.format('dd.MM.yyyy')}
        %{--</a></u></b>--}%
    </h2>
    <br/>
    ${c.description?.replaceAll('\n', '<br/>').encodeAsHTML().decodeHTML()}

    <hr/>
    <br style="page-break-after:always"/>
</g:each>


<h1>Writings</h1>
<div style="-moz-column-count:4;">
%{--<ul style="padding: 0px;">--}%
    <g:each in="${Course.list([sort: 'code'])}" var="c">
        <span style="font-family: tahoma; font-size: 14px; font-weight: bold; text-decoration: underline;">
            ${c}
        </span>

        <br/>
        <g:each in="${Writing.findAllByIsLatexAndCourse(true, c, [sort: 'course', order: 'asc'])}">
        %{--<li>--}%
            <a id="${it.id}toc" href="#${it.id}" style="font-family: tahoma; font-size: 12px; text-decoration: none;">
                ${it.course ? it.course.code + " " : ''} ${it.summary}
            </a>
            <br/>

        </g:each>
        <hr/>
    </g:each>
%{--</ul>--}%
</div>

<g:each in="${Course.list([sort: 'code'])}" var="c">
    <h2><span style="font-family: tahoma; font-size: 14px; font-weight: bold; text-decoration: underline;">
        ${c}
    </span>
    </h2>
    <br/>

    <g:each in="${Writing.findAllByIsLatexAndCourse(true, c, [sort: 'course', order: 'asc'])}">
        <br/><br/>

        <h3>
            <b><u><a id="${it.id}">
                ${it.summary} ${it.course ? "(" + it.course.toString() + ")" : ''}</a></u></b>
        </h3>
        <br/>
        ${it.description?.replaceAll('\n', '<br/>').encodeAsHTML().decodeHTML()}
        <p><small><a href="#${it.id}toc">back</a></small></p>
        <hr/><br/>
    </g:each>
</g:each>



</body>
</html>
