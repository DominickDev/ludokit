#!/usr/bin/perl

#Description:
#
#

use strict;
use warnings;
use Getopt::Long;


if (scalar @ARGV == 1) {
	print "\n Use: $0 --username <...> --currentpass <...> --newpass <...>\n";
	print "   ----Gli hosts saranno letti da file hosts.txt----\n";
	exit 0;
}

#Variabili:
#---------------
my $username;
my $currentpass;
my $newpass;
my $host;  # hostname formato stringa che verrà letto dal file hosts.txt

my @array_host;
#---------------

GetOptions(

	"username=s"	=> \$username,
	"currentpass=s"	=> \$currentpass,
	"newpass=s"	=> \$newpass,
	"host=s"	=> \$host   


);


open READFILE, "hosts.txt";

	@array_host = <READFILE>;
	chomp @array_host;

close READFILE;


foreach my $host (@array_host) {

sleep 5;

print "$host\n";

system ("./cambiopass.pl --username $username --currentpass $currentpass --newpass $newpass --host $host");


}



