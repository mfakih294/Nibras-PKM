cd /nibras/dev/pkm/


export PATH=/nibras/dev/grails-3.3.10/bin:$PATH
export GRAILS_HOME=/nibras/dev/grails-3.3.10/
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export CATALINA="-server"
export JAVA_OPTS="-server"

#grails clean

#./gradlew assemble
./gradlew  assemble 

#grails war


# Keep the terminal window open until user enters an input.
