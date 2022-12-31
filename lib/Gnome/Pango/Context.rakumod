#TL:1:Gnome::Pango::Context:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Context

Functions to run the rendering pipeline

=head1 Description

A `PangoContext` stores global information used to control the itemization process.

The information stored by `PangoContext` includes the fontmap used to look up fonts, and default values such as the default language, default gravity, or default font.

To obtain a `PangoContext`, use C<Gnome::Pango::Fontmap.create_context()>. This is equivalent to call C<.new()> followed by C<.set-font-map()>. For existing widgets, it is easier to use the C<Gnome::Gtk3::Widget.get-pango-context> call, see the example below.

=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Context;
  also is Gnome::GObject::Object;

=head2 Example

  my Gnome::Gtk3::Button $button .= new(:label<Stop>);
  my Gnome::Pango::Context() $context = $button.get-pango-context;

=end pod

#-------------------------------------------------------------------------------
use NativeCall;

#use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::N::GlibToRakuTypes;

use Gnome::GObject::Object;

use Gnome::Pango::Direction;
use Gnome::Pango::Matrix;
use Gnome::Pango::Gravity;

#-------------------------------------------------------------------------------
unit class Gnome::Pango::Context:auth<github:MARTIMM>;
also is Gnome::GObject::Object;

#-------------------------------------------------------------------------------
=begin pod
=head1 Methods
=head2 new

=head3 default, no options

Create a new Context object.

  multi method new ( )


=head3 :native-object

Create a Context object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:1:new():
#TM:4:new(:native-object):Gnome::N::TopLevelClassSupport

submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::Context' {

    # check if native object is set by a parent class
    if self.is-valid { }

    # check if common options are handled by some parent
    elsif %options<native-object>:exists { }

    # process all other options
    else {
      my $no;
      if ? %options<___x___> {
        #$no = %options<___x___>;
        #$no .= _get-native-object-no-reffing unless $no ~~ N-GObject;
        #$no = _pango_item_new___x___($no);
      }

      elsif %options.elems {
        die X::Gnome.new(
          :message(
            'Unsupported, undefined, incomplete or wrongly typed options for ' ~
            self.^name ~ ': ' ~ %options.keys.join(', ')
          )
        );
      }

      #`{{ when there are no defaults use this
      # check if there are any options
      elsif %options.elems == 0 {
        die X::Gnome.new(:message('No options specified ' ~ self.^name));
      }
      }}

      ##`{{ when there are defaults use this instead
      # create default object
      else {
        $no = _pango_context_new();
      }
      #}}

      self.set-native-object($no);
    }

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoContext');
  }
}

#-------------------------------------------------------------------------------
#TM:0:changed:
=begin pod
=head2 changed

Forces a change in the context, which will cause any `PangoLayout` using this context to re-layout.

This function is only useful when implementing a new backend for Pango, something applications won't do. Backends should call this function if they have attached extra data to the context and such data is changed.

  method changed ( )

=end pod

method changed ( ) {
  pango_context_changed( self._get-native-object-no-reffing);
}

