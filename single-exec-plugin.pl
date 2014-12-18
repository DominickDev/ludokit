#!/usr/bin/perl

#-------------------------------------------------------------------------------
# Description:
#
#	      1) Trasferimento da locale del  plugin (script) (preso da ../plugin) all'host remoto in /tmp
#	      
#	      2) Esecuzione remota dello script come utente remoto user o root
#
#             3) Verifica ricezione plugin_report_log ricevuti in ../report
# 
# by D0n1x
#--------------------------------------------------------------------------------


#---------------Copia un file nell'host remoto-------------------

    use strict;
    use warnings;
    use Getopt::Long;

#    $Expect::Debug = 1;

#---------------Start SUBroutine----------------------------------------

sub send_execution {

    my ($username, $plugin, $host) = @_;

#---------------Comando SCP via SSH per il trasferimento file-----------------

    system ("/usr/bin/scp -p \./plugin/$plugin $username\@$host:/tmp/"); #Non chiede la pass perchè il server è trusted!


#---------------Comando di esecuzione remoto del plugin-script-----------------

    system ("/usr/bin/ssh $username\@$host '/tmp/$plugin'"); #Non chiede la pass perchè il server è trusted!

}

#-----------------------Master Code-------------------------------------

if (scalar @ARGV == 0) {
print "Usage: $0 --username <...> --plugin <executible script> --host <...>\n";
        exit 0;
}

my $username;
my $host;
my $plugin;

GetOptions(

	"username=s"	=> \$username,
	"plugin=s"	=> \$plugin,
	"host=s"	=> \$host
);


#-----------------------Sub Call-----------------------------------------

send_execution ($username, $plugin, $host);

#------------------------------------------------------------------------


exit 0;
