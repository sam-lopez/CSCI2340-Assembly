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
# $v0 - integer value
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

