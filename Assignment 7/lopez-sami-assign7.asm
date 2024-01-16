# Samantha Lopez-Montano
# 12-4-23
# Program: Assignment 7

# sadly I spent hours trying to debug why I could not use lb with the labels in the 
# data section after copying and pasting them
# Symbol "AddOp" not found in symbol table.
# was the error with each of the labels and the fix was making them all camelCase 
# not sure if it is specific to using MARS-UCA or what the error originated from

# did not have time to complete bonus question before the deadline, however I will attempt 
# it later on

.text
.globl main
main:
	# Ask the user for the first floating point number.
	la $a0, prompt1
	jal PromptFloat
	mov.s $f20, $f0	# save first float

	# Ask the user for the operator (+,-,*,/,&)
	la $a0, prompt2
	jal PromptCharacter
	sb $v0, inputOp # save operator 

	# If the operator & was entered, exit the program.
	lb $t2,quitOp	# load operater for quitting
	lb $t3, inputOp	# load input operator
	b quit_check
	quit_check:
		seq $t1, $t2, $t3	# op == &  true then $t1 = 1
		bnez $t1, exit_main	# if $t1 != false (0) then exit main loop

	# Ask the user for the second operator.
	la $a0, prompt3
	jal PromptFloat
	mov.s $f22, $f0	# save second float

	# Determine the appropriate procedure to call based on the operator entered.	
	# If any value other than the following operator were entered, 
	#	print a message that the user entered an invalid operator.
	lb $t2, addOp	# load plus sign
	lb $t3, inputOp	# load input operator
	b op_check1
	
	op_check1: # check +
		seq $t1, $t2, $t3	# op == +  true then $t1 = 1
		beqz $t1, op_check2	# if not operator check next one
		mov.s $f12, $f20	# load first input $f20
		mov.s $f13, $f22	# load second input $f22
		jal addCalc
		mov.s $f24, $f0	# save total to $f24
		b end_if
	op_check2: # check -
		lb $t2, subOp	# load minus sign
		seq $t1, $t2, $t3	# op == -  true then $t1 = 1
		beqz $t1, op_check3	# if not operator check next one
		mov.s $f12, $f20	# load first input $f20
		mov.s $f13, $f22	# load second input $f22
		jal subCalc
		mov.s $f24, $f0	# save total to $f24
		b end_if
	op_check3: # check *
		lb $t2, mulOp	# load multiplication sign
		seq $t1, $t2, $t3	# op == *  true then $t1 = 1
		beqz $t1, op_check4	# if not operator check next one
		mov.s $f12, $f20	# load first input $f20
		mov.s $f13, $f22	# load second input $f22
		jal mulCalc
		mov.s $f24, $f0	# save total to $f24
		b end_if
	op_check4: # check /
		lb $t2, divOp	# load division sign
		seq $t1, $t2, $t3	# op == /  true then $t1 = 1
		beqz $t1, else	# if not operators invalid check
		mov.s $f12, $f20	# load first input $f20
		mov.s $f13, $f22	# load second input $f22
		jal divCalc
		mov.s $f24, $f0	# save total to $f24
		b end_if
	else:	# invalid operator display message
		la $a0, invalid
		jal PrintString
		j main
	end_if:
	# Print the result to the console.
	la $a0, outres # load string result
	jal PrintString
	mov.s $f12, $f24	# load total to param
	jal PrintFloat
	jal PrintNewLine
	
	# Loop back to ask the user for the next operator.
	j main
	
exit_main:
	# print goodbye
	la $a0, goodbye
	jal PrintString
	# clean exit
	j Exit

.data
prompt1: .asciiz "Enter First Float: "
prompt2: .asciiz "Enter Operator: "
prompt3: .asciiz "\nEnter Second Float: "
outres: .asciiz "Result = "
invalid: .asciiz "Invalid operator was entered. \n"
goodbye: .asciiz "\nGoodbye."
addOp: .byte '+'
subOp: .byte '-'
mulOp: .byte '*'
divOp: .byte '/'
quitOp: .byte '&'
powOp: .byte '^'
inputSize: .word 1
inputOp: .space 2
.include "lopez-sami-utils.asm"

#####################################################
# Function: addCalc - Calculates adding two floats
#	returns sum
# Parameters:
# $f12 - first input
# $f13 - second input
# Returns
# $f0 - return value
######################################################
.text
addCalc:
	add.s $f0, $f12, $f13	# $f0 = $f12 + $f13
	# return value $f0 contains sum
jr $ra

#####################################################
# Function: subCalc - Calculates subtracting two floats
#	returns total
# Parameters:
# $f12 - first input
# $f13 - second input
# Returns
# $f0 - return value
######################################################
.text
subCalc:
	sub.s $f0, $f12, $f13	# $f0 = $f12 - $f13
	# return value $f0 contains total
jr $ra

#####################################################
# Function: mulCalc - Calculates multuplying two floats
#	returns total
# Parameters:
# $f12 - first input
# $f13 - second input
# Returns
# $f0 - return value
######################################################
.text
mulCalc:
	mul.s $f0, $f12, $f13	# $f0 = $f12 * $f13
	# return value $f0 contains total
jr $ra

#####################################################
# Function: divCalc - Calculates dividing two floats
#	returns total
# Parameters:
# $f12 - first input
# $f13 - second input
# Returns
# $f0 - return value
######################################################
.text
divCalc:
	div.s $f0, $f12, $f13	# $f0 = $f12 / $f13
	# return value $f0 contains total
jr $ra

#####################################################
# Function: powCalc - Calculates power of two floats
#	returns total
# Parameters:
# $f12 - first input
# $f13 - second input
# Returns
# $f0 - return value
######################################################
.text
powCalc:
	# loop as many times as second float
	li $t0, 0              # index of array
	#la $t1, $f13              # size of the arrays
	# need to convert then also figure out how to get decimal portion ?
	loop:
		bge $t0,$t1,end_loop
        
		# multiply first input by itself	
		mul.s $f4, $f12, $f12	# $f0 = $f12 * $f12
		
		#End of for loop here
    		addi $t0,$t0,1
	    	j loop
	end_loop:
		# return value $f0 contains total
		mov.s $f0, $f4
jr $ra
