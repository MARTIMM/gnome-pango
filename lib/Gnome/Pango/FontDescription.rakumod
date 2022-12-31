#TL:1:Gnome::Pango::FontDescription:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::FontDescription

=head1 Description

A PangoFontDescription describes a font in an implementation-independent manner.

PangoFontDescription structures are used both to list what fonts are available on the system and also for specifying the characteristics of a font to load.


=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::FontDescription;
  also is Gnome::GObject::Boxed;


=comment head2 Example

=end pod
#-------------------------------------------------------------------------------
use NativeCall;

#use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::N::GlibToRakuTypes;

use Gnome::GObject::Boxed;

use Gnome::Pango::Gravity;


#-------------------------------------------------------------------------------
unit class Gnome::Pango::FontDescription:auth<github:MARTIMM>;
also is Gnome::GObject::Boxed;

#-------------------------------------------------------------------------------
=begin pod
=head1 Types
=end pod

#`{{
#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoFontMask

The bits in a `PangoFontMask` correspond to the set fields in a
`N-GObject`.

=item PANGO_FONT_MASK_FAMILY: the font family is specified.
=item PANGO_FONT_MASK_STYLE: the font style is specified.
=item PANGO_FONT_MASK_VARIANT: the font variant is specified.
=item PANGO_FONT_MASK_WEIGHT: the font weight is specified.
=item PANGO_FONT_MASK_STRETCH: the font stretch is specified.
=item PANGO_FONT_MASK_SIZE: the font size is specified.
=item PANGO_FONT_MASK_GRAVITY: the font gravity is specified (Since: 1.16.)
=item PANGO_FONT_MASK_VARIATIONS: OpenType font variations are specified (Since: 1.42)


=end pod

#TE:1:PangoFontMask:
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
}}

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

#TE:1:PangoStretch:
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

#TE:1:PangoStyle:
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

#TE:1:PangoVariant:
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

#TE:1:PangoWeight:
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
=head1 Methods
=head2 new

=head3 default, no options

Creates a new font description structure with all fields unset.

  multi method new ( )


=head3 :string

Creates a new font description from a string representation.

The string must have the form "[FAMILY-LIST] [STYLE-OPTIONS] [SIZE] [VARIATIONS]",

where FAMILY-LIST is a comma-separated list of families optionally terminated by a comma, STYLE_OPTIONS is a whitespace-separated list of words where each word describes one of style, variant, weight, stretch, or gravity, and SIZE is a decimal number (size in points) or optionally followed by the unit modifier “px” for absolute size. VARIATIONS is a comma-separated list of font variation specifications of the form “`axis`=value” (the = sign is optional).

The following words are understood as styles: “Normal”, “Roman”, “Oblique”, “Italic”.

The following words are understood as variants: “Small-Caps”, “All-Small-Caps”, “Petite-Caps”, “All-Petite-Caps”, “Unicase”, “Title-Caps”.

The following words are understood as weights: “Thin”, “Ultra-Light”, “Extra-Light”, “Light”, “Semi-Light”, “Demi-Light”, “Book”, “Regular”, “Medium”, “Semi-Bold”, “Demi-Bold”, “Bold”, “Ultra-Bold”, “Extra-Bold”, “Heavy”, “Black”, “Ultra-Black”, “Extra-Black”.

The following words are understood as stretch values: “Ultra-Condensed”, “Extra-Condensed”, “Condensed”, “Semi-Condensed”, “Semi-Expanded”, “Expanded”, “Extra-Expanded”, “Ultra-Expanded”.

The following words are understood as gravity values: “Not-Rotated”, “South”, “Upside-Down”, “North”, “Rotated-Left”, “East”, “Rotated-Right”, “West”.

Any one of the options may be absent. If FAMILY-LIST is absent, then the family_name field of the resulting font description will be initialized to NULL. If STYLE-OPTIONS is missing, then all style options will be set to the default values. If SIZE is missing, the size in the resulting font description will be set to 0.



  multi method new(:$string!)


A typical example string:

  "Cantarell Italic Light 15 \`wght`=200"



=head3 :copy

Make a copy of a PangoFontDescription.

  multi method new(:$copy!)


=head3 :native-object

