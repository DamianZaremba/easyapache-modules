Custom EasyApache Modules
=========================

Rather than having to deal with 3rd party Apache modules though multiple after_apache_make_install/posteasyapache hooks it's easier to just have some modules.

In this repo you'll find a bunch of modules, hopefully named in some useful way.

How to install
--------------

`git clone https://github.com/DamianZaremba/easyapache-modules.git /var/cpanel/easy/apache/custom_opt_mods/`

`/scripts/easyapache`

License
-------

Everything in this repo is released under GPLv3

TODO
----

* Write rpm specs for each module
* Probably puppetize somewhat