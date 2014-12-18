#!/usr/bin/perl



#-----------------------------------------------------------------
# Description:
#		1) Crea nuova utenza (sul server remoto ospite) 
#		2) Crea il report in /tmp/.dcp_temp/crea-utenza-report.log
#
#-----------------------------------------------------------------

use strict;
use warnings;

my $newuser = @_


#--------------CREAZIONE NUOVA UTENZA-----------------------------
system("useradd", "$newuser");
   if ( $? == -1 ) {
      print "command useradd failed: $!\n";
}
   else {
      printf "command useradd exited with value %d", $? >> 8;
}

#--------------------------------------------------------------------
sleep 1;


#----------------CREAZIONE LOG/REPORT-------------------------------------
system("cat",  "/etc/passwd", "\>", "/tmp/crea-utenza-report.log");
	if ( $? == -1 ){
  	   print "command creazione report failed: $!\n";
}
	else {
  	   printf "command creazione report exited with value %d", $? >> 8;
}
--------------------------------------------------------------------------

#-- list the processes running on your system
#open(PS,"ps -e -o pid,stime,args |") || die "Failed: $!\n";
#while ( <PS> )
#{
  #-- in progress...
#}
 
#-- send an email to user@localhost
#open(MAIL, "| /bin/mailx -s test user\@localhost ") || die "mailx failed: $!\n";
#print MAIL "This is a test message";



exit 0;

