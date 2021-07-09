#!/bin/bash
#
# Auswertungs-Script
#

myExpectedExecutionUser="root"
myLogFile=/tmp/m143TrueNas.log
myDelimiter="------------------------------------------------------------------------------------------------"

COLOR_OFF="\033[0m"

COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_MAGENTA="\033[35m"
COLOR_CYAN="\033[36m"
COLOR_WHITE="\033[37m"

COLOR_BOLD_RED="\033[1;31m"
COLOR_BOLD_GREEN="\033[1;32m"
COLOR_BOLD_YELLOW="\033[1;33m"
COLOR_BOLD_BLUE="\033[1;34m"
COLOR_BOLD_MAGENTA="\033[1;35m"
COLOR_BOLD_CYAN="\033[1;36m"
COLOR_BOLD_WHITE="\033[1;37m"

COLOR_INVERT_YELLOW="\033[33;5;7m"


# --------------------------------------------------------------------------------
function fnLog {

  typeset  FUNC_MESSAGE=${1:-"no message provided"}

  echo -e "${FUNC_MESSAGE}"

  return 0
}

# --------------------------------------------------------------------------------
function fnCheckUser {

    typeset  FUNC_EXPECTED_USER=${1:-"unknown"}
    typeset  FUNC_CURRENT_USER="$(id -u -n)"
    
    if [[  ${FUNC_EXPECTED_USER} != ${FUNC_CURRENT_USER} ]]; then
       fnExitError "wrong user (${FUNC_CURRENT_USER}), please execute the script with user ${FUNC_EXPECTED_USER}"
    fi   
    
    return 0
}   

# --------------------------------------------------------------------------------
function fnExitError {

  typeset  FUNC_ERROR_MESSAGE=${1:-"no message provided"}
  typeset  FUNC_EXIT_CODE=${2:-"16"}

  fnLog "${COLOR_BOLD_WHITE}***********************************************************************${COLOR_OFF}"  
  fnLog "${COLOR_RED}ERROR: ${FUNC_ERROR_MESSAGE}${COLOR_OFF}" 
  fnLog "${COLOR_BOLD_WHITE}***********************************************************************${COLOR_OFF}"
  fnLog "script will be terminated with exit code ${FUNC_EXIT_CODE}"
    
  exit ${FUNC_EXIT_CODE}
  
}

# --------------------------------------------------------------------------------


clear
fnCheckUser "$myExpectedExecutionUser"

echo  $myDelimiter     >  $myLogFile 
echo  "*** 001S ***"   >> $myLogFile  2>&1
zfs list               >> $myLogFile  2>&1
echo  "*** 001E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 002S ***"   >> $myLogFile  2>&1
ls -l  /mnt            >> $myLogFile  2>&1
echo  "*** 002E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 003S ***"   >> $myLogFile  2>&1
ls -l  /mnt/*          >> $myLogFile  2>&1
echo  "*** 003E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 004S ***"   >> $myLogFile  2>&1
zfs list -t snapshot   >> $myLogFile  2>&1
echo  "*** 004E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 005S ***"   >> $myLogFile  2>&1
zfs list -r -t snapshot -o name,creation  >> $myLogFile  2>&1
echo  "*** 005E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 006S ***"   >> $myLogFile  2>&1
ls -lRa  /mnt          >> $myLogFile  2>&1
echo  "*** 006E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 007S ***"   >> $myLogFile  2>&1
find  /mnt -ls         >> $myLogFile  2>&1
echo  "*** 007E ***"   >> $myLogFile  2>&1

echo  $myDelimiter     >> $myLogFile 
echo  "*** 008S ***"   >> $myLogFile  2>&1
cat /etc/group         >> $myLogFile  2>&1
echo  "*** 008E ***"   >> $myLogFile  2>&1


echo $myDelimiter 
echo -e "Log-File ist: ${COLOR_BOLD_WHITE}$myLogFile${COLOR_OFF}"
echo    "Achtung: Das File $myLogFile muss abgegeben werden - kein File, keine Punkte !!"
echo ""
echo "kopieren Sie das File $myLogFile fuer die Abgabe via File-Transfer Tool auf Ihren Host"
echo $myDelimiter 

