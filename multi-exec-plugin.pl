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
my $username = $ENV{USER};   # remote user credential for SSH conection (for root no need password)
my $plugin_name; # name of the plugin (script) 
my $host;   	# remote hosts
my @array_host; # list file of the remote hosts.txt  
#---------------

GetOptions(

	"username=s"	=> \$username,
	"plugin_name=s"	=> \$plugin_name,
	"host=s"	=> \$host   
);


#----------------Lettura DB hosts.txt---------------

open READFILE, "hosts.txt";

	@array_host = <READFILE>;
	chomp @array_host;

close READFILE;

#-----------------------------------------------------

#---------------CICLO ESECUZIONE PLUGIN (single-exec-plugin.pl)--------------

foreach my $host (@array_host) {

	print "$host\n";

	system ("./single-exec-plugin.pl --username $username --plugin_name $plugin_name --host $host");


}

#---------------------------------------------------------------------



exit 0;
