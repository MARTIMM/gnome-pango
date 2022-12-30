#TL:1:Gnome::Pango::FontFace:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::FontFace


=head1 Description

A B<Gnome::Pango::FontFace> is used to represent a group of fonts with the same family, slant, weight, and width, but varying sizes.


=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::FontFace;
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
unit class Gnome::Pango::FontFace:auth<github:MARTIMM>;
also is Gnome::GObject::Object;


#`{{
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

There is no default new method. To get a defined object, you can only make use of the C<:native-object> attribute.

=head3 :native-object

Create a FontFace object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:4:new(:native-object):Gnome::N::TopLevelClassSupport
submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::FontFace' {

    # check if native object is set by a parent class
    if self.is-valid { }

    # check if common options are handled by some parent
    elsif %options<native-object>:exists { }

    # process all other options
    else {
      my N-GObject() $no;
      if ? %options<___x___> {
        #$no = %options<___x___>;
        #$no .= _get-native-object-no-reffing unless $no ~~ N-GObject;
        #$no = _pango_font_face_new___x___($no);
      }

      elsif %options.elems {
        die X::Gnome.new(
          :message(
            'Unsupported, undefined, incomplete or wrongly typed options for ' ~
            self.^name ~ ': ' ~ %options.keys.join(', ')
          )
        );
      }

      ##`{{ when there are no defaults use this
      # check if there are any options
      elsif %options.elems == 0 {
        die X::Gnome.new(:message('No options specified ' ~ self.^name));
      }
      #}}

      #`{{ when there are defaults use this instead
      # create default object
      else {
        $no = _pango_font_face_new();
      }
      }}

      self.set-native-object($no);
    }

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoFontFace');
  }
}

#-------------------------------------------------------------------------------
#TM:0:describe:
=begin pod
=head2 describe

Returns a font description that matches the face.

The resulting font description will have the family, style, variant, weight and stretch of the face, but its size field will be unset.

  method describe ( --> N-GObject )

Example

  my Gnome::Pango::Font $font .= new;
  my Gnome::Pango::FontFace() $font-face = $font.get-face;
  my Gnome::Pango::FontDescription() $font-description = $font-face.describe;

=end pod

method describe ( --> N-GObject ) {
  pango_font_face_describe( self._get-native-object-no-reffing)
}

