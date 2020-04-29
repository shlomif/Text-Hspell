#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Test::More tests => 2;

use Text::Hspell v0.2.3;

{

    my $obj = Text::Hspell->new();

    # TEST
    ok( $obj, "was instantiated." );

    # TEST
    ok( scalar( $obj->check_word("שלום") ), "word is ok" );
}
