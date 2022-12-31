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
use Gnome::N::GlibToRakuTypes;

use Gnome::GObject::Boxed;

#-------------------------------------------------------------------------------
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

#TT:1:N-PangoItem:
class N-PangoItem is export is repr('CStruct') {
  has int32 $.offset;
  has int32 $.length;
  has int32 $.num_chars;
#  has Pointer $.analysis;
#  has PangoAnalysis $.analysis;
  has gpointer $.analysis;

  method COERCE ( $no --> N-PangoItem ) {
    note "Coercing from {$no.^name} to ", self.^name if $Gnome::N::x-debug;
    nativecast( N-PangoItem, $no)
  }
}

#-------------------------------------------------------------------------------
=begin pod
=head1 Methods
=head2 new

=head3 default, no options

Create a new pango item.

  multi method new ( )


=head3 :native-object

Create a Item object using a native object from elsewhere. See also B<Gnome::N::TopLevelClassSupport>.

  multi method new ( N-GObject :$native-object! )
=end pod

#TM:1:new():
#TM:1:new(:native-object):
submethod BUILD ( *%options ) {

  # prevent creating wrong native-objects
  if self.^name eq 'Gnome::Pango::Item' {

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
        $no = _pango_item_new();
      }
      #}}

      self.set-native-object($no);
    }

    # only after creating the native-object, the gtype is known
    self._set-class-info('PangoItem');
  }
}

#-------------------------------------------------------------------------------
method native-object-ref ( $n-native-object ) {
  $n-native-object
}

#-------------------------------------------------------------------------------
method native-object-unref ( $n-native-object ) {
  if self.is-valid {
    _pango_item_free(self.get-native-object);
    self.set-valid(False);
  }
}

#`{{
#-------------------------------------------------------------------------------
#TM:0:apply-attrs:
=begin pod
=head2 apply-attrs

Add attributes to a `PangoItem`.

The idea is that you have attributes that don't affect itemization, such as font features, so you filter them out using [methodI<Pango>.AttrList.filter], itemize your text, then reapply the attributes to the resulting items using this function.

The I<iter> should be positioned before the range of the item, and will be advanced past it. This function is meant to be called in a loop over the items resulting from itemization, while passing the iter to each call.

  method apply-attrs ( PangoAttrIterator $iter )

=item $iter; a `PangoAttrIterator`
=end pod

method apply-attrs ( PangoAttrIterator $iter ) {
  pango_item_apply_attrs( self._get-native-object-no-reffing, $iter);
}

sub pango_item_apply_attrs (
  N-PangoItem $item, PangoAttrIterator $iter 
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:0:copy:
=begin pod
=head2 copy

Copy an existing `PangoItem` structure.

Return value: : the newly allocated `PangoItem`

  method copy ( --> N-PangoItem )

=end pod

method copy ( --> N-PangoItem ) {
  pango_item_copy( self._get-native-object-no-reffing)
}

sub pango_item_copy (
  N-PangoItem $item --> N-PangoItem
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:_pango_item_free:
#`{{=begin pod
=head2 free

Free a `PangoItem` and all associated memory.

  method free ( )

=end pod

method free ( ) {
  pango_item_free( self._get-native-object-no-reffing);
}
}}

sub _pango_item_free (
  N-PangoItem $item 
) is native(&pango-lib)
  is symbol('pango_item_free')
  { * }

#`{{
#-------------------------------------------------------------------------------
#TM:0:pango-itemize:
=begin pod
=head2 pango-itemize



  method pango-itemize ( N-GObject() $context, Str $text, Int() $start_index, Int() $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList )

=item $context; 
=item $text; 
=item $start_index; 
=item $length; 
=item $attrs; 
=item $cached_iter; 
=end pod

method pango-itemize ( N-GObject() $context, Str $text, Int() $start_index, Int() $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList ) {
  pango_itemize( self._get-native-object-no-reffing, $context, $text, $start_index, $length, $attrs, $cached_iter)
}

