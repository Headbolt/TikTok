#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	TikTok.sh
#	https://github.com/Headbolt/TikTok
#
#   This Script is designed for use in JAMF
#
#	The Following Variables should be defined
#	Variable 4 - Named "TimeSource - eg. pool.ntp.org"
#
#   - This script will ...
#			Set TimeSync and Time Source
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.2 - 21/02/2023
#
#	- 31/03/2019 - V1.0 - Created by Headbolt
#
#   - 23/10/2019 - V1.1 - Updated by Headbolt
#							More comprehensive error checking and notation
#
#   - 21/02/2023 - V1.2 - Updated by Headbolt
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
TargetTimeSource=$4 # Grab TimeSource from JAMF variable #4 eg. pool.ntp.org
CurrentTimeSyncStatus=$(systemsetup -getusingnetworktime | cut -c 15-) # Grab Current TimeSync Status
CurrentTimeSource=$(systemsetup -getnetworktimeserver | cut -c 22-) # Grab Current TimeSource
ExitCode=0
#
ScriptName="MacOS | Set TimeSource"
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
/bin/echo Ending Script '"'$ScriptName'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
exit $ExitCode
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
#
/bin/echo Checking Current Settings
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
/bin/echo "Network Time Sync is - $CurrentTimeSyncStatus"
/bin/echo "Current TimeSource is - $CurrentTimeSource"
/bin/echo "TargetTimeSource is - $TargetTimeSource"
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
if [ "$CurrentTimeSource" == "$TargetTimeSource" ]
	then
		/bin/echo "TimeSource is Correct"
		/bin/echo # Outputting a Blank Line for Reporting Purposes
	else
		/bin/echo "TimeSource is incorrect, setting it to $TargetTimeSource"
		systemsetup -setnetworktimeserver $TargetTimeSource
		/bin/echo # Outputting a Blank Line for Reporting Purposes
fi
#
if [ "$CurrentTimeSyncStatus" == "On" ]
	then
		/bin/echo "TimeSync is On"
	else
		/bin/echo "TimeSync is not On, Enabling it"
		systemsetup -setusingnetworktime On
fi
#
SectionEnd
ScriptEnd
