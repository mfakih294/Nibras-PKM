<%@ page import="org.apache.commons.lang.StringUtils; ker.OperationController; mcs.Excerpt; mcs.Task; mcs.Goal; mcs.Book; app.IndexCard; mcs.Course; mcs.Writing" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=iso-8859-1"/>


    %{--<link rel="stylesheet" href="./site/css/main.css" type="text/css"/>--}%
    <link rel="stylesheet" href="./site/css/staticWebsite.css" type="text/css"/>
    <link rel="stylesheet" href="./site/css/jquery-ui-1.8.22.custom.css" type="text/css"/>
    <link rel="stylesheet" href="./site/css/personalization.css" type="text/css"/>
    <link rel="stylesheet" href="./site/css/bl-stylesheet.css" type="text/css"/>


    <title>Nibras PKM Static site</title>
    <link rel="shortcut icon" href="./site/icons/favicon-32px.png" type="image/png"/>
</head>


<body>
<div id="container">
    <div id="header">
        <h1 title="Blue Leaves">PKM h</h1>

        <h2 title="how strange">
            PKM static website - 30.09.2016
        </h2>
    </div>
    <ul id="nav">
        <li><a href="#courses" title="Home">Courses</a></li>
        <li><a href="#writings" title="Writings">Writings</a></li>
        <li><a href="#notes" title="Notes">Notes</a></li>
        <li><a href="#journal" title="Contact">Journal</a></li>
        <li><a href="#planner" title="Contact">Planner</a></li>
        <li><a href="#goals" title="The Author">Goals</a></li>
        <li><a href="#tasks" title="Contact">Tasks</a></li>
        <li><a href="#resources" title="The Code">Resources</a></li>
    </ul>

    <div id="sidebar">
        <div>
            <h3 title="Sidebar">Statistics</h3>

            <p>
                Total records:
            </p>
        </div>

        <div>
            <h3 title="Lorem Ipsum">Status</h3>

            <p>
                Site generated on ${new Date()?.format('dd.MM.yyyy HH:mm:ss')}
            </p>
        </div>

    </div>

    <div id="content">

    %{--//        WritingType.findAll([sort: 'name', order: 'asc']).each() {--}%
    %{--//            mtoc += """ <h2><a id="${it.id}ttoc" href="#${it.id}t"> ${it.name} (${Writing.countByType(it)})</a> </h2>--}%
    %{--//      """--}%
    %{--//        }--}%
    %{--def body = ''--}%
    %{--//        WritingType.findAll([sort: 'name', order: 'asc']).each() {type ->--}%
    %{--//            toc += """ <h2><a id="${type.id}toc" href="#${type.id}t"> ${type.name} </a></h2>--}%
    %{--//    <p><small><a href="#${type.id}ttoc">back</a></small></p>       <br/><br/>--}%
    %{--//         """--}%




    %{--<div id="tabs" class="tabsDivClass" style="">--}%
    %{--<ul>--}%
    %{--<li><a href="#type-r"><span>Resources (${mcs.Book.count()})</span></a></li>--}%
    %{--<li><a href="#type-e"><span>Chapters (${mcs.Excerpt.count()})</span></a></li>--}%
    %{--<li><a href="#type-w"><span>Writings (${Writing.count()})</span></a></li>--}%
    %{--<li><a href="#type-n"><span>Index cards (${IndexCard.count()})</span></a></li>--}%

    %{--<li><a href="#type-g"><span>Goals (${mcs.Goal.count()})</span></a></li>--}%
    %{--<li><a href="#type-t"><span>Tasks (${mcs.Task.count()})</span></a></li>--}%
    %{--</ul>--}%
    %{--<div id="type-w" style=" height: 90%; overflow: auto">--}%

        <g:if test="${1 == 2}">
            <div style="-moz-column-count:1;">
            %{--<ul style="padding: 0px;">--}%
                <g:each in="${Course.list([sort: 'code'])}" var="c">
                    <span style="font-family: tahoma; font-size: 14px; font-weight: normal; text-decoration: none;">
                        ${c}
                    </span>

                    <br/>
                    <g:each in="${Writing.findAllByIsLatexAndCourse(true, c, [sort: 'course', order: 'asc'])}">
                    %{--<li>--}%
                        <a id="${it.id}toc" href="#${it.id}"
                           style="font-family: tahoma; font-size: 12px; text-decoration: none;">
                            ${it.course ? it.course.code + " " : ''} ${it.summary}
                        </a>
                        <br/>

                    </g:each>
                </g:each>
            %{--</ul>--}%
            </div>
        </g:if>
    %{--<g:each in="${Course.list([sort: 'code'])}" var="c">--}%
    %{--<h2><span style="font-family: tahoma; font-size: 14px; font-weight: bold; text-decoration: underline;">--}%
    %{--${c}--}%
    %{--</span>--}%
    %{--</h2>--}%
    %{--<br/>--}%
        <div>
            <g:if test="${1==2}">


            <h3 title="Writings"><a id="courses">Courses</a></h3>
            <ol>
                <g:each in="${Course.executeQuery('from Course c where c.code != null order by c.department.code, c.orderNumber')}" var="c">
                    <li>
                        <u>${c.department?.code}</u> <i>C${c.id}</i>
                        <b>@${c.code} ${c.summary}</b>:
                        <span class="text${c.language}">
                            ${org.apache.commons.lang.StringUtils.abbreviate(c.description?.encodeAsHTML()?.replaceAll('\n', '<br/>'), 180)}
                        </span>
                        <span style="display: block;font-size: 8px; color: gray">
                            ${c.lastUpdated?.format('dd.MM.yyyy')} /
                            ${c.dateCreated?.format('dd.MM.yyyy')}  <pkm:listRecordFiles module="W" fileClass="himFile"
                                                                                          recordId="${c.id}"
                                                                                          static="yes"/>
                        </span>
                    </li>
                </g:each>
            </ol>

            </g:if>
        </div>
  <div>
            <h3 title="Writings"><a id="writings">Writings</a></h3>
            <ol>
                <g:each in="${Writing.executeQuery(OperationController.getPath('export.static.W.query'))}" var="c">
                    <li>
                        <i>W${c.id}</i> <u>${c.course ? "(" + c.course.toString() + ")" : ''}</u>
                        <b>${c.summary}</b>:
                        <span class="text${c.language}">
%{--                            ${org.apache.commons.lang.StringUtils.abbreviate(c.description?.encodeAsHTML()?.replaceAll('\n', '<br/>'), 180)}--}%
                        <a href="./W/${c.id}/index.html">Read</a>
                        </span>
                        <span style="display: block;font-size: 8px; color: gray">
                            ${c.lastUpdated?.format('dd.MM.yyyy')} /
                            ${c.dateCreated?.format('dd.MM.yyyy')} <pkm:listRecordFiles module="W" fileClass="himFile"
                                                                                          recordId="${c.id}"
                                                                                          static="yes"/>
                        </span>
                    </li>
                </g:each>
            </ol>
        </div>


        <div>

            <g:if test="${1==2}">


            <h3 title="Excerpts"><a id="excerpts">Excerpts</a></h3>

            <ol>
                <g:each in="${Excerpt.executeQuery(OperationController.getPath('export.static.E.query'))}" var="c">

                    <li>

                        <i>E${c.id}</i>  <u>${c.book}
                        ${c.book?.course ? "(" + c.book?.course.toString() + ")" : ''}</u>
                        <br/>    <b>${c.summary}</b>:
                        <span class="text${c.language}">
                            ${org.apache.commons.lang.StringUtils.abbreviate(c.description?.encodeAsHTML()?.replaceAll('\n', '<br/>'), 180)}
                        </span>

                        <span style="display: block;font-size: 8px; color: gray">
                            ${c.lastUpdated?.format('dd.MM.yyyy')} -
                            ${c.dateCreated?.format('dd.MM.yyyy')}
                            <br/>
                            <pkm:listRecordFiles module="E" fileClass="himFile" recordId="${c.id}" static="yes"/>

                        </span>

                    </li>

                </g:each>

            </ol>
            </g:if>
        </div>



                            <div>

                                <g:if test="${1==2}">


                                <h3 title="Resources"><a id="resources">Resources</a></h3>
                                <ol>
                                    <g:each in="${Book.executeQuery(OperationController.getPath('export.static.R.query'))}" var="c">

                                        <li>
                                        <g:if test="${new File('/' + (OperationController.getPath('rootFolder') ?: 'mhi') + '/mcd/cvr/' + c.type?.code + '/' + c.id + '.jpg').exists()}">
                                            <a href="./cvr/${c.type?.code}/${c.id}.jpg"
                                               target="_blank">
                                                <img class="Photo" style="width: 80px; height:120px; display:inline"
                                                     src="./cvr/${c.type?.code}/${c.id}.jpg"/>
                                            </a>
                                        </g:if>


                                               <u> ${c.course ? "" + c.course?.department?.code + "" : ''}</u>
                                               <u> ${c.course ? "C" + c.course.toString() + "" : ''}</u>
                                            <br/>
                                             ${c?.code ? '@' + c.code: ''}   ${c.title ?: c.dateCreated.format('dd.MM.yyyy')}

                                                <span class="text${c.language}">
                                                ${org.apache.commons.lang.StringUtils.abbreviate(c.description?.encodeAsHTML()?.replaceAll('\n', '<br/>'), 180)}
                                            </span>
                                            <span style="display: block;font-size: 8px; color: gray">
                                                ${c.lastUpdated?.format('dd.MM.yyyy')}
                                                ${c.dateCreated?.format('dd.MM.yyyy')}
                                                <pkm:listRecordFiles module="R" fileClass="himFile" recordId="${c.id}"
                                                                     type="${c.type?.code}" static="yes"/>

                                            </span>
                                        </li>
                                    </g:each>
                                </ol>

                                </g:if>
                            </div>



        <div>
            <g:if test="${1==2}">


            <h3 title="Tasks"><a id="tasks">Tasks</a></h3>
            <ol>
                <g:each in="${Task.executeQuery(OperationController.getPath('export.static.T.query'))}" var="c">
                    <li>
                        T${c.id} @${c.context?.code}

                        ${c.course ? "(" + c.course.toString() + ")" : ''}
                        <b>${c.summary}</b>:
                        <span class="text${c.language}">
                            ${org.apache.commons.lang.StringUtils.abbreviate(c.description?.encodeAsHTML()?.replaceAll('\n', '<br/>'), 180)}
                        </span>
                        <span style="display: block;font-size: 8px; color: gray">
                            @${c.status?.code}
                            ${c.dateCreated?.format('dd.MM.yyyy')} -
                            ${c.lastUpdated?.format('dd.MM.yyyy')}
                            <pkm:listRecordFiles module="T" fileClass="himFile" recordId="${c.id}" static="yes"/>
                        </span>
                    </li>
                </g:each>
            </ol>

            </g:if>
        </div>



        <div>
            <g:if test="${1==2}">


            <h3 title="Tasks"><a id="goals">Goals</a></h3>
            <ol>
                <g:each in="${Goal.executeQuery(OperationController.getPath('export.static.G.query'))}" var="c">
                    <li>
                        <i>G${c.id}</i> <u>${c.type?.code}</u>

                        ${c.course ? "(" + c.course.toString() + ")" : ''}
                        <b>${c.summary}</b>:
                        <span class="text${c.language}">
                            ${org.apache.commons.lang.StringUtils.abbreviate(c.description?.encodeAsHTML()?.replaceAll('\n', '<br/>'), 180)}
                        </span>
                        <span style="display: block;font-size: 8px; color: gray">
                            ${c.status?.code}
                            ${c.dateCreated?.format('dd.MM.yyyy')} -
                            ${c.lastUpdated?.format('dd.MM.yyyy')}
                            <pkm:listRecordFiles module="G" fileClass="himFile" recordId="${c.id}" static="yes"/>
                        </span>
                    </li>
                </g:each>
            </ol>

            </g:if>
        </div>



    </div>



    %{--<i style="text-align: right;"> PKM static website - ${new Date().format('dd.MM.yyyy')} </i>--}%

</div>


<div id="footer">
    <a href="http://validator.w3.org/check/referer" title="Validates as XHTML 1.1">XHTML</a> |
    <a href="http://jigsaw.w3.org/css-validator/check/referer?warning=no&amp;profile=css2"
       title="Validates as CSS">CSS</a> |
    <a href="&#109;a&#105;l&#116;&#111;:&#106;&#101;&#110;&#110;&#97;&#64;&#103;&#114;&#111;&#119;&#108;
    &#100;&#101;&#115;&#105;&#103;&#110;&#46;&#99;&#111;&#46;&#117;&#107;"
       title="Contact growldesign">Contact</a>    <br/>
    Copyright &copy; 2016 محمد فقيه. All Rights Reserved.<br/>
    <!-- If you would like to use this template, I ask that you keep the following line of code intact -->
    Design by <a href="http://www.growldesign.co.uk">growldesign</a>
</div>

</body>
</html>


<script type="text/javascript">

    %{--</script>--}%

    //    jQuery(document).ready(function () {


    //    });

    //    $(function() {
    //  jQuery("#tabs").tabs();
    //        $( "#tabs" ).tabs();
    //    });

</script>
