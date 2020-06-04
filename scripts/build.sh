
export PATH=$PATH:/nbr/dev/grails-3.3.10/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin/

export GRAILS_HOME=/nbr/dev/grails-3.3.10/

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

export CATALINA="-server -Xmx780m"
export JAVA_OPTS="-server -Xmx1400m"

#grails clean
grails war
#grails -disable.auto.recompile=false -Dgrails.gsp.enable.reload=true run-app
#		cp ./build/libs/nibras.war /home/alef/tomcat9/webapps/nibras.war

# Keep the terminal window open until user enters an input.
 $SHELL
