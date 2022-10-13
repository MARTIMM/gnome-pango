#TL:0:Gnome::Pango::Layout:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Layout

High-level layout driver objects

=head1 Description

While complete access to the layout capabilities of Pango is provided using the detailed interfaces for itemization and shaping, using that functionality directly involves writing a fairly large amount of code. The objects and functions in this section provide a high-level driver for formatting entire paragraphs of text at once.

=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Layout;
  also is Gnome::GObject::Object;

=comment head2 Example

=end pod
#-------------------------------------------------------------------------------
use NativeCall;

use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::GObject::Object;
use Gnome::Glib::SList;

#-------------------------------------------------------------------------------
# /usr/include/gtk-3.0/gtk/INCLUDE
# https://developer.gnome.org/WWW
unit class Gnome::Pango::Layout:auth<github:MARTIMM>;
also is Gnome::GObject::Object;

#-------------------------------------------------------------------------------
=begin pod
=head1 Types
=end pod
#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoAlignment

A B<PangoAlignment> describes how to align the lines of a B<PangoLayout> within the
available space. If the B<PangoLayout> is set to justify
using C<pango_layout_set_justify()>, this only has effect for partial lines.


=item PANGO_ALIGN_LEFT: Put all available space on the right
=item PANGO_ALIGN_CENTER: Center the line within the available space
=item PANGO_ALIGN_RIGHT: Put all available space on the left


=end pod

#TE:0:PangoAlignment:
enum PangoAlignment is export (
  'PANGO_ALIGN_LEFT',
  'PANGO_ALIGN_CENTER',
  'PANGO_ALIGN_RIGHT'
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoWrapMode

A B<PangoWrapMode> describes how to wrap the lines of a B<PangoLayout> to the desired width.


=item PANGO_WRAP_WORD: wrap lines at word boundaries.
=item PANGO_WRAP_CHAR: wrap lines at character boundaries.
=item PANGO_WRAP_WORD_CHAR: wrap lines at word boundaries, but fall back to character boundaries if there is not enough space for a full word.


=end pod

#TE:0:PangoWrapMode:
enum PangoWrapMode is export (
  'PANGO_WRAP_WORD',
  'PANGO_WRAP_CHAR',
  'PANGO_WRAP_WORD_CHAR'
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoEllipsizeMode

The B<PangoEllipsizeMode> type describes what sort of (if any)
ellipsization should be applied to a line of text. In
the ellipsization process characters are removed from the
text in order to make it fit to a given width and replaced
with an ellipsis.


=item PANGO_ELLIPSIZE_NONE: No ellipsization
=item PANGO_ELLIPSIZE_START: Omit characters at the start of the text
=item PANGO_ELLIPSIZE_MIDDLE: Omit characters in the middle of the text
=item PANGO_ELLIPSIZE_END: Omit characters at the end of the text


=end pod

#TE:0:PangoEllipsizeMode:
enum PangoEllipsizeMode is export (
  'PANGO_ELLIPSIZE_NONE',
  'PANGO_ELLIPSIZE_START',
  'PANGO_ELLIPSIZE_MIDDLE',
  'PANGO_ELLIPSIZE_END'
);


#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoLayoutLine

The B<PangoLayoutLine> structure represents one of the lines resulting
from laying out a paragraph via B<PangoLayout>. B<PangoLayoutLine>
structures are obtained by calling C<pango_layout_get_line()> and
are only valid until the text, attributes, or settings of the
parent B<PangoLayout> are modified.

Routines for rendering PangoLayout objects are provided in
code specific to each rendering system.


=item N-GObject $.layout: (allow-none): the layout this line belongs to, might be C<Any>
=item ___start_index: start of line as byte index into layout->text
=item ___length: length of line in bytes
=item N-GSList $.runs: (allow-none) (element-type Pango.LayoutRun): list of runs in the line, from left to right
=item ___is_paragraph_start: B<TRUE> if this is the first line of the paragraph
=item ___resolved_dir: B<Resolved> PangoDirection of line


=end pod

#TT:0:N-PangoLayoutLine:
class N-PangoLayoutLine is export is repr('CStruct') {
  has N-GObject $.layout;
  has N-GSList $.runs;
}

#-------------------------------------------------------------------------------

=begin pod
=head1 Methods
=head2 new

Create a new default object.

  multi method new ( )

Create an object using a native object from elsewhere. See also B<Gnome::GObject::Object>.

  multi method new ( N-GObject :$native-object! )

Create an object using a native object from a builder. See also B<Gnome::GObject::Object>.

  multi method new ( Str :$build-id! )

=end pod

#TM:0:new():inheriting
#TM:0:new():
#TM:0:new(:native-object):
#TM:0:new(:build-id):

submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  return unless self.^name eq 'Gnome::Pango::Layout';

  # process all named arguments
  if ? %options<widget> || ? %options<native-object> ||
     ? %options<build-id> {
    # provided in Gnome::GObject::Object
  }

  elsif %options.keys.elems {
    die X::Gnome.new(
      :message('Unsupported, undefined or wrongly typed options for ' ~
               self.^name ~ ': ' ~ %options.keys.join(', ')
              )
    );
  }

  # create default object
  else {
    # self.set-native-object(pango_layout_new());
  }

  # only after creating the native-object, the gtype is known
  self.set-class-info('PangoLayout');
}

#-------------------------------------------------------------------------------
# no pod. user does not have to know about it.
method _fallback ( $native-sub is copy --> Callable ) {

  my Callable $s;
  try { $s = &::("pango_layout_$native-sub"); };
  try { $s = &::("pango_$native-sub"); } unless ?$s;
  try { $s = &::($native-sub); } if !$s and $native-sub ~~ m/^ 'pango_' /;

  self.set-class-name-of-sub('PangoLayout');
  $s = callsame unless ?$s;

  $s;
}


#-------------------------------------------------------------------------------
#TM:0:pango_layout_new:
=begin pod
=head2 pango_layout_new

Create a new B<PangoLayout> object with attributes initialized to
default values for a particular B<PangoContext>.

Return value: the newly allocated B<PangoLayout>, with a reference
count of one, which should be freed with
C<g_object_unref()>.

  method pango_layout_new ( N-GObject $context --> N-GObject  )

=item N-GObject $context; a B<PangoContext>

=end pod

sub pango_layout_new ( N-GObject $context )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_copy:
=begin pod
=head2 pango_layout_copy

Does a deep copy-by-value of the I<src> layout. The attribute list,
tab array, and text from the original layout are all copied by
value.

Return value: (transfer full): the newly allocated B<PangoLayout>,
with a reference count of one, which should be freed
with C<g_object_unref()>.

  method pango_layout_copy ( --> N-GObject  )


=end pod

sub pango_layout_copy ( N-GObject $src )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_context:
=begin pod
=head2 [pango_layout_] get_context

Retrieves the B<PangoContext> used for this layout.

Return value: (transfer none): the B<PangoContext> for the layout.
This does not have an additional refcount added, so if you want to
keep a copy of this around, you must reference it yourself.

  method pango_layout_get_context ( --> N-GObject  )


=end pod

sub pango_layout_get_context ( N-GObject $layout )
  returns N-GObject
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_attributes:
=begin pod
=head2 [pango_layout_] set_attributes

Sets the text attributes for a layout object.
References I<attrs>, so the caller can unref its reference.

  method pango_layout_set_attributes ( PangoAttrList $attrs )

=item PangoAttrList $attrs; (allow-none) (transfer none): a B<PangoAttrList>, can be C<Any>

=end pod

sub pango_layout_set_attributes ( N-GObject $layout, PangoAttrList $attrs )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_attributes:
=begin pod
=head2 [pango_layout_] get_attributes

Gets the attribute list for the layout, if any.

Return value: (transfer none): a B<PangoAttrList>.

  method pango_layout_get_attributes ( --> PangoAttrList  )


=end pod

sub pango_layout_get_attributes ( N-GObject $layout )
  returns PangoAttrList
  is native(&pango-lib)
  { * }
}}
#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_text:
=begin pod
=head2 [pango_layout_] set_text

