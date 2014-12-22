#!/usr/bin/perl

# Description:  Uploading plugin-script to hosts written on hosts.txt,
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
sub uploading_plugin {

        my ($username, $plugin, $host) = @_;

	#Comando SCP via SSH per il trasferimento file
	#Non chiede la pass perchè il server è trusted!
    
	system ("/usr/bin/scp -p \./plugin/$plugin $username\@$host:/tmp/");

}
#----------------------------Fine Sub-------------------------


#---------------------------CODE-------------------------------




if ($host) {

	#uploading_plugin($username, $currentpass, $host);
	print "\n\nCopia plugin avvenuta con successo: singolo host: $host \n";	
	print "User: $username\n";

}# fine if
 
else {	
	
	open (FILE, 'hosts.txt')
	  || die "Impossibile aprire il file: $!\n";
	  
	while (<FILE>) {
		chomp $_;
		#uploading_plugin($username, $currentpass, $_);
		print "\n\nCopia plugin avvenuta con successo ---> host:  $_ \n";	
		print "User: $username\n";

	}#fine while

	close (FILE);
}




exit 0;

















