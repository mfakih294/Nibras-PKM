import grails.util.BuildSettings
import grails.util.Environment
import org.springframework.boot.logging.logback.ColorConverter
import org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter

import java.nio.charset.Charset

conversionRule 'clr', ColorConverter
conversionRule 'wex', WhitespaceThrowableProxyConverter

import grails.util.BuildSettings
import grails.util.Environment
import org.springframework.boot.logging.logback.ColorConverter
import org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter

import java.nio.charset.Charset

conversionRule 'clr', ColorConverter
conversionRule 'wex', WhitespaceThrowableProxyConverter

// See http://logback.qos.ch/manual/groovy.html for details on configuration
appender('STDOUT', ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        charset = Charset.forName('UTF-8')

        pattern =
                '%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} ' + // Date
                        '%clr(%5p) ' + // Log level
                        //              '%clr(---){faint} %clr([%15.15t]){faint} ' + // Thread
                        '%clr(%-40.40logger{39}){cyan} %clr(:){faint} ' + // Logger
                        '%n%m%n%wex' // Message
    }
}

def targetDir = BuildSettings.TARGET_DIR
if (Environment.isDevelopmentMode() && targetDir != null) {
    appender("FULL_STACKTRACE", FileAppender) {
        file = "${targetDir}/stacktrace.log"
        append = true
        encoder(PatternLayoutEncoder) {
            pattern = "%n%level %logger - %msg%n"
        }
    }
    logger("StackTrace", ERROR, ['FULL_STACKTRACE'], false)
}

root(ERROR, ['STDOUT'])
//root(INFO, ['STDOUT'])
//root(WARN, ['STDOUT'])



/*

// See http://logback.qos.ch/manual/groovy.html for details on configuration
appender('STDOUT', ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        charset = Charset.forName('UTF-8')
        pattern =
                '%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} ' + // Date
                        '%clr(%5p) ' + // Log level
//                        '%clr(---){faint} %clr([%15.15t]){faint} ' + // Thread
                        '%clr(%-40.40logger{39}){cyan} %clr(:){faint} ' + // Logger
                        '%m%n%wex' // Message
    }
}


String logDir = Environment.warDeployed ?
        System.getProperty('catalina.home') + '/logs' :
        BuildSettings.TARGET_DIR

def bySecond = timestamp("yyyyMMdd'T'HHmmss")

appender("FULL_STACKTRACE", FileAppender) {
    file = "${logDir}/log-nibras-${bySecond}.log"
//        layout = pattern(conversionPattern: "'%d [%t] %-5p %c{2} %x - %m%n'")
//                'append': true,
//                threshold: org.apache.log4j.Level.ALL
    append = true
    encoder(PatternLayoutEncoder) {
        pattern = "%level %logger:%n%n%msg%n%n%n%n"
    }
}

logger("StackTrace", ERROR, ['FULL_STACKTRACE'], false)


//root(ERROR, ['FULL_STACKTRACE'])
//root(SEVERE, ['FULL_STACKTRACE'])


appender("CONSOLE", ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        pattern = "%n%n%d{HH:mm:ss}  %-5level %logger{36}:%n%msg%n%n"
//        pattern = "%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n"
    }
}

appender("STDOUT", ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        pattern = "%n%n%d{HH:mm:ss}  %-5level %logger{36}:%n%msg%n%n"
//        pattern = "%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n"
    }
}

//root(WARN, ["StackTrace"])



*/


//logger('nibras', INFO, ['STDOUT'], false)
logger('nibras', ERROR, ['STDOUT'], false)
//logger('nibras', WARN, ['STDOUT'], false)


