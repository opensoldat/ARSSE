ARSSE
-----
Advanced Remote Soldat Server Enchanter



The purpose of this project is to create the ultimate Soldat Server Administrator Tool.
You are free to distribute it in any form if you don't earn money from it. Just write me
an email to let me know. If you find any kind of bug please add it to the bugtracker on
http://arsse.u13.net.

Installation:
--------

ARSSE doesn't need much installation, just unzip and copy to any directory you wish.

The Layout:
-----------

The layout is pretty self-representative. You can see the server tabs on the top, with the
Add and Remove buttons on the right. You can use these to open a new server tab, or close
one.
Below, you can see the server settings: host, port and password, along with some buttons:
Connect/Disconnect, Manage Favourites, Refresh and Settings. They do what they say:
-Connect/Disconnect connects you to the server, or disconnects if already connected
-Manage Favourites offers a few options like Add, Delete, Rename and Update Servers
-Refresh sends a REFRESH command to the server and updates the server info
-Settings opens a new dialog where you can do all the configuration of ARSSE (see below)

Under These, you see the Player List, which will show you some info about the players in
your server. Next to it there is the Team Scores and the Server Info boxes.
You can find the server message box under player list. You can adjust their size if
you click on the resizer on the bottom of the player list.
Next to that, there is the Command Box, where you can select and perform any command of
the server.
On the Bottom, you can see the Command Line and some version info. Use the command line
to execute any command you wish. You can select the previously executed commands from the
drop-down list.


Options:
---------

On the settings window you can set the following options:

-automatically refresh every [X] seconds.
  If you check this, ARSSE will refresh server info every seconds you specify.
-save server password
  If checked, your passwords will be stored encrypted for your pleasure.
-save message log
  If checked, server messages will be stored in a logfile in the logs directory.
  The filename is the server's ip/hostname.
-minimize to system tray
  If you check this, ARSSE will minimize itself to the system tray with an icon.
-automatically sort on refresh
  Default is checked. If not checked, the playerlist won't be sorted by Score.
-automatically swap teams after every map change
  If true, teams are changed on next map load
-automatically scroll to the end of message
  Unchecking prevents scrolling to the bottom of the message window
-automatically balance teams if difference is more than [X]
  If teams are not even, ARSSE will make balance. [X] can't be less than 2. Only works with alpha and bravo teams, so you might turn it off in TDM.
-automatically send server message(s) every [X] seconds
  The specified server messages are sent to the server. More than one lines can be set.


Player List:
------------

It will display the list of players currently playing on your server. Refresh method is
"user-friendly", which means it don't flicker but updates.
With the right click menu, you can Kick, Ban by IP/Name, Set/Remove Admin, Move to Team or
Copy Player Name/IP to Clipboard.
You can also resize/re-arrange the columns of the list if you wish.


Command Box:
------------

You can find all commands for soldat, and even more. I don't want to describe these
commands, you can check Soldat Manual for a description.
But i need to say a few words about some of them:

-Make Private
  This command will kick all players and set the specified game password. Useful for cw.
-Add bot
  This will bring up a Default Bots window also, where you can select the bot you wish to
  join your server. You can add bot names to the list by editing botlist.txt
-Change map
  Just like Add bot, Change map displays the Default Maps for faster and easier map change.
  If you want to add new maps, just edit the file maplist.txt (!! not mapslist.txt !!)

Bulit-in IRC Bot:
-----------------

Not much support yet, as it is not complete. Check IRC Commands section for some
details on IRC commands.
You can use the Command line to execute IRC commands, or without the / prefix, you
can send messages to the channel. Note that you must use the command syntax described in
the Internet Relay Chat Protocol, not mIRC like commands.
Check http://www.rfc-editor.org/rfc/rfc1459.txt for the protocol document.
(will change later, as it is not important. use with care, it may cause problems.)


Super Fast Hotkeys:
-------------------

ARSSE supports Super fast hotkeys. Just press the key when you are not in an edit box, and
the command will run. You can find the list of Hotkeys in the Hotkeytab in configuration.
You can change them if you want. If you want to disable a Hotkey just doubleclick on the
Hotkey and press backspace or delete.


Additional Server Commands:
---------------------------

