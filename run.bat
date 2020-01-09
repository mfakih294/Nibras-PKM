
set PATH=D:\dev\grails-3.3.10\bin;C:\Program Files\Java\jdk1.8.0_111\jre\bin;
set GRAILS_HOME=D:\dev\grails-3.3.10
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_111
set CATALINA=-server -Xmx780m

grails -disable.auto.recompile=false -Dgrails.gsp.enable.reload=true run-app
pause
