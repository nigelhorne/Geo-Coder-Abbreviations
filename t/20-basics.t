#!perl -w

use strict;
use warnings;
use Test::Most tests => 15;
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

			my %streets = (
				'SW MACVICAR AVENUE' => 'SW MACVICAR AV',
				'NORFOLK AVENUE' => 'NORFOLK AV',
				'CONNECTICUT AVENUE' => 'CONNECTICUT AV',
				'HOWARD AVENUE' => 'HOWARD AV',
				'MAPLE AVENUE W' => 'MAPLE AV W',
				'SW MACVICAR AVE' => 'SW MACVICAR AVE',	# FIXME: This is wrong, it should be AV to be consistent
				'NORFOLK AVE' => 'NORFOLK AVE',
				'CONNECTICUT AVE' => 'CONNECTICUT AVE',
				'HOWARD AVE' => 'HOWARD AVE',
				'MAPLE AVE W' => 'MAPLE AVE W',
			);

			while ((my ($k, $v)) = each(%streets)) {
				my $street = uc($k);
				if($street =~ /(.+)\s+AVENUE\s+(.+)/) {
					$street = "$1 AV $2";
				} elsif($street =~ /(.+)\s(.+)$/) {
					if(my $a = $abbr->abbreviate($2)) {
						$street = "$1 $a";
					}
				}
				# $street =~ s/^0+//;	# Turn 04th St into 4th St
				diag("$k: expected $v, got $street") if($street ne $v);
				ok($street eq $v);
			}
		} elsif(defined($ENV{'AUTHOR_TESTING'})) {
			fail('Test failed');
		} else {
			skip "Couldn't instantiate class", 12;
		}
	}
}
