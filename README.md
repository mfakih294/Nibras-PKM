# Nibras PKM

**Nibras PKM** is an __offline open source system__ for the __long-term management__ of __personal__ information. It is a combination of a __web-based__ application intended for desktop use, and an Android __mobile__ reader application.

**Why offline?** The user has full control over his/her data, without the need for (fast) internet connection, and without all the distractions and information overload that the internet can cause.

**Why open source?** The user has control over the system itself too, especially when using it on the long term to manage the important personal information and files.


**It manages**: resources (articles, books, documents), notes, writings, tasks, goals, journal, planner, payments, indicators, and (study) courses and departments.

![Screenshots](http://khuta.org/nibras-doc/images/nibras-1.2.4.jpg)

## Main Features

* **Flexible text-based commands** to add, update and search records, which provides powerful ways to manage information.
* **Saved searches** to save searches for later use.
* Ability to display records on calendars and Kanban boards.
* Full-text search of all record fields.
* Simple file system integration so to greatly reduce the need to organize files manually.

## Technical details

* Nibras is developed in Grails framework 3.3.10, which is based on Groovy language, a dynamic language on top of the Java platform.
* Grails applications run on any platform that can run Java 8 and later, so practically all platforms, including Windows, Linux, Mac.
* For production use, Nibras uses MySQL 5 for its database, and the file system to store the files of the records. To testing and demonstration, you can run it with h2 database, with no need to configure it.
* Apache Tomcat 8+ is the recommended application server to run it for production use.


* Documentation: [https://mfakih294.github.io/Nibras-PKM/](https://mfakih294.github.io/Nibras-PKM/).
* Code, releases and issues: [https://github.com/mfakih294/Nibras-PKM](https://github.com/mfakih294/Nibras-PKM).