#####################################################
# Function: Exit - exit the program
# Parameters:
# None
# Returns
# None
######################################################
.text
Exit:
    li $v0, 10
    syscall

#####################################################
# Function: PrintNewLine - prints a new line
# Parameters:
# None
# Returns
# None
######################################################
.text
PrintNewLine:
   li $v0, 4
   la $a0, __PNL_newline
   syscall
   jr $ra
.data
   __PNL_newline: .asciiz "\n"

#####################################################
# Function: PrintInt - prints a label and an integer
# Parameters:
# $a0 label to print
# $a1 integer to print
# Returns
# None
######################################################
.text 
PrintInt:   
	# Print string. The string address is already in $a0 
	li $v0, 4
	syscall
	# Print integer. The integer value is in $a1, and 
	# must # be first moved to $a0.
	move $a0, $a1
	li $v0, 1
	syscall
	#return
jr $ra

#####################################################
# Function: PromptInt - prints a label and prompts for
#           an integer
# Parameters:
# $a0 - label to print
# Returns
# $v0 - integer entered
######################################################
.text
PromptInt:
	# Print the prompt, which is already in $a0
	li $v0, 4
	syscall
	# Read the integer value.  Note that at the end of the
	# syscall the value is already in $v0, so there is no
	# need to move it anywhere.
	move $a0, $a1
	li $v0, 5
	syscall
	#return
jr $ra


#####################################################
# Function: PromptString - prints a label and prompts for
#           a string
# Parameters:
# $a0 - label to print
# $a1 - size of string
# $a2 - label of string 
# Returns
# none
######################################################
.text
PromptString:
	# Print the prompt, which is already in $a0
	li $v0, 4
	syscall
	# Read the string value.  Note that at the end of the
	# syscall the value is already in label inputStr, so there is no
	# need to move it anywhere.
	move $a0, $a2
	li $v0, 8
	syscall
	#return
jr $ra

#####################################################
# Function: PrintString - prints a string
# Parameters:
# $a0 - string to print
# Returns
# None
######################################################
.text
PrintString:	
	addi $v0, $zero, 4
	syscall
	jr $ra

#####################################################
# Function: PromptCharacter - prints a label and prompts for
#           a character
# Parameters:
# $a0 - label to print
# Returns
# $v0 - character entered
######################################################
.text
PromptCharacter:
	# Print the prompt, which is already in $a0
	li $v0, 4
	syscall
	# Read the character value.  Note that at the end of the
	# syscall the value needs to be saved in $v0
	li $v0, 12
	syscall
	addiu $v0, $v0, 0  # $v0 gets the next char
	#return
jr $ra

#####################################################
# Function: PrintCharacter - prints a character
# Parameters:
# $a0 - character to print
# Returns
# None
######################################################
.text
PrintCharacter:	
	li $v0, 11       
	syscall
jr $ra
  