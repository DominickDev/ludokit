#!/usr/bin/perl

#Description:
#
#

use strict;
use warnings;
use Getopt::Long;


if (scalar @ARGV == 1) {
	print "\n Use: $0 --username <...> --currentpass <...>\n";
	print "   ---- (Gli hosts saranno letti da file hosts.txt) ----\n";
	exit 0;
}

#Variabili:
#---------------
my $username;
my $currentpass;
my $host;  # hostname formato stringa che verrà letto dal file hosts.txt

my @array_host;
#---------------

GetOptions(

	"username=s"	=> \$username,
	"currentpass=s"	=> \$currentpass,
	"host=s"	=> \$host   
);

#--------LETTURA FILE HOSTS.TXT------------------------
open READFILE, "hosts.txt";

	@array_host = <READFILE>;
	chomp @array_host;

close READFILE;
#------------------------------------------------------

# ------------ CICLO -----------------------------
foreach my $host (@array_host) {

sleep 2;

print "$host\n";

system ("./copiakey.pl --username $username --currentpass $currentpass --host $host");

}
#--------------FINE------------------------------

exit 0 
