# Nibras PKM

**Nibras PKM** is a __local open source__ system for the __long-term management__ of __personal__ information. It is a combination of a __web-based__ application intended for desktop use, and an Android __mobile__ reader application.

![](https://raw.githubusercontent.com/mfakih294/Nibras-PKM/master/docs/images/screenshot.jpg)


**Open source**

The user has control over the system itself too, especially when using it on the long term to manage the important personal information and files.

**Comprehensize**

It manages resources (articles, books, documents), notes, writings, tasks, goals, journal, planner, payments, indicators, and (study) courses and departments.

**Powerful**

It was designed with large amounts of information in mind. In current usage, it manages dozens of thousands of records. With its commands and saved searches, it makes easy to navigate through all the information.

## Main Features

* **Flexible text-based commands** to add, update and search records, which provides powerful ways to manage information.
* **Saved searches** to save searches for later use.
* Ability to display records on calendars and Kanban boards.
* Full-text search of all record fields.
* Simple file system integration so to greatly reduce the need to organize files manually.

## Documentation

User's guide is available online at [https://mfakih294.github.io/Nibras-PKM/](https://mfakih294.github.io/Nibras-PKM/).

## Code, releases and issues

Nibras PKM is hosted on GitHub [https://github.com/mfakih294/Nibras-PKM](https://github.com/mfakih294/Nibras-PKM).

## Quick start guide

Running Nibras requires three simple steps:

- Download the bundle file corresponding to your platform, e.g. nibras-bundle-windows.zip from the [releases page](https://github.com/mfakih294/Nibras-PKM/releases) on Github.
- Extract the zipped file to a location of your choice on your local disk.
- Launch Nibras by double clicking on ./scripts/start file.

Once Nibras has finished launching, a text message like the one below will appear.

`************************************************************`

`* Nibras has launched. You can access it from: *`

`* https://localhost:1441/nibras *`

`************************************************************`

Go to **https://localhost:1441/nibras** using Firefox or Chrome. On the login page, enter *nibras* for username and *nibras* for the password.

Notes: 
- As it has a self-signed certificate, you need to accept and bypass the security warning that shows up at the beginning.
- On Linux, you need to make the files inside ./scripts and ./tomcat/bin folders executable (chmod +x *).
- To stop Nibras, you can close this window, or press ctrl+c in it, or run ./scripts/stop script.

## Technical details

* Nibras is developed in Grails framework 3.3.10, which is based on Groovy language, a dynamic language on top of the Java platform.
* Grails applications run on any platform that can run Java 8 and later, so practically all platforms, including Windows, Linux, Mac.
* For production use, Nibras uses MySQL 5 for its database, and the file system to store the files of the records. To testing and demonstration, you can run it with h2 database, with no need to configure it.
* Apache Tomcat 8+ is the recommended application server to run it for production use.
