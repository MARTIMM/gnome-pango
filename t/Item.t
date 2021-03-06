use v6;
#use lib '../gnome-native/lib', '../gnome-gobject/lib';
#use lib '../gnome-native/lib', '../gnome-gtk3/lib';
use NativeCall;
use Test;

use Gnome::Pango::Item;

use Gnome::N::X;
Gnome::N::debug(:on);

#-------------------------------------------------------------------------------
my Gnome::Pango::Item $i;
#-------------------------------------------------------------------------------
subtest 'ISA test', {
  $i .= new;
  isa-ok $i, Gnome::Pango::Item, '.new';
  ok $i.is-valid(), '.is-valid()';
  $i.clear-object();
  nok $i.is-valid(), '.clear-object()';

  $i .= new;
  isa-ok $i, Gnome::Pango::Item, '.new()';
  my Gnome::Pango::Item $i2 = $i.copy;
  isa-ok $i2, Gnome::Pango::Item, '.copy()';
  ok $i.is-valid(), 'copy is also valid';
}

#`{{
#-------------------------------------------------------------------------------
subtest 'Manipulations', {
}

#-------------------------------------------------------------------------------
subtest 'Inherit ...', {
}

#-------------------------------------------------------------------------------
subtest 'Interface ...', {
}

#-------------------------------------------------------------------------------
subtest 'Properties ...', {
}

#-------------------------------------------------------------------------------
subtest 'Themes ...', {
}

#-------------------------------------------------------------------------------
subtest 'Signals ...', {
}
}}

#-------------------------------------------------------------------------------
done-testing;
