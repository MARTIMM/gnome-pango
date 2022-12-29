#TL:1:Gnome::Pango::Font:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Font

=head2 Declaration

  unit class Gnome::Pango::Font;
  also is Gnome::GObject::Object;


=comment head2 Example

=end pod
#-------------------------------------------------------------------------------
use NativeCall;

#use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::N::GlibToRakuTypes;

use Gnome::GObject::Object;


#-------------------------------------------------------------------------------
unit class Gnome::Pango::Font:auth<github:MARTIMM>;
also is Gnome::GObject::Object;


#-------------------------------------------------------------------------------
=begin pod
=head1 Types
=end pod
#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoFontMask

The bits in a `PangoFontMask` correspond to the set fields in a
`PangoFontDescription`.


=item PANGO_FONT_MASK_FAMILY: the font family is specified.
=item PANGO_FONT_MASK_STYLE: the font style is specified.
=item PANGO_FONT_MASK_VARIANT: the font variant is specified.
=item PANGO_FONT_MASK_WEIGHT: the font weight is specified.
=item PANGO_FONT_MASK_STRETCH: the font stretch is specified.
=item PANGO_FONT_MASK_SIZE: the font size is specified.
=item PANGO_FONT_MASK_GRAVITY: the font gravity is specified (Since: 1.16.)
=item PANGO_FONT_MASK_VARIATIONS: OpenType font variations are specified (Since: 1.42)


=end pod

