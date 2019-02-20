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
