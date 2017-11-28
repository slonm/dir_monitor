dir_monitor
===========

Filesystem changes monitor using boost::asio © Boris Schaeling

Fixes and extensions contributed by @pmed, @obaskanderi, @GamePad64, @sbelsky and @slonm from GitHub.

[![Build Status](https://travis-ci.org/slonm/dir_monitor.svg?branch=develop)](https://travis-ci.org/slonm/dir_monitor)

**dir_monitor** is C++11 compatible header-only library

**dir_monitor** currently supports the following platforms:

* Linux as [inotify](http://en.wikipedia.org/wiki/Inotify) wrapper

* Windows as [ReadDirectoryChangesW](https://msdn.microsoft.com/ru-ru/library/windows/desktop/aa365465(v=vs.85).aspx) wrapper

* Mac OS X as [FSEvents](http://en.wikipedia.org/wiki/FSEvents) wrapper

* FreeBSD/BSD as [kqueue](http://en.wikipedia.org/wiki/Kqueue) wrapper

Historical first topic: [SourceForge mailing list](https://sourceforge.net/p/asio/mailman/message/20161905/)

### Another mature cross-platform directory watch implemetations:

[Entropia File System Watcher for C++](https://bitbucket.org/SpartanJ/efsw)

[JNotify File system events library for Java](http://jnotify.sourceforge.net/)

### Contribution

Please create PRs against `develop` branch. `master` branch is used for stable releases only.