sub pango_context_changed (
  N-GObject $context 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-base-dir:
=begin pod
=head2 get-base-dir

Retrieves the base direction for the context.

See [methodI<Pango>.Context.set_base_dir].

Return value: the base direction for the context.

  method get-base-dir ( --> PangoDirection )

=end pod

method get-base-dir ( --> PangoDirection ) {
  PangoDirection(
    pango_context_get_base_dir(self._get-native-object-no-reffing)
  )
}

sub pango_context_get_base_dir (
  N-GObject $context --> GEnum
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-base-gravity:
=begin pod
=head2 get-base-gravity

Retrieves the base gravity for the context.

See [methodI<Pango>.Context.set_base_gravity].

Return value: the base gravity for the context.

  method get-base-gravity ( --> N-GObject )

=end pod

method get-base-gravity ( --> N-GObject ) {
  pango_context_get_base_gravity( self._get-native-object-no-reffing)
}

sub pango_context_get_base_gravity (
  N-GObject $context --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-font-description:
=begin pod
=head2 get-font-description

Retrieve the default font description for the context.

Return value: : a pointer to the context's default font description. This value must not be modified or freed.

  method get-font-description ( --> N-GObject )

=end pod

method get-font-description ( --> N-GObject ) {
  pango_context_get_font_description( self._get-native-object-no-reffing)
}

sub pango_context_get_font_description (
  N-GObject $context --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-font-map:
=begin pod
=head2 get-font-map

Gets the `PangoFontMap` used to look up fonts for this context.

Return value: : the font map for the `PangoContext`. This value is owned by Pango and should not be unreferenced.

  method get-font-map ( --> N-GObject )

=end pod

method get-font-map ( --> N-GObject ) {
  pango_context_get_font_map( self._get-native-object-no-reffing)
}

sub pango_context_get_font_map (
  N-GObject $context --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-gravity:
=begin pod
=head2 get-gravity

Retrieves the gravity for the context.

This is similar to [methodI<Pango>.Context.get_base_gravity], except for when the base gravity is C<PANGO_GRAVITY_AUTO> for which [funcI<Pango>.Gravity.get_for_matrix] is used to return the gravity from the current context matrix.

Return value: the resolved gravity for the context.

  method get-gravity ( --> N-GObject )

=end pod

method get-gravity ( --> N-GObject ) {
  pango_context_get_gravity( self._get-native-object-no-reffing)
}

sub pango_context_get_gravity (
  N-GObject $context --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-gravity-hint:
=begin pod
=head2 get-gravity-hint

Retrieves the gravity hint for the context.

See [methodI<Pango>.Context.set_gravity_hint] for details.

Return value: the gravity hint for the context.

  method get-gravity-hint ( --> PangoGravityHint )

=end pod

method get-gravity-hint ( --> PangoGravityHint ) {
  PangoGravityHint(
    pango_context_get_gravity_hint( self._get-native-object-no-reffing)
  )
}

sub pango_context_get_gravity_hint (
  N-GObject $context --> GEnum
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-language:
=begin pod
=head2 get-language

Retrieves the global language tag for the context.

Return value: the global language tag.

  method get-language ( --> N-GObject )

=end pod

method get-language ( --> N-GObject ) {
  pango_context_get_language( self._get-native-object-no-reffing)
}

sub pango_context_get_language (
  N-GObject $context --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-matrix:
=begin pod
=head2 get-matrix

Gets the transformation matrix that will be applied when rendering with this context.

See [methodI<Pango>.Context.set_matrix].

Return value: : the matrix, or C<undefined> if no matrix has been set (which is the same as the identity matrix). The returned matrix is owned by Pango and must not be modified or freed.

  method get-matrix ( --> N-GObject )

=end pod

method get-matrix ( --> N-GObject ) {
  pango_context_get_matrix( self._get-native-object-no-reffing)
}

sub pango_context_get_matrix (
  N-GObject $context --> N-GObject
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:get-metrics:
=begin pod
=head2 get-metrics

Get overall metric information for a particular font description.

Since the metrics may be substantially different for different scripts, a language tag can be provided to indicate that the metrics should be retrieved that correspond to the script(s) used by that language.

The `PangoFontDescription` is interpreted in the same way as by [funcI<itemize>], and the family name may be a comma separated list of names. If characters from multiple of these families would be used to render the string, then the returned fonts would be a composite of the metrics for the fonts loaded for the individual families.

Return value: a `PangoFontMetrics` object. The caller must call [methodI<Pango>.FontMetrics.unref] when finished using the object.

  method get-metrics ( N-GObject() $desc, N-GObject() $language --> PangoFontMetrics )

=item $desc; a `PangoFontDescription` structure. C<undefined> means that the font description from the context will be used.
=item $language; language tag used to determine which script to get the metrics for. C<undefined> means that the language tag from the context will be used. If no language tag is set on the context, metrics for the default language (as determined by [funcI<Pango>.Language.get_default] will be returned.
=end pod

method get-metrics ( N-GObject() $desc, N-GObject() $language --> PangoFontMetrics ) {
  pango_context_get_metrics( self._get-native-object-no-reffing, $desc, $language)
}

sub pango_context_get_metrics (
  N-GObject $context, N-GObject $desc, N-GObject $language --> PangoFontMetrics
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:get-round-glyph-positions:
=begin pod
=head2 get-round-glyph-positions

Returns whether font rendering with this context should round glyph positions and widths.

  method get-round-glyph-positions ( --> Bool )

=end pod

method get-round-glyph-positions ( --> Bool ) {
  pango_context_get_round_glyph_positions( self._get-native-object-no-reffing).Bool
}

sub pango_context_get_round_glyph_positions (
  N-GObject $context --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-serial:
=begin pod
=head2 get-serial

Returns the current serial number of I<context>.

The serial number is initialized to an small number larger than zero when a new context is created and is increased whenever the context is changed using any of the setter functions, or the `PangoFontMap` it uses to find fonts has changed. The serial may wrap, but will never have the value 0. Since it can wrap, never compare it with "less than", always use "not equals".

This can be used to automatically detect changes to a `PangoContext`, and is only useful when implementing objects that need update when their `PangoContext` changes, like `PangoLayout`.

Return value: The current serial number of I<context>.

.4

  method get-serial ( --> UInt )

=end pod

method get-serial ( --> UInt ) {
  pango_context_get_serial( self._get-native-object-no-reffing)
}

sub pango_context_get_serial (
  N-GObject $context --> guint
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:list-families:
=begin pod
=head2 list-families

List all families for a context.

  method list-families ( PangoFontFamily $families )

=item $families;  (array length=n_families) (transfer container): location to store a pointer to an array of `PangoFontFamily`. This array should be freed with C<g_free()>.
=item $n_families; location to store the number of elements in I<descs>
=end pod

method list-families ( PangoFontFamily $families ) {
  pango_context_list_families( self._get-native-object-no-reffing, $families, my gint $n_families);
}

sub pango_context_list_families (
  N-GObject $context, PangoFontFamily $families, gint $n_families is rw 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:load-font:
=begin pod
=head2 load-font

Loads the font in one of the fontmaps in the context that is the closest match for I<desc>.

Returns: the newly allocated `PangoFont` that was loaded, or C<undefined> if no font matched.

  method load-font ( N-GObject() $desc --> N-GObject )

=item $desc; a `PangoFontDescription` describing the font to load
=end pod

method load-font ( N-GObject() $desc --> N-GObject ) {
  pango_context_load_font( self._get-native-object-no-reffing, $desc)
}

sub pango_context_load_font (
  N-GObject $context, N-GObject $desc --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:load-fontset:
=begin pod
=head2 load-fontset

Load a set of fonts in the context that can be used to render a font matching I<desc>.

Returns: the newly allocated `PangoFontset` loaded, or C<undefined> if no font matched.

  method load-fontset ( N-GObject() $desc, N-GObject() $language --> N-GObject )

=item $desc; a `PangoFontDescription` describing the fonts to load
=item $language; a `PangoLanguage` the fonts will be used for
=end pod

method load-fontset ( N-GObject() $desc, N-GObject() $language --> N-GObject ) {
  pango_context_load_fontset( self._get-native-object-no-reffing, $desc, $language)
}

sub pango_context_load_fontset (
  N-GObject $context, N-GObject $desc, N-GObject $language --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-base-dir:
=begin pod
=head2 set-base-dir

Sets the base direction for the context.

The base direction is used in applying the Unicode bidirectional algorithm; if the I<direction> is C<PANGO_DIRECTION_LTR> or C<PANGO_DIRECTION_RTL>, then the value will be used as the paragraph direction in the Unicode bidirectional algorithm. A value of C<PANGO_DIRECTION_WEAK_LTR> or C<PANGO_DIRECTION_WEAK_RTL> is used only for paragraphs that do not contain any strong characters themselves.

  method set-base-dir ( PangoDirection $direction )

=item $direction; the new base direction
=end pod

method set-base-dir ( PangoDirection $direction ) {
  pango_context_set_base_dir( self._get-native-object-no-reffing, $direction);
}

sub pango_context_set_base_dir (
  N-GObject $context, GEnum $direction 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-base-gravity:
=begin pod
=head2 set-base-gravity

Sets the base gravity for the context.

The base gravity is used in laying vertical text out.

  method set-base-gravity ( N-GObject() $gravity )

=item $gravity; the new base gravity
=end pod

method set-base-gravity ( N-GObject() $gravity ) {
  pango_context_set_base_gravity( self._get-native-object-no-reffing, $gravity);
}

sub pango_context_set_base_gravity (
  N-GObject $context, N-GObject $gravity 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-font-description:
=begin pod
=head2 set-font-description

Set the default font description for the context

  method set-font-description ( N-GObject() $desc )

=item $desc; the new pango font description
=end pod

method set-font-description ( N-GObject() $desc ) {
  pango_context_set_font_description( self._get-native-object-no-reffing, $desc);
}

sub pango_context_set_font_description (
  N-GObject $context, N-GObject $desc 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-font-map:
=begin pod
=head2 set-font-map

Sets the font map to be searched when fonts are looked-up in this context.

This is only for internal use by Pango backends, a `PangoContext` obtained via one of the recommended methods should already have a suitable font map.

  method set-font-map ( N-GObject() $font_map )

=item $font_map; the `PangoFontMap` to set.
=end pod

method set-font-map ( N-GObject() $font_map ) {
  pango_context_set_font_map( self._get-native-object-no-reffing, $font_map);
}

sub pango_context_set_font_map (
  N-GObject $context, N-GObject $font_map 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-gravity-hint:
=begin pod
=head2 set-gravity-hint

Sets the gravity hint for the context.

The gravity hint is used in laying vertical text out, and is only relevant if gravity of the context as returned by [methodI<Pango>.Context.get_gravity] is set to C<PANGO_GRAVITY_EAST> or C<PANGO_GRAVITY_WEST>.

  method set-gravity-hint ( PangoGravityHint $hint )

=item $hint; the new gravity hint
=end pod

method set-gravity-hint ( PangoGravityHint $hint ) {
  pango_context_set_gravity_hint( self._get-native-object-no-reffing, $hint);
}

sub pango_context_set_gravity_hint (
  N-GObject $context, GEnum $hint 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-language:
=begin pod
=head2 set-language

Sets the global language tag for the context.

The default language for the locale of the running process can be found using [funcI<Pango>.Language.get_default].

  method set-language ( N-GObject() $language )

=item $language; the new language tag.
=end pod

method set-language ( N-GObject() $language ) {
  pango_context_set_language( self._get-native-object-no-reffing, $language);
}

sub pango_context_set_language (
  N-GObject $context, N-GObject $language 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-matrix:
=begin pod
=head2 set-matrix

Sets the transformation matrix that will be applied when rendering with this context.

Note that reported metrics are in the user space coordinates before the application of the matrix, not device-space coordinates after the application of the matrix. So, they don't scale with the matrix, though they may change slightly for different matrices, depending on how the text is fit to the pixel grid.

  method set-matrix ( N-PangoMatrix() $matrix )

=item $matrix; a `PangoMatrix`, or C<undefined> to unset any existing matrix. (No matrix set is the same as setting the identity matrix.)
=end pod

method set-matrix ( N-GObject() $matrix ) {
  pango_context_set_matrix( self._get-native-object-no-reffing, $matrix);
}

sub pango_context_set_matrix (
  N-GObject $context, N-GObject $matrix 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:set-round-glyph-positions:
=begin pod
=head2 set-round-glyph-positions

Sets whether font rendering with this context should round glyph positions and widths to integral positions, in device units.

This is useful when the renderer can't handle subpixel positioning of glyphs.

The default value is to round glyph positions, to remain compatible with previous Pango behavior.

  method set-round-glyph-positions ( Bool $round_positions )

=item $round_positions; whether to round glyph positions
=end pod

method set-round-glyph-positions ( Bool $round_positions ) {
  pango_context_set_round_glyph_positions( self._get-native-object-no-reffing, $round_positions);
}

sub pango_context_set_round_glyph_positions (
  N-GObject $context, gboolean $round_positions 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:_pango_context_new:
#`{{
=begin pod
=head2 _pango_context_new

Creates a new `PangoContext` initialized to default values.

This function is not particularly useful as it should always be followed by a [methodI<Pango>.Context.set_font_map] call, and the function [methodI<Pango>.FontMap.create_context] does these two steps together and hence users are recommended to use that.

If you are using Pango as part of a higher-level system, that system may have it's own way of create a `PangoContext`. For instance, the GTK toolkit has, among others, `C<gtk_widget_get_pango_context()>`. Use those instead.

Return value: the newly allocated `PangoContext`, which should be freed with C<g_object_unref()>.

  method _pango_context_new ( --> N-GObject )

=end pod
}}

sub _pango_context_new (  --> N-GObject )
  is native(&pango-lib)
  is symbol('pango_context_new')
  { * }
