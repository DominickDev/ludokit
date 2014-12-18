#!/usr/bin/perl

#Description:
#
#

    use Expect;
    use Getopt::Long;
    use strict;
    use warnings;


#    $Expect::Debug = 1;


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


#---------------Master Code-------------------------------------

if (scalar @ARGV == 1) {
print "\n Use: $0 --username <...> --currentpass <...> --newpass <...> --host <...> \n";
	exit 0;
}

my $username;  
my $currentpass;
my $newpass; 
my $host;


#Varibili di input di default::
#	my $username  = 'pippo';
#	my $currentpass = 'perldidefault';
#	my $newpass = 'perldipippo';
#	my $host = '10.0.3.214';


GetOptions(

	"username=s"	=> \$username,
	"currentpass=s"	=> \$currentpass,
	"newpass=s"	=> \$newpass,
	"host=s"	=> \$host


);


cambia_password($username, $currentpass, $newpass, $host);

print "$? è successo!!\n";






