

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>

<body>

<g:each in="${mcs.Department.list()}" var="d">
    <h1>${d} (${mcs.Goal.countByDepartment(d)} goals)</h1>
    <mbp:pagebreak/>
    <g:each in="${mcs.Goal.findAllByDepartmentAndDeletedOnIsNull(d, [sort: 'priority', order: 'desc'])}" var="g">
        <b>${d.code} &nbsp;&nbsp; goal <i>${g.id}</i> -</b> priority ${g.priority}  &nbsp;

        <br/>
        <br/>

        <h3>${g.title}</h3>
        <br/>
        <i>&nbsp;&nbsp; ${g.goalStatus}</i> ${g.goalType}

        <br/>
        <br/>

        ${g.description}
        <br/>
        <center>* * *</center>
        <mbp:pagebreak/>
    </g:each>
</g:each>

</body>
</html>