Sets the text of the layout.

Note that if you have used
C<pango_layout_set_markup()> or C<pango_layout_set_markup_with_accel()> on
I<layout> before, you may want to call C<pango_layout_set_attributes()> to clear
the attributes set on the layout from the markup as this function does not
clear attributes.

  method pango_layout_set_text ( Str $text, Int $length )

=item Str $text; a valid UTF-8 string
=item Int $length; maximum length of I<text>, in bytes. -1 indicates that the string is nul-terminated and the length should be calculated.  The text will also be truncated on encountering a nul-termination even when I<length> is positive.

=end pod

sub pango_layout_set_text ( N-GObject $layout, Str $text, int32 $length )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_text:
=begin pod
=head2 [pango_layout_] get_text

Gets the text in the layout. The returned text should not
be freed or modified.

Return value: the text in the I<layout>.

  method pango_layout_get_text ( --> Str  )


=end pod

sub pango_layout_get_text ( N-GObject $layout )
  returns Str
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_character_count:
=begin pod
=head2 [pango_layout_] get_character_count

Returns the number of Unicode characters in the
the text of I<layout>.

Return value: the number of Unicode characters
in the text of I<layout>

Since: 1.30

  method pango_layout_get_character_count ( --> Int  )


=end pod

sub pango_layout_get_character_count ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_markup:
=begin pod
=head2 [pango_layout_] set_markup

Same as C<pango_layout_set_markup_with_accel()>, but
the markup text isn't scanned for accelerators.


  method pango_layout_set_markup ( Str $markup, Int $length )

=item Str $markup; marked-up text
=item Int $length; length of marked-up text in bytes, or -1 if I<markup> is null-terminated

=end pod

sub pango_layout_set_markup ( N-GObject $layout, Str $markup, int32 $length )
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_markup_with_accel:
=begin pod
=head2 [pango_layout_] set_markup_with_accel

Sets the layout text and attribute list from marked-up text (see
<link linkend="PangoMarkupFormat">markup format</link>). Replaces
the current text and attribute list.

If I<accel_marker> is nonzero, the given character will mark the
character following it as an accelerator. For example, I<accel_marker>
might be an ampersand or underscore. All characters marked
as an accelerator will receive a C<PANGO_UNDERLINE_LOW> attribute,
and the first character so marked will be returned in I<accel_char>.
Two I<accel_marker> characters following each other produce a single
literal I<accel_marker> character.

  method pango_layout_set_markup_with_accel ( Str $markup, Int $length, gunichar $accel_marker, guniStr $accel_char )

=item Str $markup; marked-up text (see <link linkend="PangoMarkupFormat">markup format</link>)
=item Int $length; length of marked-up text in bytes, or -1 if I<markup> is null-terminated
=item gunichar $accel_marker; marker for accelerators in the text
=item guniStr $accel_char; (out caller-allocates) (allow-none): return location for first located accelerator, or C<Any>

=end pod

sub pango_layout_set_markup_with_accel ( N-GObject $layout, Str $markup, int32 $length, guniint8 $accel_marker, guniStr $accel_char )
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_font_description:
=begin pod
=head2 [pango_layout_] set_font_description

Sets the default font description for the layout. If no font
description is set on the layout, the font description from
the layout's context is used.

  method pango_layout_set_font_description ( PangoFontDescription $desc )

=item PangoFontDescription $desc; (allow-none): the new B<PangoFontDescription>, or C<Any> to unset the current font description

=end pod

sub pango_layout_set_font_description ( N-GObject $layout, PangoFontDescription $desc )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_font_description:
=begin pod
=head2 [pango_layout_] get_font_description

Gets the font description for the layout, if any.

Return value: (nullable): a pointer to the layout's font
description, or C<Any> if the font description from the layout's
context is inherited. This value is owned by the layout and must
not be modified or freed.

Since: 1.8

  method pango_layout_get_font_description ( --> PangoFontDescription  )


=end pod

sub pango_layout_get_font_description ( N-GObject $layout )
  returns PangoFontDescription
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_width:
=begin pod
=head2 [pango_layout_] set_width

Sets the width to which the lines of the B<PangoLayout> should wrap or
ellipsized.  The default value is -1: no width set.

  method pango_layout_set_width ( Int $width )

=item Int $width; the desired width in Pango units, or -1 to indicate that no wrapping or ellipsization should be performed.

=end pod

sub pango_layout_set_width ( N-GObject $layout, int32 $width )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_width:
=begin pod
=head2 [pango_layout_] get_width

Gets the width to which the lines of the B<PangoLayout> should wrap.

Return value: the width in Pango units, or -1 if no width set.

  method pango_layout_get_width ( --> Int  )


=end pod

sub pango_layout_get_width ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_height:
=begin pod
=head2 [pango_layout_] set_height

Sets the height to which the B<PangoLayout> should be ellipsized at.  There
are two different behaviors, based on whether I<height> is positive or
negative.

If I<height> is positive, it will be the maximum height of the layout.  Only
lines would be shown that would fit, and if there is any text omitted,
an ellipsis added.  At least one line is included in each paragraph regardless
of how small the height value is.  A value of zero will render exactly one
line for the entire layout.

If I<height> is negative, it will be the (negative of) maximum number of lines per
paragraph.  That is, the total number of lines shown may well be more than
this value if the layout contains multiple paragraphs of text.
The default value of -1 means that first line of each paragraph is ellipsized.
This behvaior may be changed in the future to act per layout instead of per
paragraph.  File a bug against pango at <ulink
url="http://bugzilla.gnome.org/">http://bugzilla.gnome.org/</ulink> if your
code relies on this behavior.

Height setting only has effect if a positive width is set on
I<layout> and ellipsization mode of I<layout> is not C<PANGO_ELLIPSIZE_NONE>.
The behavior is undefined if a height other than -1 is set and
ellipsization mode is set to C<PANGO_ELLIPSIZE_NONE>, and may change in the
future.

Since: 1.20

  method pango_layout_set_height ( Int $height )

=item Int $height; the desired height of the layout in Pango units if positive, or desired number of lines if negative.

=end pod

sub pango_layout_set_height ( N-GObject $layout, int32 $height )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_height:
=begin pod
=head2 [pango_layout_] get_height

