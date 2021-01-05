
export PATH=$PATH:/nbr/dev/grails-3.3.10/bin:/nbr/dev/jdk1.8.0_65/bin/

export GRAILS_HOME=/nbr/dev/grails-3.3.10/

export JAVA_HOME=/nbr/dev/jdk1.8.0_65/

export CATALINA="-server"
export JAVA_OPTS="-server"

grails war

# Keep the terminal window open until user enters an input.
$SHELL
