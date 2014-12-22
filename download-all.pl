#!/usr/bin/perl

# Description:  Downloading report-plugin from  hosts written on hosts.txt to /report,
#	        or single host specified with --host parameter
#
#
#------Moduli----------

use strict;
use warnings;
use Getopt::Long;

#---------------Controllo parametri----------------
if (scalar @ARGV < 1) {
	print "\n Usage: $0 [OPTION]\n\n --username  (default: current user) \n --plugin (filename)\n --host (default: hosts.txt)\n\n";
	exit 0;
}

#Variabili:
#-----------------------------------------
my $username = $ENV{USER};
my $host;
my $plugin;  
#-----------------------------------------

#Def Parametri:
GetOptions(

	"username=s"	=> \$username,
	"plugin=s"	=> \$plugin,
	"host=s"	=> \$host   
);

#---------------Subroutine----------------------------------------
sub downloading_report {

        my ($username, $plugin, $host) = @_;

	#Non chiede la pass perchè il server è trusted!
    
	system ("/usr/bin/scp -p $username\@$host:/tmp/report_$plugin \./report");

}
#----------------------------Fine Sub-------------------------


#---------------------------CODE-------------------------------




if ($host) {

	#downloading_report($username, $currentpass, $host);
	print "\n\nDownload report avvenuto con successo: singolo host: $host \n";	
	print "User: $username\n";

}# fine if
 
else {	
	
	open (FILE, 'hosts.txt')
	  || die "Impossibile aprire il file: $!\n";
	  
	while (<FILE>) {
		chomp $_;
		#downloading_report($username, $currentpass, $_);
		print "\n\nDownload report avvenuto con successo ---> host:  $_ \n";	
		print "User: $username\n";

	}#fine while

	close (FILE);
}




exit 0;

