/kickall [password] - kicks all players from the server. If password is specified, it sets game password also
/swapteams - swaps teams, only works in CTF and INF game modes.
/spectall - moves everyone to Spectator
/banname [player] - permanently bans [player] by name from the server (only works if ARSSE runs)
/unbanname [player] - removes name ban of [player]
/setteamall [number] - sets all players to the specified team [number]
/load [script] - loads and executes [script]. Scripts must be in script directory with .txt extension.
/balance - balances teams if difference is greater than (or equal to) 2 (or the number set in Options)
/clientlist - shows all connected adminclients (works only for new ARSSE and lin 0.4)

Ingame commands:
----------------

!admin - sends request for an admin by popping up a window and - if connected to IRC - sending message to IRC channel
!rate - displays the players rate (disabled by default)
!test - echos your name to show you if it can respond to you
!time - shows current time - on the computer running ARSSE
!version - displays the version of ARSSE
!commands - displays all the available commands
!myip - displays player's IP (disabled by default)
!ping - displays player's ping (disabled by default)
!nextmap - echos next map

Additional commands can be applied, see scripts/OnPlayerSpeak.txt (bottom) for more info. Those commands
are for private servers.

IRC commands:
-------------

!help - displays a commands screen
!servers - shows all the servers under it's control
!info [num] - shows info about server number [num]
!connect [num] - connects to server, or if already connected, disconnects
!disconnect [num] - an alias for !connect :)
!players [num] - shows players on server number [num]. Use !servers to get the numbers
!kill - disconnects bot from IRC


System Requirements:
--------------------

-Windows 9X/NT/2000/XP/2003/Vista/7
-Any kind of hardware capable of running above mentioned OS
-Around 1 MB of hard disk space (you need more for logs)
-Around 11 MB of RAM (needs more RAM when you run it longer and/or connect to more servers)


