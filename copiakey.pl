#!/usr/bin/perl

#---------------Copia un file nell'host remoto-------------------

    use strict;
    use warnings;
    use Expect;
    use Getopt::Long;

#    $Expect::Debug = 1;

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

#---------------Master Code-------------------------------------
if (scalar @ARGV == 1) {
print "Use: $0 --username <...>  --currentpass <...> --host <...>\n";
	exit 0;
}

#Varibili di input di default::

	my $newpass;
	my $username  = 'pippo';
	my $currentpass = 'perldidefault';
	my $host = '10.0.3.214';


GetOptions(

	"username=s"	=> \$username,
	"currentpass=s"	=> \$currentpass,
	"host=s"	=> \$host


);


copia_key_ssh ($username, $currentpass, $host);




exit 0
