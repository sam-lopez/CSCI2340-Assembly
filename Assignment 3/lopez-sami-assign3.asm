# Samantha Lopez-Montano
# Assembly 10-11-2023
# Program: Assignment 3

.text
   .globl main
   main:
      # Print first message through subroutine
      la $a0, greeting
      jal printMsg
      jal printNewLine
      
      # Call subroutine to print prompt for user for an int
      la $a0, prompt
      jal getInt
      move $a0, $v0	# move retrun value to first parameter for next subroutine
      
      # Call subroutine to calculate the minutes
      jal calcMins
      move $a1, $v0	# move return value to second parameter for next subroutine
      
      # Print minutes with subroutine
      la $a0,outMin
      jal printInt
      jal printNewLine
      move $a0, $a1	# since \n replaced the a0, move the a1 value of the min to $a0
      
      # Call subroutine to calculate the hours
      jal calcHours
      move $a1, $v0
      
      # Print hours with subroutine
      la $a0,outHr
      jal printInt
      jal printNewLine
      
      # Print farewell with subroutine
      la $a0, farewell
      jal printMsg
      
      # Exit cleanly with subroutine
      j Exit
      
.data
greeting: .asciiz "Welcome to the time converter."
prompt: .asciiz "Enter the number of seconds: "
outMin: .asciiz "Number of minutes: "
outHr: .asciiz "Number of hours: "
farewell: .asciiz "Goodbye!"

#########################################
# Function: Exit
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
Exit:
li $v0,10
syscall

#########################################
# Function: printNewLine
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
printNewLine:
	li $v0,4
	la $a0,__PNL_newline
	syscall 
jr $ra

.data
__PNL_newline: .asciiz "\n"

#########################################
# Function: printInt
# Parameters:
#   $a0 - the address of the string to print
#   $a1 - the value of the integer to print
# Return Values:
#   none
#########################################
.text
printInt:
# print the prompt string in $a0
li $v0, 4
# $a0 already contains the prompt string location
syscall

# print the integer
li $v0, 1
move $a0, $a1
syscall

jr $ra

#########################################
# Function: printMsg
# Parameters:
#   $a0 - the address of the string to print
# Return Values:
#   none
#########################################
.text
printMsg:
li $v0, 4
# address already in $a0
syscall

jr $ra

#########################################
# Function: getInt
# Parameters:
#   $a0 - the address of the string to print
# Return Values:
#   $v0 - Integer that was entered
#########################################
.text
getInt:
# Print the prompt, which is already in $a0
li $v0, 4
syscall
# Read the integer value saving to $v0
move $a0, $a1
li $v0, 5
syscall
# return
jr $ra

#########################################
# Function: calcMins
# Parameters:
#   $a0 - the value of the seconds to calculate
# Return Values:
#   $v0 - the number of minutes
#########################################
.text
calcMins:
div $v0, $a0, 60
jr $ra

#########################################
# Function: calcHours
# Parameters:
#   $a0 - the value of the minutes to calculate
# Return Values:
#   $v0 - the number of hours
#########################################
.text
calcHours:
div $v0, $a0, 60
jr $ra