Version history:
----------------
1.2.9.69
-added Send All Servers Command to CommandBox (only in full version)
-modified replaced TagID with HWID
-modified updated refreshx to work with new soldatserver and hardwareids
-modified replaced banning by tagid with banning by hardwareid
-fixed long connection timeout delay when connecting on startup
-fixed OnConnect not called on connect on startup bug (#131)
-fixed spelling error in command box "Unban Now" => "Unban Name" (fixed in full version) #134
-fixed /amsg doesn't work from command box #133

1.2.9.68
-added $DATE scripting variable
-fixed index out of bounds error on non chat [*]* messages

1.2.9.67
-added new flags (download flags.zip or full version to get them)
-modified improved ? flag
-modified new version of ip.adb added
-fixed ARSSE focused when minimized bug (#128)
-fixed On Player Join color Bug (#120)
-fixed OnAdminDisconnect event doesn't work
-fixed Focusing invisible window error when restoring from tray menu (#130)

1.2.9.66
-modified new version of ip.adb added
-modified caret is visible when clicking into Memo
-fixed memo console flickering where possible
-fixed scrolling bug
-fixed disabled controls on autoconnect bug (#125)
-fixed host and command line editbox focus issues when inactive window gets focus
-fixed closing confirm windows (by clicking on the x) is handled as if clicked on "no" (instead of "yes")
-fixed message gets cut off on ingame admin command on soldatserver 2.6.6
-fixed access violations on too many timers

1.2.9.65
-modified connect timeout delay set to 2.5 seconds
-modified new ip.adb added (2010.06)
-fixed host input field has focus on window show
-fixed memo stops scrolling when clicked into it
-fixed refreshx spam on massive player/bot kick (causes a server and ARSSE freeze)
-fixed negative value in total score field on left side when total score is larger then 127
-fixed access violation when mouse is over playerlist and ip.adb is missing

1.2.9.64
-modified OnData examples to not be enables by default
-modified new ip.adb added
-fixed script execution bug with $DATA
-fixed adding and removing favorites - Manage Favorites bug (#121)

1.2.9.63
-added /bantag support for player context menu
-added Copy tagid for player context menu
-modified After Update message
-modified default size and min size of columns
-modified tagid column has min width now
-modified Playerlist columns now remember their width when resized on tab change
-modified ip.adb is now from 2010.03
-fixed Names and Flags are drawn at wrong position when vertical scrollbar isn't all left
-fixed wrong column hide on column move
-fixed column hide takes too long
-fixed moving playernames column in playerlist
-fixed flag tooltip triggers don't work correctly when moved playerlist columns around
-fixed playercount on servertab stays on connection failture

1.2.9.62
-added copyright date to file info
-modified spectator points are displayed now
-modified spectators are now sorted like all other players
-fixed freeze for 25 seconds is now 5s max
-fixed typo in about tab of the contiguration window
-fixed index out of bounds error when clicking on playerlist sort
-fixed wrong sorting of playerlist
-fixed playerlist contextmenu reads values from wrong column
-fixed info underneath the "more.."/"less.." label isn't empty when switching from an connected tab
-fixed focusing hidden control error message when scrolling in IRC tab
-fixed first click gets ignored when switching back to server tab comming from IRC tab
-fixed IRC config username had wrong taborder

1.2.9.61
-added new ip.adb from 2010-01
-added new script examples
-added IRC bot Username option into settings
-added Hide Command Box support when clicking on "more.." (id 0000090)
-added TagID field in playerslist
-added Radio teammessage color and scripting event handling (same event as teamchat)
-added Always on top feature can be accessed through the systemmenu
-added Player Caps to playerlist when server uses new refreshx (soldatserver 2.6.5 and later)
-added Teamlist shows spec count and total caps/count information
-added ip.adb updating feature
-modified "using refreshx" messages to tell which refreshx version is beeing used
-modified FlagDB to load ip.adb into ram instead of reading it everytime
-modified Search argorithm to work with new FlagDB
-modified Channel name in about box is now #shoozza
-modified Removed perform action button
-modified Enter saves changes in the hotkeys tab
-modified Rewrote updater to first check then download to tempfolder and then move updatefiles to arsse's folder
-fixed Soldatserver 2.7.0c refreshx parsing - note 2.7.0a and 2.7.0b are not supported anymore
-fixed flag hover text spelling error
-fixed Getting output from other server
-fixed Reconnecting when 'disconnect all' menuitem has been clicked and autoreconnect is enabled
-fixed Path problems when useing wrong working directory (botlist.txt, maplist.txt, bannames.txt, ip.adb and flags)
-fixed Path problem in script file exisiting coloring
-fixed Clicking outside of the edit filed in the hotkeys tab (settings window) saves changes anyways
-fixed Irc connect button keeps saying 'disconnect' when connection failed
-fixed Console Colors Merge (first attempt to fit it)
-fixed Spelling errors Avarage -> Average
-fixed Spelling errors in CommandBox.txt

1.2.9.60
-fixed update shows debug popups
-fixed sideeffects because of semi multithreading

1.2.9.59
-fixed Hotkeys don't work initially
-fixed Hotkeys get disabled when Hotkeytab in Config have been shown
-fixed Wrong Refreshx detection code
-fixed Timelimit gets displayed wrong on high value
-added Backspace and Delete disable to hotkey in settings

1.2.9.58
-fixed adminip closing ')' missing when long ip
-fixed arsse keeps hanging when connecting to nonexistent server
-fixed tabcount -1 in ini causes access violations
-fixed wrong refreshx detection
-added custom hotkeys
-changed copyright note in about box
-changed updater loads dynamic generated update.dat file

1.2.9.57
-fixed problem with updating
-fixed possible bug abuse with Server Version string
-fixed REFRESHX packet detection

1.2.9.56
-fixed wrong default tab in settings selected
-fixed problem with /kickall and password
-fixed hotkeys show "Cannot focus a disabled or invisible window" when used while disconnected
-added hotkey read functionality (only reading hotkey not saving / using)
-added compatibility with new REFRESHX
-added /clientlist hotkey (ctrl+l)
-added /amsg command
-added first documentation txt*
-changed reduced size of Team column in Playerslist
-changed hotkeychecking uses char casts instead of numbers*

1.2.9.55
-fixed possible IO error on startup with debug mode
-fixed multiple commands
-added remove log when servertab is removed
-added custom Sound on ADMINMSG
-added /clientlist command

1.2.9.45 (and earlier)
-fixed autobalance focus error on tray
-added nick chat mode checkbox
-added hotkey for nick chat mode (ctfl+n)
-added OPENSERVERLOG command for the commandbox (opens last logfile for the current server)
-added ADMIN_NAME variable for scripting
-added $SENDER_IP and $SENDER_PORT
-changed $VERSION
-fixed /setteamall nickname bug
-added colored playerlist)
-fixed special nickname kicks all players and sets password
-fixed $MAXPLAYER variable not working
-fixed ctrl+n selects searchform when not visible
-fixed all controls try to select searchform when pressing 'n'
-fixed formating bugs (outcommented code caused commandbox.txt to get bigger and bigger)
-fixed weird messageboxes on updatefail
-fixed cmd no doubleinputs
-added ctrl+n for next search
-added tooltip with countryname for flags in playerlist
-fixed default textcolor changes to the color of lastline on clea
-fixed playerlist doesn't update when spectator joins
-added playerlist backgroundcolor for different teams
-fixed tab order in settings and mainform
-fixed ctrl+e / ctrl+r changes align of the selected memo text
-fixed access violation on timeredit
-added second ctrl+a selects whole text in cmd-inputfield
-added new ip.adb (source webhosting.info)
-added optional ip2.adb (source maxmind.com)
-added make_dev.bat for autorenaming ARSSE.exe to ARSSE_dev.e
-fixed updater
-fixed vertical position of show menu (>>) button
-added easteregg (let them search stuff - they will find more bugs :D )
-undo changes to playerlistdraw
-fixed up arrow shos same text when there is not sent text
-fixed c hotkey not working in certain situations
-fixed deleted unused flag files. note that there are 10 flagfiles missing, required by FlagDB.pas
-added button for connect-related options, same as right-click on connect button
-added developing TreeView-like command box (doesn't work, it's a test..)
-fixed hacker alert removed
-fixed admin chat adds to history with name
-fixed typed and not sent command is saved if arrows are pressed
-fixed player list and command box lose focus on tab change
-fixed memo loses focus if no selection is made
-fixed ctrl+a for all edit, combobox, richedit and memo controls on server-console and settings form
-fixed scrolling bug with hidden control
-added searchform
-added memoapp func for fixing scrolling with active memo
-modified all memo app/add func to use memoapp
-modified focus on memo
-removed icon from main form (other icon in options is used by default)
-fixed various scrolling related issues
-added $PLAYERS_COUNT variable to script engine
-modified size of update popup (original size)
-fixed add tab button didn't activate new tab
-fixed add and remove tab buttons didn't gave focus to cmd line
-fixed when IRC Bot is active, cmd can't have focus
-fixed adding new tab always activates second tab only
-fixed sometimes fails to recognise player messages
-fixed changing tabs took focus from command line

-added ctrl+1..6 hotkeys to change focus:
	ctrl+1 = Command line
	ctrl+2 = Player list
	ctrl+3 = Command Box
	ctrl+4 = Host
	ctrl+5 = Server Tabs
	ctrl+6 = Server Console/IRC Console
-added ctrl+left, ctrl+right arrows change ServerTabs (only if command line
	doesn't have focus
-added ctrl+tab sets focus on player list

-modified removed / hotkey
-modified hotkey i to ctrl+i
-modified IP bans in player list (Permanent/30 days)
-modified player list and command list can have focus
-modified console can't have focus
-modified tab orders
-modified update popup position
-fixed finished cmd line has default focus
-modified scrolling enabled while cmd line or server rename has focus
-modified command line has the focus by default
-modified admin and normal chat mode tweaks
-added ctrl+clicking on commands in console window executes command
-fixed abnormal behavior of command line to ctrl+home, ctrl+end, etc.
-fixed removed redundant functions for checking ctrl state
-modified removed ctrl+space hotkey for admin chat
-modified hotkeys: connect is now c, disconnect is now ctrl+d
-fixed Cmd filters ctrl+x/c/v
-fixed Cmd up arrow doesn't work after second up + enter
-added Cmd jumps to first/last Command when at list end/start and pressing up/down
-added Cmd ctrl+a support
-modified Admin chat mode text replacement code (tweaked)
-modified small tweak on Cmd line, if dropped down, arrows work original way
-fixed on old REFRESH-request corrupt data is displayed in console
-fixed beep with hotkeys
-fixed no botflag when db missing
-fixed tabscrolling + - was missing
-fixed tabcontrol scrolling range checks
-fixed flag-releasing
-fixed wrong scrolling direction in tabcontrol
-added comments
-improved look of code
-increased build version number in options
-modified hotkeys now ctrl is required for most of them
-cleaned up commit
-fixed flags for bots
-added hotkey for Chat mode (ctrl+e)
-added hotkey for Admin chat mode (ctrl+w)
-fixed new scrollbugs
-fixed deleting flags on exit issue
-added bot flag (rb.gif and flag code)
-modified scrolling method
-fixed various scrolling issues (ServerTab, ActionList, PlayerList, etc.)
-fixed resizing panels and scrollchanging tabs issue
-fixed exception problems on disconnect
-added Admin chat mode checkbox
-added filter for open save scrips
-fixed windowpos saving when maximized
-fixed wrong detection of versionnumber when updating
-fixed update fail detection
-modified selected not active tab text color
-modified removed unnecessary ip checking code
-added flags in playerlist (FlagDB and flag gifs)
-added chat mode hotkey
-added gray text for disconnected active tab
-fixed layout
-fixed nametabcompletion (complete rewritten)
-fixed wrong folderpath for openlogsfolder
-added Chat mode
-added mouseweelscrolling through servertabs
-added renaming servertabs on doubleclick
-fixed beep sound on hotkey ctrl+t
-fixed layout
-fixed disabled commandboxtext color
-fixed bug with moved memo on small window
-added version-file-information
-fixed bug with botcount
-fixed logsaving local format may disallow writing of logfiles
-fixed IRCConsole is not acting like ServerConsole
-fixed focus fails on IRCTab choosen when showing form
-modified IRCTab-Items positioning to look like in ServerTab
-modified versioning in title
-modified Icon name
-added cmdbox colorswitch on too long /say /pm messages
-added darker teamcolors for bots
-added open logs folder button in configuration
-added defines for dev beta and stable version (updater will allow to choose in future)
-added UpdatePopup Dialog
-added new icons for beta and dev version
-added fakeupdate batch file for creating fake updates
-fixed Adminpassword is displayed when older ARSSE client connects
-fixed Playerlist sort is not set to points at startup and sorts wrong (from a few commits ago)
-fixed ctrl+space tries to focus disabled control
-modified Playerlist has focus instad of Serverip has focus on startup / formshow
-modified copyright date
-added New and Duplicated tab opens in Foreground if Ctrl is not pressed
-fixed remove button access violation and deleting wrong tab
-fixed not possible to exit when update is running without Internet
-fixed focus on tabs interferes with deleting of tabs
-fixed Command Line label displaying
-fixed Number of Bots in the Server doesn't Display
-fixed Playerlist doesn't stay customsorted
-changed Aboutbox text
-fixed adminmsg tab problem when arsse minimized to tray
-added middle mouse closes tab (already in last commit)
-added timestamps for logfiles
-fixed Adding Tab access violation bug
-fixed Scrollbug with ActionBox
-fixed Access Violation on incorrect portnumber bug
-added colored tabs
-fixed Adding Tab access violation bug
-fixed Scrollbug with ActionBox
-fixed duplicated server issue with showing server password and duplicate info commands and other abnormal behavior
-fixed Windows x64 drawing

1.2 - (2006.06.XX)
-fixed auto-connect bug: server showed disconnected
-fixed Connect on Startup showed false information
-fixed reconnected when clicked "Disconnect" and Auto-Retry was on
-fixed !admin command resized the main window
-fixed pressing Tab on password box takes you to Connect button
-fixed Team scores, Avarage Ping, Avarage/Total Score, Avarage/Total Deaths refreshed with delay on Tab change
-fixed !rate sometimes show 10-14 digits for K:D rate, now it shows in a 0.00 format
-fixed stability problems, less lag, crash now
-added option to hide "Registering Server.." messages
-added option to hide kill messages
-added hotkeys: z will send PM to the player selected in Player List, / will immediately focus on command line
-added Join Game function to Command Box - starts Soldat and joins the actual server
-added right-click menu to Command Box
-added OnRefresh event
-added pressing CTRL key in Password box shows the password
-added more server informations to InfoBox (bots, spectators, respawn time, etc.)
-added hotkey (i) to open/close InfoBox
-added HIDE function to hide data in main console
-added CLEAR function to script engine to clear the main console
-added WRITEFILE to write to a specified file. Usage: WRITEFILE file_name.txt Write this text.
-added timers to execute scripts on a regular basis
-modified Command Box: commands are loaded from CommandBox.txt
-modified Command Box: custom commands can be added
-modified connected servers are now displayed in black, disconnected servers are in gray
-modified command line played a "beep" on pressing "Enter", now it's silent
-modified server name is changed if clicked anywhere, hitting ESC cancels renaming
-modified pings are displayed in color depending on value in Player List
-modified main window's layout: version info and 'by RiA|KeFear' is now displayed in title
-modified Spectators' score, death and ratio are replaced with N/A
-modified scrolling mechanism of main console
-modified structure and name of configuration ini file (now arsse.ini) not compatible with previous versions
-modified settings and events are now separated for each server
-modified main form design
-removed 'automatically scroll to the end of the message box' from Settings


1.1.6.3 - (2006.06.04)
-fixed Command Box bug: Set Realistic Mode command was "/realisitc 1"
-added Load Settings File to Command Box
-added Private Message to player popup menu (/pm command)
-added Global Mute and Global Unmute commands to player popup menu (/gmute, /ungmute)
-added !myip ingame command (see OnPlayerSpeak.txt)
-added !ping ingame command
-added !restart, !p, !laos, !b2b, !nuubia, etc ingame commands
-added !tnl and !srl ingame commands (thanks to Kaimelar)
-modified connected servers are displayed in bold on ServerTab
-removed Reload Settings from Command Box


1.1.6.2 - (2006.04.05)
-added Connect/Disconnect All to Connect button right click menu
-added Auto Reconnect to Connect button right click menu
-added Connect on startup to Connect button right click menu
-added a few new variables to script engine: $MAXPLAYERS, $ALPHA_PLAYERS, $ALPHA_SCORE, etc.
-modified logs: now saves under "Server Name.txt"

1.1.6.1 - (2006.02.18)
-added autobalance
-added new command: /balance
-fixed CPU overusage problem
-fixed various bugs

1.1.6 - (2005.12.10)
-added events
-added improved scripting
-added script editor
-added maximum players display
-added team players display
-added echo server messages to IRC channel controlled by OnData event
-added new Soldat 1.3.1 commands /loadlist X and /lobby to the Command Box
-added new default maps to maplist.txt
-added new OnPlayerSay scripts: Team-change by Leo and Revolution-hack prevention by jaddy
-modified team score display
-modified player list team colours
-modified in-game commands are now controlled by OnPlayerSpeak event
-fixed Deafult Bots/Maps list height issues
-fixed first server tab port and password loaded incorrectly
-fixed all events occure when player starts text with space
-and some more changes I forgot about long ago... :S

1.1b - first beta with IRC Bot ;) (2005.07.26)
-added "basic" IRC support
-added varius IRC commands
-added in-game commands: !commands, !test, !time, !admin
-added players/maxplayers to display
-added player count to team display
-added option to enable/disable in-game commands
-modified auto say now sends message to every connected servers
-modified message read method, so multi-lines are filtered out and players using it are warned
-modified teams are colored in player list
-fixed no refresh when server before actual tab is not connected
-fixed server data not saved when only one tab is open
-fixed selected text colored when new line added to message box
-fixed various message box related errors
-fixed refresh stops for all if not selected server is not connected
-fixed autosay saved incorrectly if settings not pressed

1.0 - first non-beta release (2005.07.03)
-added named ban support
-added command /banname [player]
-added command /unbanname [player]
-added command /setteamall [number]
-added resizeable Player list / Message Box
-added player command !rate
-added player command !version
-added multiple lines to automatic server message
-added tabbed multi server support
-added favourite servers manage support
-added statistics: avarage ping, avarage/total score and deaths
-added setting: auto scroll to bottom of message screen
-added basic scripting support (/load command)
-modified resize method
-modified automatic server message
-modified main icon
-modified readme
-modified favourite server storing method
-fixed auto say function state not saved
-fixed bad sorting of Spectators

0.9.4b - third public beta (2005.06.04)
-added hotkeys: c, d, p (connect/disconnect, set password)
-added Copy to clipboard function to player list right-click menu (player's name or IP)
-added setting sort on refresh
-added setting swap teams after map change (on timeout and nextmap command, not on map command)
-added setting send server message every x seconds
-added spectators to player list
-added command /kickall [password] - kicks all players and sets game password (optional)
-added command /swapteams - swaps teams (works in ctf and inf only)
-added command /spectall - puts all players to spectators
-added name completion on pressing Tab
-modified player list chat messages are now displayed in light blue for better review
-modified player list team names instead of numbers
-modified player list can be sorted by clicking on columns
-modified saved passwords are now encrypted (incompatible with previous versions!)
-modified hotkeys: kick and ban now opens dialog for paramters
-fixed focus always on parameter input
-fixed Make Private command sends command line text too
-fixed on player join last player's team displayed incorrectly
-fixed minimize to system tray icon - wierd things happened sometimes
-fixed command history issue with automatic command completion - turned off 

0.9.1b - second public beta (2005.05.21)
-added real time counter: Time Left
-added player counter
-added message logging
-added timestamp to messages
-added readme :)
-added settings dialog
-added minimize to system tray option
-added confirm dialog on exit while connected
-added flexible window, now resizeable
-modified refresh time now configurable
-modified player list refresh method
-fixed infinite error message when server closes while connected

0.8b - first public beta (2005.05.11.)

-added favorite servers support
-added commands history
-added command box
-added botlist and maplist to add bot and change map command
-added Make Private command
-added fast hotkeys
-added Ratio to playerlist
-added Time Limit and Time Left informations to server info box
-added Move to team (all teams+spectator included) to player list popup menu
-added improved keyboard support -> press enter to connect while in any textbox (host, port, password)
-modified Set remote admin in player list popup menu
-modified layout
-modified reduced size of the executable (around 38% of the original)
-fixed some of the original Soldat Admin's bugs


Special Thanks:
---------------

-Special Thanks goes to Michal Marcinkowski for creating Soldat, and then releasing his
 Soldat Admin tool's source. I used that code in my project.
-Thanks for all the kind ppl, who reported bugs, suggestions in the SoldatForums
on the Bugtracker or in any other way.
-I also thank for the people of #Shoozza, #soldat.ARSSE, #soldat.hu and the Hungarian Soldat Community, for supporting me with suggestions and bugreports.
-Thanks goes to Leo and all the people in #lrs @ irc.quakenet.org for using ARSSE on Leo's
 servers and giving ideas and support
-Thanks to Kaimelar for noticing bugs, ideas and writing some ingame command scripts
-Thanks to FliesLikeABrick for hosting on http://arsse.u13.net
-Thanks to Coyote for finding vulnerable things and help them fixing
-Last, but not least, thank you everyone who helped me in the Project in any form.


Flag Database License:
----------------------

OPEN DATA LICENSE (GeoLite Country and GeoLite City databases)

Copyright (c) 2008 MaxMind, Inc.  All Rights Reserved.

All advertising materials and documentation mentioning features or use of
this database must display the following acknowledgment:
"This product includes GeoLite data created by MaxMind, available from
http://maxmind.com/"

Redistribution and use with or without modification, are permitted provided
that the following conditions are met:
1. Redistributions must retain the above copyright notice, this list of
conditions and the following disclaimer in the documentation and/or other
materials provided with the distribution.
2. All advertising materials and documentation mentioning features or use of
this database must display the following acknowledgement:
"This product includes GeoLite data created by MaxMind, available from
http://maxmind.com/"
3. "MaxMind" may not be used to endorse or promote products derived from this
database without specific prior written permission.

THIS DATABASE IS PROVIDED BY MAXMIND, INC ``AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL MAXMIND BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
DATABASE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


Contact Information:
--------------------

email:  shoozza@selfkill.com
jabber: shoozza@selfkill.com
IRC:   QNet @ #Shoozza

URL:   http://arsse.u13.net


Copyright (c) 2005-2008  Harsányi László
Copyright (c) 2007-2010  Gregor A. Cieslak