sub pango_font_face_describe (
  N-GObject $face --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-face-name:
=begin pod
=head2 get-face-name

Gets a name representing the style of this face.

Note that a font family may contain multiple faces with the same name (e.g. a variable and a non-variable face for the same style).

  method get-face-name ( --> Str )

=end pod

method get-face-name ( --> Str ) {
  pango_font_face_get_face_name( self._get-native-object-no-reffing)
}

sub pango_font_face_get_face_name (
  N-GObject $face --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:get-family:
=begin pod
=head2 get-family

Gets the PangoFontFamily that face belongs to.

  method get-family ( --> N-GObject )

=end pod

method get-family ( --> N-GObject ) {
  pango_font_face_get_family( self._get-native-object-no-reffing)
}

sub pango_font_face_get_family (
  N-GObject $face --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:is-synthesized:
=begin pod
=head2 is-synthesized

Returns whether a PangoFontFace is synthesized.

This will be the case if the underlying font rendering engine creates this face from another face, by shearing, emboldening, lightening or modifying it in some other way.

  method is-synthesized ( --> Bool )

=end pod

method is-synthesized ( --> Bool ) {
  pango_font_face_is_synthesized( self._get-native-object-no-reffing).Bool
}

sub pango_font_face_is_synthesized (
  N-GObject $face --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:list-sizes:
=begin pod
=head2 list-sizes

List the available sizes for a font.

This is only applicable to bitmap fonts. For scalable fonts, stores NULL at the location pointed to by sizes and 0 at the location pointed to by n_sizes. The sizes returned are in Pango units and are sorted in ascending order.

  method list-sizes ( --> List )

The method returns a list of sizes
=end pod

method list-sizes ( --> List ) {
  pango_font_face_list_sizes(
    self._get-native-object-no-reffing,
    my CArray[gint] $sizes, my gint $n_sizes
  );

  my @szs = ();
  for ^$n_sizes -> $i {
    @szs.push: $sizes[$i];
  }

  @szs
}

sub pango_font_face_list_sizes (
  N-GObject $face, gint $sizes is rw, gint $n_sizes is rw 
) is native(&pango-lib)
  { * }


#`{{
#-------------------------------------------------------------------------------
#TM:0:pango-font-describe:
=begin pod
=head2 pango-font-describe



  method pango-font-describe ( N-GObject() $font --> PangoFontDescription )

=item $font; 
=end pod

method pango-font-describe ( N-GObject() $font --> PangoFontDescription ) {
  pango_font_describe( self._get-native-object-no-reffing, $font)
}

sub pango_font_describe (
  N-GObject $font --> PangoFontDescription
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-describe-with-absolute-size:
=begin pod
=head2 pango-font-describe-with-absolute-size



  method pango-font-describe-with-absolute-size ( N-GObject() $font --> PangoFontDescription )

=item $font; 
=end pod

method pango-font-describe-with-absolute-size ( N-GObject() $font --> PangoFontDescription ) {
  pango_font_describe_with_absolute_size( self._get-native-object-no-reffing, $font)
}

sub pango_font_describe_with_absolute_size (
  N-GObject $font --> PangoFontDescription
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-better-match:
=begin pod
=head2 pango-font-description-better-match



  method pango-font-description-better-match ( PangoFontDescription $desc, PangoFontDescription $old_match, PangoFontDescription $new_match --> Bool )

=item $desc; 
=item $old_match; 
=item $new_match; 
=end pod

method pango-font-description-better-match ( PangoFontDescription $desc, PangoFontDescription $old_match, PangoFontDescription $new_match --> Bool ) {
  pango_font_description_better_match( self._get-native-object-no-reffing, $desc, $old_match, $new_match).Bool
}

sub pango_font_description_better_match (
  PangoFontDescription $desc, PangoFontDescription $old_match, PangoFontDescription $new_match --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-copy:
=begin pod
=head2 pango-font-description-copy



  method pango-font-description-copy ( PangoFontDescription $desc --> PangoFontDescription )

=item $desc; 
=end pod

method pango-font-description-copy ( PangoFontDescription $desc --> PangoFontDescription ) {
  pango_font_description_copy( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_copy (
  PangoFontDescription $desc --> PangoFontDescription
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-copy-static:
=begin pod
=head2 pango-font-description-copy-static



  method pango-font-description-copy-static ( PangoFontDescription $desc --> PangoFontDescription )

=item $desc; 
=end pod

method pango-font-description-copy-static ( PangoFontDescription $desc --> PangoFontDescription ) {
  pango_font_description_copy_static( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_copy_static (
  PangoFontDescription $desc --> PangoFontDescription
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-equal:
=begin pod
=head2 pango-font-description-equal



  method pango-font-description-equal ( PangoFontDescription $desc1, PangoFontDescription $desc2 --> Bool )

=item $desc1; 
=item $desc2; 
=end pod

method pango-font-description-equal ( PangoFontDescription $desc1, PangoFontDescription $desc2 --> Bool ) {
  pango_font_description_equal( self._get-native-object-no-reffing, $desc1, $desc2).Bool
}

sub pango_font_description_equal (
  PangoFontDescription $desc1, PangoFontDescription $desc2 --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-free:
=begin pod
=head2 pango-font-description-free



  method pango-font-description-free ( PangoFontDescription $desc )

=item $desc; 
=end pod

method pango-font-description-free ( PangoFontDescription $desc ) {
  pango_font_description_free( self._get-native-object-no-reffing, $desc);
}

sub pango_font_description_free (
  PangoFontDescription $desc 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-from-string:
=begin pod
=head2 pango-font-description-from-string



  method pango-font-description-from-string ( Str $str --> PangoFontDescription )

=item $str; 
=end pod

method pango-font-description-from-string ( Str $str --> PangoFontDescription ) {
  pango_font_description_from_string( self._get-native-object-no-reffing, $str)
}

sub pango_font_description_from_string (
  gchar-ptr $str --> PangoFontDescription
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-family:
=begin pod
=head2 pango-font-description-get-family



  method pango-font-description-get-family ( PangoFontDescription $desc --> Str )

=item $desc; 
=end pod

method pango-font-description-get-family ( PangoFontDescription $desc --> Str ) {
  pango_font_description_get_family( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_family (
  PangoFontDescription $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-gravity:
=begin pod
=head2 pango-font-description-get-gravity



  method pango-font-description-get-gravity ( PangoFontDescription $desc --> N-GObject )

=item $desc; 
=end pod

method pango-font-description-get-gravity ( PangoFontDescription $desc --> N-GObject ) {
  pango_font_description_get_gravity( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_gravity (
  PangoFontDescription $desc --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-set-fields:
=begin pod
=head2 pango-font-description-get-set-fields



  method pango-font-description-get-set-fields ( PangoFontDescription $desc --> PangoFontMask )

=item $desc; 
=end pod

method pango-font-description-get-set-fields ( PangoFontDescription $desc --> PangoFontMask ) {
  pango_font_description_get_set_fields( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_set_fields (
  PangoFontDescription $desc --> PangoFontMask
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-size:
=begin pod
=head2 pango-font-description-get-size



  method pango-font-description-get-size ( PangoFontDescription $desc --> Int )

=item $desc; 
=end pod

method pango-font-description-get-size ( PangoFontDescription $desc --> Int ) {
  pango_font_description_get_size( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_size (
  PangoFontDescription $desc --> gint
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-size-is-absolute:
=begin pod
=head2 pango-font-description-get-size-is-absolute



  method pango-font-description-get-size-is-absolute ( PangoFontDescription $desc --> Bool )

=item $desc; 
=end pod

method pango-font-description-get-size-is-absolute ( PangoFontDescription $desc --> Bool ) {
  pango_font_description_get_size_is_absolute( self._get-native-object-no-reffing, $desc).Bool
}

sub pango_font_description_get_size_is_absolute (
  PangoFontDescription $desc --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-stretch:
=begin pod
=head2 pango-font-description-get-stretch



  method pango-font-description-get-stretch ( PangoFontDescription $desc --> PangoStretch )

=item $desc; 
=end pod

method pango-font-description-get-stretch ( PangoFontDescription $desc --> PangoStretch ) {
  pango_font_description_get_stretch( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_stretch (
  PangoFontDescription $desc --> PangoStretch
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-style:
=begin pod
=head2 pango-font-description-get-style



  method pango-font-description-get-style ( PangoFontDescription $desc --> PangoStyle )

=item $desc; 
=end pod

method pango-font-description-get-style ( PangoFontDescription $desc --> PangoStyle ) {
  pango_font_description_get_style( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_style (
  PangoFontDescription $desc --> PangoStyle
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-variant:
=begin pod
=head2 pango-font-description-get-variant



  method pango-font-description-get-variant ( PangoFontDescription $desc --> PangoVariant )

=item $desc; 
=end pod

method pango-font-description-get-variant ( PangoFontDescription $desc --> PangoVariant ) {
  pango_font_description_get_variant( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_variant (
  PangoFontDescription $desc --> PangoVariant
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-variations:
=begin pod
=head2 pango-font-description-get-variations



  method pango-font-description-get-variations ( PangoFontDescription $desc --> Str )

=item $desc; 
=end pod

method pango-font-description-get-variations ( PangoFontDescription $desc --> Str ) {
  pango_font_description_get_variations( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_variations (
  PangoFontDescription $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-get-weight:
=begin pod
=head2 pango-font-description-get-weight



  method pango-font-description-get-weight ( PangoFontDescription $desc --> PangoWeight )

=item $desc; 
=end pod

method pango-font-description-get-weight ( PangoFontDescription $desc --> PangoWeight ) {
  pango_font_description_get_weight( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_get_weight (
  PangoFontDescription $desc --> PangoWeight
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-hash:
=begin pod
=head2 pango-font-description-hash



  method pango-font-description-hash ( PangoFontDescription $desc --> UInt )

=item $desc; 
=end pod

method pango-font-description-hash ( PangoFontDescription $desc --> UInt ) {
  pango_font_description_hash( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_hash (
  PangoFontDescription $desc --> guint
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-merge:
=begin pod
=head2 pango-font-description-merge



  method pango-font-description-merge ( PangoFontDescription $desc, PangoFontDescription $desc_to_merge, Bool $replace_existing )

=item $desc; 
=item $desc_to_merge; 
=item $replace_existing; 
=end pod

method pango-font-description-merge ( PangoFontDescription $desc, PangoFontDescription $desc_to_merge, Bool $replace_existing ) {
  pango_font_description_merge( self._get-native-object-no-reffing, $desc, $desc_to_merge, $replace_existing);
}

sub pango_font_description_merge (
  PangoFontDescription $desc, PangoFontDescription $desc_to_merge, gboolean $replace_existing 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-merge-static:
=begin pod
=head2 pango-font-description-merge-static



  method pango-font-description-merge-static ( PangoFontDescription $desc, PangoFontDescription $desc_to_merge, Bool $replace_existing )

=item $desc; 
=item $desc_to_merge; 
=item $replace_existing; 
=end pod

method pango-font-description-merge-static ( PangoFontDescription $desc, PangoFontDescription $desc_to_merge, Bool $replace_existing ) {
  pango_font_description_merge_static( self._get-native-object-no-reffing, $desc, $desc_to_merge, $replace_existing);
}

sub pango_font_description_merge_static (
  PangoFontDescription $desc, PangoFontDescription $desc_to_merge, gboolean $replace_existing 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-new:
=begin pod
=head2 pango-font-description-new



  method pango-font-description-new ( --> PangoFontDescription )

=end pod

method pango-font-description-new ( --> PangoFontDescription ) {
  pango_font_description_new( self._get-native-object-no-reffing)
}

sub pango_font_description_new (
   --> PangoFontDescription
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-absolute-size:
=begin pod
=head2 pango-font-description-set-absolute-size



  method pango-font-description-set-absolute-size ( PangoFontDescription $desc, double $size )

=item $desc; 
=item $size; 
=end pod

method pango-font-description-set-absolute-size ( PangoFontDescription $desc, double $size ) {
  pango_font_description_set_absolute_size( self._get-native-object-no-reffing, $desc, $size);
}

sub pango_font_description_set_absolute_size (
  PangoFontDescription $desc, double $size 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-family:
=begin pod
=head2 pango-font-description-set-family



  method pango-font-description-set-family ( PangoFontDescription $desc, Str $family )

=item $desc; 
=item $family; 
=end pod

method pango-font-description-set-family ( PangoFontDescription $desc, Str $family ) {
  pango_font_description_set_family( self._get-native-object-no-reffing, $desc, $family);
}

sub pango_font_description_set_family (
  PangoFontDescription $desc, gchar-ptr $family 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-family-static:
=begin pod
=head2 pango-font-description-set-family-static



  method pango-font-description-set-family-static ( PangoFontDescription $desc, Str $family )

=item $desc; 
=item $family; 
=end pod

method pango-font-description-set-family-static ( PangoFontDescription $desc, Str $family ) {
  pango_font_description_set_family_static( self._get-native-object-no-reffing, $desc, $family);
}

sub pango_font_description_set_family_static (
  PangoFontDescription $desc, gchar-ptr $family 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-gravity:
=begin pod
=head2 pango-font-description-set-gravity



  method pango-font-description-set-gravity ( PangoFontDescription $desc, N-GObject() $gravity )

=item $desc; 
=item $gravity; 
=end pod

method pango-font-description-set-gravity ( PangoFontDescription $desc, N-GObject() $gravity ) {
  pango_font_description_set_gravity( self._get-native-object-no-reffing, $desc, $gravity);
}

sub pango_font_description_set_gravity (
  PangoFontDescription $desc, N-GObject $gravity 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-size:
=begin pod
=head2 pango-font-description-set-size



  method pango-font-description-set-size ( PangoFontDescription $desc, Int() $size )

=item $desc; 
=item $size; 
=end pod

method pango-font-description-set-size ( PangoFontDescription $desc, Int() $size ) {
  pango_font_description_set_size( self._get-native-object-no-reffing, $desc, $size);
}

sub pango_font_description_set_size (
  PangoFontDescription $desc, gint $size 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-stretch:
=begin pod
=head2 pango-font-description-set-stretch



  method pango-font-description-set-stretch ( PangoFontDescription $desc, PangoStretch $stretch )

=item $desc; 
=item $stretch; 
=end pod

method pango-font-description-set-stretch ( PangoFontDescription $desc, PangoStretch $stretch ) {
  pango_font_description_set_stretch( self._get-native-object-no-reffing, $desc, $stretch);
}

sub pango_font_description_set_stretch (
  PangoFontDescription $desc, PangoStretch $stretch 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-style:
=begin pod
=head2 pango-font-description-set-style



  method pango-font-description-set-style ( PangoFontDescription $desc, PangoStyle $style )

=item $desc; 
=item $style; 
=end pod

method pango-font-description-set-style ( PangoFontDescription $desc, PangoStyle $style ) {
  pango_font_description_set_style( self._get-native-object-no-reffing, $desc, $style);
}

sub pango_font_description_set_style (
  PangoFontDescription $desc, PangoStyle $style 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-variant:
=begin pod
=head2 pango-font-description-set-variant



  method pango-font-description-set-variant ( PangoFontDescription $desc, PangoVariant $variant )

=item $desc; 
=item $variant; 
=end pod

method pango-font-description-set-variant ( PangoFontDescription $desc, PangoVariant $variant ) {
  pango_font_description_set_variant( self._get-native-object-no-reffing, $desc, $variant);
}

sub pango_font_description_set_variant (
  PangoFontDescription $desc, PangoVariant $variant 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-variations:
=begin pod
=head2 pango-font-description-set-variations



  method pango-font-description-set-variations ( PangoFontDescription $desc, Str $variations )

=item $desc; 
=item $variations; 
=end pod

method pango-font-description-set-variations ( PangoFontDescription $desc, Str $variations ) {
  pango_font_description_set_variations( self._get-native-object-no-reffing, $desc, $variations);
}

sub pango_font_description_set_variations (
  PangoFontDescription $desc, gchar-ptr $variations 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-variations-static:
=begin pod
=head2 pango-font-description-set-variations-static



  method pango-font-description-set-variations-static ( PangoFontDescription $desc, Str $variations )

=item $desc; 
=item $variations; 
=end pod

method pango-font-description-set-variations-static ( PangoFontDescription $desc, Str $variations ) {
  pango_font_description_set_variations_static( self._get-native-object-no-reffing, $desc, $variations);
}

sub pango_font_description_set_variations_static (
  PangoFontDescription $desc, gchar-ptr $variations 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-set-weight:
=begin pod
=head2 pango-font-description-set-weight



  method pango-font-description-set-weight ( PangoFontDescription $desc, PangoWeight $weight )

=item $desc; 
=item $weight; 
=end pod

method pango-font-description-set-weight ( PangoFontDescription $desc, PangoWeight $weight ) {
  pango_font_description_set_weight( self._get-native-object-no-reffing, $desc, $weight);
}

sub pango_font_description_set_weight (
  PangoFontDescription $desc, PangoWeight $weight 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-to-filename:
=begin pod
=head2 pango-font-description-to-filename



  method pango-font-description-to-filename ( PangoFontDescription $desc --> Str )

=item $desc; 
=end pod

method pango-font-description-to-filename ( PangoFontDescription $desc --> Str ) {
  pango_font_description_to_filename( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_to_filename (
  PangoFontDescription $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-to-string:
=begin pod
=head2 pango-font-description-to-string



  method pango-font-description-to-string ( PangoFontDescription $desc --> Str )

=item $desc; 
=end pod

method pango-font-description-to-string ( PangoFontDescription $desc --> Str ) {
  pango_font_description_to_string( self._get-native-object-no-reffing, $desc)
}

sub pango_font_description_to_string (
  PangoFontDescription $desc --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-description-unset-fields:
=begin pod
=head2 pango-font-description-unset-fields



  method pango-font-description-unset-fields ( PangoFontDescription $desc, PangoFontMask $to_unset )

=item $desc; 
=item $to_unset; 
=end pod

method pango-font-description-unset-fields ( PangoFontDescription $desc, PangoFontMask $to_unset ) {
  pango_font_description_unset_fields( self._get-native-object-no-reffing, $desc, $to_unset);
}

sub pango_font_description_unset_fields (
  PangoFontDescription $desc, PangoFontMask $to_unset 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-descriptions-free:
=begin pod
=head2 pango-font-descriptions-free



  method pango-font-descriptions-free ( PangoFontDescription $descs, Int() $n_descs )

=item $descs; 
=item $n_descs; 
=end pod

method pango-font-descriptions-free ( PangoFontDescription $descs, Int() $n_descs ) {
  pango_font_descriptions_free( self._get-native-object-no-reffing, $descs, $n_descs);
}

sub pango_font_descriptions_free (
  PangoFontDescription $descs, int $n_descs 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-deserialize:
=begin pod
=head2 pango-font-deserialize



  method pango-font-deserialize ( N-GObject() $context, GBytes $bytes, N-GError $error --> N-GObject )

=item $context; 
=item $bytes; 
=item $error; 
=end pod

method pango-font-deserialize ( N-GObject() $context, GBytes $bytes, $error is copy --> N-GObject ) {
  $error .= _get-native-object-no-reffing unless $error ~~ N-GError;
  pango_font_deserialize( self._get-native-object-no-reffing, $context, $bytes, $error)
}

sub pango_font_deserialize (
  N-GObject $context, GBytes $bytes, N-GError $error --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-family-get-face:
=begin pod
=head2 pango-font-family-get-face



  method pango-font-family-get-face ( PangoFontFamily $family, Str $name --> PangoFontFace )

=item $family; 
=item $name; 
=end pod

method pango-font-family-get-face ( PangoFontFamily $family, Str $name --> PangoFontFace ) {
  pango_font_family_get_face( self._get-native-object-no-reffing, $family, $name)
}

sub pango_font_family_get_face (
  PangoFontFamily $family, gchar-ptr $name --> PangoFontFace
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-family-get-name:
=begin pod
=head2 pango-font-family-get-name



  method pango-font-family-get-name ( PangoFontFamily $family --> Str )

=item $family; 
=end pod

method pango-font-family-get-name ( PangoFontFamily $family --> Str ) {
  pango_font_family_get_name( self._get-native-object-no-reffing, $family)
}

sub pango_font_family_get_name (
  PangoFontFamily $family --> gchar-ptr
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-family-is-monospace:
=begin pod
=head2 pango-font-family-is-monospace



  method pango-font-family-is-monospace ( PangoFontFamily $family --> Bool )

=item $family; 
=end pod

method pango-font-family-is-monospace ( PangoFontFamily $family --> Bool ) {
  pango_font_family_is_monospace( self._get-native-object-no-reffing, $family).Bool
}

sub pango_font_family_is_monospace (
  PangoFontFamily $family --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-family-is-variable:
=begin pod
=head2 pango-font-family-is-variable



  method pango-font-family-is-variable ( PangoFontFamily $family --> Bool )

=item $family; 
=end pod

method pango-font-family-is-variable ( PangoFontFamily $family --> Bool ) {
  pango_font_family_is_variable( self._get-native-object-no-reffing, $family).Bool
}

sub pango_font_family_is_variable (
  PangoFontFamily $family --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-family-list-faces:
=begin pod
=head2 pango-font-family-list-faces



  method pango-font-family-list-faces ( PangoFontFamily $family, PangoFontFace $faces )

=item $family; 
=item $faces; 
=item $n_faces; 
=end pod

method pango-font-family-list-faces ( PangoFontFamily $family, PangoFontFace $faces ) {
  pango_font_family_list_faces( self._get-native-object-no-reffing, $family, $faces, my gint $n_faces);
}

sub pango_font_family_list_faces (
  PangoFontFamily $family, PangoFontFace $faces, gint $n_faces is rw 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-coverage:
=begin pod
=head2 pango-font-get-coverage



  method pango-font-get-coverage ( N-GObject() $font, N-GObject() $language --> N-GObject )

=item $font; 
=item $language; 
=end pod

method pango-font-get-coverage ( N-GObject() $font, N-GObject() $language --> N-GObject ) {
  pango_font_get_coverage( self._get-native-object-no-reffing, $font, $language)
}

sub pango_font_get_coverage (
  N-GObject $font, N-GObject $language --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-face:
=begin pod
=head2 pango-font-get-face



  method pango-font-get-face ( N-GObject() $font --> PangoFontFace )

=item $font; 
=end pod

method pango-font-get-face ( N-GObject() $font --> PangoFontFace ) {
  pango_font_get_face( self._get-native-object-no-reffing, $font)
}

sub pango_font_get_face (
  N-GObject $font --> PangoFontFace
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-features:
=begin pod
=head2 pango-font-get-features



  method pango-font-get-features ( N-GObject() $font, hb_feature_t $features, UInt $len, guInt-ptr $num_features )

=item $font; 
=item $features; 
=item $len; 
=item $num_features; 
=end pod

method pango-font-get-features ( N-GObject() $font, hb_feature_t $features, UInt $len, guInt-ptr $num_features ) {
  pango_font_get_features( self._get-native-object-no-reffing, $font, $features, $len, $num_features);
}

sub pango_font_get_features (
  N-GObject $font, hb_feature_t $features, guint $len, gugint-ptr $num_features 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-font-map:
=begin pod
=head2 pango-font-get-font-map



  method pango-font-get-font-map ( N-GObject() $font --> N-GObject )

=item $font; 
=end pod

method pango-font-get-font-map ( N-GObject() $font --> N-GObject ) {
  pango_font_get_font_map( self._get-native-object-no-reffing, $font)
}

sub pango_font_get_font_map (
  N-GObject $font --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-glyph-extents:
=begin pod
=head2 pango-font-get-glyph-extents



  method pango-font-get-glyph-extents ( N-GObject() $font, N-GObject() $glyph, PangoRectangle $ink_rect, PangoRectangle $logical_rect )

=item $font; 
=item $glyph; 
=item $ink_rect; 
=item $logical_rect; 
=end pod

method pango-font-get-glyph-extents ( N-GObject() $font, N-GObject() $glyph, PangoRectangle $ink_rect, PangoRectangle $logical_rect ) {
  pango_font_get_glyph_extents( self._get-native-object-no-reffing, $font, $glyph, $ink_rect, $logical_rect);
}

sub pango_font_get_glyph_extents (
  N-GObject $font, N-GObject $glyph, PangoRectangle $ink_rect, PangoRectangle $logical_rect 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-hb-font:
=begin pod
=head2 pango-font-get-hb-font



  method pango-font-get-hb-font ( N-GObject() $font --> hb_font_t )

=item $font; 
=end pod

method pango-font-get-hb-font ( N-GObject() $font --> hb_font_t ) {
  pango_font_get_hb_font( self._get-native-object-no-reffing, $font)
}

sub pango_font_get_hb_font (
  N-GObject $font --> hb_font_t
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-languages:
=begin pod
=head2 pango-font-get-languages



  method pango-font-get-languages ( N-GObject() $font --> N-GObject )

=item $font; 
=end pod

method pango-font-get-languages ( N-GObject() $font --> N-GObject ) {
  pango_font_get_languages( self._get-native-object-no-reffing, $font)
}

sub pango_font_get_languages (
  N-GObject $font --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-get-metrics:
=begin pod
=head2 pango-font-get-metrics



  method pango-font-get-metrics ( N-GObject() $font, N-GObject() $language --> PangoFontMetrics )

=item $font; 
=item $language; 
=end pod

method pango-font-get-metrics ( N-GObject() $font, N-GObject() $language --> PangoFontMetrics ) {
  pango_font_get_metrics( self._get-native-object-no-reffing, $font, $language)
}

sub pango_font_get_metrics (
  N-GObject $font, N-GObject $language --> PangoFontMetrics
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-has-char:
=begin pod
=head2 pango-font-has-char



  method pango-font-has-char ( N-GObject() $font, gunichar $wc --> Bool )

=item $font; 
=item $wc; 
=end pod

method pango-font-has-char ( N-GObject() $font, gunichar $wc --> Bool ) {
  pango_font_has_char( self._get-native-object-no-reffing, $font, $wc).Bool
}

sub pango_font_has_char (
  N-GObject $font, gunichar $wc --> gboolean
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-approximate-char-width:
=begin pod
=head2 pango-font-metrics-get-approximate-char-width



  method pango-font-metrics-get-approximate-char-width ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-approximate-char-width ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_approximate_char_width( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_approximate_char_width (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-approximate-digit-width:
=begin pod
=head2 pango-font-metrics-get-approximate-digit-width



  method pango-font-metrics-get-approximate-digit-width ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-approximate-digit-width ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_approximate_digit_width( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_approximate_digit_width (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-ascent:
=begin pod
=head2 pango-font-metrics-get-ascent



  method pango-font-metrics-get-ascent ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-ascent ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_ascent( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_ascent (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-descent:
=begin pod
=head2 pango-font-metrics-get-descent



  method pango-font-metrics-get-descent ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-descent ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_descent( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_descent (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-height:
=begin pod
=head2 pango-font-metrics-get-height



  method pango-font-metrics-get-height ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-height ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_height( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_height (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-strikethrough-position:
=begin pod
=head2 pango-font-metrics-get-strikethrough-position



  method pango-font-metrics-get-strikethrough-position ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-strikethrough-position ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_strikethrough_position( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_strikethrough_position (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-strikethrough-thickness:
=begin pod
=head2 pango-font-metrics-get-strikethrough-thickness



  method pango-font-metrics-get-strikethrough-thickness ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-strikethrough-thickness ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_strikethrough_thickness( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_strikethrough_thickness (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-underline-position:
=begin pod
=head2 pango-font-metrics-get-underline-position



  method pango-font-metrics-get-underline-position ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-underline-position ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_underline_position( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_underline_position (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-get-underline-thickness:
=begin pod
=head2 pango-font-metrics-get-underline-thickness



  method pango-font-metrics-get-underline-thickness ( PangoFontMetrics $metrics --> Int )

=item $metrics; 
=end pod

method pango-font-metrics-get-underline-thickness ( PangoFontMetrics $metrics --> Int ) {
  pango_font_metrics_get_underline_thickness( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_get_underline_thickness (
  PangoFontMetrics $metrics --> int
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-ref:
=begin pod
=head2 pango-font-metrics-ref



  method pango-font-metrics-ref ( PangoFontMetrics $metrics --> PangoFontMetrics )

=item $metrics; 
=end pod

method pango-font-metrics-ref ( PangoFontMetrics $metrics --> PangoFontMetrics ) {
  pango_font_metrics_ref( self._get-native-object-no-reffing, $metrics)
}

sub pango_font_metrics_ref (
  PangoFontMetrics $metrics --> PangoFontMetrics
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-metrics-unref:
=begin pod
=head2 pango-font-metrics-unref



  method pango-font-metrics-unref ( PangoFontMetrics $metrics )

=item $metrics; 
=end pod

method pango-font-metrics-unref ( PangoFontMetrics $metrics ) {
  pango_font_metrics_unref( self._get-native-object-no-reffing, $metrics);
}

sub pango_font_metrics_unref (
  PangoFontMetrics $metrics 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-font-serialize:
=begin pod
=head2 pango-font-serialize



  method pango-font-serialize ( N-GObject() $font --> GBytes )

=item $font; 
=end pod

method pango-font-serialize ( N-GObject() $font --> GBytes ) {
  pango_font_serialize( self._get-native-object-no-reffing, $font)
}

sub pango_font_serialize (
  N-GObject $font --> GBytes
) is native(&pango-lib)
  { * }
}}
