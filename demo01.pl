#!/usr/bin/perl

use warnings;
use strict;

for my $count (reverse (1..10), "BOOM")
{
	print($count, "\n");
	sleep(1);
}

