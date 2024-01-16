# Samantha Lopez-Montano
# Assembly 10-4-2023 
# Assignment: Lab 6

.text
main:
# call Hello
jal Hello

# call PrintNewLine
jal PrintNewLine

# call Goodbye
jal Goodbye

# jump to exit
j exit

#########################################
# PrintNewLine: prints "\n"
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
PrintNewLine:
	li $v0,4		# load string service
	la $a0,__PNL_newline	# load \n to be printed
	syscall 
jr $ra

.data
__PNL_newline: .asciiz "\n"

#########################################
# Hello: Says "Hello World"
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
Hello:
	li $v0,4		# load string service
	la $a0,greeting		# load hello world to be printed
	syscall
jr $ra
.data
greeting: .asciiz "Hello World"
#########################################
# Goodbye: Says "Goodbye!"
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
Goodbye:
	li $v0,4		# load string service
	la $a0, farewell	# load goodbye to be printed
	syscall
jr $ra
.data
farewell: .asciiz "Goodbye!"
#########################################
# exit:  cleanly exits program
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
exit:
	li $v0,10
	syscall
