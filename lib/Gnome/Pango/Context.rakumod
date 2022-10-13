#TL:1:Gnome::Pango::Context:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Context

Functions to run the rendering pipeline

=head1 Description

The Pango rendering pipeline takes a string of Unicode characters and converts it into glyphs. The functions described in this section accomplish various steps of this process.

=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Context;
  also is Gnome::GObject::Object;

=head2 Example

  my Gnome::Gtk3::Button $button .= new(:label<Stop>);
  my Gnome::Pango::Context $context .= new(
    :native-object($button.get_pango_context)
  );

=end pod

#-------------------------------------------------------------------------------
use NativeCall;

use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::GObject::Object;

#-------------------------------------------------------------------------------
unit class Gnome::Pango::Context:auth<github:MARTIMM>;
also is Gnome::GObject::Object;

#-------------------------------------------------------------------------------

=begin pod
=head1 Methods
=head2 new

Create a new Context object.

  multi method new ( )

Create an object using a native object from elsewhere. See also B<Gnome::GObject::Object>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:0:new():
#TM:0:new(:native-object):

submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  return unless self.^name eq 'Gnome::Pango::Context';

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
    self.set-native-object(pango_context_new());
  }
}

#-------------------------------------------------------------------------------
# no pod. user does not have to know about it.
method _fallback ( $native-sub is copy --> Callable ) {

  my Callable $s;
  try { $s = &::("pango_context_$native-sub"); };
  try { $s = &::("pango_$native-sub"); } unless ?$s;
  try { $s = &::($native-sub); } if !$s and $native-sub ~~ m/^ 'pango_' /;

  self.set-class-name-of-sub('PangoContext');
  $s = callsame unless ?$s;

  $s;
}

#-------------------------------------------------------------------------------
#TM:0:pango_context_new:
=begin pod
=head2 pango_context_new

Creates a new B<PangoContext> initialized to default values.

This function is not particularly useful as it should always
be followed by a C<pango_context_set_font_map()> call, and the
function C<pango_font_map_create_context()> does these two steps
together and hence users are recommended to use that.

If you are using Pango as part of a higher-level system,
that system may have it's own way of create a B<PangoContext>.
For instance, the GTK+ toolkit has, among others,
C<gdk_pango_context_get_for_screen()>, and
C<gtk_widget_get_pango_context()>.  Use those instead.

Return value: the newly allocated B<PangoContext>, which should
be freed with C<g_object_unref()>.

  method pango_context_new ( --> N-GObject  )


=end pod

sub pango_context_new (  )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_changed:
=begin pod
=head2 pango_context_changed

Forces a change in the context, which will cause any B<PangoLayout>
using this context to re-layout.

This function is only useful when implementing a new backend
for Pango, something applications won't do. Backends should
call this function if they have attached extra data to the context
and such data is changed.

Since: 1.32.4

  method pango_context_changed ( )


=end pod

sub pango_context_changed ( N-GObject $context )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_set_font_map:
=begin pod
=head2 [pango_context_] set_font_map

Sets the font map to be searched when fonts are looked-up in this context.
This is only for internal use by Pango backends, a B<PangoContext> obtained
via one of the recommended methods should already have a suitable font map.

  method pango_context_set_font_map ( N-GObject $font_map )

=item N-GObject $font_map; the B<PangoFontMap> to set.

=end pod

sub pango_context_set_font_map ( N-GObject $context, N-GObject $font_map )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_font_map:
=begin pod
=head2 [pango_context_] get_font_map

Gets the B<PangoFontMap> used to look up fonts for this context.

Return value: (transfer none): the font map for the B<PangoContext>.
This value is owned by Pango and should not be unreferenced.

Since: 1.6

  method pango_context_get_font_map ( --> N-GObject  )


=end pod

sub pango_context_get_font_map ( N-GObject $context )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_serial:
=begin pod
=head2 [pango_context_] get_serial

Returns the current serial number of I<context>.  The serial number is
initialized to an small number larger than zero when a new context
is created and is increased whenever the context is changed using any
of the setter functions, or the B<PangoFontMap> it uses to find fonts has
changed. The serial may wrap, but will never have the value 0. Since it
can wrap, never compare it with "less than", always use "not equals".

