# Features

* **Flexible text-based commands** to add, update and search records, which provides powerful ways to manage information.
* **Saved searches** to save searches for later use.
* Ability to display records on calendars and Kanban boards.
* Full-text search of all record fields.
* Simple file system integration so to greatly reduce the need to organize files manually.

## Technical details

* Nibras is developed in Grails framework 3.3.10, a dynamic framework on top of the Java platform.
* Grails applications run on any platform that can run Java 8 and later, so practically all platforms, including Windows, Linux, Mac.
* For production use, Nibras uses MySQL 5+ for its database, and the file system to store the files of the records. To testing and demonstration, it can run with h2 database, with zero extra configuration.
* Apache Tomcat 8+ is the recommended application server to run it for production use.
* The bundled distribution comes with Tomcat 8 and runs with a h2 database.

## Quick start guide

Running Nibras requires three simple steps:

- Download the bundle file corresponding to your platform, e.g. nibras-bundle-windows.zip from the [releases page](https://github.com/mfakih294/Nibras-PKM/releases) on Github.
- Extract the zipped file to a location of your choice on your local disk.
- Launch Nibras by double clicking on ./scripts/start file.

Once Nibras has finished launching, a message like the one below will appear.

`************************************************************`

`* Nibras has launched. You can access it from:             *`

`* https://localhost:1441/nibras                            *`

`************************************************************`

Go to **https://localhost:1441/nibras** using Firefox or Chrome. On the login page, enter *nibras* for username and *nibras* for the password.

Notes: 
- As it has a self-signed certificate, you need to accept and bypass the security warning that shows up at the beginning.
- On Linux, you need to make the files inside ./scripts and ./tomcat/bin folders executable (chmod +x *).
- To stop Nibras, you can close this window, or press ctrl+c in it, or run ./scripts/stop script.