Gets the height of layout used for ellipsization.  See
C<pango_layout_set_height()> for details.

Return value: the height, in Pango units if positive, or
number of lines if negative.

Since: 1.20

  method pango_layout_get_height ( --> Int  )


=end pod

sub pango_layout_get_height ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_wrap:
=begin pod
=head2 [pango_layout_] set_wrap

Sets the wrap mode; the wrap mode only has effect if a width
is set on the layout with C<pango_layout_set_width()>.
To turn off wrapping, set the width to -1.

  method pango_layout_set_wrap ( PangoWrapMode $wrap )

=item PangoWrapMode $wrap; the wrap mode

=end pod

sub pango_layout_set_wrap ( N-GObject $layout, int32 $wrap )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_wrap:
=begin pod
=head2 [pango_layout_] get_wrap

Gets the wrap mode for the layout.

Use C<pango_layout_is_wrapped()> to query whether any paragraphs
were actually wrapped.

Return value: active wrap mode.

  method pango_layout_get_wrap ( --> PangoWrapMode  )


=end pod

sub pango_layout_get_wrap ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_is_wrapped:
=begin pod
=head2 [pango_layout_] is_wrapped

Queries whether the layout had to wrap any paragraphs.

This returns C<1> if a positive width is set on I<layout>,
ellipsization mode of I<layout> is set to C<PANGO_ELLIPSIZE_NONE>,
and there are paragraphs exceeding the layout width that have
to be wrapped.

Return value: C<1> if any paragraphs had to be wrapped, C<0>
otherwise.

Since: 1.16

  method pango_layout_is_wrapped ( --> Int  )


=end pod

sub pango_layout_is_wrapped ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_indent:
=begin pod
=head2 [pango_layout_] set_indent

Sets the width in Pango units to indent each paragraph. A negative value
of I<indent> will produce a hanging indentation. That is, the first line will
have the full width, and subsequent lines will be indented by the
absolute value of I<indent>.

The indent setting is ignored if layout alignment is set to
C<PANGO_ALIGN_CENTER>.

  method pango_layout_set_indent ( Int $indent )

=item Int $indent; the amount by which to indent.

=end pod

sub pango_layout_set_indent ( N-GObject $layout, int32 $indent )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_indent:
=begin pod
=head2 [pango_layout_] get_indent

Gets the paragraph indent width in Pango units. A negative value
indicates a hanging indentation.

Return value: the indent in Pango units.

  method pango_layout_get_indent ( --> Int  )


=end pod

sub pango_layout_get_indent ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_spacing:
=begin pod
=head2 [pango_layout_] set_spacing

Sets the amount of spacing in Pango unit between the lines of the
layout.

  method pango_layout_set_spacing ( Int $spacing )

=item Int $spacing; the amount of spacing

=end pod

sub pango_layout_set_spacing ( N-GObject $layout, int32 $spacing )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_spacing:
=begin pod
=head2 [pango_layout_] get_spacing

Gets the amount of spacing between the lines of the layout.

Return value: the spacing in Pango units.

  method pango_layout_get_spacing ( --> Int  )


=end pod

sub pango_layout_get_spacing ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_justify:
=begin pod
=head2 [pango_layout_] set_justify

Sets whether each complete line should be stretched to
fill the entire width of the layout. This stretching is typically
done by adding whitespace, but for some scripts (such as Arabic),
the justification may be done in more complex ways, like extending
the characters.

Note that this setting is not implemented and so is ignored in Pango
older than 1.18.

  method pango_layout_set_justify ( Int $justify )

=item Int $justify; whether the lines in the layout should be justified.

=end pod

sub pango_layout_set_justify ( N-GObject $layout, int32 $justify )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_justify:
=begin pod
=head2 [pango_layout_] get_justify

Gets whether each complete line should be stretched to fill the entire
width of the layout.

Return value: the justify.

  method pango_layout_get_justify ( --> Int  )


=end pod

sub pango_layout_get_justify ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_auto_dir:
=begin pod
=head2 [pango_layout_] set_auto_dir

Sets whether to calculate the bidirectional base direction
for the layout according to the contents of the layout;
when this flag is on (the default), then paragraphs in
(Arabic and Hebrew principally), will have right-to-left
layout, paragraphs with letters from other scripts will
have left-to-right layout. Paragraphs with only neutral
characters get their direction from the surrounding paragraphs.

When C<0>, the choice between left-to-right and
right-to-left layout is done according to the base direction
of the layout's B<PangoContext>. (See C<pango_context_set_base_dir()>).

When the auto-computed direction of a paragraph differs from the
base direction of the context, the interpretation of
C<PANGO_ALIGN_LEFT> and C<PANGO_ALIGN_RIGHT> are swapped.

Since: 1.4

  method pango_layout_set_auto_dir ( Int $auto_dir )

=item Int $auto_dir; if C<1>, compute the bidirectional base direction from the layout's contents.

=end pod

sub pango_layout_set_auto_dir ( N-GObject $layout, int32 $auto_dir )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_auto_dir:
=begin pod
=head2 [pango_layout_] get_auto_dir

Gets whether to calculate the bidirectional base direction
for the layout according to the contents of the layout.
See C<pango_layout_set_auto_dir()>.

Return value: C<1> if the bidirectional base direction
is computed from the layout's contents, C<0> otherwise.

Since: 1.4

  method pango_layout_get_auto_dir ( --> Int  )


=end pod

sub pango_layout_get_auto_dir ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_alignment:
=begin pod
=head2 [pango_layout_] set_alignment

Sets the alignment for the layout: how partial lines are
positioned within the horizontal space available.

  method pango_layout_set_alignment ( PangoAlignment $alignment )

=item PangoAlignment $alignment; the alignment

=end pod

sub pango_layout_set_alignment ( N-GObject $layout, int32 $alignment )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_alignment:
=begin pod
=head2 [pango_layout_] get_alignment

Gets the alignment for the layout: how partial lines are
positioned within the horizontal space available.

Return value: the alignment.

  method pango_layout_get_alignment ( --> PangoAlignment  )


=end pod

sub pango_layout_get_alignment ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_tabs:
=begin pod
=head2 [pango_layout_] set_tabs

Sets the tabs to use for I<layout>, overriding the default tabs
(by default, tabs are every 8 spaces). If I<tabs> is C<Any>, the default
tabs are reinstated. I<tabs> is copied into the layout; you must
free your copy of I<tabs> yourself.

  method pango_layout_set_tabs ( PangoTabArray $tabs )

=item PangoTabArray $tabs; (allow-none): a B<PangoTabArray>, or C<Any>

=end pod

sub pango_layout_set_tabs ( N-GObject $layout, PangoTabArray $tabs )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_tabs:
=begin pod
=head2 [pango_layout_] get_tabs

Gets the current B<PangoTabArray> used by this layout. If no
B<PangoTabArray> has been set, then the default tabs are in use
and C<Any> is returned. Default tabs are every 8 spaces.
The return value should be freed with C<pango_tab_array_free()>.

Return value: (nullable): a copy of the tabs for this layout, or
C<Any>.

  method pango_layout_get_tabs ( --> PangoTabArray  )


=end pod

