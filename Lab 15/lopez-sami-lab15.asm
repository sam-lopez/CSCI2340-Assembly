# Samantha Lopez-Montano
# 11-27-23
# Program: Lab 15

# Pseudo Code:
# int numhours = input("Please enter the number of hours: ")
# calcExp(int numhours):
#	numhours = float(numhours)
#	expenses = numhours * hourlyRate
#	expenses += constantExpense
# 	return expenses
# print("The total expenses are " + expenses + ".")

.text
main:
	# prompt the user for number of hours
	la $a0, prompt
	jal PromptInt
	move $s0, $v0	# move inputted integer into register to be used later
	
	# call procedure to calculate expenses
	move $a0, $s0 	# load hours into param
	jal calcExp
	swc1 $f0, expenses	# store the returned expense into memory
	
	# print the output and the final total expense
	la $a0, output
	jal PrintString
	
	lwc1 $f0, expenses	# load floating point from memory into param
	jal PrintFloat
	
	la $a0, period
	jal PrintString
	
	# clean exit
	j Exit
.data
prompt: .asciiz "Please enter the number of hours: "
output: .asciiz "The total expenses are "
expenses: .float 0.0
period: .asciiz ". "
.include "lopez-sami-utils.asm"

#####################################################
# Function: calcExp - to 
# Parameters:
# $a0 - number of hours (int)
# Returns
# $f0 - total expenses (float)
######################################################
.text
calcExp:
	# convert using mtc1 rs, ft
	mtc1 $a0, $f1	# copy data from gp register rs to fp register ft
	cvt.s.w $f1, $f1 	# convert from word to single precision
	# load the variables from memory to floating point registers
	#    $f1 - number of hours
	lwc1 $f2, hourlyRate	# load 
	lwc1 $f3, constantExpense	# load word from register/memory to register

	# multiply hourly rate by number of hours
	mul.s $f0, $f1, $f2	# $f0 = #_of_hrs * 10.5
	# add constant expense
	add.s $f0, $f0, $f3	# $f0 += 315.30
	jr $ra
.data
hourlyRate: .float 10.5
constantExpense: .float 315.30