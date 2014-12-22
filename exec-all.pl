#!/usr/bin/perl

# Description:  Execution plugin-script to hosts written on hosts.txt,
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
sub executing_plugin {

        my ($username, $plugin, $host) = @_;

	#Non chiede la pass perchè il server è trusted!
    
	system ("/usr/bin/ssh $username\@$host '/tmp/$plugin'");
}
#----------------------------Fine Sub-------------------------


#---------------------------CODE-------------------------------




if ($host) {

	#executing_plugin($username, $currentpass, $host);
	print "\n\nEsecuzione plugin avvenuta con successo: singolo host: $host \n";	
	print "User: $username\n";

}#fine if
 
else {	
	
	open (FILE, 'hosts.txt')
	  || die "Impossibile aprire il file: $!\n";
	  
	while (<FILE>) {
		chomp $_;
		#executing_plugin($username, $currentpass, $_);
		print "\n\nEsecuzione  plugin avvenuta con successo ---> host:  $_ \n";	
		print "User: $username\n";
		}#fine while
	
	close (FILE);

}#fine else


exit 0;






















