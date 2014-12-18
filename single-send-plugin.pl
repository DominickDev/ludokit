#!/usr/bin/perl

#-------------------------------------------------------------------------------
# Description:
#
#	      1) Upload plugin from ./plugin to remote host in /tmp
#             2) Download log-report in ./report 
# 
# by d0n1x
#--------------------------------------------------------------------------------

    use strict;
    use warnings;
    use Getopt::Long;

#    $Expect::Debug = 1;

#---------------------Sub---------------------------------

sub send_execution {

        my ($username, $plugin, $host) = @_;

	#Comando SCP via SSH per il trasferimento file
	#Non chiede la pass perchè il server è trusted!
    
	system ("/usr/bin/scp -p \./plugin/$plugin $username\@$host:/tmp/");

}

#-----------------------Master Code------------------------

#Controllo parametri in input
if (@ARGV == 0) {
	print "Usage: $0 --username <...> --plugin <executible script> --host <...>\n";
        exit 0;

# Parametri script:
my $username;
my $host;
print "Inserire nome plugin  [xxxx-xxxx-xxxx.pl] e premere invio.";

my $plugin;

# 


GetOptions(

	"username=s"	=> \$username,
	"plugin=s"	=> \$plugin,
	"host=s"	=> \$host
);


#-----------------------Sub Call---------------------------

send_execution($username, $plugin, $host);

#----------------------------------------------------------


exit 0;
