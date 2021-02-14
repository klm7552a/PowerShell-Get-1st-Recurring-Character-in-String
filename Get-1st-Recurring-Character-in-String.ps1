#==================================================================================================
# Get-1st-Recurring-Character-in-String.ps1   v1.0
#
# Author: Ken Marvin
# Date..: 02/12/2021
#
# This PowerShell Script Deminstrates the newly written Function Get-1st-RecurringChar
#
#  
# Notes:
#
# Modified by:
# Date.......:
# Description:
#
# GitHub: https://github.com/klm7552a/PowerShell-Get-1st-Recurring-Character-in-String.git
#
#==================================================================================================


# Functions
#----------

#--------------------------------------------------------
# Function Get-1st-RecurringChar
# Author: Ken Marvin
# Date: 02/12/2021
#
# $t_String = "abcdedcba"
# Usage: Get-1st-RecurringChar $t_String
# Returns: d   
#--------------------------------------------------------
Function Get-1st-RecurringChar
{

  param($f_String = $null)

  # Initiialize Variables
  #----------------------
  $f_String_Array = @()
  $Recurring_Char_Index = 0
  $c_Count = 0
  $rc = 0
  $First_Recurring_Char_Found = $false

  # Remove All Spaces If there are any
  #-----------------------------------
  $f_String = $t_String.Replace(' ','')

  # Get the Length of the String
  #-----------------------------
  $f_String_Length = $f_String.Length

  # Load the String into an Array
  #------------------------------
  $f_String_Array = $f_String.ToCharArray()

  ForEach($Char in $f_String_Array)
  {
     #$c_Count ++
     $c_Char = $Char

     # Let's Check for Recurring Charactors
     #-------------------------------------
     For($c_cnt = $c_Count + 1; $c_cnt -lt $f_String_Length; $c_cnt ++)
     {
      
        $t_C = $f_String_Array.GetValue($c_cnt)
        #Write-Host "I Count  $c_cnt - $t_C"
           
        If($c_Char -eq $t_C)
        {

           $rc ++
           #Write-Host "$c_Char is a Recurring Char at: $c_cnt" -ForegroundColor Green
           $Previous_Index = $c_cnt
           
           #Write-Host "pi: $Previous_Index  -  rci: $Recurring_Char_Index - rc: $rc"
              
           #If($rc -gt 0 -and $First_Recurring_Char_Found -eq $false)
           If($rc -gt 0)
           {

             $Recurring_Char_Index = $c_cnt
             $Recurring_Char = $t_C
             #Write-Host "Recurring_Char: $Recurring_Char" -ForegroundColor Yellow

           } # EndIf

         } # End If

     } # End For

     $c_Count ++

     #Write-Host "Recurring_Char: $Recurring_Char" -ForegroundColor Yellow
     #Write-Host "---" -ForegroundColor Green

  }  # End ForEach $Char in $f_String_Array

  If($Recurring_Char_Index -gt 0)
  {
    #Write-Host "The first recurring character is: $Recurring_Char" -ForegroundColor Green
    Return $Recurring_Char
  }
  Else
  {
    #Write-Host "There are no recurring characters in the string: $f_String" -ForegroundColor Green
    Return "No recurring characters in the String: $f_String"
  } # EndIf

} # End Function Get-1st-RecurringChar

#------------------------------------------------------------------------------
# Function Get-ElapsedTime - Ken Marvin 
#
# Usage:
#        $script:startTime = Get-Date
#
#        $ScriptRunTime = GetElapsedTime $script:startTime
#
#        $ts = New-TimeSpan -Seconds $ScriptRunTime
#        $RunTime = "{0:00}:{1:00}:{2:00}" -f $ts.Hours,$ts.Minutes,$ts.Seconds
# 
#------------------------------------------------------------------------------
Function Get-ElapsedTime([datetime]$starttime) 
{

    $runtime = $(get-date) - $starttime
    $retStr = [string]::format("{0}", $runtime.TotalSeconds)
    
    Return $retStr

} # End Function Get-ElapsedTime

 
#-------------
# Begin Script
#-------------

# Clear Console
#--------------
CLS

#-------------------------- 
# Get Current Date and Time
#-------------------------- 
$LogDate = Get-Date -Format MMddyyyy 
$LogTime = Get-Date -Format hhmmtt
$r_Date = Get-Date -Format d
$r_Time = Get-Date -Format T

$Script_Server = $env:COMPUTERNAME

#-----------------------
# Get Scripts Start Time
#-----------------------
$script:startTime = Get-Date
Write-Host "Script Started at $script:startTime" -ForegroundColor Green
Write-Host "Running on Server: $Script_Server" -ForegroundColor Green
Write-Host "------------------------------" -ForegroundColor Green
Write-Host ""

# Let's Test a String for the 1st recurring character
#----------------------------------------------------
$t_String = "abcdedcba"                            # 'd' is the 1st Recurring Character
#$t_String = "abcdefgadcba"                         # 'a' is the 1st Recurring Character
#$t_String = "abcdefghijklmnopqrstuvwxyzfedcba"     # 'f' is the 1st Recurring Character
#$t_String = "abcdefghi"                            # No Recurring Characters

# Let's Get the 1st Recurring Character of the Input String
#----------------------------------------------------------
$r = Get-1st-RecurringChar $t_String

If($r.Length -eq 1)
{
   Write-Host "====================================" -ForegroundColor Green
   Write-Host "The first recurring character is: $r - For String: $t_String" -ForegroundColor Green
   Write-Host "====================================" -ForegroundColor Green
}
ElseIf($r.Length -gt 1)
{
   Write-Host "======================================" -ForegroundColor Green
   Write-Host "$r" -ForegroundColor Yellow
   Write-Host "======================================" -ForegroundColor Green
}

#---------------------
# Get Scripts End Time
#---------------------
Write-Host "---------------------------" -ForegroundColor Green
Write-Host "Script Ended at $(get-date)" -ForegroundColor Green
Start-Sleep -s 1

#-------------------
# Garbage Collection
#-------------------
Start-Sleep -s 1
[GC]::Collect()

$ScriptRunTime = Get-ElapsedTime $script:startTime
$ts = New-TimeSpan -Seconds $ScriptRunTime
$RunTime = "{0:00}:{1:00}:{2:00}" -f $ts.Hours,$ts.Minutes,$ts.Seconds
Write-Host "Total Script Run Time: [$RunTime]" -ForegroundColor Green

# Clean Up Variables
#-------------------
$LogDate = $null
$LogTime = $null
$r_Date = $null
$r_Time = $null
$RunTime = $null
$ts = $null
$ScriptRunTime = $null
$script:startTime = $null
$r = $null
