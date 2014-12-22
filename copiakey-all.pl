#!/usr/bin/perl

# Description:  Ciclo Copia Key da una lista hosts.txt,
#	        oppure su  un singolo host specificato dal parametro --host
#
#
#------Moduli----------

use strict;
use warnings;
use Getopt::Long;
use Expect;

#---------------Controllo parametri----------------
if (scalar @ARGV < 1) {
	print "\n Usage: $0 [OPTION]\n\n --username  (default: current user) \n --currentpass \n --host (default: hosts.txt)\n\n";
	exit 0;
}

#Variabili:
#-----------------------------------------
my $username = $ENV{USER};
my $currentpass;
my $host;  
#-----------------------------------------

#Def Parametri:
GetOptions(

	"username=s"	=> \$username,
	"currentpass=s"	=> \$currentpass,
	"host=s"	=> \$host   
);

#---------------Subroutine----------------------------------------
sub copia_key_ssh {

    my ($username, $currentpass, $host) = @_;
    my $timeout = '30';
    my $miahome= $ENV{HOME};
    my $path_key="$miahome/.ssh/id_rsa";

    my $exp = Expect->spawn("ssh-copy-id -i $path_key $username\@$host")
 				or die "Cannot spawn ssh: $!\n";
my $spawn_ok;

 $exp->expect($timeout,
             [ qr /\(yes\/no\)\? $/ => sub {
                                $spawn_ok = 1;
                                my $expect = shift;
                                $expect->send("yes\n");
                                exp_continue;} ],
             [ qr /\@.*password: $/ => sub {
                                $spawn_ok = 1;
                                my $expect = shift;
                                $expect->send("$currentpass\n");
                                exp_continue;} ],

        [ eof => sub {
                if ($spawn_ok) {
                        die "Connessione di login ssh terminata.\n";}
                else {
                        die "ERROR: Could not spawn ssh.\n";}}],
        [ timeout => sub {die "No login.\n";}],

        '-re', qr'[#>:] $', #' wait for shell prompt, then exit expect
        );


}
#----------------------------Fine Sub-------------------------


#---------------------------CODE-------------------------------




if ($host) {

	#copia_key_ssh($username, $currentpass, $host);
	print "\n\nCopia key avvenuta con successo: singolo host: $host \n";	
	print "User: $username\n";

}# fine if
 
else {	
	
	open (FILE, 'hosts.txt')
	  || die "Impossibile aprire il file: $!\n";
	  
	while (<FILE>) {
		chomp $_;
		#copia_key_ssh($username, $currentpass, $_);
		print "\n\nCopia key avvenuta con successo ---> host:  $_ \n";	
		print "User: $username\n";

	close (FILE);
}#fine else

}






















