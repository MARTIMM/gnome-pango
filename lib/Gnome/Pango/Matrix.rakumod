#TL:1:Gnome::Pango::Matrix:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Matrix

=head1 Description

A Gnome::Pango::Matrix specifies a transformation between user-space and device coordinates.

Given the transformation matrix.

  class N-PangoMatrix is export is repr('CStruct') {
    has gdouble $.xx;
    has gdouble $.xy;
    has gdouble $.yx;
    has gdouble $.yy;
    has gdouble $.x0;
    has gdouble $.y0;
  }


Then the transformation is given by

  | $xd $yd | = | $xu $yu 1 | * | $xx $yx |
                                | $xy $yy |
                                | $x0 $y0 |
  
or

  $xd = $xu * $matrix.xx + $yu * $matrix.xy + $matrix.x0;
  $yd = $xu * $matrix.yx + $yu * $matrix.yy + $matrix.y0;


=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Matrix;
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


#-------------------------------------------------------------------------------
unit class Gnome::Pango::Matrix:auth<github:MARTIMM>;
also is Gnome::GObject::Boxed;


#-------------------------------------------------------------------------------
=begin pod
=head1 Types
=end pod

#-------------------------------------------------------------------------------
=begin pod
=head2 class N-PangoMatrix

A `PangoMatrix` specifies a transformation between user-space
and device coordinates.

=item double $.xx: 1st component of the transformation matrix
=item double $.xy: 2nd component of the transformation matrix
=item double $.yx: 3rd component of the transformation matrix
=item double $.yy: 4th component of the transformation matrix
=item double $.x0: x translation
=item double $.y0: y translation

=end pod


#TT:1:N-PangoMatrix:
class N-PangoMatrix is export is repr('CStruct') {
  has gdouble $.xx;
  has gdouble $.xy;
  has gdouble $.yx;
  has gdouble $.yy;
  has gdouble $.x0;
  has gdouble $.y0;

  multi submethod BUILD (
    Num() :$!xx!, Num() :$!xy, Num() :$!yx,
    Num() :$!yy,  Num() :$!x0, Num() :$!y0
  ) { }

  multi submethod BUILD ( Any:D :$matrix! ) {
    my N-PangoMatrix $pm;
    if $matrix ~~ Gnome::Pango::Matrix {
      $pm = $matrix.get-native-object-no-reffing;
    }

    elsif $matrix ~~ N-PangoMatrix {
      $pm = $matrix;
    }

    else {
      die X::Gnome.new(:message('$matrix has not the proper type'));
    }

    $!xx = $pm.xx;
    $!xy = $pm.xy;
    $!yx = $pm.yx;
    $!yy = $pm.yy;
    $!x0 = $pm.x0;
    $!y0 = $pm.y0;
  }

#TODO coersion is not working for 'my N-PangoMatrix() $pm = $m
# produced error: Cannot find method 'is_dispatcher' on object of type BOOTCode
  method COERCE ( $no is copy --> N-PangoMatrix ) {
    $no .= get-native-object unless $no ~~ any(N-GObject,N-PangoMatrix);
    note "Coercing from {$no.^name} to ", self.^name if $Gnome::N::x-debug;
    nativecast( N-PangoMatrix, $no)
  }
}

#-------------------------------------------------------------------------------
=begin pod
=head1 Methods
=head2 new

=head3 default, no options

Create a new Matrix object.

  multi method new ( )


=head3 :native-object

Create a Matrix object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:1:new():
#TM:4:new(:native-object):Gnome::N::TopLevelClassSupport
submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::Matrix' {

    # check if native object is set by a parent class
    if self.is-valid { }

    # check if common options are handled by some parent
    elsif %options<native-object>:exists { }

    # process all other options
    else {
      my $no;
      if %options<matrix>:exists {
        my %m = %options<matrix>;
        $no = N-PangoMatrix.new(
          :xx(%m<xx>.Num), :xy(%m<xy>.Num), :yx(%m<yx>.Num),
          :yy(%m<yy>.Num), :x0(%m<x0>.Num), :y0(%m<y0>.Num)
        );
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
        $no = _pango_matrix_new();
      }
      }}

      self.set-native-object($no);
    }

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoMatrix');
  }
}

#-------------------------------------------------------------------------------
method native-object-ref ( $n-native-object ) {
  $n-native-object
}

#-------------------------------------------------------------------------------
method native-object-unref ( $n-native-object ) {
  if self.is-valid {
    _pango_matrix_free(self.get-native-object);
    self.set-valid(False);
  }
}


#-------------------------------------------------------------------------------
#TM:0:concat:
=begin pod
=head2 concat

