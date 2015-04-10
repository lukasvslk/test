#!/usr/bin/perl

use strict;
use warnings;

use DateTime;

print(DateTime->now(), "\n");

my @pole = qw(ahoj jak se mate a co delate ?);

foreach (map {qq('$_')} sort {$a cmp $b} grep {$_ =~ m/a/} @pole)
{
	print("v01: $_\n");
}

my @pole2 = (1..100);

foreach (map {$_**2} grep {!($_ % 2 || $_ % 3)} @pole2)
{
	print("v02: $_\n");
}

my %hash = ("first", 10, "second", 20, "third", 30);

printf("v03: %s\n", $hash{third});

my %hash2 = (
	first 	=> 11,
	second 	=> 21,
	third 	=> 31,
);

foreach my $key (keys %hash2)
{
	printf("v04: %s => %s\n", $key, $hash2{$key});
}

while (my ($key, $value) = each(%hash2))
{
	printf("v14: %s => %s\n", $key, $value);
}

printf("v05: %s\n", $hash2{second});

my %hash3 = @pole;

printf("v05: %s\n", $hash3{ahoj});

my $hashref = \%hash;

printf("v06: %s\n", $hashref->{first});

for my $key (keys $hashref)
{
	printf("v07: %s\n", $hashref->{$key});
}

for (@pole2) {s/1/a/};

for (@pole2) {print "v08: $_\n"}

my $string = <<COD;
SELECT * FROM `table` WHERE 1
COD

print $string;

printf("12345678901234567890\n");
my $mutliple = callFunction(5, 2);

sub callFunction
{
	my ($first, $second) = @_;
	return $first * $second;
}
