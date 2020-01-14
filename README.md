![gtk logo][logo]

# Gnome Pango - Internationalized text layout and rendering

<!--
[![License](http://martimm.github.io/label/License-label.svg)](http://www.perlfoundation.org/artistic_license_2_0)
-->

Documentation can be found at [this site](http://martimm.github.io/gnome-gtk3) and has the `GNU Free Documentation License`.

# Description



# Versions of involved software

* Program is tested against the latest version of **Raku** on **rakudo** en **moarvm**. It is also necessary to have the (almost) newest compiler, because there are some code changes which made e.g. variable argument lists to the native subs possible. Older compilers cannot handle that (before summer 2019 I believe). This means that Rakudo Star is not usable because the newest release is from March 2019.

  Some steps to follow if you want to be at the top of things. You need `git` to get software from the github site.
  1) Make a directory to work in e.g. Raku
  2) Go in that directory and run `git clone https://github.com/rakudo/rakudo.git`
  3) Then go into the created rakudo directory
  4) Run `perl Configure.pl --gen-moar --gen-nqp --backends=moar`
  5) Run `make test`
  6) And run `make install`

  Subsequent updates of the Raku compiler and moarvm can be installed with
  1) Go into the rakudo directory
  2) Run `git pull`
  then repeat steps 4 to 6 from above

  Your path must then be set to the program directories where `$Rakudo` is your  `rakudo` directory;
  `${PATH}:$Rakudo/install/bin:$Rakudo/install/share/perl6/site/bin`

  You can read the README for more details on the same site: https://github.com/rakudo/rakudo

  After this, you will notice that the `raku` command is available next to `perl6` so it is also a move forward in the renaming of perl6.

  The rakudo star installation must be removed, because otherwise there will be two raku compilers wanting to be the captain on your ship. Also all modules must be reinstalled of course and are installed at `$Rakudo/install/share/perl6/site`.

* Gtk library used **Gtk 3.24**. The versioning of GTK+ is a bit different in that there is also a 3.90 and up. This is only meant as a prelude to version 4. So do not use those versions for the perl packages.


# Installation
There are several dependencies from one package to the other because it was one package in the past. To get all packages, just install the *Gnome::Gtk3* package and the rest will be installed with it.

`zef install Gnome::Gtk3`

# Issues

There are always some problems! If you find one, please help by filing an issue at [my github project](https://github.com/MARTIMM/gnome-gtk3/issues).

# Attribution
* First of all, I would like to thank the developers of the `GTK::Simple` project because of the information I got while reading the code. Also because one of the files is copied unaltered for which I did not had to think about to get that right. The examples in that project are also useful to compare code with each other and to see what is or is not possible.
* The inventors of Raku, formerly known as Perl 6, of course and the writers of the documentation which helped me out every time again and again.
* The builders of the GTK+ library and the documentation.
* Other helpful modules for their insight and use.

# Author

Name: **Marcel Timmerman**
Github account name: **MARTIMM**

[//]: # (---- [refs] ----------------------------------------------------------)
[//]: # (Pod documentation rendered with)
[//]: # (pod-render.pl6 --md --d=../gnome-gtk3/docs/content-docs/references/Pango lib)
