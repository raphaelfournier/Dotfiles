# ical2rem.pl - 
# Reads iCal files and outputs remind-compatible files.   Tested ONLY with
#   calendar files created by Mozilla Calendar/Sunbird. Use at your own risk.
# Copyright (c) 2005, 2007, Justin B. Alcorn

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#
# version 0.5.2 2007-03-23
# 	- BUG: leadtime for recurring events had a max of 4 instead of DEFAULT_LEAD_TIME
#	- remove project-lead-time, since Category was a non-standard attribute
#	- NOTE: There is a bug in iCal::Parser v1.14 that causes multiple calendars to
#		fail if a calendar with recurring events is followed by a calendar with no
#		recurring events.  This has been reported to the iCal::Parser author.
# version 0.5.1 2007-03-21
#	- BUG: Handle multiple calendars on STDIN
#	- add --heading option for priority on section headers
# version 0.5 2007-03-21
#	- Add more help options
#	- --project-lead-time option
#	- Supress printing of heading if there are no todos to print
# version 0.4
#	- Version 0.4 changes all written or inspired by, and thanks to Mark Stosberg
#	- Change to GetOptions
#	- Change to pipe
#	- Add --label, --help options
#	- Add Help Text
#	- Change to subroutines
#	- Efficiency and Cleanup
# version 0.3
#	- Convert to GPL (Thanks to Mark Stosberg)
#	- Add usage
# version 0.2
#	- add command line switches
#	- add debug code
#	- add SCHED _sfun keyword
#	- fix typos
# version 0.1 - ALPHA CODE.  

=head1 SYNOPSIS

 cat /path/to/file*.ics | ical2rem.pl &gt; ~/.ical2rem

 All options have reasonable defaults:
 --label		       Calendar name (Default: Calendar)
 --lead-time	       Advance days to start reminders (Default: 3)
 --todos, --no-todos   Process Todos? (Default: Yes)
 --heading			   Define a priority for static entries
 --help				   Usage
 --man				   Complete man page

Expects an ICAL stream on STDIN. Converts it to the format
used by the C&lt;remind&gt; script and prints it to STDOUT. 

=head2 --label

  ical2rem.pl --label &quot;Bob's Calendar&quot;

The syntax generated includes a label for the calendar parsed.
By default this is &quot;Calendar&quot;. You can customize this with 
the &quot;--label&quot; option.

=head2 --lead-time 

  ical2rem.pl --lead-time 3
 
How may days in advance to start getting reminders about the events. Defaults to 3. 

=head2 --no-todos

  ical2rem.pl --no-todos

If you don't care about the ToDos the calendar, this will surpress
printing of the ToDo heading, as well as skipping ToDo processing. 

=head2 --heading

  ical2rem.pl --heading &quot;PRIORITY 9999&quot;

Set an option on static messages output.  Using priorities can made the static messages look different from
the calendar entries.  See the file defs.rem from the remind distribution for more information.

=cut 

use strict;
use iCal::Parser;
use DateTime;
use Getopt::Long 2.24 qw':config auto_help';
use Pod::Usage;
use Data::Dumper;
use vars '$VERSION';
$VERSION = &quot;0.5.2&quot;;

# Declare how many days in advance to remind
my $DEFAULT_LEAD_TIME = 3;
my $PROCESS_TODOS     = 1;
my $HEADING			  = &quot;&quot;;
my $help;
my $man;

my $label = 'Calendar';
GetOptions (
	&quot;label=s&quot;     =&gt; \$label,
	&quot;lead-time=i&quot; =&gt; \$DEFAULT_LEAD_TIME,
	&quot;todos!&quot;	  =&gt; \$PROCESS_TODOS,
	&quot;heading=s&quot;	  =&gt; \$HEADING,
	&quot;help|?&quot; 	  =&gt; \$help, 
	&quot;man&quot; 	 	  =&gt; \$man
);
pod2usage(1) if $help;
pod2usage(-verbose =&gt; 2) if $man;