sub pango_layout_get_tabs ( N-GObject $layout )
  returns PangoTabArray
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_single_paragraph_mode:
=begin pod
=head2 [pango_layout_] set_single_paragraph_mode

If I<setting> is C<1>, do not treat newlines and similar characters
as paragraph separators; instead, keep all text in a single paragraph,
and display a glyph for paragraph separator characters. Used when
you want to allow editing of newlines on a single text line.

  method pango_layout_set_single_paragraph_mode ( Int $setting )

=item Int $setting; new setting

=end pod

sub pango_layout_set_single_paragraph_mode ( N-GObject $layout, int32 $setting )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_single_paragraph_mode:
=begin pod
=head2 [pango_layout_] get_single_paragraph_mode

Obtains the value set by C<pango_layout_set_single_paragraph_mode()>.

Return value: C<1> if the layout does not break paragraphs at
paragraph separator characters, C<0> otherwise.

  method pango_layout_get_single_paragraph_mode ( --> Int  )


=end pod

sub pango_layout_get_single_paragraph_mode ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_set_ellipsize:
=begin pod
=head2 [pango_layout_] set_ellipsize

Sets the type of ellipsization being performed for I<layout>.
Depending on the ellipsization mode I<ellipsize> text is
removed from the start, middle, or end of text so they
fit within the width and height of layout set with
C<pango_layout_set_width()> and C<pango_layout_set_height()>.

If the layout contains characters such as newlines that
force it to be layed out in multiple paragraphs, then whether
each paragraph is ellipsized separately or the entire layout
is ellipsized as a whole depends on the set height of the layout.
See C<pango_layout_set_height()> for details.

Since: 1.6

  method pango_layout_set_ellipsize ( PangoEllipsizeMode $ellipsize )

=item PangoEllipsizeMode $ellipsize; the new ellipsization mode for I<layout>

=end pod

sub pango_layout_set_ellipsize ( N-GObject $layout, int32 $ellipsize )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_ellipsize:
=begin pod
=head2 [pango_layout_] get_ellipsize

Gets the type of ellipsization being performed for I<layout>.
See C<pango_layout_set_ellipsize()>

Return value: the current ellipsization mode for I<layout>.

Use C<pango_layout_is_ellipsized()> to query whether any paragraphs
were actually ellipsized.

Since: 1.6

  method pango_layout_get_ellipsize ( --> PangoEllipsizeMode  )


=end pod

sub pango_layout_get_ellipsize ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_is_ellipsized:
=begin pod
=head2 [pango_layout_] is_ellipsized

Queries whether the layout had to ellipsize any paragraphs.

This returns C<1> if the ellipsization mode for I<layout>
is not C<PANGO_ELLIPSIZE_NONE>, a positive width is set on I<layout>,
and there are paragraphs exceeding that width that have to be
ellipsized.

Return value: C<1> if any paragraphs had to be ellipsized, C<0>
otherwise.

Since: 1.16

  method pango_layout_is_ellipsized ( --> Int  )


=end pod

sub pango_layout_is_ellipsized ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_unknown_glyphs_count:
=begin pod
=head2 [pango_layout_] get_unknown_glyphs_count

Counts the number unknown glyphs in I<layout>.  That is, zero if
glyphs for all characters in the layout text were found, or more
than zero otherwise.

This function can be used to determine if there are any fonts
available to render all characters in a certain string, or when
used in combination with C<PANGO_ATTR_FALLBACK>, to check if a
certain font supports all the characters in the string.

Return value: The number of unknown glyphs in I<layout>.

Since: 1.16

  method pango_layout_get_unknown_glyphs_count ( --> Int  )


=end pod

sub pango_layout_get_unknown_glyphs_count ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_context_changed:
=begin pod
=head2 [pango_layout_] context_changed

Forces recomputation of any state in the B<PangoLayout> that
might depend on the layout's context. This function should
be called if you make changes to the context subsequent
to creating the layout.

  method pango_layout_context_changed ( )


=end pod

sub pango_layout_context_changed ( N-GObject $layout )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_serial:
=begin pod
=head2 [pango_layout_] get_serial

Returns the current serial number of I<layout>.  The serial number is
initialized to an small number  larger than zero when a new layout
is created and is increased whenever the layout is changed using any
of the setter functions, or the B<PangoContext> it uses has changed.
The serial may wrap, but will never have the value 0. Since it
can wrap, never compare it with "less than", always use "not equals".

This can be used to automatically detect changes to a B<PangoLayout>, and
is useful for example to decide whether a layout needs redrawing.
To force the serial to be increased, use C<pango_layout_context_changed()>.

Return value: The current serial number of I<layout>.

Since: 1.32.4

  method pango_layout_get_serial ( --> UInt  )


=end pod

sub pango_layout_get_serial ( N-GObject $layout )
  returns uint32
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_log_attrs:
=begin pod
=head2 [pango_layout_] get_log_attrs

Retrieves an array of logical attributes for each character in
the I<layout>.

  method pango_layout_get_log_attrs ( PangoLogAttr $attrs, Int $n_attrs )

=item PangoLogAttr $attrs; (out)(array length=n_attrs)(transfer container): location to store a pointer to an array of logical attributes This value must be freed with C<g_free()>.
=item Int $n_attrs; (out): location to store the number of the attributes in the array. (The stored value will be one more than the total number of characters in the layout, since there need to be attributes corresponding to both the position before the first character and the position after the last character.)

=end pod

sub pango_layout_get_log_attrs ( N-GObject $layout, PangoLogAttr $attrs, int32 $n_attrs )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_log_attrs_readonly:
=begin pod
=head2 [pango_layout_] get_log_attrs_readonly

Retrieves an array of logical attributes for each character in
the I<layout>.

This is a faster alternative to C<pango_layout_get_log_attrs()>.
The returned array is part of I<layout> and must not be modified.
Modifying the layout will invalidate the returned array.

The number of attributes returned in I<n_attrs> will be one more
than the total number of characters in the layout, since there
need to be attributes corresponding to both the position before
the first character and the position after the last character.

Returns: (array length=n_attrs): an array of logical attributes

Since: 1.30

  method pango_layout_get_log_attrs_readonly ( Int $n_attrs --> PangoLogAttr  )

=item Int $n_attrs; (out): location to store the number of the attributes in the array

=end pod

sub pango_layout_get_log_attrs_readonly ( N-GObject $layout, int32 $n_attrs )
  returns PangoLogAttr
  is native(&pango-lib)
  { * }
}}
#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_index_to_pos:
=begin pod
=head2 [pango_layout_] index_to_pos

Converts from an index within a B<PangoLayout> to the onscreen position
corresponding to the grapheme at that index, which is represented
as rectangle.  Note that <literal>pos->x</literal> is always the leading
edge of the grapheme and <literal>pos->x + pos->width</literal> the trailing
edge of the grapheme. If the directionality of the grapheme is right-to-left,
then <literal>pos->width</literal> will be negative.

  method pango_layout_index_to_pos ( Int $index_, PangoRectangle $pos )

=item Int $index_; byte index within I<layout>
=item PangoRectangle $pos; (out): rectangle in which to store the position of the grapheme

=end pod

