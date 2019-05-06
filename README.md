⚙学 Manabu GUI Client for GAKU Engine
=====================================
The Manabu Desktop is a GUI interface built on GTK for the Manabu Gaku Engine client.

Warning!
========
Manabu Desktop is currently very much a work in progress.

Installation
============
Either install the gem:  
```gem install manabu-desktop```  
or clone this repository and the manabu client in the same path and bundle:
```
git clone git@github.com:GAKUEngine/manabu.git
git clone git@github.com:GAKUEngine/manabu-desktop.git
cd manabu-desktop
bundle install
```

Usage
=====
If you installed the gem simply run the ```manabu-desktop``` command.  
Otherwise, navigate to the manabu-desktop directory and run ```bundle exec bin/manabu-desktop```

Testing
=======
You can test against a live GAKU Engine server or with a testing container.

Testing Container Details
-------------------------
Test server:
 * URL: localhost
 * Port: 9000
 * HTTPS/SSL: No/Disabled

Test admin user:
 * username: admin
 * password: 123456

Desktop Client Composition
==========================
Due to limitations in the Ruby GTK implementation most of manabu-desktop is implemented in  
C++ with GTK+. However, to facilitate various extensibility features there is a bridge to 
Ruby and a set of simplified interfaces for most parts of the client, including a Ruby native 
login screen, student roster, etc. Using this bridge and these basic interfaces can help you 
build individual extension modules such as GUI student importers/exporters and visual 
tools for generating printables.

Building
========
Manabu Desktop requires CMake, GTK MM, and libmanabu to build. You can build libmanabu 
separately or use an installed/packaged version. The process to obtain CMake and GTK MM 
will be different depending on your system. If you build libmanabu in the directory next 
to manabu-desktop (libraries will be built in; ../libmanabu/build) CMake will detect this 
and use these libraries - prioritizing them over any libmanabu binaries installed on the 
system.
  
If you have all dependencies ready the rest of the process is a fairly standard CMake build:
```sh
cd manabu-desktop
mkdir build
cd build
cmake ..
make
```

Linux Build Notes
-----------------
Other than basic build tools you'll mostly only need the GTK MM v3 libraries and headers 
(and their dependencies). You can obtain these on Debian/Ubuntu based systems with 
```sudo apt-get install libgtkmm-3.0-dev```.

Windows Build Notes
-------------------
Building with msys2 is generally recommended simply because we build most components within 
this environment and you'll likely be building libmanabu with msys2 as well. Unfortunately 
only the GTK+ libraries available through msys2 at the time of this writing are up to date 
and usable, so we have to build the gtkmm libraries manually. To build gtkmm you're going to 
first need the GTK common build tools called "mm-common" and the GTK3 base libraries. The 
GTK3 base libraries packaged on msys2 seem to work fine for development, so we can obtain 
those with ```pacman -S mingw-w64-x86_64-gtk3```. Assuming you have build tools and general 
libraries installed (which you likely do if you built libmanabu) you can build and install 
mm-common with:  
```sh
git clone https://gitlab.gnome.org/GNOME/mm-common.git
cd mm-common
./autogen.sh
make
make install
```

Then, clone and build gtkmm. We specifically need to check out the lastest branch for version 
3, so you should check "git branch -a" to see if there is a newer version branch than the 
instructions below. To quickly build and install gtkmm you can do something like:
```sh
git clone https://gitlab.gnome.org/GNOME/gtkmm.git
cd gtkmm
git checkout gtkmm-3-24
./autogen.sh
make
make install
```
!NOTICE! If you have problems building, the GTK3 package you obtained from msys2/pacman may be 
incompatible with the branch you checked out. You can either build and install GTK3 from source 
or check the version of the GTK3 packages installed and try to match the gtkmm branch with that.

License & Contribution
======================
Manabu Desktop is Copyright 2012 K.K. GenSouSha of Aichi, Japan  
All rights reserved.

This software is dual licensed under the GNU GPL version 3 and the AGPL version 3.  
The full text of these licenses can be found here:  
[GPL](https://gnu.org/licenses/gpl.html) [AGPL](https://gnu.org/licenses/agpl.html)  

When submitting code, patches, or pull requests to official GAKU Engine repositories you agree to 
transfer copyright to your code to the GAKU Engine project. This is to prevent an external party 
from controlling code incorporated into GAKU Engine in such a way as to influence the development 
or sub-licensing of GAKU Engine. 

Alternative licenses can be granted upon consultation.  
Please contact info@gakuengine.com for details.
