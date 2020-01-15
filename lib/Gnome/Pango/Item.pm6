#TL:1:Gnome::Pango::Item:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Item

Rendering — Functions to run the rendering pipeline

=head1 Description

The Pango rendering pipeline takes a string of Unicode characters and converts it into glyphs. The functions described in this section accomplish various steps of this process.

![](images/pipeline.png)


=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Item;
  also is Gnome::GObject::Boxed;

=comment  also does Gnome::Gtk3::Buildable;
=comment  also does Gnome::Gtk3::Orientable;

=comment head2 Example

=end pod
#-------------------------------------------------------------------------------
use NativeCall;

use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::GObject::Boxed;

#-------------------------------------------------------------------------------
# /usr/include/gtk-3.0/gtk/INCLUDE
# https://developer.gnome.org/WWW
unit class Gnome::Pango::Item:auth<github:MARTIMM>;
also is Gnome::GObject::Boxed;

#-------------------------------------------------------------------------------
#`{{ PangoEngineShape & PangoEngineLang are deprecated!
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

# TT:0:N-PangoAnalysis:
class N-PangoAnalysis is export is repr('CStruct') {
  has PangoEngineShape $.shape_engine;
  has PangoEngineLang $.lang_engine;
  has PangoFont $.font;
  has byte $.level;
  has byte $.flags;
  has PangoLanguage $.language;
  has N-GSList $.extra_attrs;
}
}}

#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoItem

The B<N-PangoItem> structure stores information about a segment of text.

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
  has Pointer $.analysis;
#  has PangoAnalysis $.analysis;
}

#-------------------------------------------------------------------------------
=begin pod
=head1 Methods
=head2 new

Create a new pango item.

  multi method new ( Bool :empty! )

Create an object using a native object from elsewhere. See also B<Gnome::GObject::Object>.

  multi method new ( N-GObject :$native-object! )

Create an object using a native object from a builder. See also B<Gnome::GObject::Object>.

  multi method new ( Str :$build-id! )

=end pod

#TM:1:new():
#TM:1:new(:empty):

submethod BUILD ( *%options ) {

  # prevent creating wrong widgets
  return unless self.^name eq 'Gnome::Pango::Item';

  # process all named arguments
  if ? %options<empty> {
    DEPRECATED( 'new(:empty)', 'new(:empty)', '0.2.0');
    self.set-native-object(pango_item_new());
    self.set-valid(True);
  }

  elsif %options.keys.elems {
    die X::Gnome.new(
      :message('Unsupported options for ' ~ self.^name ~
               ': ' ~ %options.keys.join(', ')
              )
    );
  }

  # no options mean :empty
  else {
    self.set-native-object(pango_item_new());
    self.set-valid(True);
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
  try { $s = &::("pango_$native-sub"); } unless ?$s;
  try { $s = &::($native-sub); } if !$s and $native-sub ~~ m/^ 'gtk_' /;
#  $s = self._buildable_interface($native-sub) unless ?$s;
#  $s = self._orientable_interface($native-sub) unless ?$s;

  self.set-class-name-of-sub('PangoItem');
  $s = callsame unless ?$s;

  $s;
}

#-------------------------------------------------------------------------------
submethod DESTROY ( ) {
  _pango_item_free(self.get-native-object) if self.is-valid;
}

#-------------------------------------------------------------------------------
#TM:0:clear-object
=begin pod
=head2 clear-object

Clear the native object and return data to memory pool. The object is not valid after this call and C<.is-valid()> will return C<False>.

  method clear-object ()

=end pod

method clear-object ( ) {

  if self.is-valid {
    _pango_item_free(self.get-native-object);
    self.set-valid(False);
    self.set-native-object(Any);
  }
}

#-------------------------------------------------------------------------------
#TM:2:pango_item_new::new(:empty)
=begin pod
=head2 pango_item_new

Creates a new B<N-PangoItem> structure initialized to default values.

Return value: the newly allocated B<N-PangoItem>, which should
be freed with C<pango_item_free()>.

  method pango_item_new ( --> N-PangoItem )

=end pod

sub pango_item_new (  )
  returns N-PangoItem
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_item_copy:
=begin pod
=head2 pango_item_copy

Copy an existing B<N-PangoItem> structure.

Return value: the newly allocated B<N-PangoItem>, which should be cleared with C<clear-object()>.

  method pango_item_copy ( --> N-PangoItem  )

=end pod

sub pango_item_copy ( N-PangoItem $item )
  returns N-PangoItem
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#`{{ No doc, user
# TM:0:pango_item_free:
=begin pod
=head2 pango_item_free

Free a B<N-PangoItem> and all associated memory.

  method pango_item_free ( )


=end pod
}}
sub _pango_item_free ( N-PangoItem $item )
  is native(&pango-lib)
  is symbol('pango_item_free')
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

  method pango_item_split ( Int $split_index, Int $split_offset --> N-PangoItem  )

=item Int $split_index; byte index of position to split item, relative to the start of the item
=item Int $split_offset; number of chars between start of I<orig> and I<split_index>

=end pod

sub pango_item_split ( N-PangoItem $orig, int32 $split_index, int32 $split_offset )
  returns N-PangoItem
  is native(&pango-lib)
  { * }
