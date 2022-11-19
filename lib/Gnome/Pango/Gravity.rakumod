#TL:1:Gnome::Pango::Gravity:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Gravity

=head1 Description

=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Gravity;
  


=comment head2 Example

=end pod
#-------------------------------------------------------------------------------
use NativeCall;

#use Gnome::N::X;
use Gnome::N::NativeLib;
use Gnome::N::N-GObject;
use Gnome::N::GlibToRakuTypes;


#-------------------------------------------------------------------------------
unit class Gnome::Pango::Gravity:auth<github:MARTIMM>;


#-------------------------------------------------------------------------------
=begin pod
=head1 Types
=end pod
#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoGravity

`PangoGravity` represents the orientation of glyphs in a segment
of text.

This is useful when rendering vertical text layouts. In those situations,
the layout is rotated using a non-identity [structI<Pango>.Matrix], and then
glyph orientation is controlled using `PangoGravity`.

Not every value in this enumeration makes sense for every usage of
`PangoGravity`; for example, C<PANGO_GRAVITY_AUTO> only can be passed to
[methodI<Pango>.Context.set_base_gravity] and can only be returned by
[methodI<Pango>.Context.get_base_gravity].

See also: PangoGravityHint below



=item PANGO_GRAVITY_SOUTH: Glyphs stand upright (default) <img align="right" valign="center" src="m-south.png">
=item PANGO_GRAVITY_EAST: Glyphs are rotated 90 degrees counter-clockwise. <img align="right" valign="center" src="m-east.png">
=item PANGO_GRAVITY_NORTH: Glyphs are upside-down. <img align="right" valign="cener" src="m-north.png">
=item PANGO_GRAVITY_WEST: Glyphs are rotated 90 degrees clockwise. <img align="right" valign="center" src="m-west.png">
=item PANGO_GRAVITY_AUTO: Gravity is resolved from the context matrix


=end pod

#TE:1:PangoGravity:
enum PangoGravity is export (
  'PANGO_GRAVITY_SOUTH',
  'PANGO_GRAVITY_EAST',
  'PANGO_GRAVITY_NORTH',
  'PANGO_GRAVITY_WEST',
  'PANGO_GRAVITY_AUTO'
);

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoGravityHint

`PangoGravityHint` defines how horizontal scripts should behave in a
vertical context.

That is, English excerpts in a vertical paragraph for example.

See also [enumI<Pango>.Gravity]



=item PANGO_GRAVITY_HINT_NATURAL: scripts will take their natural gravity based on the base gravity and the script.  This is the default.
=item PANGO_GRAVITY_HINT_STRONG: always use the base gravity set, regardless of the script.
=item PANGO_GRAVITY_HINT_LINE: for scripts not in their natural direction (eg. Latin in East gravity), choose per-script gravity such that every script respects the line progression. This means, Latin and Arabic will take opposite gravities and both flow top-to-bottom for example.


=end pod

#TE:1:PangoGravityHint:
enum PangoGravityHint is export (
  'PANGO_GRAVITY_HINT_NATURAL',
  'PANGO_GRAVITY_HINT_STRONG',
  'PANGO_GRAVITY_HINT_LINE'
);

#`{{
#-------------------------------------------------------------------------------
=begin pod
=head1 Methods
=head2 new

=head3 default, no options

Create a new Gravity object.

  multi method new ( )


=head3 :native-object

Create a Gravity object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )

=end pod

#TM:1:new():
#TM:4:new(:native-object):Gnome::N::TopLevelClassSupport
submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::Gravity' {

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
        #$no = _pango_gravity_new___x___($no);
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

      #`{{ when there are defaults use this instead
      # create default object
      else {
        $no = _pango_gravity_new();
      }
      }}

      self.set-native-object($no);
    }

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoGravity');
  }
}
}}

#`{{
#-------------------------------------------------------------------------------
#TM:0:get-for-matrix:
=begin pod
=head2 get-for-matrix

Finds the gravity that best matches the rotation component in a `PangoMatrix`.

Return value: the gravity of I<matrix>, which will never be C<PANGO_GRAVITY_AUTO>, or C<PANGO_GRAVITY_SOUTH> if I<matrix> is C<undefined>

I<gravity>: gravity to query, should not be C<PANGO_GRAVITY_AUTO>

Converts a `PangoGravity` value to its natural rotation in radians.

Note that [methodI<Pango>.Matrix.rotate] takes angle in degrees, not radians. So, to call [methodI<Pango>.Matrix,rotate] with the output of this function you should multiply it by (180. / G_PI).

Return value: the rotation value corresponding to I<gravity>.

Since: 1.16


  method get-for-matrix ( N-GObject() $matrix --> N-GObject )

=item $matrix; a `PangoMatrix`
=end pod

method get-for-matrix ( N-GObject() $matrix --> N-GObject ) {
  pango_gravity_get_for_matrix( self._f('PangoGravity'), $matrix)
}

sub pango_gravity_get_for_matrix (
  N-GObject $matrix --> N-GObject
) is native(&pango-lib)
  { * }
}}