sub pango_itemize (
  N-PangoItem $context, gchar-ptr $text, int $start_index, int $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-itemize-with-base-dir:
=begin pod
=head2 pango-itemize-with-base-dir



  method pango-itemize-with-base-dir ( N-GObject() $context, PangoDirection $base_dir, Str $text, Int() $start_index, Int() $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList )

=item $context; 
=item $base_dir; 
=item $text; 
=item $start_index; 
=item $length; 
=item $attrs; 
=item $cached_iter; 
=end pod

method pango-itemize-with-base-dir ( N-GObject() $context, PangoDirection $base_dir, Str $text, Int() $start_index, Int() $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList ) {
  pango_itemize_with_base_dir( self._get-native-object-no-reffing, $context, $base_dir, $text, $start_index, $length, $attrs, $cached_iter)
}

sub pango_itemize_with_base_dir (
  N-PangoItem $context, PangoDirection $base_dir, gchar-ptr $text, int $start_index, int $length, PangoAttrList $attrs, PangoAttrIterator $cached_iter --> N-GList
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:pango-reorder-items:
=begin pod
=head2 pango-reorder-items



  method pango-reorder-items ( N-GList $items --> N-GList )

=item $items; 
=end pod

method pango-reorder-items ( $items is copy --> N-GList ) {
  $items .= _get-native-object-no-reffing unless $items ~~ N-GList;
  pango_reorder_items( self._get-native-object-no-reffing, $items)
}

sub pango_reorder_items (
  N-GList $items --> N-GList
) is native(&pango-lib)
  { * }

#-------------------------------------------------------------------------------
#TM:0:split:
=begin pod
=head2 split

Modifies I<orig> to cover only the text after I<split_index>, and returns a new item that covers the text before I<split_index> that used to be in I<orig>.

You can think of I<split_index> as the length of the returned item. I<split_index> may not be 0, and it may not be greater than or equal to the length of I<orig> (that is, there must be at least one byte assigned to each item, you can't create a zero-length item). I<split_offset> is the length of the first item in chars, and must be provided because the text used to generate the item isn't available, so `C<split()>` can't count the char length of the split items itself.

Return value: new item representing text before I<split_index>, which should be freed with [methodI<Pango>.Item.free].

  method split ( Int() $split_index, Int() $split_offset --> N-PangoItem )

=item $split_index; byte index of position to split item, relative to the start of the item
=item $split_offset; number of chars between start of I<orig> and I<split_index>
=end pod

method split ( Int() $split_index, Int() $split_offset --> N-PangoItem ) {
  pango_item_split( self._get-native-object-no-reffing, $split_index, $split_offset)
}

sub pango_item_split (
  N-PangoItem $orig, int $split_index, int $split_offset --> N-PangoItem
) is native(&pango-lib)
  { * }
}}

#-------------------------------------------------------------------------------
#TM:1:_pango_item_new:
#`{{
=begin pod
=head2 _pango_item_new



  method _pango_item_new ( --> N-PangoItem )

=end pod
}}

sub _pango_item_new (  --> N-PangoItem )
  is native(&pango-lib)
  is symbol('pango_item_new')
  { * }



















=finish
#-------------------------------------------------------------------------------
#TM:2:pango_item_new::new()
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
#TM:1:pango_item_copy:
=begin pod
=head2 pango_item_copy

Copy an existing B<N-PangoItem> structure.

Return value: the newly allocated B<N-PangoItem>, which should be cleared with C<clear-object()>.

  method pango_item_copy ( --> Gnome::Pango::Item )

=end pod

method copy ( |c ) { pango_item_copy(self.get-native-object); }
sub pango_item_copy ( N-PangoItem $item --> Gnome::Pango::Item ) {
  my N-PangoItem $pi = _pango_item_copy($item);

  Gnome::Pango::Item.new(:native-object($pi))
}

sub _pango_item_copy ( N-PangoItem $item )
  returns N-PangoItem
  is native(&pango-lib)
  is symbol('pango_item_copy')
  { * }

#-------------------------------------------------------------------------------
#`{{ No doc, user must use clear-object
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

Modifies I<$orig> to cover only the text after I<$split_index>, and returns a new item that covers the text before I<$split_index> that used to be in I<$orig>. You can think of I<$split_index> as the length of the returned item. I<$split_index> may not be 0, and it may not be greater than or equal to the length of I<$orig> (that is, there must be at least one byte assigned to each item, you can't create a zero-length item). I<$split_offset> is the length of the first item in chars, and must be provided because the text used to generate the item isn't available, so C<pango_item_split()> can't count the char length of the split items itself.

Return value: new item representing text before I<$split_index>, which should be freed with C<pango_item_free()>.

  method pango_item_split ( Int $split_index, Int $split_offset --> N-PangoItem  )

=item Int $split_index; byte index of position to split item, relative to the start of the item
=item Int $split_offset; number of chars between start of I<orig> and I<split_index>

=end pod

sub pango_item_split ( N-PangoItem $orig, int32 $split_index, int32 $split_offset )
  returns N-PangoItem
  is native(&pango-lib)
  { * }