#TE:0:PangoFontMask:
enum PangoFontMask is export (
  'PANGO_FONT_MASK_FAMILY'  => 1 +< 0,
  'PANGO_FONT_MASK_STYLE'   => 1 +< 1,
  'PANGO_FONT_MASK_VARIANT' => 1 +< 2,
  'PANGO_FONT_MASK_WEIGHT'  => 1 +< 3,
  'PANGO_FONT_MASK_STRETCH' => 1 +< 4,
  'PANGO_FONT_MASK_SIZE'    => 1 +< 5,
  'PANGO_FONT_MASK_GRAVITY' => 1 +< 6,
  'PANGO_FONT_MASK_VARIATIONS' => 1 +< 7,
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoStretch

An enumeration specifying the width of the font relative to other designs
within a family.


=item PANGO_STRETCH_ULTRA_CONDENSED: ultra condensed width
=item PANGO_STRETCH_EXTRA_CONDENSED: extra condensed width
=item PANGO_STRETCH_CONDENSED: condensed width
=item PANGO_STRETCH_SEMI_CONDENSED: semi condensed width
=item PANGO_STRETCH_NORMAL: the normal width
=item PANGO_STRETCH_SEMI_EXPANDED: semi expanded width
=item PANGO_STRETCH_EXPANDED: expanded width
=item PANGO_STRETCH_EXTRA_EXPANDED: extra expanded width
=item PANGO_STRETCH_ULTRA_EXPANDED: ultra expanded width


=end pod

#TE:0:PangoStretch:
enum PangoStretch is export (
  'PANGO_STRETCH_ULTRA_CONDENSED',
  'PANGO_STRETCH_EXTRA_CONDENSED',
  'PANGO_STRETCH_CONDENSED',
  'PANGO_STRETCH_SEMI_CONDENSED',
  'PANGO_STRETCH_NORMAL',
  'PANGO_STRETCH_SEMI_EXPANDED',
  'PANGO_STRETCH_EXPANDED',
  'PANGO_STRETCH_EXTRA_EXPANDED',
  'PANGO_STRETCH_ULTRA_EXPANDED'
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoStyle

An enumeration specifying the various slant styles possible for a font.


=item PANGO_STYLE_NORMAL: the font is upright.
=item PANGO_STYLE_OBLIQUE: the font is slanted, but in a roman style.
=item PANGO_STYLE_ITALIC: the font is slanted in an italic style.


=end pod

#TE:0:PangoStyle:
enum PangoStyle is export (
  'PANGO_STYLE_NORMAL',
  'PANGO_STYLE_OBLIQUE',
  'PANGO_STYLE_ITALIC'
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoVariant

An enumeration specifying capitalization variant of the font.


=item PANGO_VARIANT_NORMAL: A normal font.
=item PANGO_VARIANT_SMALL_CAPS: A font with the lower case characters replaced by smaller variants of the capital characters.
=item PANGO_VARIANT_ALL_SMALL_CAPS: A font with all characters replaced by smaller variants of the capital characters. Since: 1.50
=item PANGO_VARIANT_PETITE_CAPS: A font with the lower case characters replaced by smaller variants of the capital characters. Petite Caps can be even smaller than Small Caps. Since: 1.50
=item PANGO_VARIANT_ALL_PETITE_CAPS: A font with all characters replaced by smaller variants of the capital characters. Petite Caps can be even smaller than Small Caps. Since: 1.50
=item PANGO_VARIANT_UNICASE: A font with the upper case characters replaced by smaller variants of the capital letters. Since: 1.50
=item PANGO_VARIANT_TITLE_CAPS: A font with capital letters that are more suitable for all-uppercase titles. Since: 1.50


=end pod

#TE:0:PangoVariant:
enum PangoVariant is export (
  'PANGO_VARIANT_NORMAL',
  'PANGO_VARIANT_SMALL_CAPS',
  'PANGO_VARIANT_ALL_SMALL_CAPS',
  'PANGO_VARIANT_PETITE_CAPS',
  'PANGO_VARIANT_ALL_PETITE_CAPS',
  'PANGO_VARIANT_UNICASE',
  'PANGO_VARIANT_TITLE_CAPS'
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoWeight

An enumeration specifying the weight (boldness) of a font.

Weight is specified as a numeric value ranging from 100 to 1000.
This enumeration simply provides some common, predefined values.


=item PANGO_WEIGHT_THIN: the thin weight (= 100) Since: 1.24
=item PANGO_WEIGHT_ULTRALIGHT: the ultralight weight (= 200)
=item PANGO_WEIGHT_LIGHT: the light weight (= 300)
=item PANGO_WEIGHT_SEMILIGHT: the semilight weight (= 350) Since: 1.36.7
=item PANGO_WEIGHT_BOOK: the book weight (= 380) Since: 1.24)
=item PANGO_WEIGHT_NORMAL: the default weight (= 400)
=item PANGO_WEIGHT_MEDIUM: the normal weight (= 500) Since: 1.24
=item PANGO_WEIGHT_SEMIBOLD: the semibold weight (= 600)
=item PANGO_WEIGHT_BOLD: the bold weight (= 700)
=item PANGO_WEIGHT_ULTRABOLD: the ultrabold weight (= 800)
=item PANGO_WEIGHT_HEAVY: the heavy weight (= 900)
=item PANGO_WEIGHT_ULTRAHEAVY: the ultraheavy weight (= 1000) Since: 1.24


=end pod

#TE:0:PangoWeight:
enum PangoWeight is export (
  'PANGO_WEIGHT_THIN' => 100,
  'PANGO_WEIGHT_ULTRALIGHT' => 200,
  'PANGO_WEIGHT_LIGHT' => 300,
  'PANGO_WEIGHT_SEMILIGHT' => 350,
  'PANGO_WEIGHT_BOOK' => 380,
  'PANGO_WEIGHT_NORMAL' => 400,
  'PANGO_WEIGHT_MEDIUM' => 500,
  'PANGO_WEIGHT_SEMIBOLD' => 600,
  'PANGO_WEIGHT_BOLD' => 700,
  'PANGO_WEIGHT_ULTRABOLD' => 800,
  'PANGO_WEIGHT_HEAVY' => 900,
  'PANGO_WEIGHT_ULTRAHEAVY' => 1000
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoScale

CSS scale factors (1.2 factor between each size)

=item PANGO_SCALE_XX_SMALL: The scale factor for three shrinking steps (1 / (1.2 * 1.2 * 1.2)
=item PANGO_SCALE_X_SMALL: The scale factor for two shrinking steps (1 / (1.2 * 1.2)).
=item PANGO_SCALE_SMALL: The scale factor for one shrinking step (1 / 1.2).
=item PANGO_SCALE_MEDIUM: The scale factor for normal size (1.0).
=item PANGO_SCALE_LARGE: The scale factor for one magnification step (1.2).
=item PANGO_SCALE_X_LARGE: The scale factor for two magnification steps (1.2 * 1.2).
=item PANGO_SCALE_XX_LARGE: The scale factor for three magnification steps (1.2 * 1.2 * 1.2).

=end pod

# NOTE: These were C defines -> no enums but num64!!!
#TE:0:PangoScale
enum PangoScale is export (
  :PANGO_SCALE_XX_SMALL(Num(0.5787037037037)),
  :PANGO_SCALE_X_SMALL(Num(0.6944444444444)),
  :PANGO_SCALE_SMALL(Num(0.8333333333333)),
  :PANGO_SCALE_MEDIUM(Num(1.0)),
  :PANGO_SCALE_LARGE(Num(1.2)),
  :PANGO_SCALE_X_LARGE(Num(1.44)),
  :PANGO_SCALE_XX_LARGE(Num(1.728)),
);

#`{{
#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoFont

A `PangoFont` is used to represent a font in a
rendering-system-independent manner.

=end pod

#TT:0:N-PangoFont:
class N-PangoFont is export is repr('CStruct') {
  has GObject $.parent_instance;
}

#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoFontFace

A `PangoFontFace` is used to represent a group of fonts with
the same family, slant, weight, and width, but varying sizes.

=end pod

#TT:0:N-PangoFontFace:
class N-PangoFontFace is export is repr('CStruct') {
  has GObject $.parent_instance;
}

#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoFontFamily

A `PangoFontFamily` is used to represent a family of related
font faces.

The font faces in a family share a common design, but differ in
slant, weight, width or other aspects.

=end pod

#TT:0:N-PangoFontFamily:
class N-PangoFontFamily is export is repr('CStruct') {
  has GObject $.parent_instance;
}
}}

#-------------------------------------------------------------------------------
=begin pod
=head1 Methods
=head2 new

=head3 default, no options

Create a new Font object.

  multi method new ( )


=head3 :native-object

Create a Font object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:1:new():
#TM:4:new(:native-object):Gnome::N::TopLevelClassSupport
submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::Font' #`{{ or %options<PangoFont> }} {

    # check if native object is set by a parent class
    if self.is-valid { }

    # check if common options are handled by some parent
    elsif %options<native-object>:exists { }
#`{{
    # process all other options
    else {
      my $no;
      if ? %options<___x___> {
        #$no = %options<___x___>;
        #$no .= _get-native-object-no-reffing unless $no ~~ N-GObject;
        #$no = _pango_font_new___x___($no);
      }

      #`{{ use this when the module is not made inheritable
      # check if there are unknown options
      elsif %options.elems {
        die X::Gnome.new(
          :message(
            'Unsupported, undefined, incomplete or wrongly typed options for ' ~
            self.^name ~ ': ' ~ %options.keys.join(', ')
          )
        );
      }
      }}

      #`{{ when there are no defaults use this
      # check if there are any options
      elsif %options.elems == 0 {
        die X::Gnome.new(:message('No options specified ' ~ self.^name));
      }
      }}

      #`{{ when there are defaults use this instead
      # create default object
      else {
        $no = _pango_font_new();
      }
      }}

      self.set-native-object($no);
    }
}}

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoFont');
  }
}


