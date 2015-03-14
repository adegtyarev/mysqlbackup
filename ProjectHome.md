# mysqlbackup #

# Download from Google Drive #

https://drive.google.com/folderview?id=0BwMHb92XtFurS2RpOE9ObDhFNDQ&usp=sharing#list

## Features ##
  * Requires minimum coding to create everyday MySQL-backups with some additional functions.

  * Backups can be compressed on-the-fly and automatically rotated after specified number of a days.

  * «Slave mode» feature — stop slave, save it's status and then create backup.  Start slave afterwards.

  * Includes basic database maintenance: check and optimize tables before backup creation.

  * Successfully used on a large MySQL installations (1000+ databases).

  * Does not requires root privileges to create backup — any Unix user may create it's own MySQL backup.

  * It is written in sh — code interpreter available in a base system.

  * Work out-of-the-box on Linux and FreeBSD: no third-party libraries required except MySQL client.

You will simply run «`mysqlbackup -a`» with `@daily` cron schedule to have five most recent MySQL backups.  Tables checked and optimized before archiving so you will have consistent data.  Archives compressed to save space and automatically rotated.  Finally, mysqlbackup has a lot of tunables to adjust backup configuration according to your taste — just type «`man mysqlbackup`».