my $month = ['None','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

my @calendars;
my $in;

while (&lt;&gt;) {
	$in .= $_;
	if (/END:VCALENDAR/) {
		push(@calendars,$in);
		$in = &quot;&quot;;
	}
}
my $parser = iCal::Parser-&gt;new();
my $hash = $parser-&gt;parse_strings(@calendars);

##############################################################
#
# Subroutines 
#
#############################################################
#
# _process_todos()
# expects 'todos' hashref from iCal::Parser is input
# returns String to output
sub _process_todos {
	my $todos = shift; 
	
	my ($todo, @newtodos, $leadtime);
	my $output = &quot;&quot;;

	$output .=  'REM '.$HEADING.' MSG '.$label.' ToDos:%&quot;%&quot;%'.&quot;\n&quot;;

# For sorting, make sure everything's got something
#   To sort on.  
	my $now = DateTime-&gt;now;
	for $todo (@{$todos}) {
		# remove completed items
		if ($todo-&gt;{'STATUS'} &amp;&amp; $todo-&gt;{'STATUS'} eq 'COMPLETED') {
			next;
		} elsif ($todo-&gt;{'DUE'}) {
			# All we need is a due date, everything else is sugar
			$todo-&gt;{'SORT'} = $todo-&gt;{'DUE'}-&gt;clone;
		} elsif ($todo-&gt;{'DTSTART'}) {
			# for sorting, sort on start date if there's no due date
			$todo-&gt;{'SORT'} = $todo-&gt;{'DTSTART'}-&gt;clone;
		} else {
			# if there's no due or start date, just make it now.
			$todo-&gt;{'SORT'} = $now;
		}
		push(@newtodos,$todo);
	}
	if (! (scalar @newtodos)) {
		return &quot;&quot;;
	}
# Now sort on the new Due dates and print them out.  
	for $todo (sort { DateTime-&gt;compare($a-&gt;{'SORT'}, $b-&gt;{'SORT'}) } @newtodos) {
		my $due = $todo-&gt;{'SORT'}-&gt;clone();
		my $priority = &quot;&quot;;
		if (defined($todo-&gt;{'PRIORITY'})) {
			if ($todo-&gt;{'PRIORITY'} == 1) {
				$priority = &quot;PRIORITY 1000&quot;;
			} elsif ($todo-&gt;{'PRIORITY'} == 3) {
				$priority = &quot;PRIORITY 7500&quot;;
			}
		}
		if (defined($todo-&gt;{'DTSTART'}) &amp;&amp; defined($todo-&gt;{'DUE'})) {
			# Lead time is duration of task + lead time
			my $diff = ($todo-&gt;{'DUE'}-&gt;delta_days($todo-&gt;{'DTSTART'})-&gt;days())+$DEFAULT_LEAD_TIME;
			$leadtime = &quot;+&quot;.$diff;
		} else {
			$leadtime = &quot;+&quot;.$DEFAULT_LEAD_TIME;
		}
		$output .=  &quot;REM &quot;.$due-&gt;month_abbr.&quot; &quot;.$due-&gt;day.&quot; &quot;.$due-&gt;year.&quot; $leadtime $priority MSG \%a $todo-&gt;{'SUMMARY'}\%\&quot;\%\&quot;\%\n&quot;;
	}
	$output .= 'REM '.$HEADING.' MSG %&quot;%&quot;%'.&quot;\n&quot;;
	return $output;
}


#######################################################################
#
#  Main Program
#
######################################################################

print _process_todos($hash-&gt;{'todos'}) if $PROCESS_TODOS;

my ($leadtime, $yearkey, $monkey, $daykey,$uid,%eventsbyuid);
print 'REM '.$HEADING.' MSG '.$label.' Events:%&quot;%&quot;%'.&quot;\n&quot;;
my $events = $hash-&gt;{'events'};
foreach $yearkey (sort keys %{$events} ) {
    my $yearevents = $events-&gt;{$yearkey};
    foreach $monkey (sort {$a &lt;=&gt; $b} keys %{$yearevents}){
        my $monevents = $yearevents-&gt;{$monkey};
        foreach $daykey (sort {$a &lt;=&gt; $b} keys %{$monevents} ) {
            my $dayevents = $monevents-&gt;{$daykey};
            foreach $uid (sort {
                            DateTime-&gt;compare($dayevents-&gt;{$a}-&gt;{'DTSTART'}, $dayevents-&gt;{$b}-&gt;{'DTSTART'})    
                            } keys %{$dayevents}) {
                my $event = $dayevents-&gt;{$uid};
               if ($eventsbyuid{$uid}) {
                    my $curreventday = $event-&gt;{'DTSTART'}-&gt;clone;
                    $curreventday-&gt;truncate( to =&gt; 'day' );
                    $eventsbyuid{$uid}{$curreventday-&gt;epoch()} =1;
                    for (my $i = 0;$i &lt; $DEFAULT_LEAD_TIME &amp;&amp;&nbsp;!defined($event-&gt;{'LEADTIME'});$i++) {
                        if ($eventsbyuid{$uid}{$curreventday-&gt;subtract( days =&gt; $i+1 )-&gt;epoch() }) {
                            $event-&gt;{'LEADTIME'} = $i;
                        }
                    }
                } else {
                    $eventsbyuid{$uid} = $event;
                    my $curreventday = $event-&gt;{'DTSTART'}-&gt;clone;
                    $curreventday-&gt;truncate( to =&gt; 'day' );
                    $eventsbyuid{$uid}{$curreventday-&gt;epoch()} =1;
                }

            }
        }
    }
}
foreach $yearkey (sort keys %{$events} ) {
    my $yearevents = $events-&gt;{$yearkey};
    foreach $monkey (sort {$a &lt;=&gt; $b} keys %{$yearevents}){
        my $monevents = $yearevents-&gt;{$monkey};
        foreach $daykey (sort {$a &lt;=&gt; $b} keys %{$monevents} ) {
            my $dayevents = $monevents-&gt;{$daykey};
            foreach $uid (sort {
                            DateTime-&gt;compare($dayevents-&gt;{$a}-&gt;{'DTSTART'}, $dayevents-&gt;{$b}-&gt;{'DTSTART'})
                            } keys %{$dayevents}) {
                my $event = $dayevents-&gt;{$uid};
                if (exists($event-&gt;{'LEADTIME'})) {
                    $leadtime = &quot;+&quot;.$event-&gt;{'LEADTIME'};
                } else {
                    $leadtime = &quot;+&quot;.$DEFAULT_LEAD_TIME;
                }
                my $start = $event-&gt;{'DTSTART'};
                print &quot;REM &quot;.$start-&gt;month_abbr.&quot; &quot;.$start-&gt;day.&quot; &quot;.$start-&gt;year.&quot; $leadtime &quot;;
                if ($start-&gt;hour &gt; 0) { 
                    print &quot; AT &quot;;
                    print $start-&gt;strftime(&quot;%H:%M&quot;);
                    print &quot; SCHED _sfun MSG %a %2 &quot;;
                } else {
                    print &quot; MSG %a &quot;;
                }
                print &quot;%\&quot;$event-&gt;{'SUMMARY'}&quot;;
                print &quot; at $event-&gt;{'LOCATION'}&quot; if $event-&gt;{'LOCATION'};
                print &quot;\%\&quot;%\n&quot;;
            }
        }
    }
}
exit 0;
#:vim set ft=perl ts=4 sts=4 expandtab&nbsp;:
</pre>

<!-- Saved in parser cache with key graham_wiki:pcache:idhash:1387-0!1!0!0!!en!2 and timestamp 20100215022506 -->
<div class="printfooter">
Retrieved from "<a href="http://wiki.grahamenglish.net/index.php/Ical2rem.pl">http://wiki.grahamenglish.net/index.php/Ical2rem.pl</a>"</div>
	    	    <!-- end content -->
	    <div class="visualClear"></div>
	  </div>
	</div>
      </div>
      <div id="column-one">
	<div id="p-cactions" class="portlet">
	  <h5>Views</h5>
	  <ul>
	    <li id="ca-nstab-main"
	       class="selected"	       ><a href="/index.php/Ical2rem.pl">Article</a></li><li id="ca-talk"
	       class="new"	       ><a href="/index.php?title=Talk:Ical2rem.pl&amp;action=edit">Discussion</a></li><li id="ca-edit"
	       	       ><a href="/index.php?title=Ical2rem.pl&amp;action=edit">Edit</a></li><li id="ca-history"
	       	       ><a href="/index.php?title=Ical2rem.pl&amp;action=history">History</a></li>	  </ul>
	</div>
	<div class="portlet" id="p-personal">
	  <h5>Personal tools</h5>
	  <div class="pBody">
	    <ul>
	    <li id="pt-login"><a href="/index.php?title=Special:Userlogin&amp;returnto=Ical2rem.pl">Create an account or log in</a></li>	    </ul>
	  </div>
	</div>
	<div class="portlet" id="p-logo">
	  <a style="background-image: url(http://www.grahamenglish.net/logo.png);"
	    href="/index.php/Main_Page"
	    title="Main Page"></a>
	</div>
	<script type="text/javascript"> if (window.isMSIE55) fixalpha(); </script>
		<div class='portlet' id='p-navigation'>
	  <h5>Navigation</h5>
	  <div class='pBody'>
	    <ul>
	    	      <li id="n-mainpage"><a href="/index.php/Main_Page">Main Page</a></li>
	     	      <li id="n-recentchanges"><a href="/index.php/Special:Recentchanges">Recent changes</a></li>
	     	      <li id="n-randompage"><a href="/index.php/Special:Random">Random page</a></li>
	     	      <li id="n-sitesupport"><a href="/index.php/The_Graham_English_Wiki:Site_support">Donations</a></li>
	     	    </ul>
	  </div>
	</div>
		<div id="p-search" class="portlet">
	  <h5><label for="searchInput">Search</label></h5>
	  <div class="pBody">
	    <form name="searchform" action="/index.php/Special:Search" id="searchform">
	      <input id="searchInput" name="search" type="text"
	        accesskey="f" value="" />
	      <input type='submit' name="go" class="searchButton" id="searchGoButton"
	        value="Go"
	        />&nbsp;<input type='submit' name="fulltext"
	        class="searchButton"
	        value="Search" />
	    </form>
	  </div>
	</div>
	<div class="portlet" id="p-tb">
	  <h5>Toolbox</h5>
	  <div class="pBody">
	    <ul>
		  		  <li id="t-whatlinkshere"><a href="/index.php/Special:Whatlinkshere/Ical2rem.pl">What links here</a></li>
		  		  <li id="t-recentchangeslinked"><a href="/index.php/Special:Recentchangeslinked/Ical2rem.pl">Related changes</a></li>
		                	      	      	      	      	      	      	      <li id="t-upload"><a href="/index.php/Special:Upload">Upload file</a></li>	      	      <li id="t-specialpages"><a href="/index.php/Special:Specialpages">Special pages</a></li>	      	      	      <li id="t-print"><a href="/index.php?title=Ical2rem.pl&amp;printable=yes">Printable version</a></li>
	      	    </ul>
	  </div>
	</div>
	      </div><!-- end of the left (by default at least) column -->
      <div class="visualClear"></div>
      <div id="footer">
    <div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" alt="MediaWiki" /></a></div>	<div id="f-copyrightico"><a href="http://creativecommons.org/licenses/by-nc-nd/2.5/"><img src="http://creativecommons.org/images/public/somerights20.png" alt='Attribution-NonCommercial-NoDerivs 2.5' /></a></div>	<ul id="f-list">
	  <li id="f-lastmod"> This page was last modified 19:04, 30 May 2007.</li>	  <li id="f-viewcount">This page has been accessed 552 times.</li>	  	  	  <li id="f-copyright">Content is available under <a href="http://creativecommons.org/licenses/by-nc-nd/2.5/" class='external ' title="http://creativecommons.org/licenses/by-nc-nd/2.5/" rel="nofollow">Attribution-NonCommercial-NoDerivs 2.5</a>.</li>	  <li id="f-about"><a href="/index.php/The_Graham_English_Wiki:About" title="The Graham English Wiki:About">About The Graham English Wiki</a></li>	  <li id="f-disclaimer"><a href="/index.php/The_Graham_English_Wiki:General_disclaimer" title="The Graham English Wiki:General disclaimer">Disclaimers</a></li>	  	</ul>
      </div>
    </div>
    <!-- Served by gator48.hostgator.com in 0.12 secs. -->
<!-- www.hitslink.com/ web tools statistics hit counter code -->
<script type="text/javascript">//<![CDATA[
var ns_data,ns_hp,ns_tz,ns_rf,ns_sr,ns_img,ns_pageName;

// The pageName variable can be customized if needed
ns_pageName=location.pathname;

document.cookie='__support_check=1';ns_hp='http';
ns_rf=document.referrer;ns_sr=window.location.search;
ns_tz=new Date();if(location.href.substr(0,6).toLowerCase()=='https:')
ns_hp='https';ns_data='&an='+escape(navigator.appName)+ 
'&sr='+escape(ns_sr)+'&ck='+document.cookie.length+
'&rf='+escape(ns_rf)+'&sl='+escape(navigator.systemLanguage)+
'&av='+escape(navigator.appVersion)+'&l='+escape(navigator.language)+
'&pf='+escape(navigator.platform)+'&pg='+escape(ns_pageName);
ns_data=ns_data+'&cd='+
screen.colorDepth+'&rs='+escape(screen.width+ ' x '+screen.height)+
'&tz='+ns_tz.getTimezoneOffset()+'&je='+ navigator.javaEnabled();
ns_img=new Image();ns_img.src=ns_hp+'://counter.hitslink.com/statistics.asp'+
'?v=1&s=214&acct=gewiki'+ns_data+'&tks='+ns_tz.getTime(); //]]>
</script>
<!-- End www.hitslink.com/ statistics web tools hit counter code -->

<!-- BEGIN Invitation Positioning  -->
<script language="javascript">
var lpPosY = 100;
var lpPosX = 100;
</script>
<!-- END Invitation Positioning  -->

<!-- BEGIN HumanTag Monitor. DO NOT MOVE! MUST BE PLACED JUST BEFORE THE /BODY TAG --><script language='javascript' src='https://server.iad.liveperson.net/hc/44546139/x.js?cmd=file&file=chatScript3&site=44546139&&imageUrl=https://www.mcssl.com/merchantLogos/64168'> </script><!-- END HumanTag Monitor. DO NOT MOVE! MUST BE PLACED JUST BEFORE THE /BODY TAG -->

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-180463-3";
_udn="grahamenglish.net";
urchinTracker();
</script>

  </body>
</html>
