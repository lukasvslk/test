#!/usr/bin/perl

#
# Module for rename by regex.
#
#

use strict;
use warnings;
use diagnostics;

use File::Copy;
use Getopt::Long;

my $regex;
my $path;
my $newname;
my $copy;

GetOptions(
	"regex=s"	=> \$regex,
	"path=s"	=> \$path,
	"new=s"		=> \$newname,
	"copy"		=> \$copy,	 
);

my $documentation = <<"DOCEND";
Usage: $0 --regex <...> --new <...> [--path <...>] [--copy]

Input:
 --regex    Regular expresion to find
 --new      New name from regex param 
 --path     Where to find files (default current directory)
 --copy     Copy instead of rename

DOCEND

if (!$regex)
{
	print $documentation;
	print "Zadej regulartni vyraz ...\n";
	exit(0);
}

if (!$path)
{
	$path = '.';
}

if (!$newname)
{
	print $documentation;
	print "Zadej sablonu noveho jmena ...\n";
	exit(0);
}

opendir(DIR, $path) or die "Could not open $path";

while (my $filename = readdir(DIR)) 
{
	if (my @sub = ($filename =~ m/$regex/))
	{
		my $loc_newname = $newname;
		my @count = $loc_newname =~ m/\$\d/g;
		if (@sub != @count)
		{
			print "Spatny pocet parametru ...\n";
			exit(0);
		}

		my $index = 1;
		for (@sub) 
		{
			$loc_newname =~ s/\$$index/$_/g;
			$index++;
		} 

		if ($copy)
		{
			copy $path.$filename, $path.$loc_newname;
		}
		else
		{
			move $path.$filename, $path.$loc_newname;
		}
		printf "%s from '$filename' to  '$loc_newname'.\n", $copy ? 'Copy' : 'Rename';
	}
}

closedir(DIR);

=CHANGELOG
2015-05-17	New module rename by regex.