This can be used to automatically detect changes to a B<PangoContext>, and
is only useful when implementing objects that need update when their
B<PangoContext> changes, like B<PangoLayout>.

Return value: The current serial number of I<context>.

Since: 1.32.4

  method pango_context_get_serial ( --> UInt  )


=end pod

sub pango_context_get_serial ( N-GObject $context )
  returns uint32
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_list_families:
=begin pod
=head2 [pango_context_] list_families

List all families for a context.

  method pango_context_list_families ( PangoFontFamily $families, Int $n_families )

=item PangoFontFamily $families; (out) (array length=n_families) (transfer container): location to store a pointer to an array of B<PangoFontFamily> *. This array should be freed with C<g_free()>.
=item Int $n_families; (out): location to store the number of elements in I<descs>

=end pod

sub pango_context_list_families ( N-GObject $context, N-GObject $families, int32 $n_families )
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_context_load_font:
=begin pod
=head2 [pango_context_] load_font

Loads the font in one of the fontmaps in the context
that is the closest match for I<desc>.

Returns: (transfer full) (nullable): the newly allocated B<PangoFont>
that was loaded, or C<Any> if no font matched.

  method pango_context_load_font ( PangoFontDescription $desc --> N-GObject  )

=item PangoFontDescription $desc; a B<PangoFontDescription> describing the font to load

=end pod

sub pango_context_load_font ( N-GObject $context, PangoFontDescription $desc )
  returns N-GObject
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_context_load_fontset:
=begin pod
=head2 [pango_context_] load_fontset

Load a set of fonts in the context that can be used to render
a font matching I<desc>.

Returns: (transfer full) (nullable): the newly allocated
B<PangoFontset> loaded, or C<Any> if no font matched.

  method pango_context_load_fontset ( PangoFontDescription $desc, N-GObject $language --> N-GObject  )

=item PangoFontDescription $desc; a B<PangoFontDescription> describing the fonts to load
=item N-GObject $language; a B<PangoLanguage> the fonts will be used for

=end pod

sub pango_context_load_fontset ( N-GObject $context, PangoFontDescription $desc, N-GObject $language )
  returns N-GObject
  is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_context_get_metrics:
=begin pod
=head2 [pango_context_] get_metrics

Get overall metric information for a particular font
description.  Since the metrics may be substantially different for
different scripts, a language tag can be provided to indicate that
the metrics should be retrieved that correspond to the script(s)
used by that language.

The B<PangoFontDescription> is interpreted in the same way as
by C<pango_itemize()>, and the family name may be a comma separated
list of figures. If characters from multiple of these families
would be used to render the string, then the returned fonts would
be a composite of the metrics for the fonts loaded for the
individual families.

Return value: a B<PangoFontMetrics> object. The caller must call C<pango_font_metrics_unref()>
when finished using the object.

  method pango_context_get_metrics ( PangoFontDescription $desc, N-GObject $language --> PangoFontMetrics  )

=item PangoFontDescription $desc; (allow-none): a B<PangoFontDescription> structure.  C<Any> means that the font description from the context will be used.
=item N-GObject $language; (allow-none): language tag used to determine which script to get the metrics for. C<Any> means that the language tag from the context will be used. If no language tag is set on the context, metrics for the default language (as determined by C<pango_language_get_default()>) will be returned.

=end pod

sub pango_context_get_metrics ( N-GObject $context, PangoFontDescription $desc, N-GObject $language )
  returns PangoFontMetrics
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_set_font_description:
=begin pod
=head2 [pango_context_] set_font_description

Set the default font description for the context

  method pango_context_set_font_description ( PangoFontDescription $desc )

=item PangoFontDescription $desc; the new pango font description

=end pod

sub pango_context_set_font_description ( N-GObject $context, PangoFontDescription $desc )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_font_description:
=begin pod
=head2 [pango_context_] get_font_description

Retrieve the default font description for the context.

Return value: (transfer none): a pointer to the context's default font
description. This value must not be modified or freed.

  method pango_context_get_font_description ( --> PangoFontDescription  )


=end pod

