package Text::Hspell;

use strict;
use warnings;

use Inline Python => <<'EOF';
import HspellPy

class HspellPyWrapper:
    def __init__(self):
        self._hspell = HspellPy.Hspell(linguistics=True)

    def check_word(self, word):
        return self._hspell.check_word(word);
EOF

sub new
{
    return Inline::Python::Object->new( '__main__', 'HspellPyWrapper' );
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
spell check Hebrew words. It requires L<Inline::Python> and HspellPy (
L<https://pypi.org/project/HspellPy/> ) from PyPI.

=head1 METHODS

=head2 my $speller = Text::Hspell->new;

Create a new speller object instance.

=head2 $speller->check_word($word)

Returns true if the word is spelled right and false if it is an unknown
word.

=head1 COPYRIGHT & LICENSE

Copyright 2019 by Shlomi Fish

This program is distributed under the MIT / Expat License:
L<http://www.opensource.org/licenses/mit-license.php>

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

=cut
