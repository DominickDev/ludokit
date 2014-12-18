#!/usr/bin/perl

#-----------------------------------------------------------
#Description:
#	      1) Send plugin (script) to remote hosts.
#
#--------------------------------------------------------------


use strict;
use warnings;
use Getopt::Long;

#Controllo parametri:
if (scalar @ARGV == 0) {
	print "\n Use: $0 --username <...> --plugin <...>\n";
	print "   ----Gli hosts saranno letti da file hosts.txt----\n";
	exit 0;
}

#Dichiarazione variabili:
#---------------
my $username;   # remote user 
my $plugin; 	# remote script-plugin 
my $host;   	# remote hosts
my @array_host; # file remote hosts.txt  
#---------------

GetOptions(

	"username=s"	=> \$username,
	"plugin=s"	=> \$plugin,
	"host=s"	=> \$host   
);


#----------------Lettura DB hosts.txt---------------

open READFILE, "hosts.txt";

	@array_host = <READFILE>;
	chomp @array_host;

close READFILE;

#-----------------------------------------------------

foreach my $host (@array_host) {

sleep 1;

print "$host\n";

system ("./send-plugin.pl --username $username --plugin $plugin --host $host");


}