sub pango_layout_index_to_pos ( N-GObject $layout, int32 $index_, PangoRectangle $pos )
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_layout_index_to_line_x:
=begin pod
=head2 [pango_layout_] index_to_line_x

Converts from byte I<index_> within the I<layout> to line and X position.
(X position is measured from the left edge of the line)

  method pango_layout_index_to_line_x ( Int $index_, Int $trailing, Int $line, Int $x_pos )

=item Int $index_; the byte index of a grapheme within the layout.
=item Int $trailing; an integer indicating the edge of the grapheme to retrieve the position of. If > 0, the trailing edge of the grapheme, if 0, the leading of the grapheme.
=item Int $line; (out) (allow-none): location to store resulting line index. (which will between 0 and pango_layout_get_line_count(layout) - 1), or C<Any>
=item Int $x_pos; (out) (allow-none): location to store resulting position within line (C<PANGO_SCALE> units per device unit), or C<Any>

=end pod

sub pango_layout_index_to_line_x ( N-GObject $layout, int32 $index_, int32 $trailing, int32 $line, int32 $x_pos )
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_cursor_pos:
=begin pod
=head2 [pango_layout_] get_cursor_pos

Given an index within a layout, determines the positions that of the
strong and weak cursors if the insertion point is at that
index. The position of each cursor is stored as a zero-width
rectangle. The strong cursor location is the location where
characters of the directionality equal to the base direction of the
layout are inserted.  The weak cursor location is the location
where characters of the directionality opposite to the base
direction of the layout are inserted.

  method pango_layout_get_cursor_pos ( Int $index_, PangoRectangle $strong_pos, PangoRectangle $weak_pos )

=item Int $index_; the byte index of the cursor
=item PangoRectangle $strong_pos; (out) (allow-none): location to store the strong cursor position (may be C<Any>)
=item PangoRectangle $weak_pos; (out) (allow-none): location to store the weak cursor position (may be C<Any>)

=end pod

sub pango_layout_get_cursor_pos ( N-GObject $layout, int32 $index_, PangoRectangle $strong_pos, PangoRectangle $weak_pos )
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_layout_move_cursor_visually:
=begin pod
=head2 [pango_layout_] move_cursor_visually

Computes a new cursor position from an old position and
a count of positions to move visually. If I<direction> is positive,
then the new strong cursor position will be one position
to the right of the old cursor position. If I<direction> is negative,
then the new strong cursor position will be one position
to the left of the old cursor position.

In the presence of bidirectional text, the correspondence
between logical and visual order will depend on the direction
of the current run, and there may be jumps when the cursor
is moved off of the end of a run.

Motion here is in cursor positions, not in characters, so a
single call to C<pango_layout_move_cursor_visually()> may move the
cursor over multiple characters when multiple characters combine
to form a single grapheme.

  method pango_layout_move_cursor_visually ( Int $strong, Int $old_index, Int $old_trailing, Int $direction, Int $new_index, Int $new_trailing )

=item Int $strong; whether the moving cursor is the strong cursor or the weak cursor. The strong cursor is the cursor corresponding to text insertion in the base direction for the layout.
=item Int $old_index; the byte index of the grapheme for the old index
=item Int $old_trailing; if 0, the cursor was at the leading edge of the grapheme indicated by I<old_index>, if > 0, the cursor was at the trailing edge.
=item Int $direction; direction to move cursor. A negative value indicates motion to the left.
=item Int $new_index; (out): location to store the new cursor byte index. A value of -1 indicates that the cursor has been moved off the beginning of the layout. A value of C<G_MAXINT> indicates that the cursor has been moved off the end of the layout.
=item Int $new_trailing; (out): number of characters to move forward from the location returned for I<new_index> to get the position where the cursor should be displayed. This allows distinguishing the position at the beginning of one line from the position at the end of the preceding line. I<new_index> is always on the line where the cursor should be displayed.

=end pod

sub pango_layout_move_cursor_visually ( N-GObject $layout, int32 $strong, int32 $old_index, int32 $old_trailing, int32 $direction, int32 $new_index, int32 $new_trailing )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_xy_to_index:
=begin pod
=head2 [pango_layout_] xy_to_index

Converts from X and Y position within a layout to the byte
index to the character at that logical position. If the
Y position is not inside the layout, the closest position is chosen
(the position will be clamped inside the layout). If the
X position is not within the layout, then the start or the
end of the line is chosen as described for C<pango_layout_line_x_to_index()>.
If either the X or Y positions were not inside the layout, then the
function returns C<0>; on an exact hit, it returns C<1>.

Return value: C<1> if the coordinates were inside text, C<0> otherwise.

  method pango_layout_xy_to_index ( Int $x, Int $y, Int $index_, Int $trailing --> Int  )

=item Int $x; the X offset (in Pango units) from the left edge of the layout.
=item Int $y; the Y offset (in Pango units) from the top edge of the layout
=item Int $index_; (out):   location to store calculated byte index
=item Int $trailing; (out): location to store a integer indicating where in the grapheme the user clicked. It will either be zero, or the number of characters in the grapheme. 0 represents the leading edge of the grapheme.

=end pod

sub pango_layout_xy_to_index ( N-GObject $layout, int32 $x, int32 $y, int32 $index_, int32 $trailing )
  returns int32
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_extents:
=begin pod
=head2 [pango_layout_] get_extents

Computes the logical and ink extents of I<layout>. Logical extents
are usually what you want for positioning things.  Note that both extents
may have non-zero x and y.  You may want to use those to offset where you
render the layout.  Not doing that is a very typical bug that shows up as
right-to-left layouts not being correctly positioned in a layout with
a set width.

