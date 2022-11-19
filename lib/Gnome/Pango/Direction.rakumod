#TL:1:Gnome::Pango::Direction:

use v6;
#-------------------------------------------------------------------------------
=begin pod

=head1 Gnome::Pango::Direction

=comment ![](images/X.png)

=head1 Synopsis
=head2 Declaration

  unit class Gnome::Pango::Direction;

=comment head2 Example

=end pod

#-------------------------------------------------------------------------------
unit class Gnome::Pango::Direction:auth<github:MARTIMM>;

#-------------------------------------------------------------------------------
=begin pod
=head1 Types
=end pod

#-------------------------------------------------------------------------------
=begin pod
=head2 enum PangoDirection

`PangoDirection` represents a direction in the Unicode bidirectional
algorithm.

Not every value in this enumeration makes sense for every usage of
`PangoDirection`; for example, the return value of [funcI<unichar_direction>]
and [funcI<find_base_dir>] cannot be `PANGO_DIRECTION_WEAK_LTR` or
`PANGO_DIRECTION_WEAK_RTL`, since every character is either neutral
or has a strong direction; on the other hand `PANGO_DIRECTION_NEUTRAL`
doesn't make sense to pass to [funcI<itemize_with_base_dir>].

The `PANGO_DIRECTION_TTB_LTR`, `PANGO_DIRECTION_TTB_RTL` values come from
an earlier interpretation of this enumeration as the writing direction
of a block of text and are no longer used. See `PangoGravity` for how
vertical text is handled in Pango.

If you are interested in text direction, you should really use fribidi
directly. `PangoDirection` is only retained because it is used in some
public apis.


=item PANGO_DIRECTION_LTR: A strong left-to-right direction
=item PANGO_DIRECTION_RTL: A strong right-to-left direction
=item PANGO_DIRECTION_TTB_LTR: Deprecated value; treated the same as `PANGO_DIRECTION_RTL`.
=item PANGO_DIRECTION_TTB_RTL: Deprecated value; treated the same as `PANGO_DIRECTION_LTR`
=item PANGO_DIRECTION_WEAK_LTR: A weak left-to-right direction
=item PANGO_DIRECTION_WEAK_RTL: A weak right-to-left direction
=item PANGO_DIRECTION_NEUTRAL: No direction specified


=end pod

#TE:1:PangoDirection:
enum PangoDirection is export (
  'PANGO_DIRECTION_LTR',
  'PANGO_DIRECTION_RTL',
  'PANGO_DIRECTION_TTB_LTR',
  'PANGO_DIRECTION_TTB_RTL',
  'PANGO_DIRECTION_WEAK_LTR',
  'PANGO_DIRECTION_WEAK_RTL',
  'PANGO_DIRECTION_NEUTRAL'
);