Changes the transformation represented by I<matrix> to be the transformation given by first applying transformation given by I<new_matrix> then applying the original transformation.

  method concat ( N-GObject() $new_matrix )

=item $new_matrix; a `PangoMatrix`
=end pod

method concat ( N-GObject() $new_matrix ) {
  pango_matrix_concat( self._get-native-object-no-reffing, $new_matrix);
}

sub pango_matrix_concat (
  N-GObject $matrix, N-GObject $new_matrix 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:copy:
=begin pod
=head2 copy

Copies a PangoMatrix.

  method copy ( --> N-GObject )

Example

  my Gnome::Pango::Matrix() $my-copy = $matrix.copy;

=end pod

method copy ( --> N-GObject ) {
  pango_matrix_copy( self._get-native-object-no-reffing)
}

sub pango_matrix_copy (
  N-PangoMatrix $matrix --> N-GObject
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:_pango_matrix_free:
#`{{
  =begin pod
=head2 free

Free a `PangoMatrix`.

  method free ( )

=end pod

method free ( ) {
  pango_matrix_free( self._get-native-object-no-reffing);
}
}}

sub _pango_matrix_free (
  N-PangoMatrix $matrix 
) is native(&pango-lib)
  is symbol('pango_matrix_free')
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-font-scale-factor:
=begin pod
=head2 get-font-scale-factor

Returns the scale factor of a matrix on the height of the font.

That is, the scale factor in the direction perpendicular to the vector that the X coordinate is mapped to. If the scale in the X coordinate is needed as well, use method C<.get-font-scale-factors()>.

Return value: the scale factor of I<matrix> on the height of the font, or 1.0 if I<matrix> is C<undefined>.

  method get-font-scale-factor ( --> Num )

=end pod

method get-font-scale-factor ( --> Num ) {
  pango_matrix_get_font_scale_factor(self._get-native-object-no-reffing)
}