The extents are given in layout coordinates and in Pango units; layout
coordinates begin at the top left corner of the layout.

  method pango_layout_get_extents ( PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoRectangle $ink_rect; (out) (allow-none): rectangle used to store the extents of the layout as drawn or C<Any> to indicate that the result is not needed.
=item PangoRectangle $logical_rect; (out) (allow-none):rectangle used to store the logical extents of the layout or C<Any> to indicate that the result is not needed.

=end pod

sub pango_layout_get_extents ( N-GObject $layout, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_pixel_extents:
=begin pod
=head2 [pango_layout_] get_pixel_extents

Computes the logical and ink extents of I<layout> in device units.
This function just calls C<pango_layout_get_extents()> followed by
two C<pango_extents_to_pixels()> calls, rounding I<ink_rect> and I<logical_rect>
such that the rounded rectangles fully contain the unrounded one (that is,
passes them as first argument to C<pango_extents_to_pixels()>).

  method pango_layout_get_pixel_extents ( PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoRectangle $ink_rect; (out) (allow-none): rectangle used to store the extents of the layout as drawn or C<Any> to indicate that the result is not needed.
=item PangoRectangle $logical_rect; (out) (allow-none): rectangle used to store the logical extents of the layout or C<Any> to indicate that the result is not needed.

=end pod

sub pango_layout_get_pixel_extents ( N-GObject $layout, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_size:
=begin pod
=head2 [pango_layout_] get_size

Determines the logical width and height of a B<PangoLayout>
in Pango units (device units scaled by C<PANGO_SCALE>). This
is simply a convenience function around C<pango_layout_get_extents()>.

  method pango_layout_get_size ( Int $width, Int $height )

=item Int $width; (out) (allow-none): location to store the logical width, or C<Any>
=item Int $height; (out) (allow-none): location to store the logical height, or C<Any>

=end pod

sub pango_layout_get_size ( N-GObject $layout, int32 $width, int32 $height )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_pixel_size:
=begin pod
=head2 [pango_layout_] get_pixel_size

Determines the logical width and height of a B<PangoLayout>
in device units. (C<pango_layout_get_size()> returns the width
and height scaled by C<PANGO_SCALE>.) This
is simply a convenience function around
C<pango_layout_get_pixel_extents()>.

  method pango_layout_get_pixel_size ( Int $width, Int $height )

=item Int $width; (out) (allow-none): location to store the logical width, or C<Any>
=item Int $height; (out) (allow-none): location to store the logical height, or C<Any>

=end pod

sub pango_layout_get_pixel_size ( N-GObject $layout, int32 $width, int32 $height )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_baseline:
=begin pod
=head2 [pango_layout_] get_baseline

Gets the Y position of baseline of the first line in I<layout>.

Return value: baseline of first line, from top of I<layout>.

Since: 1.22

  method pango_layout_get_baseline ( --> Int  )


=end pod

sub pango_layout_get_baseline ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_line_count:
=begin pod
=head2 [pango_layout_] get_line_count

Retrieves the count of lines for the I<layout>.

Return value: the line count.

  method pango_layout_get_line_count ( --> Int  )


=end pod

sub pango_layout_get_line_count ( N-GObject $layout )
  returns int32
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_line:
=begin pod
=head2 [pango_layout_] get_line

Retrieves a particular line from a B<PangoLayout>.

Use the faster C<pango_layout_get_line_readonly()> if you do not plan
to modify the contents of the line (glyphs, glyph widths, etc.).

Return value: (transfer none) (nullable): the requested
B<PangoLayoutLine>, or C<Any> if the index is out of
range. This layout line can be ref'ed and retained,
but will become invalid if changes are made to the
B<PangoLayout>.

  method pango_layout_get_line ( Int $line --> PangoLayoutLine  )

=item Int $line; the index of a line, which must be between 0 and <literal>pango_layout_get_line_count(layout) - 1</literal>, inclusive.

=end pod

sub pango_layout_get_line ( N-GObject $layout, int32 $line )
  returns PangoLayoutLine
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_line_readonly:
=begin pod
=head2 [pango_layout_] get_line_readonly

Retrieves a particular line from a B<PangoLayout>.

This is a faster alternative to C<pango_layout_get_line()>,
but the user is not expected
to modify the contents of the line (glyphs, glyph widths, etc.).

Return value: (transfer none) (nullable): the requested
B<PangoLayoutLine>, or C<Any> if the index is out of
range. This layout line can be ref'ed and retained,
but will become invalid if changes are made to the
B<PangoLayout>.  No changes should be made to the line.

Since: 1.16

  method pango_layout_get_line_readonly ( Int $line --> PangoLayoutLine  )

=item Int $line; the index of a line, which must be between 0 and <literal>pango_layout_get_line_count(layout) - 1</literal>, inclusive.

=end pod

sub pango_layout_get_line_readonly ( N-GObject $layout, int32 $line )
  returns PangoLayoutLine
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_lines:
=begin pod
=head2 [pango_layout_] get_lines

Returns the lines of the I<layout> as a list.

Use the faster C<pango_layout_get_lines_readonly()> if you do not plan
to modify the contents of the lines (glyphs, glyph widths, etc.).

Return value: (element-type Pango.LayoutLine) (transfer none): a B<GSList> containing
the lines in the layout. This points to internal data of the B<PangoLayout>
and must be used with care. It will become invalid on any change to the layout's
text or properties.

  method pango_layout_get_lines ( --> N-GSList  )


=end pod

sub pango_layout_get_lines ( N-GObject $layout )
  returns N-GSList
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_lines_readonly:
=begin pod
=head2 [pango_layout_] get_lines_readonly

Returns the lines of the I<layout> as a list.

This is a faster alternative to C<pango_layout_get_lines()>,
but the user is not expected
to modify the contents of the lines (glyphs, glyph widths, etc.).

Return value: (element-type Pango.LayoutLine) (transfer none): a B<GSList> containing
the lines in the layout. This points to internal data of the B<PangoLayout> and
must be used with care. It will become invalid on any change to the layout's
text or properties.  No changes should be made to the lines.

Since: 1.16

  method pango_layout_get_lines_readonly ( --> N-GSList  )


=end pod

sub pango_layout_get_lines_readonly ( N-GObject $layout )
  returns N-GSList
  is native(&pango-lib)
  { * }
#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_ref:
=begin pod
=head2 [pango_layout_] line_ref

Increase the reference count of a B<PangoLayoutLine> by one.

Return value: the line passed in.

Since: 1.10

  method pango_layout_line_ref ( PangoLayoutLine $line --> PangoLayoutLine  )

=item PangoLayoutLine $line; (nullable): a B<PangoLayoutLine>, may be C<Any>

=end pod

sub pango_layout_line_ref ( PangoLayoutLine $line )
  returns PangoLayoutLine
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_unref:
=begin pod
=head2 [pango_layout_] line_unref

Decrease the reference count of a B<PangoLayoutLine> by one.
If the result is zero, the line and all associated memory
will be freed.

  method pango_layout_line_unref ( PangoLayoutLine $line )

=item PangoLayoutLine $line; a B<PangoLayoutLine>

=end pod

sub pango_layout_line_unref ( PangoLayoutLine $line )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_x_to_index:
=begin pod
=head2 [pango_layout_] line_x_to_index

Converts from x offset to the byte index of the corresponding
character within the text of the layout. If I<x_pos> is outside the line,
I<index_> and I<trailing> will point to the very first or very last position
in the line. This determination is based on the resolved direction
of the paragraph; for example, if the resolved direction is
right-to-left, then an X position to the right of the line (after it)
results in 0 being stored in I<index_> and I<trailing>. An X position to the
left of the line results in I<index_> pointing to the (logical) last
grapheme in the line and I<trailing> being set to the number of characters
in that grapheme. The reverse is true for a left-to-right line.

Return value: C<0> if I<x_pos> was outside the line, C<1> if inside

  method pango_layout_line_x_to_index ( PangoLayoutLine $line, Int $x_pos, Int $index_, Int $trailing --> Int  )

=item PangoLayoutLine $line; a B<PangoLayoutLine>
=item Int $x_pos; the X offset (in Pango units) from the left edge of the line.
=item Int $index_; (out):   location to store calculated byte index for the grapheme in which the user clicked.
=item Int $trailing; (out): location to store an integer indicating where in the grapheme the user clicked. It will either be zero, or the number of characters in the grapheme. 0 represents the leading edge of the grapheme.

=end pod

sub pango_layout_line_x_to_index ( PangoLayoutLine $line, int32 $x_pos, int32 $index_, int32 $trailing )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_index_to_x:
=begin pod
=head2 [pango_layout_] line_index_to_x

Converts an index within a line to a X position.


  method pango_layout_line_index_to_x ( PangoLayoutLine $line, Int $index_, Int $trailing, Int $x_pos )

=item PangoLayoutLine $line; a B<PangoLayoutLine>
=item Int $index_; byte offset of a grapheme within the layout
=item Int $trailing; an integer indicating the edge of the grapheme to retrieve the position of. If > 0, the trailing edge of the grapheme, if 0, the leading of the grapheme.
=item Int $x_pos; (out): location to store the x_offset (in Pango unit)

=end pod

sub pango_layout_line_index_to_x ( PangoLayoutLine $line, int32 $index_, int32 $trailing, int32 $x_pos )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_get_x_ranges:
=begin pod
=head2 [pango_layout_] line_get_x_ranges

Gets a list of visual ranges corresponding to a given logical range.
This list is not necessarily minimal - there may be consecutive
ranges which are adjacent. The ranges will be sorted from left to
right. The ranges are with respect to the left edge of the entire
layout, not with respect to the line.

  method pango_layout_line_get_x_ranges ( PangoLayoutLine $line, Int $start_index, Int $end_index, Int $ranges, Int $n_ranges )

=item PangoLayoutLine $line; a B<PangoLayoutLine>
=item Int $start_index; Start byte index of the logical range. If this value is less than the start index for the line, then the first range will extend all the way to the leading edge of the layout. Otherwise it will start at the leading edge of the first character.
=item Int $end_index; Ending byte index of the logical range. If this value is greater than the end index for the line, then the last range will extend all the way to the trailing edge of the layout. Otherwise, it will end at the trailing edge of the last character.
=item Int $ranges; (out) (array length=n_ranges) (transfer full): location to store a pointer to an array of ranges. The array will be of length <literal>2*n_ranges</literal>, with each range starting at <literal>(*ranges)[2*n]</literal> and of width <literal>(*ranges)[2*n + 1] - (*ranges)[2*n]</literal>. This array must be freed with C<g_free()>. The coordinates are relative to the layout and are in Pango units.
=item Int $n_ranges; The number of ranges stored in I<ranges>.

=end pod

sub pango_layout_line_get_x_ranges ( PangoLayoutLine $line, int32 $start_index, int32 $end_index, int32 $ranges, int32 $n_ranges )
  is native(&pango-lib)
  { * }
}}
#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_get_extents:
=begin pod
=head2 [pango_layout_] line_get_extents

Computes the logical and ink extents of a layout line. See
C<pango_font_get_glyph_extents()> for details about the interpretation
of the rectangles.

  method pango_layout_line_get_extents ( PangoLayoutLine $line, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoLayoutLine $line; a B<PangoLayoutLine>
=item PangoRectangle $ink_rect; (out) (allow-none): rectangle used to store the extents of the glyph string as drawn, or C<Any>
=item PangoRectangle $logical_rect; (out) (allow-none):rectangle used to store the logical extents of the glyph string, or C<Any>

=end pod

sub pango_layout_line_get_extents ( PangoLayoutLine $line, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_line_get_pixel_extents:
=begin pod
=head2 [pango_layout_] line_get_pixel_extents

Computes the logical and ink extents of I<layout_line> in device units.
This function just calls C<pango_layout_line_get_extents()> followed by
two C<pango_extents_to_pixels()> calls, rounding I<ink_rect> and I<logical_rect>
such that the rounded rectangles fully contain the unrounded one (that is,
passes them as first argument to C<pango_extents_to_pixels()>).

  method pango_layout_line_get_pixel_extents ( PangoLayoutLine $layout_line, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoLayoutLine $layout_line; a B<PangoLayoutLine>
=item PangoRectangle $ink_rect; (out) (allow-none): rectangle used to store the extents of the glyph string as drawn, or C<Any>
=item PangoRectangle $logical_rect; (out) (allow-none): rectangle used to store the logical extents of the glyph string, or C<Any>

=end pod

sub pango_layout_line_get_pixel_extents ( PangoLayoutLine $layout_line, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_get_iter:
=begin pod
=head2 [pango_layout_] get_iter

Returns an iterator to iterate over the visual extents of the layout.

Return value: the new B<PangoLayoutIter> that should be freed using
C<pango_layout_iter_free()>.

  method pango_layout_get_iter ( --> PangoLayoutIter  )


=end pod

sub pango_layout_get_iter ( N-GObject $layout )
  returns PangoLayoutIter
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_copy:
=begin pod
=head2 [pango_layout_] iter_copy

Copies a B<PangoLayoutIter>.

Return value: (nullable): the newly allocated B<PangoLayoutIter>,
which should be freed with C<pango_layout_iter_free()>,
or C<Any> if I<iter> was C<Any>.

Since: 1.20

  method pango_layout_iter_copy ( PangoLayoutIter $iter --> PangoLayoutIter  )

=item PangoLayoutIter $iter; (nullable): a B<PangoLayoutIter>, may be C<Any>

=end pod

sub pango_layout_iter_copy ( PangoLayoutIter $iter )
  returns PangoLayoutIter
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_free:
=begin pod
=head2 [pango_layout_] iter_free

Frees an iterator that's no longer in use.

  method pango_layout_iter_free ( PangoLayoutIter $iter )

=item PangoLayoutIter $iter; (nullable): a B<PangoLayoutIter>, may be C<Any>

=end pod

sub pango_layout_iter_free ( PangoLayoutIter $iter )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_index:
=begin pod
=head2 [pango_layout_] iter_get_index

Gets the current byte index. Note that iterating forward by char
moves in visual order, not logical order, so indexes may not be
sequential. Also, the index may be equal to the length of the text
in the layout, if on the C<Any> run (see C<pango_layout_iter_get_run()>).

Return value: current byte index.

  method pango_layout_iter_get_index ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_index ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_run:
=begin pod
=head2 [pango_layout_] iter_get_run

Gets the current run. When iterating by run, at the end of each
line, there's a position with a C<Any> run, so this function can return
C<Any>. The C<Any> run at the end of each line ensures that all lines have
at least one run, even lines consisting of only a newline.

Use the faster C<pango_layout_iter_get_run_readonly()> if you do not plan
to modify the contents of the run (glyphs, glyph widths, etc.).

Return value: (transfer none) (nullable): the current run.

  method pango_layout_iter_get_run ( PangoLayoutIter $iter --> PangoLayoutRun  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_run ( PangoLayoutIter $iter )
  returns PangoLayoutRun
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_run_readonly:
=begin pod
=head2 [pango_layout_] iter_get_run_readonly

Gets the current run. When iterating by run, at the end of each
line, there's a position with a C<Any> run, so this function can return
C<Any>. The C<Any> run at the end of each line ensures that all lines have
at least one run, even lines consisting of only a newline.

This is a faster alternative to C<pango_layout_iter_get_run()>,
but the user is not expected
to modify the contents of the run (glyphs, glyph widths, etc.).

Return value: (transfer none) (nullable): the current run, that
should not be modified.

Since: 1.16

  method pango_layout_iter_get_run_readonly ( PangoLayoutIter $iter --> PangoLayoutRun  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_run_readonly ( PangoLayoutIter $iter )
  returns PangoLayoutRun
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_line:
=begin pod
=head2 [pango_layout_] iter_get_line

Gets the current line.

Use the faster C<pango_layout_iter_get_line_readonly()> if you do not plan
to modify the contents of the line (glyphs, glyph widths, etc.).

Return value: the current line.

  method pango_layout_iter_get_line ( PangoLayoutIter $iter --> PangoLayoutLine  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_line ( PangoLayoutIter $iter )
  returns PangoLayoutLine
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_line_readonly:
=begin pod
=head2 [pango_layout_] iter_get_line_readonly

Gets the current line for read-only access.

This is a faster alternative to C<pango_layout_iter_get_line()>,
but the user is not expected
to modify the contents of the line (glyphs, glyph widths, etc.).

Return value: (transfer none): the current line, that should not be
modified.

Since: 1.16

  method pango_layout_iter_get_line_readonly ( PangoLayoutIter $iter --> PangoLayoutLine  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_line_readonly ( PangoLayoutIter $iter )
  returns PangoLayoutLine
  is native(&pango-lib)
  { * }
}}
#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_at_last_line:
=begin pod
=head2 [pango_layout_] iter_at_last_line

Determines whether I<iter> is on the last line of the layout.

Return value: C<1> if I<iter> is on the last line.

  method pango_layout_iter_at_last_line ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_at_last_line ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_layout:
=begin pod
=head2 [pango_layout_] iter_get_layout

Gets the layout associated with a B<PangoLayoutIter>.

Return value: (transfer none): the layout associated with I<iter>.

Since: 1.20

  method pango_layout_iter_get_layout ( PangoLayoutIter $iter --> N-GObject  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_layout ( PangoLayoutIter $iter )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_next_char:
=begin pod
=head2 [pango_layout_] iter_next_char

Moves I<iter> forward to the next character in visual order. If I<iter> was already at
the end of the layout, returns C<0>.

Return value: whether motion was possible.

  method pango_layout_iter_next_char ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_next_char ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_next_cluster:
=begin pod
=head2 [pango_layout_] iter_next_cluster

Moves I<iter> forward to the next cluster in visual order. If I<iter>
was already at the end of the layout, returns C<0>.

Return value: whether motion was possible.

  method pango_layout_iter_next_cluster ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_next_cluster ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_next_run:
=begin pod
=head2 [pango_layout_] iter_next_run

Moves I<iter> forward to the next run in visual order. If I<iter> was
already at the end of the layout, returns C<0>.

Return value: whether motion was possible.

  method pango_layout_iter_next_run ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_next_run ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_next_line:
=begin pod
=head2 [pango_layout_] iter_next_line

Moves I<iter> forward to the start of the next line. If I<iter> is
already on the last line, returns C<0>.

Return value: whether motion was possible.

  method pango_layout_iter_next_line ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_next_line ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_char_extents:
=begin pod
=head2 [pango_layout_] iter_get_char_extents

Gets the extents of the current character, in layout coordinates
(origin is the top left of the entire layout). Only logical extents
can sensibly be obtained for characters; ink extents make sense only
down to the level of clusters.


  method pango_layout_iter_get_char_extents ( PangoLayoutIter $iter, PangoRectangle $logical_rect )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>
=item PangoRectangle $logical_rect; (out caller-allocates): rectangle to fill with logical extents

=end pod

sub pango_layout_iter_get_char_extents ( PangoLayoutIter $iter, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }
}}
#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_cluster_extents:
=begin pod
=head2 [pango_layout_] iter_get_cluster_extents

Gets the extents of the current cluster, in layout coordinates
(origin is the top left of the entire layout).


  method pango_layout_iter_get_cluster_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>
=item PangoRectangle $ink_rect; (out) (allow-none): rectangle to fill with ink extents, or C<Any>
=item PangoRectangle $logical_rect; (out) (allow-none): rectangle to fill with logical extents, or C<Any>

=end pod

sub pango_layout_iter_get_cluster_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_run_extents:
=begin pod
=head2 [pango_layout_] iter_get_run_extents

Gets the extents of the current run in layout coordinates
(origin is the top left of the entire layout).


  method pango_layout_iter_get_run_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>
=item PangoRectangle $ink_rect; (out) (allow-none): rectangle to fill with ink extents, or C<Any>
=item PangoRectangle $logical_rect; (out) (allow-none): rectangle to fill with logical extents, or C<Any>

=end pod

sub pango_layout_iter_get_run_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_line_extents:
=begin pod
=head2 [pango_layout_] iter_get_line_extents

Obtains the extents of the current line. I<ink_rect> or I<logical_rect>
can be C<Any> if you aren't interested in them. Extents are in layout
coordinates (origin is the top-left corner of the entire
B<PangoLayout>).  Thus the extents returned by this function will be
the same width/height but not at the same x/y as the extents
returned from C<pango_layout_line_get_extents()>.


  method pango_layout_iter_get_line_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>
=item PangoRectangle $ink_rect; (out) (allow-none): rectangle to fill with ink extents, or C<Any>
=item PangoRectangle $logical_rect; (out) (allow-none): rectangle to fill with logical extents, or C<Any>

=end pod

sub pango_layout_iter_get_line_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_line_yrange:
=begin pod
=head2 [pango_layout_] iter_get_line_yrange

Divides the vertical space in the B<PangoLayout> being iterated over
between the lines in the layout, and returns the space belonging to
the current line.  A line's range includes the line's logical
extents, plus half of the spacing above and below the line, if
C<pango_layout_set_spacing()> has been called to set layout spacing.
The Y positions are in layout coordinates (origin at top left of the
entire layout).


  method pango_layout_iter_get_line_yrange ( PangoLayoutIter $iter, Int $y0_, Int $y1_ )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>
=item Int $y0_; (out) (allow-none): start of line, or C<Any>
=item Int $y1_; (out) (allow-none): end of line, or C<Any>

=end pod

sub pango_layout_iter_get_line_yrange ( PangoLayoutIter $iter, int32 $y0_, int32 $y1_ )
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_layout_extents:
=begin pod
=head2 [pango_layout_] iter_get_layout_extents

Obtains the extents of the B<PangoLayout> being iterated
over. I<ink_rect> or I<logical_rect> can be C<Any> if you
aren't interested in them.


  method pango_layout_iter_get_layout_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>
=item PangoRectangle $ink_rect; (out) (allow-none): rectangle to fill with ink extents, or C<Any>
=item PangoRectangle $logical_rect; (out) (allow-none): rectangle to fill with logical extents, or C<Any>

=end pod

sub pango_layout_iter_get_layout_extents ( PangoLayoutIter $iter, PangoRectangle $ink_rect, PangoRectangle $logical_rect )
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_layout_iter_get_baseline:
=begin pod
=head2 [pango_layout_] iter_get_baseline

Gets the Y position of the current line's baseline, in layout
coordinates (origin at top left of the entire layout).

Return value: baseline of current line.

  method pango_layout_iter_get_baseline ( PangoLayoutIter $iter --> Int  )

=item PangoLayoutIter $iter; a B<PangoLayoutIter>

=end pod

sub pango_layout_iter_get_baseline ( PangoLayoutIter $iter )
  returns int32
  is native(&pango-lib)
  { * }
}}