sub pango_context_get_font_description ( N-GObject $context )
  returns PangoFontDescription
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_language:
=begin pod
=head2 [pango_context_] get_language

Retrieves the global language tag for the context.

Return value: the global language tag.

  method pango_context_get_language ( --> N-GObject  )


=end pod

sub pango_context_get_language ( N-GObject $context )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_set_language:
=begin pod
=head2 [pango_context_] set_language

Sets the global language tag for the context.  The default language
for the locale of the running process can be found using
C<pango_language_get_default()>.

  method pango_context_set_language ( N-GObject $language )

=item N-GObject $language; the new language tag.

=end pod

sub pango_context_set_language ( N-GObject $context, N-GObject $language )
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_context_set_base_dir:
=begin pod
=head2 [pango_context_] set_base_dir

Sets the base direction for the context.

The base direction is used in applying the Unicode bidirectional
algorithm; if the I<direction> is C<PANGO_DIRECTION_LTR> or
C<PANGO_DIRECTION_RTL>, then the value will be used as the paragraph
direction in the Unicode bidirectional algorithm.  A value of
C<PANGO_DIRECTION_WEAK_LTR> or C<PANGO_DIRECTION_WEAK_RTL> is used only
for paragraphs that do not contain any strong characters themselves.

  method pango_context_set_base_dir ( PangoDirection $direction )

=item PangoDirection $direction; the new base direction

=end pod

sub pango_context_set_base_dir ( N-GObject $context, PangoDirection $direction )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_base_dir:
=begin pod
=head2 [pango_context_] get_base_dir

Retrieves the base direction for the context. See
C<pango_context_set_base_dir()>.

Return value: the base direction for the context.

  method pango_context_get_base_dir ( --> PangoDirection  )


=end pod

sub pango_context_get_base_dir ( N-GObject $context )
  returns PangoDirection
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_context_set_base_gravity:
=begin pod
=head2 [pango_context_] set_base_gravity

Sets the base gravity for the context.

The base gravity is used in laying vertical text out.

Since: 1.16

  method pango_context_set_base_gravity ( N-GObject $gravity )

=item N-GObject $gravity; the new base gravity

=end pod

sub pango_context_set_base_gravity ( N-GObject $context, N-GObject $gravity )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_base_gravity:
=begin pod
=head2 [pango_context_] get_base_gravity

Retrieves the base gravity for the context. See
C<pango_context_set_base_gravity()>.

Return value: the base gravity for the context.

Since: 1.16

  method pango_context_get_base_gravity ( --> N-GObject  )


=end pod

sub pango_context_get_base_gravity ( N-GObject $context )
  returns N-GObject
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_gravity:
=begin pod
=head2 [pango_context_] get_gravity

Retrieves the gravity for the context. This is similar to
C<pango_context_get_base_gravity()>, except for when the base gravity
is C<PANGO_GRAVITY_AUTO> for which C<pango_gravity_get_for_matrix()> is used
to return the gravity from the current context matrix.

Return value: the resolved gravity for the context.

Since: 1.16

  method pango_context_get_gravity ( --> N-GObject  )


=end pod

sub pango_context_get_gravity ( N-GObject $context )
  returns N-GObject
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_context_set_gravity_hint:
=begin pod
=head2 [pango_context_] set_gravity_hint

Sets the gravity hint for the context.

The gravity hint is used in laying vertical text out, and is only relevant
if gravity of the context as returned by C<pango_context_get_gravity()>
is set C<PANGO_GRAVITY_EAST> or C<PANGO_GRAVITY_WEST>.

Since: 1.16

  method pango_context_set_gravity_hint ( PangoGravityHInt $hint )

=item PangoGravityHInt $hint; the new gravity hint

=end pod

sub pango_context_set_gravity_hint ( N-GObject $context, PangoGravityHint32 $hint )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_gravity_hint:
=begin pod
=head2 [pango_context_] get_gravity_hint

Retrieves the gravity hint for the context. See
C<pango_context_set_gravity_hint()> for details.

Return value: the gravity hint for the context.

Since: 1.16

  method pango_context_get_gravity_hint ( --> PangoGravityHInt  )


=end pod

