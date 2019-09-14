<%@ page import="org.apache.commons.lang.StringUtils; mcs.Course; org.apache.commons.lang.WordUtils; mcs.parameters.WritingStatus; mcs.Writing" %>

<%@ page import="mcs.Goal; mcs.Department" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>

<body>

<g:each in="${Department.findAllByIdLessThan(29)}" var="d">
    <h1>${d}</h1>
    <mbp:pagebreak/>

    <g:each in="${Course.findAllByDepartment(d, [sort: 'code'])}" var="c">
        <h2>${c} (${Writing.countByCourse(c)} writings)</h2>
        <mbp:pagebreak/>

        <g:each in="${Writing.findAllByCourse(c, [sort: 'orderNumber'])}" var="w">

            <b>${d.code} &nbsp;&nbsp; writing <i>${w.id}</i> -</b> priority ${w.priority}  &nbsp;
            <br/>     <br/>

            <h3>${Math.floor(w.orderNumber ?: 0)} ${WordUtils.capitalize(w.title)}</h3>
            <br/>      <i>&nbsp;&nbsp; ${w.writingStatus}</i> ${w.type} ${w.bookmarked ? 'bookmarked' : ''}
            <br/>     <br/>
            ${StringUtils.abbreviate(w.body, 300)} (${w.body?.count(' ')} words)
            <br/>
            <center>* * *</center>
            <mbp:pagebreak/>

        </g:each>
    </g:each>
</g:each>
