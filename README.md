# Nibras PKM

**Nibras PKM** is an open source web-based personal knowledge management (PKM) system.

* Its goal is to manage the information needed for long-term use by the individual advanced user.
* It manages: resources (articles, books, documents), notes, writings, tasks, goals, journal, planner, payments, indicators, and (study) courses and departments.
* It is cross-platform and written in the Grails framework.



* Nibras Homepage: http://khuta.org/nibras.
* Code, releases and issues: https://github.com/mfakih294/nibras-pkm.
* Documentation: http://khuta.org/nibras-doc.


Developer: Mohamad Fakih (mail@khuta.org, Telegram: @m_fakih)


## Main features

* Text commands to add, update and search records, which provides powerful ways to manage information.
* Easy creation of records from files named in Nibras command format.
* Ability to save searches for later use.
* Ability to display records on calendars and Kanban boards.
* Full-text search of all record fields.
* Storing records files in a way that reduces greatly the need to organize them manually.


## Technical details

* Nibras is developed in Grails framework 3.3.10, which is based on Groovy language, a dynamic language on top of the Java platform.
* Grails applications run on any platform that can run Java 8 and later, so practically all platforms, including Windows, Linux, Mac.
* For production use, Nibras uses MySQL 5.5+ for its database, and the file system to store the files of the records. To testing and demonstration, you can run it with h2 database, with no need to configure it.
* Apache Tomcat 8+ is the recommended application server to run it.