sub pango_context_get_gravity_hint ( N-GObject $context )
  returns PangoGravityHint32
  is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:pango_context_set_matrix:
=begin pod
=head2 [pango_context_] set_matrix

Sets the transformation matrix that will be applied when rendering
with this context. Note that reported metrics are in the user space
coordinates before the application of the matrix, not device-space
coordinates after the application of the matrix. So, they don't scale
with the matrix, though they may change slightly for different
matrices, depending on how the text is fit to the pixel grid.

Since: 1.6

  method pango_context_set_matrix ( N-GObject $matrix )

=item N-GObject $matrix; (allow-none): a B<PangoMatrix>, or C<Any> to unset any existing matrix. (No matrix set is the same as setting the identity matrix.)

=end pod

sub pango_context_set_matrix ( N-GObject $context, N-GObject $matrix )
  is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango_context_get_matrix:
=begin pod
=head2 [pango_context_] get_matrix

Gets the transformation matrix that will be applied when
rendering with this context. See C<pango_context_set_matrix()>.

Return value: (nullable): the matrix, or C<Any> if no matrix has
been set (which is the same as the identity matrix). The returned
matrix is owned by Pango and must not be modified or freed.

Since: 1.6

  method pango_context_get_matrix ( --> N-GObject  )


=end pod

sub pango_context_get_matrix ( N-GObject $context )
  returns N-GObject
  is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_itemize:
=begin pod
=head2 pango_itemize

Breaks a piece of text into segments with consistent
directional level and shaping engine. Each byte of I<text> will
be contained in exactly one of the items in the returned list;
the generated list of items will be in logical order (the start
offsets of the items are ascending).

I<cached_iter> should be an iterator over I<attrs> currently positioned at a
range before or containing I<start_index>; I<cached_iter> will be advanced to
the range covering the position just after I<start_index> + I<length>.
(i.e. if itemizing in a loop, just keep passing in the same I<cached_iter>).

Return value: (transfer full) (element-type Pango.Item): a B<GList> of B<PangoItem>
structures. The items should be freed using C<pango_item_free()>
probably in combination with C<g_list_foreach()>, and the list itself
using C<g_list_free()>.

  method pango_itemize ( Str $text, Int $start_index, Int $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList  )

=item Str $text; the text to itemize.
=item Int $start_index; first byte in I<text> to process
=item Int $length; the number of bytes (not characters) to process after I<start_index>. This must be >= 0.
=item PangoAttrList $attrs; the set of attributes that apply to I<text>.
=item PangoAttrIterator $cached_iter; (allow-none): Cached attribute iterator, or C<Any>

=end pod

sub pango_itemize ( N-GObject $context, Str $text, int32 $start_index, int32 $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter )
  returns N-GList
  is native(&pango-lib)
  { * }
}}
#`{{
#-------------------------------------------------------------------------------
#TM:0:pango_itemize_with_base_dir:
=begin pod
=head2 pango_itemize_with_base_dir

Like C<pango_itemize()>, but the base direction to use when
computing bidirectional levels (see C<pango_context_set_base_dir()>),
is specified explicitly rather than gotten from the B<PangoContext>.

Return value: (transfer full) (element-type Pango.Item): a B<GList> of
B<PangoItem> structures.  The items should be freed using
C<pango_item_free()> probably in combination with
C<g_list_foreach()>, and the list itself using C<g_list_free()>.

Since: 1.4

  method pango_itemize_with_base_dir ( PangoDirection $base_dir, Str $text, Int $start_index, Int $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList  )

=item PangoDirection $base_dir; base direction to use for bidirectional processing
=item Str $text; the text to itemize.
=item Int $start_index; first byte in I<text> to process
=item Int $length; the number of bytes (not characters) to process after I<start_index>. This must be >= 0.
=item PangoAttrList $attrs; the set of attributes that apply to I<text>.
=item PangoAttrIterator $cached_iter; (allow-none): Cached attribute iterator, or C<Any>

=end pod

sub pango_itemize_with_base_dir ( N-GObject $context, PangoDirection $base_dir, Str $text, int32 $start_index, int32 $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter )
  returns N-GList
  is native(&pango-lib)
  { * }
}}
