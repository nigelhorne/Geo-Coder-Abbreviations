#!perl -w

use strict;
use warnings;
use Test::Most tests => 5;
use Test::NoWarnings;

BEGIN {
	use_ok('Geo::Coder::Abbreviations');
}

BASICS: {
	SKIP: {
		skip 'Test requires Internet access', 2 unless(-e 't/online.enabled');
		if(my $abbr = new_ok('Geo::Coder::Abbreviations')) {
			ok($abbr->abbreviate('Road') eq 'RD');
			ok($abbr->abbreviate('Avenue') eq 'AV');	# I think it should abbreviate to AVE
		} elsif(defined($ENV{'AUTHOR_TESTING'})) {
			fail('Test failed');
		} else {
			skip "Couldn't instantiate class", 2;
		}
	}
}
