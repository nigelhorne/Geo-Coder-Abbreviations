# Generated from Makefile.PL using makefilepl2cpanfile

requires 'perl', '5.6.2';

requires 'JSON::MaybeXS';
requires 'LWP::Protocol::https';
requires 'LWP::Simple::WithCache';

on 'test' => sub {
	requires 'Test::DescribeMe';
	requires 'Test::Kwalitee';
	requires 'Test::Most';
	requires 'Test::Needs';
	requires 'Test::NoWarnings';
};
on 'develop' => sub {
	requires 'Devel::Cover';
	requires 'Perl::Critic';
	requires 'Test::Pod';
	requires 'Test::Pod::Coverage';
};