#-------------------------------------------------------------------------------
#TM:0:describe:
=begin pod
=head2 describe

Returns a description of the font, with font size set in points.

  method describe ( --> N-GObject )

=end pod

method describe ( --> N-GObject ) {
  pango_font_describe( self._f('PangoFont'))
}

sub pango_font_describe (
  N-GObject $font --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:describe-with-absolute-size:
=begin pod
=head2 describe-with-absolute-size

Returns a description of the font, with absolute font size set in device units.

  method describe-with-absolute-size ( --> N-GObject )

=end pod

method describe-with-absolute-size ( --> N-GObject ) {
  pango_font_describe_with_absolute_size( self._f('PangoFont'))
}

sub pango_font_describe_with_absolute_size (
  N-GObject $font --> N-GObject
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
# TM:0:deserialize:
=begin pod
=head2 deserialize



  method deserialize ( N-GObject() $context, GBytes $bytes, N-GError $error --> N-GObject )

=item $context; 
=item $bytes; 
=item $error; 
=end pod

method deserialize ( N-GObject() $context, GBytes $bytes, $error is copy --> N-GObject ) {
  $error .= _get-native-object-no-reffing unless $error ~~ N-GError;
  pango_font_deserialize( self._f('PangoFont'), $context, $bytes, $error)
}

sub pango_font_deserialize (
  N-GObject $context, GBytes $bytes, N-GError $error --> N-GObject
) is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:face-describe:
=begin pod
=head2 face-describe



  method face-describe ( PangoFontFace $face --> N-GObject )

=item $face; 
=end pod

method face-describe ( PangoFontFace $face --> N-GObject ) {
  pango_font_face_describe( self._f('PangoFont'), $face)
}

sub pango_font_face_describe (
  PangoFontFace $face --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:face-get-face-name:
=begin pod
=head2 face-get-face-name



  method face-get-face-name ( PangoFontFace $face --> Str )

=item $face; 
=end pod

method face-get-face-name ( PangoFontFace $face --> Str ) {
  pango_font_face_get_face_name( self._f('PangoFont'), $face)
}

sub pango_font_face_get_face_name (
  PangoFontFace $face --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:face-get-family:
=begin pod
=head2 face-get-family



  method face-get-family ( PangoFontFace $face --> PangoFontFamily )

=item $face; 
=end pod

method face-get-family ( PangoFontFace $face --> PangoFontFamily ) {
  pango_font_face_get_family( self._f('PangoFont'), $face)
}

sub pango_font_face_get_family (
  PangoFontFace $face --> PangoFontFamily
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:face-is-synthesized:
=begin pod
=head2 face-is-synthesized



  method face-is-synthesized ( PangoFontFace $face --> Bool )

=item $face; 
=end pod

method face-is-synthesized ( PangoFontFace $face --> Bool ) {
  pango_font_face_is_synthesized( self._f('PangoFont'), $face).Bool
}

sub pango_font_face_is_synthesized (
  PangoFontFace $face --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:face-list-sizes:
=begin pod
=head2 face-list-sizes



  method face-list-sizes ( PangoFontFace $face )

=item $face; 
=item $sizes; 
=item $n_sizes; 
=end pod

method face-list-sizes ( PangoFontFace $face ) {
  pango_font_face_list_sizes( self._f('PangoFont'), $face, my gint $sizes, my gint $n_sizes);
}

sub pango_font_face_list_sizes (
  PangoFontFace $face, gint $sizes is rw, gint $n_sizes is rw 
) is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:family-get-face:
=begin pod
=head2 family-get-face



  method family-get-face ( PangoFontFamily $family, Str $name --> PangoFontFace )

=item $family; 
=item $name; 
=end pod

method family-get-face ( PangoFontFamily $family, Str $name --> PangoFontFace ) {
  pango_font_family_get_face( self._f('PangoFont'), $family, $name)
}

sub pango_font_family_get_face (
  PangoFontFamily $family, gchar-ptr $name --> PangoFontFace
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:family-get-name:
=begin pod
=head2 family-get-name



  method family-get-name ( PangoFontFamily $family --> Str )

=item $family; 
=end pod

method family-get-name ( PangoFontFamily $family --> Str ) {
  pango_font_family_get_name( self._f('PangoFont'), $family)
}

sub pango_font_family_get_name (
  PangoFontFamily $family --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:family-is-monospace:
=begin pod
=head2 family-is-monospace



  method family-is-monospace ( PangoFontFamily $family --> Bool )

=item $family; 
=end pod

method family-is-monospace ( PangoFontFamily $family --> Bool ) {
  pango_font_family_is_monospace( self._f('PangoFont'), $family).Bool
}

sub pango_font_family_is_monospace (
  PangoFontFamily $family --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:family-is-variable:
=begin pod
=head2 family-is-variable



  method family-is-variable ( PangoFontFamily $family --> Bool )

=item $family; 
=end pod

method family-is-variable ( PangoFontFamily $family --> Bool ) {
  pango_font_family_is_variable( self._f('PangoFont'), $family).Bool
}

sub pango_font_family_is_variable (
  PangoFontFamily $family --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:family-list-faces:
=begin pod
=head2 family-list-faces



  method family-list-faces ( PangoFontFamily $family, PangoFontFace $faces )

=item $family; 
=item $faces; 
=item $n_faces; 
=end pod

method family-list-faces ( PangoFontFamily $family, PangoFontFace $faces ) {
  pango_font_family_list_faces( self._f('PangoFont'), $family, $faces, my gint $n_faces);
}

sub pango_font_family_list_faces (
  PangoFontFamily $family, PangoFontFace $faces, gint $n_faces is rw 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:get-coverage:
=begin pod
=head2 get-coverage

Computes the coverage map for a given font and language tag.

  method get-coverage ( N-GObject() $language --> N-GObject )

=item $language; 
=end pod

method get-coverage ( N-GObject() $language --> N-GObject ) {
  pango_font_get_coverage( self._f('PangoFont'), $language)
}

sub pango_font_get_coverage (
  N-GObject $font, N-GObject $language --> N-GObject
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:get-face:
=begin pod
=head2 get-face



  method get-face ( --> PangoFontFace )

=end pod

method get-face ( --> PangoFontFace ) {
  pango_font_get_face( self._f('PangoFont'))
}

sub pango_font_get_face (
  N-GObject $font --> PangoFontFace
) is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:get-features:
=begin pod
=head2 get-features



  method get-features ( hb_feature_t $features, UInt $len, guInt-ptr $num_features )

=item $features; 
=item $len; 
=item $num_features; 
=end pod

method get-features ( hb_feature_t $features, UInt $len, guInt-ptr $num_features ) {
  pango_font_get_features( self._f('PangoFont'), $features, $len, $num_features);
}

sub pango_font_get_features (
  N-GObject $font, hb_feature_t $features, guint $len, gugint-ptr $num_features 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:get-font-map:
=begin pod
=head2 get-font-map

Gets the font map for which the font was created.

Note that the font maintains a weak reference to the font map, so if all references to font map are dropped, the font map will be finalized even if there are fonts created with the font map that are still alive. In that case this function will return NULL.

It is the responsibility of the user to ensure that the font map is kept alive. In most uses this is not an issue as a PangoContext holds a reference to the font map.


  method get-font-map ( --> N-GObject )

=end pod

method get-font-map ( --> N-GObject ) {
  pango_font_get_font_map( self._f('PangoFont'))
}

sub pango_font_get_font_map (
  N-GObject $font --> N-GObject
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:get-glyph-extents:
=begin pod
=head2 get-glyph-extents



  method get-glyph-extents ( N-GObject() $glyph, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item $glyph; 
=item $ink_rect; 
=item $logical_rect; 
=end pod

method get-glyph-extents ( N-GObject() $glyph, PangoRectangle $ink_rect, PangoRectangle $logical_rect ) {
  pango_font_get_glyph_extents( self._f('PangoFont'), $glyph, $ink_rect, $logical_rect);
}

sub pango_font_get_glyph_extents (
  N-GObject $font, N-GObject $glyph, PangoRectangle $ink_rect, PangoRectangle $logical_rect 
) is native(&pango-lib)
  { * }
}}
#`{{
#-------------------------------------------------------------------------------
#TM:0:get-hb-font:
=begin pod
=head2 get-hb-font



  method get-hb-font ( --> hb_font_t )

=end pod

method get-hb-font ( --> hb_font_t ) {
  pango_font_get_hb_font( self._f('PangoFont'))
}

sub pango_font_get_hb_font (
  N-GObject $font --> hb_font_t
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:get-languages:
=begin pod
=head2 get-languages

Returns the languages that are supported by font.

If the font backend does not provide this information, NULL is returned. For the fontconfig backend, this corresponds to the FC_LANG member of the FcPattern.

The returned array is only valid as long as the font and its fontmap are valid.


  method get-languages ( --> N-GObject )

=end pod

method get-languages ( --> N-GObject ) {
  pango_font_get_languages( self._f('PangoFont'))
}

sub pango_font_get_languages (
  N-GObject $font --> N-GObject
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:get-metrics:
=begin pod
=head2 get-metrics



  method get-metrics ( N-GObject() $language --> PangoFontMetrics )

=item $language; 
=end pod

method get-metrics ( N-GObject() $language --> PangoFontMetrics ) {
  pango_font_get_metrics( self._f('PangoFont'), $language)
}

sub pango_font_get_metrics (
  N-GObject $font, N-GObject $language --> PangoFontMetrics
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:has-char:
=begin pod
=head2 has-char

Returns whether the font provides a glyph for this character.

  method has-char ( gunichar $wc --> Bool )

=item $wc; 
=end pod

method has-char ( gunichar $wc --> Bool ) {
  pango_font_has_char( self._f('PangoFont'), $wc).Bool
}

sub pango_font_has_char (
  N-GObject $font, gunichar $wc --> gboolean
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:metrics-get-approximate-char-width:
=begin pod
=head2 metrics-get-approximate-char-width



  method metrics-get-approximate-char-width ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-approximate-char-width ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_approximate_char_width( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_approximate_char_width (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-approximate-digit-width:
=begin pod
=head2 metrics-get-approximate-digit-width



  method metrics-get-approximate-digit-width ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-approximate-digit-width ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_approximate_digit_width( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_approximate_digit_width (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-ascent:
=begin pod
=head2 metrics-get-ascent



  method metrics-get-ascent ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-ascent ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_ascent( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_ascent (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-descent:
=begin pod
=head2 metrics-get-descent



  method metrics-get-descent ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-descent ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_descent( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_descent (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-height:
=begin pod
=head2 metrics-get-height



  method metrics-get-height ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-height ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_height( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_height (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-strikethrough-position:
=begin pod
=head2 metrics-get-strikethrough-position



  method metrics-get-strikethrough-position ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-strikethrough-position ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_strikethrough_position( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_strikethrough_position (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-strikethrough-thickness:
=begin pod
=head2 metrics-get-strikethrough-thickness



  method metrics-get-strikethrough-thickness ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-strikethrough-thickness ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_strikethrough_thickness( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_strikethrough_thickness (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-underline-position:
=begin pod
=head2 metrics-get-underline-position



  method metrics-get-underline-position ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-underline-position ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_underline_position( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_underline_position (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-get-underline-thickness:
=begin pod
=head2 metrics-get-underline-thickness



  method metrics-get-underline-thickness ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method metrics-get-underline-thickness ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_underline_thickness( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_get_underline_thickness (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-ref:
=begin pod
=head2 metrics-ref



  method metrics-ref ( PangoFontMetrics $metrics --> PangoFontMetrics )

=item $metrics; 
=end pod

method metrics-ref ( PangoFontMetrics $metrics --> PangoFontMetrics ) {
  pango_font_metrics_ref( self._f('PangoFont'), $metrics)
}

sub pango_font_metrics_ref (
  PangoFontMetrics $metrics --> PangoFontMetrics
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:metrics-unref:
=begin pod
=head2 metrics-unref



  method metrics-unref ( PangoFontMetrics $metrics )

=item $metrics; 
=end pod

method metrics-unref ( PangoFontMetrics $metrics ) {
  pango_font_metrics_unref( self._f('PangoFont'), $metrics);
}

sub pango_font_metrics_unref (
  PangoFontMetrics $metrics 
) is native(&pango-lib)
  { * }
}}

#`{{
#-------------------------------------------------------------------------------
# TM:0:serialize:
=begin pod
=head2 serialize



  method serialize ( --> GBytes )

=end pod

method serialize ( --> GBytes ) {
  pango_font_serialize( self._f('PangoFont'))
}

sub pango_font_serialize (
  N-GObject $font --> GBytes
) is native(&pango-lib)
  { * }
}}