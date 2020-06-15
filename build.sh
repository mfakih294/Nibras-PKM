
export PATH=/home/mf/dev/grails-3.3.10/bin:/home/mf/dev/jdk1.8.0_111/bin/:$PATH

export GRAILS_HOME=/home/mf/dev/grails-3.3.10/

export JAVA_HOME=/home/mf/dev/jdk1.8.0_111/
#/usr/lib/jvm/java-11-openjdk-amd64/

export CATALINA="-server"
export JAVA_OPTS="-server"

cd ..
grails war

# Keep the terminal window open until user enters an input.
 $SHELL
