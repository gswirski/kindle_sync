KindleSync
==========

KindleSync is a OS X only small Ruby script to automatically synchronise books
on your Kindle. 

Installation
------------

### Paths

Change `usb_plug` file in following way:

    sync = KindleSync.new("Volume name you want sync")
    if sync.ready?
      sync.process("Full path to directory with books", "documents")
    end

For example configuration check out my file.

### Plug & Play

Edit `ProgramArguments` key to point your `usb_plug` file

Run

    mv com.sognat.kindle-sync.plist /System/Library/LaunchDaemons/

How it works
------------

When you mount new volume (eg. plug USB drive), LaunchDaemon runs this little
script. It just goes through your books and checks whether it exists on
Kindle. If not, copies file and lets you know by Growl.

ToDo
----

* Manage collections