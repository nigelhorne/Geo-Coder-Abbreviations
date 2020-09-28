#!perl -wT

use strict;
use warnings;
use Test::Most tests => 4;
use Test::NoWarnings;

BEGIN {
	use_ok('Geo::Coder::Abbreviations');
}

NEW: {
	SKIP: {
		skip 'Test requires Internet access', 2 unless(-e 't/online.enabled');
		my $abbr = new_ok('Geo::Coder::Abbreviations');

		ok($abbr->abbreviate('Road') eq 'RD');
	}
}
