package Text::Hspell;

use 5.014;
use strict;
use warnings;

require DynaLoader;

use vars qw/ $VERSION /;
use vars qw(@ISA);
@ISA = qw/ DynaLoader /;

bootstrap Text::Hspell $VERSION;

use Encode qw/ decode encode /;

sub new
{
    return proto_new();
}

sub check_word
{
    my ( $self, $s ) = @_;
    return $self->check_word_internal( encode( 'iso8859-8', $s ) );
}

sub try_to_correct_word
{
    my ( $self, $s ) = @_;
    my $ret = $self->trycorrect_internal( encode( 'iso8859-8', $s ) );
    foreach my $r (@$ret)
    {
        $r = decode( 'iso8859-8', $r );
    }
    return $ret;
}

1;

__END__

=head1 NAME

Text::Hspell - wrapper for the hspell (= Hebrew speller) library

=head1 SYNOPSIS

    use Text::Hspell ();
    use utf8;

    my $speller = Text::Hspell->new;

    print $speller->check_word("שלום") ? "spelled right\n" : "misspelling\n";

=head1 DESCRIPTION

This module allows one to use libhspell ( L<http://hspell.ivrix.org.il/> ) to
spell check Hebrew words.

=head1 METHODS

=head2 my $speller = Text::Hspell->new;

Create a new speller object instance.

=head2 $speller->check_word($word)

Returns true if the word is spelled right and false if it is an unknown
word.

=head2 my $array_ref = $speller->try_to_correct_word($word)

Returns an array reference of strings with spell correction suggestions
for $word .

(Added in version 0.4.0 .)

=head2 $speller->proto_new()

For internal use.

=head2 $speller->check_word_internal()

For internal use.

=head2 $speller->trycorrect_internal()

For internal use.

=head1 COPYRIGHT & LICENSE

Copyright 2019 by Shlomi Fish.

This program is distributed under the MIT / Expat License:
L<http://www.opensource.org/licenses/mit-license.php> .
Note that it depends on libhspell which is currently under the
L<https://en.wikipedia.org/wiki/Affero_General_Public_License>
v3.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=head1 THANKS

An early version of this module required L<Inline::Python> (by
L<https://metacpan.org/author/NINE> and others)
and HspellPy ( L<https://pypi.org/project/HspellPy/> ) from PyPI
(by L<https://github.com/eranroz/> ), so thanks to them.
The dependency on these packages was removed in version 0.2.0.

We still make use of libhspell ( L<http://hspell.ivrix.org.il/> )
by wrapping its C API.

=cut
