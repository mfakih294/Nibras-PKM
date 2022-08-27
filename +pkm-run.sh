cd /nibras/dev/pkm/


export PATH=/nibras/dev/grails-3.3.10/bin:$PATH
export GRAILS_HOME=/nibras/dev/grails-3.3.10/
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export CATALINA="-server"
export JAVA_OPTS="-server"

#grails clean
#grails war

./gradlew bootRun #--offline -offline 


# grails -https -disable.auto.recompile=false -Dgrails.gsp.enable.reload=true run-app
#		cp ./build/libs/nibras.war /home/alef/tomcat9/webapps/nibras.war

# Keep the terminal window open until user enters an input.

