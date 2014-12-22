#!/usr/bin/perl

# Description:  Ciclo Cambia Password da una lista hosts.txt,
#	        oppure da un singolo host specificato nel parametro --host
#
#
#------Moduli----------

use strict;
use warnings;
use Getopt::Long;
use Expect;

#---------------Controllo parametri----------------
if (scalar @ARGV < 2) {
	print "\n Usage: $0 [OPTION]\n\n --username  (default: current user) \n --currentpass \n --newpass \n --host (default: hosts.txt)\n\n";
	exit 0;
}

#Variabili:
#-----------------------------------------
my $username = $ENV{USER};
my $currentpass;
my $newpass;
my $host;  
#-----------------------------------------

#Def Parametri:
GetOptions(

	"username=s"	=> \$username,
	"currentpass=s"	=> \$currentpass,
	"newpass=s"	=> \$newpass,
	"host=s"	=> \$host   
);

#---------------Subroutine----------------------------------------

sub cambia_password {

    my ($username, $currentpass, $newpass, $host) = @_;

    my $timeout = '30';

    #Collegamento SSH a $host e cambio password scaduta con una nuova:
    my $exp = Expect->spawn("ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $username\@$host")
        or die "Cannot spawn ssh: $!\n";

    my $spawn_ok;

    $exp->expect($timeout,
             [ qr /\@.*password: $/ => sub {
                                $spawn_ok = 1;
                                my $expect = shift;
                                $expect->send("$currentpass\n");
                                exp_continue;} ],
             [ qr /\(current\) UNIX password:/ => sub {
                                my $expect = shift;
                                $expect->send("$currentpass\n");
                                exp_continue;} ],
             [ qr /New password:/ => sub {
                                my $expect = shift;
                                $expect->send("$newpass\n");
                                exp_continue;} ],
             [ qr /Retype new password:/ => sub {
                                my $expect = shift;
                                $expect->send("$newpass\n");
                                exp_continue;}],
        [ eof => sub {
                if ($spawn_ok) {
                        die "Connessione SSH: logout.\n";}
                else {
                        die "ERROR: could not spawn telnet.\n";}}],
        [ timeout => sub {die "No login.\n";}],

        '-re', qr'[#>:] $', #' wait for shell prompt, then exit expect
        );


}
#----------------------------Fine Sub-------------------------


#---------------------------CODE-------------------------------




if ($host) {

	#cambia_password($username, $currentpass, $newpass, $host);
	print "\n\nRinnovo password avvenuto con successo: singolo host: $host \n";	
	print "User: $username\n";
	print "Current pass: $currentpass ---> New pass: $newpass\n";

} else {	
	
	open (FILE, 'hosts.txt')
	  || die "Impossibile aprire il file: $!\n";
	  
	while (<FILE>) {
		chomp $_;
		#cambia_password($username, $currentpass, $newpass, $_);
		print "\n\nRinnovo password avvenuto con successo ---> host:  $_ \n";	
		print "User: $username\n";
		print "Current pass: $currentpass ---> New pass: $newpass\n";
}

	close (FILE);
}
























