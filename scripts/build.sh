
export PATH=$PATH:/nbr/dev/grails-3.3.10/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin/

export GRAILS_HOME=/nbr/dev/grails-3.3.10/

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

export CATALINA="-server"
export JAVA_OPTS="-server"

cd ..
grails war

# Keep the terminal window open until user enters an input.
 $SHELL