sub pango_matrix_get_font_scale_factor (
  N-PangoMatrix $matrix --> gdouble
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:get-font-scale-factors:
=begin pod
=head2 get-font-scale-factors

Calculates the scale factor of a matrix on the width and height of the font.

That is, I<xscale> is the scale factor in the direction of the X coordinate, and I<yscale> is the scale factor in the direction perpendicular to the vector that the X coordinate is mapped to.

Note that output numbers will always be non-negative.

  method get-font-scale-factors ( --> List )

The list returned consists of
=item scale factor in the x direction
=item scale factor perpendicular to the x direction
=end pod

method get-font-scale-factors ( --> List ) {
  my gdouble $xscale;
  my gdouble $yscale;
  pango_matrix_get_font_scale_factors(
    self._get-native-object-no-reffing, $xscale, $yscale
  );

  ( $xscale, $yscale)
}

sub pango_matrix_get_font_scale_factors (
  N-PangoMatrix $matrix,  gdouble  $xscale,  gdouble  $yscale 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:01:get-slant-ratio:
=begin pod
=head2 get-slant-ratio

Gets the slant ratio of a matrix.

For a simple shear matrix in the form:

1 λ 0 1

this is simply λ.

Returns: the slant ratio of I<matrix>

  method get-slant-ratio ( --> Num )

=end pod

method get-slant-ratio ( --> Num ) {
  pango_matrix_get_slant_ratio( self._get-native-object-no-reffing)
}

sub pango_matrix_get_slant_ratio (
  N-PangoMatrix $matrix -->  gdouble 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:rotate:
=begin pod
=head2 rotate

Changes the transformation represented by I<matrix> to be the transformation given by first rotating by I<degrees> degrees counter-clockwise then applying the original transformation.

  method rotate ( Num() $degrees )

=item $degrees; degrees to rotate counter-clockwise
=end pod

method rotate ( Num() $degrees ) {
  pango_matrix_rotate( self._get-native-object-no-reffing, $degrees);
}

sub pango_matrix_rotate (
  N-PangoMatrix $matrix,  gdouble  $degrees 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:scale:
=begin pod
=head2 scale

Changes the transformation represented by I<matrix> to be the transformation given by first scaling by I<sx> in the X direction and I<sy> in the Y direction then applying the original transformation.

  method scale ( Num() $scale_x, Num() $scale_y )

=item $scale_x; amount to scale by in X direction
=item $scale_y; amount to scale by in Y direction
=end pod

method scale ( Num() $scale_x, Num() $scale_y ) {
  pango_matrix_scale( self._get-native-object-no-reffing, $scale_x, $scale_y);
}

sub pango_matrix_scale (
  N-PangoMatrix $matrix,  gdouble  $scale_x,  gdouble  $scale_y 
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:1:transform-distance:
=begin pod
=head2 transform-distance

Transforms the distance vector (I<dx>,I<dy>) by I<matrix>.

This is similar to method C<.transform_point()>, except that the translation components of the transformation are ignored. The calculation of the returned vector is as follows:

  dx2 = dx1 * xx + dy1 * xy;
  dy2 = dx1 * yx + dy1 * yy;

Affine transformations are position invariant, so the same vector always transforms to the same vector. If (I<x1>,I<y1>) transforms to (I<x2>,I<y2>) then (I<x1>+I<dx1>,I<y1>+I<dy1>) will transform to (I<x1>+I<dx2>,I<y1>+I<dy2>) for all values of I<x1> and I<x2>.

  method transform-distance ( Num() $dx is rw, Num() $dy is rw )

=item $dx; X component of a distance vector
=item $dy; Y component of a distance vector
=end pod

method transform-distance ( Num() $dx is rw, Num() $dy is rw ) {
  my gdouble $n-dx = $dx;
  my gdouble $n-dy = $dy;
  pango_matrix_transform_distance(
    self._get-native-object-no-reffing, $n-dx, $n-dy
  );

  $dx = $n-dx;
  $dy = $n-dy;
}

sub pango_matrix_transform_distance (
  N-PangoMatrix $matrix,  gdouble  $dx is rw,  gdouble  $dy  is rw
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:transform-pixel-rectangle:
=begin pod
=head2 transform-pixel-rectangle

First transforms the I<rect> using I<matrix>, then calculates the bounding box of the transformed rectangle.

This function is useful for example when you want to draw a rotated I<PangoLayout> to an image buffer, and want to know how large the image should be and how much you should shift the layout when rendering.

For better accuracy, you should use [methodI<Pango>.Matrix.transform_rectangle] on original rectangle in Pango units and convert to pixels afterward using [funcI<extents_to_pixels>]'s first argument.

  method transform-pixel-rectangle ( PangoRectangle $rect )

=item $rect; in/out bounding box in device units
=end pod

method transform-pixel-rectangle ( PangoRectangle $rect ) {
  pango_matrix_transform_pixel_rectangle( self._get-native-object-no-reffing, $rect);
}

sub pango_matrix_transform_pixel_rectangle (
  N-PangoMatrix $matrix, PangoRectangle $rect 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:1:transform-point:
=begin pod
=head2 transform-point

Transforms the point (I<x>, I<y>) by I<matrix>.

  method transform-point ( Num() $x is rw, Num() $y is rw )

=item $x; in/out X position
=item $y; in/out Y position
=end pod

method transform-point ( Num() $x is rw, Num() $y is rw ) {
  my gdouble $nx = $x;
  my gdouble $ny = $y;
  pango_matrix_transform_point( self._get-native-object-no-reffing, $nx, $ny);
  $x = $nx;
  $y = $ny;
}

sub pango_matrix_transform_point (
  N-PangoMatrix $matrix,  gdouble  $x is rw,  gdouble $y  is rw
) is native(&pango-lib)
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:transform-rectangle:
=begin pod
=head2 transform-rectangle

First transforms I<rect> using I<matrix>, then calculates the bounding box of the transformed rectangle.

This function is useful for example when you want to draw a rotated I<PangoLayout> to an image buffer, and want to know how large the image should be and how much you should shift the layout when rendering.

If you have a rectangle in device units (pixels), use [methodI<Pango>.Matrix.transform_pixel_rectangle].

If you have the rectangle in Pango units and want to convert to transformed pixel bounding box, it is more accurate to transform it first (using this function) and pass the result to C<pango_extents_to_pixels()>, first argument, for an inclusive rounded rectangle. However, there are valid reasons that you may want to convert to pixels first and then transform, for example when the transformed coordinates may overflow in Pango units (large matrix translation for example).

  method transform-rectangle ( PangoRectangle $rect )

=item $rect; in/out bounding box in Pango units
=end pod

method transform-rectangle ( PangoRectangle $rect ) {
  pango_matrix_transform_rectangle( self._get-native-object-no-reffing, $rect);
}

sub pango_matrix_transform_rectangle (
  N-PangoMatrix $matrix, PangoRectangle $rect 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:1:translate:
=begin pod
=head2 translate

Changes the transformation represented by I<matrix> to be the transformation given by first translating by (I<tx>, I<ty>) then applying the original transformation.

  method translate ( Num() $tx, Num() $ty )

=item $tx; amount to translate in the X direction
=item $ty; amount to translate in the Y direction
=end pod

method translate ( Num() $tx, Num() $ty ) {
  pango_matrix_translate( self._get-native-object-no-reffing, $tx, $ty);
}

sub pango_matrix_translate (
  N-PangoMatrix $matrix,  gdouble  $tx,  gdouble  $ty 
) is native(&pango-lib)
  { * }
