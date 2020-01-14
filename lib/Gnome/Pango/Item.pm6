#TL:0:Gnome::Pango::Item:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Item

Rendering — Functions to run the rendering pipeline

=head1 Description

The Pango rendering pipeline takes a string of Unicode characters and converts it into glyphs. The functions described in this section accomplish various steps of this process.

![](images/pipeline.png)


=begin comment
=head2 Implemented Interfaces

Gnome::Pango::Item implements
=comment item Gnome::Atk::ImplementorIface
=comment item [Gnome::Gtk3::Buildable](Buildable.html)
=comment item [Gnome::Gtk3::Orientable](Orientable.html)

=head2 Known implementations

Gnome::Pango::Item is implemented by

=item

=end comment



=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Item;

=comment  also does Gnome::Gtk3::Buildable;
=comment  also does Gnome::Gtk3::Orientable;

=comment head2 Example

=end pod
#-------------------------------------------------------------------------------
use NativeCall;

use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;


#use Gnome::Gtk3::Orientable;
#use Gnome::Gtk3::Buildable;

#-------------------------------------------------------------------------------
# /usr/include/gtk-3.0/gtk/INCLUDE
# https://developer.gnome.org/WWW
unit class Gnome::Pango::Item:auth<github:MARTIMM>;

#also does Gnome::Gtk3::Buildable;
#also does Gnome::Gtk3::Orientable;

#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoAnalysis

The B<PangoAnalysis> structure stores information about
the properties of a segment of text.


=item PangoEngineShape $.shape_engine: the engine for doing rendering-system-dependent processing.
=item PangoEngineLang $.lang_engine: the engine for doing rendering-system-independent processing.
=item PangoFont $.font: the font for this segment.
=item UInt $.level: the bidirectional level for this segment.
=item ___gravity: the glyph orientation for this segment (A B<PangoGravity>).
=item UInt $.flags: boolean flags for this segment (currently only one) (Since: 1.16).
=item ___script: the detected script for this segment (A B<PangoScript>) (Since: 1.18).
=item PangoLanguage $.language: the detected language for this segment.
=item N-GSList $.extra_attrs: extra attributes for this segment.


=end pod

#TT:0:N-PangoAnalysis:
class N-PangoAnalysis is export is repr('CStruct') {
  has PangoEngineShape $.shape_engine;
  has PangoEngineLang $.lang_engine;
  has PangoFont $.font;
  has byte $.level;
  has byte $.flags;
  has PangoLanguage $.language;
  has N-GSList $.extra_attrs;
}

#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoItem

The B<PangoItem> structure stores information about a segment of text.


=item Int $.offset: byte offset of the start of this item in text.
=item Int $.length: length of this item in bytes.
=item Int $.num_chars: number of Unicode characters in the item.
=item PangoAnalysis $.analysis: analysis results for the item.


=end pod

#TT:0:N-PangoItem:
class N-PangoItem is export is repr('CStruct') {
  has int32 $.offset;
  has int32 $.length;
  has int32 $.num_chars;
  has PangoAnalysis $.analysis;
}

#-------------------------------------------------------------------------------

=begin pod
=head1 Methods
=head2 new

Create a new plain object.

  multi method new ( Bool :empty! )

Create an object using a native object from elsewhere. See also B<Gnome::GObject::Object>.

  multi method new ( N-GObject :$widget! )

Create an object using a native object from a builder. See also B<Gnome::GObject::Object>.

  multi method new ( Str :$build-id! )

=end pod

#TM:0:new():inheriting
#TM:0:new(:empty):
#TM:0:new(:widget):
#TM:0:new(:build-id):

submethod BUILD ( *%options ) {



  # prevent creating wrong widgets
  return unless self.^name eq 'Gnome::Pango::Item';

  # process all named arguments
  if ? %options<empty> {
    # self.native-gobject(pango_item_new());
  }

  elsif ? %options<widget> || %options<build-id> {
    # provided in Gnome::GObject::Object
  }

  elsif %options.keys.elems {
    die X::Gnome.new(
      :message('Unsupported options for ' ~ self.^name ~
               ': ' ~ %options.keys.join(', ')
              )
    );
  }

  # only after creating the widget, the gtype is known
  self.set-class-info('PangoItem');
}

#-------------------------------------------------------------------------------
# no pod. user does not have to know about it.
method _fallback ( $native-sub is copy --> Callable ) {

  my Callable $s;
  try { $s = &::("pango_item_$native-sub"); };
# check for gtk_, gdk_ or g_ !!!
  try { $s = &::("gtk_$native-sub"); } unless ?$s;
  try { $s = &::($native-sub); } if !$s and $native-sub ~~ m/^ 'gtk_' /;
#  $s = self._buildable_interface($native-sub) unless ?$s;
#  $s = self._orientable_interface($native-sub) unless ?$s;

  self.set-class-name-of-sub('PangoItem');
  $s = callsame unless ?$s;

  $s;
}


#-------------------------------------------------------------------------------
#TM:0:pango_item_new:
=begin pod
=head2 pango_item_new

Creates a new B<PangoItem> structure initialized to default values.

Return value: the newly allocated B<PangoItem>, which should
be freed with C<pango_item_free()>.

  method pango_item_new ( --> PangoItem  )


=end pod

sub pango_item_new (  )
  returns PangoItem
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_item_copy:
=begin pod
=head2 pango_item_copy

Copy an existing B<PangoItem> structure.

Return value: (nullable): the newly allocated B<PangoItem>, which
should be freed with C<pango_item_free()>, or C<Any> if
I<item> was C<Any>.

  method pango_item_copy ( --> PangoItem  )


=end pod

sub pango_item_copy ( PangoItem $item )
  returns PangoItem
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_item_free:
=begin pod
=head2 pango_item_free

Free a B<PangoItem> and all associated memory.

  method pango_item_free ( )


=end pod

sub pango_item_free ( PangoItem $item )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_item_split:
=begin pod
=head2 pango_item_split

Modifies I<orig> to cover only the text after I<split_index>, and
returns a new item that covers the text before I<split_index> that
used to be in I<orig>. You can think of I<split_index> as the length of
the returned item. I<split_index> may not be 0, and it may not be
greater than or equal to the length of I<orig> (that is, there must
be at least one byte assigned to each item, you can't create a
zero-length item). I<split_offset> is the length of the first item in
chars, and must be provided because the text used to generate the
item isn't available, so C<pango_item_split()> can't count the char
length of the split items itself.

Return value: new item representing text before I<split_index>, which
should be freed with C<pango_item_free()>.

  method pango_item_split ( Int $split_index, Int $split_offset --> PangoItem  )

=item Int $split_index; byte index of position to split item, relative to the start of the item
=item Int $split_offset; number of chars between start of I<orig> and I<split_index>

=end pod

sub pango_item_split ( PangoItem $orig, int32 $split_index, int32 $split_offset )
  returns PangoItem
  is native(&pango-lib)
  { * }