Create a FontDescription object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:1:new():
#TM:4:new(:native-object):Gnome::N::TopLevelClassSupport
submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::FontDescription' {

    # check if native object is set by a parent class
    if self.is-valid { }

    # check if common options are handled by some parent
    elsif %options<native-object>:exists { }

    # process all other options
    else {
      my N-GObject() $no;
      if ? %options<string> {
        #$no = %options<___x___>;
        #$no .= _get-native-object-no-reffing unless $no ~~ N-GObject;
        $no = _pango_font_description_from_string(%options<string>);
      }

      elsif ? %options<copy> {
        $no = %options<copy>;
        #$no .= _get-native-object-no-reffing unless $no ~~ N-GObject;
        $no = _pango_font_description_copy($no);
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
        $no = _pango_font_description_new();
      }
      #}}

      self.set-native-object($no);
#note $no.gist;
#note pango_font_description_to_string($no);
    }

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoFontDescription');
  }
}

#-------------------------------------------------------------------------------
# no referencing for descriptions
method native-object-ref ( $n-native-object ) {
  $n-native-object
}

#-------------------------------------------------------------------------------
method native-object-unref ( $n-native-object ) {
  _pango_font_description_free($n-native-object);
}


#-------------------------------------------------------------------------------
#TM:0:better-match:
=begin pod
=head2 better-match

Determines if the style attributes of new_match are a closer match for desc than those of old_match are, or if old_match is NULL, determines if new_match is a match at all.

Approximate matching is done for weight and style; other style attributes must match exactly. Style attributes are all attributes other than family and size-related attributes. Approximate matching for style considers PANGO_STYLE_OBLIQUE and PANGO_STYLE_ITALIC as matches, but not as good a match as when the styles are equal.

Note that old_match must match desc.

  method better-match (
    N-GObject() $old_match, N-GObject() $new_match --> Bool
  )

=item $old_match; 
=item $new_match; 
=end pod

method better-match (
  N-GObject() $old_match, N-GObject() $new_match --> Bool
) {
  pango_font_description_better_match( self._get-native-object-no-reffing, $old_match, $new_match).Bool
}

sub pango_font_description_better_match (
  N-GObject $desc, N-GObject $old_match, N-GObject $new_match --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#`{{
#TM:1:_pango_font_description_copy:
=begin pod
=head2 copy



  method copy ( --> N-GObject )

=end pod

method copy ( --> N-GObject ) {
  pango_font_description_copy( self._get-native-object-no-reffing)
}
}}

sub _pango_font_description_copy (
  N-GObject $desc --> N-GObject
) is native(&pango-lib)
  is symbol('pango_font_description_copy')
  { * }

#`{{
#-------------------------------------------------------------------------------
# TM:0:copy-static:
=begin pod
=head2 copy-static



  method copy-static ( --> N-GObject )

=end pod

method copy-static ( --> N-GObject ) {
  pango_font_description_copy_static( self._get-native-object-no-reffing)
}

sub pango_font_description_copy_static (
  N-GObject $desc --> N-GObject
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:equal:
=begin pod
=head2 equal

Compares this font description with given one for equality.

  method equal ( N-GObject() $desc --> Bool )

=item $desc; Another PangoFontDescription
=end pod

method equal ( N-GObject() $desc2 --> Bool ) {
  pango_font_description_equal( self._get-native-object-no-reffing, $desc2).Bool
}

sub pango_font_description_equal (
  N-GObject $desc1, N-GObject $desc2 --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:_pango_font_description_free:
#`{{
=begin pod
=head2 free



  method free ( )

=end pod

method free ( ) {
  pango_font_description_free( self._get-native-object-no-reffing);
}
}}

sub _pango_font_description_free (
  N-GObject $desc 
) is native(&pango-lib)
  is symbol('pango_font_description_free')
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:1:_pango_font_description_from_string:
=begin pod
=head2 from-string



  method from-string ( Str $str --> N-GObject )

=item $str; 
=end pod

method from-string ( Str $str --> N-GObject ) {
  pango_font_description_from_string( self._get-native-object-no-reffing, $str)
}
}}

sub _pango_font_description_from_string (
  gchar-ptr $str --> N-GObject
) is native(&pango-lib)
  is symbol('pango_font_description_from_string')
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-family:
=begin pod
=head2 get-family

Gets the family name field of a font description.

Returns the family name field for the font description, or NULL if not previously set. This has the same life-time as the font description itself.

  method get-family ( --> Str )

=end pod

method get-family ( --> Str ) {
  pango_font_description_get_family( self._get-native-object-no-reffing)
}

sub pango_font_description_get_family (
  N-GObject $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-gravity:
=begin pod
=head2 get-gravity

Gets the gravity field of a font description.

Returns the gravity field for the font description. Use C<.get-set-fields()> to find out if the field was explicitly set or not.

  method get-gravity ( --> PangoGravity )

=end pod

method get-gravity ( --> PangoGravity ) {
  PangoGravity(
    pango_font_description_get_gravity(self._get-native-object-no-reffing)
  )
}

sub pango_font_description_get_gravity (
  N-GObject $desc --> GEnum
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-set-fields:
=begin pod
=head2 get-set-fields

Determines which fields in a font description have been set.

Returns a bitmask with bits set corresponding to the fields in desc that have been set.

  method get-set-fields ( --> UInt )

=end pod

method get-set-fields ( --> UInt ) {
  pango_font_description_get_set_fields( self._get-native-object-no-reffing);
}

sub pango_font_description_get_set_fields (
  N-GObject $desc --> GFlag
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-size:
=begin pod
=head2 get-size

Gets the size field of a font description.

Returns the size field for the font description in points or device units. You must call C<.get-size-is-absolute()> to find out which is the case. Returns 0 if the size field has not previously been set or it has been set to 0 explicitly. Use C<.get-set-fields()> to find out if the field was explicitly set or not.

  method get-size ( --> Int )

=end pod

method get-size ( --> Int ) {
  pango_font_description_get_size( self._get-native-object-no-reffing)
}

sub pango_font_description_get_size (
  N-GObject $desc --> gint
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-size-is-absolute:
=begin pod
=head2 get-size-is-absolute

Determines whether the size of the font is in points (not absolute) or device units (absolute).

Returns whether the size for the font description is in points or device units. Use C<.get-set-fields()> to find out if the size field of the font description was explicitly set or not.

  method get-size-is-absolute ( --> Bool )

=end pod

method get-size-is-absolute ( --> Bool ) {
  pango_font_description_get_size_is_absolute( self._get-native-object-no-reffing).Bool
}

sub pango_font_description_get_size_is_absolute (
  N-GObject $desc --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-stretch:
=begin pod
=head2 get-stretch

Gets the stretch field of a font description.

Returns the stretch field for the font description. Use C<.get-set-fields()> to find out if the field was explicitly set or not.

  method get-stretch ( --> PangoStretch )

=end pod

method get-stretch ( --> PangoStretch ) {
  PangoStretch(pango_font_description_get_stretch( self._get-native-object-no-reffing))
}

sub pango_font_description_get_stretch (
  N-GObject $desc --> GEnum
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-style:
=begin pod
=head2 get-style

Gets the style field of a font description.

  method get-style ( --> PangoStyle )

=end pod

method get-style ( --> PangoStyle ) {
  PangoStyle(pango_font_description_get_style( self._get-native-object-no-reffing))
}

sub pango_font_description_get_style (
  N-GObject $desc --> GEnum
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-variant:
=begin pod
=head2 get-variant

Gets the variant field of a font description.

  method get-variant ( --> PangoVariant )

=end pod

method get-variant ( --> PangoVariant ) {
  PangoVariant(
    pango_font_description_get_variant( self._get-native-object-no-reffing)
  )
}

sub pango_font_description_get_variant (
  N-GObject $desc --> GEnum
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-variations:
=begin pod
=head2 get-variations

Gets the variations field of a font description, or NULL if not previously set.

  method get-variations ( --> Str )

=end pod

method get-variations ( --> Str ) {
  pango_font_description_get_variations( self._get-native-object-no-reffing)
}

sub pango_font_description_get_variations (
  N-GObject $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-weight:
=begin pod
=head2 get-weight

Gets the weight field of a font description.

  method get-weight ( --> PangoWeight )

=end pod

method get-weight ( --> PangoWeight ) {
  PangoWeight(
    pango_font_description_get_weight( self._get-native-object-no-reffing)
  )
}

sub pango_font_description_get_weight (
  N-GObject $desc --> GEnum
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
# TM:0:hash:
=begin pod
=head2 hash



  method hash ( --> UInt )

=end pod

method hash ( --> UInt ) {
  pango_font_description_hash( self._get-native-object-no-reffing)
}

sub pango_font_description_hash (
  N-GObject $desc --> guint
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:merge:
=begin pod
=head2 merge

Merges the fields that are set in C<$desc_to_merge> into the fields of this description.

  method merge ( N-GObject() $desc_to_merge, Bool $replace_existing )

=item $desc_to_merge; The PangoFontDescription to merge from.
=item $replace_existing; If TRUE, replace fields in desc with the corresponding values from desc_to_merge, even if they are already exist.
=end pod

method merge ( N-GObject() $desc_to_merge, Bool $replace_existing ) {
  pango_font_description_merge(
    self._get-native-object-no-reffing, $desc_to_merge, $replace_existing
  );
}

sub pango_font_description_merge (
  N-GObject $desc, N-GObject $desc_to_merge, gboolean $replace_existing 
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
# TM:0:merge-static:
=begin pod
=head2 merge-static



  method merge-static ( N-GObject $desc_to_merge, Bool $replace_existing )

=item $desc_to_merge; 
=item $replace_existing; 
=end pod

method merge-static ( N-GObject $desc_to_merge, Bool $replace_existing ) {
  pango_font_description_merge_static( self._get-native-object-no-reffing, $desc_to_merge, $replace_existing);
}

sub pango_font_description_merge_static (
  N-GObject $desc, N-GObject $desc_to_merge, gboolean $replace_existing 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:1:set-absolute-size:
=begin pod
=head2 set-absolute-size

Sets the size field of a font description, in device units.

  method set-absolute-size ( Num() $size )

=item $size; 
=end pod

method set-absolute-size ( Num() $size ) {
  pango_font_description_set_absolute_size( self._get-native-object-no-reffing, $size);
}

sub pango_font_description_set_absolute_size (
  N-GObject $desc, gdouble $size 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-family:
=begin pod
=head2 set-family

Sets the family name field of a font description.

The family name represents a family of related font styles, and will resolve to a particular PangoFontFamily. In some uses of PangoFontDescription, it is also possible to use a comma separated list of family names for this field.

  method set-family ( Str $family )

=item $family; A string representing the family name.
=end pod

method set-family ( Str $family ) {
  pango_font_description_set_family(
    self._get-native-object-no-reffing, $family
  );
}

sub pango_font_description_set_family (
  N-GObject $desc, gchar-ptr $family 
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
# TM:0:set-family-static:
=begin pod
=head2 set-family-static



  method set-family-static ( Str $family )

=item $family; 
=end pod

method set-family-static ( Str $family ) {
  pango_font_description_set_family_static( self._get-native-object-no-reffing, $family);
}

sub pango_font_description_set_family_static (
  N-GObject $desc, gchar-ptr $family 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:1:set-gravity:
=begin pod
=head2 set-gravity

Sets the gravity field of a font description.

  method set-gravity ( PangoGravity $gravity )

=item $gravity; The gravity for the font description.
=end pod

method set-gravity ( PangoGravity $gravity ) {
  pango_font_description_set_gravity(
    self._get-native-object-no-reffing, $gravity
  );
}

sub pango_font_description_set_gravity (
  N-GObject $desc, GEnum $gravity 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-size:
=begin pod
=head2 set-size

Sets the size field of a font description in fractional points.

  method set-size ( Int() $size )

=item $size; The size of the font in points, scaled by PANGO_SCALE. (That is, a size value of 10 * PANGO_SCALE is a 10 point font. The conversion factor between points and device units depends on system configuration and the output device. For screen display, a logical DPI of 96 is common, in which case a 10 point font corresponds to a 10 * (96 / 72) = 13.3 pixel font. Use pango_font_description_set_absolute_size() if you need a particular size in device units.

=end pod

method set-size ( Int() $size ) {
  pango_font_description_set_size( self._get-native-object-no-reffing, $size);
}

sub pango_font_description_set_size (
  N-GObject $desc, gint $size 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-stretch:
=begin pod
=head2 set-stretch

Sets the stretch field of a font description.

  method set-stretch ( PangoStretch $stretch )

=item $stretch; The stretch for the font description.
=end pod

method set-stretch ( PangoStretch $stretch ) {
  pango_font_description_set_stretch( self._get-native-object-no-reffing, $stretch);
}

sub pango_font_description_set_stretch (
  N-GObject $desc, GEnum $stretch 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-style:
=begin pod
=head2 set-style

Sets the style field of a PangoFontDescription.

  method set-style ( PangoStyle $style )

=item $style; The style for the font description.
=end pod

method set-style ( PangoStyle $style ) {
  pango_font_description_set_style( self._get-native-object-no-reffing, $style);
}

sub pango_font_description_set_style (
  N-GObject $desc, GEnum $style 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-variant:
=begin pod
=head2 set-variant

Sets the variant field of a font description.

  method set-variant ( PangoVariant $variant )

=item $variant; The variant type for the font description.
=end pod

method set-variant ( PangoVariant $variant ) {
  pango_font_description_set_variant( self._get-native-object-no-reffing, $variant);
}

sub pango_font_description_set_variant (
  N-GObject $desc, GEnum $variant 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:set-variations:
=begin pod
=head2 set-variations

Sets the variations field of a font description.

OpenType font variations allow to select a font instance by specifying values for a number of axes, such as width or weight.

The format of the variations string is 'AXIS1=VALUE,AXIS2=VALUE...'

with each AXIS a 4 character tag that identifies a font axis, and each VALUE a floating point number. Unknown axes are ignored, and values are clamped to their allowed range.

Pango does not currently have a way to find supported axes of a font. Both harfbuzz and freetype have API for this. See for example hb_ot_var_get_axis_infos.

  method set-variations ( Str $variations )

=item $variations; A string representing the variations. The argument can be NULL.
=end pod

method set-variations ( Str $variations ) {
  pango_font_description_set_variations( self._get-native-object-no-reffing, $variations);
}

sub pango_font_description_set_variations (
  N-GObject $desc, gchar-ptr $variations 
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
# TM:0:set-variations-static:
=begin pod
=head2 set-variations-static



  method set-variations-static ( Str $variations )

=item $variations; 
=end pod

method set-variations-static ( Str $variations ) {
  pango_font_description_set_variations_static( self._get-native-object-no-reffing, $variations);
}

sub pango_font_description_set_variations_static (
  N-GObject $desc, gchar-ptr $variations 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:1:set-weight:
=begin pod
=head2 set-weight

Sets the weight field of a font description.

The weight field specifies how bold or light the font should be. In addition to the values of the PangoWeight enumeration, other intermediate numeric values are possible.

  method set-weight ( PangoWeight $weight )

=item $weight; The weight for the font description.
=end pod

method set-weight ( PangoWeight $weight ) {
  pango_font_description_set_weight( self._get-native-object-no-reffing, $weight);
}

sub pango_font_description_set_weight (
  N-GObject $desc, GEnum $weight 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:to-filename:
=begin pod
=head2 to-filename

Creates a filename representation of a font description.

  method to-filename ( --> Str )

=end pod

method to-filename ( --> Str ) {
  pango_font_description_to_filename( self._get-native-object-no-reffing)
}

sub pango_font_description_to_filename (
  N-GObject $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:to-string:
=begin pod
=head2 to-string

Creates a string representation of a font description.

  method to-string ( --> Str )

=end pod

method to-string ( --> Str ) {
  pango_font_description_to_string( self._get-native-object-no-reffing)
}

sub pango_font_description_to_string (
  N-GObject $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:unset-fields:
=begin pod
=head2 unset-fields

Unsets some of the fields in a PangoFontDescription.

The unset fields will get back to their default values.

  method unset-fields ( UInt $to_unset )

=item $to_unset; Bitmask of fields in the desc to unset.
=end pod

method unset-fields ( UInt $to_unset ) {
  pango_font_description_unset_fields(
    self._get-native-object-no-reffing, $to_unset
  );
}

sub pango_font_description_unset_fields (
  N-GObject $desc, GEnum $to_unset 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:_pango_font_description_new:
#`{{
=begin pod
=head2 _pango_font_description_new



  method _pango_font_description_new ( --> N-GObject )

=end pod
}}

sub _pango_font_description_new (  --> N-GObject )
  is native(&pango-lib)
  is symbol('pango_font_description_new')
  { * }
