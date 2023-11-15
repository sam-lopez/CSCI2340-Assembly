# Samantha Lopez-Montano
# 11-15-2023
# Program: Assignment 5

.text
main:
	# call min procedure
	la $a0, A	# load location of array into parameter 
	lw $a1, size	# size of the array loaded into parameter
	jal Minimum	# returns min in $v0
	sw $v0, min	# saves min to be used later
	# Print outputs
	la $a0, outMin
	lw $a1, min	# Set up parameter for printing min
	jal PrintInt
	jal PrintNewLine
	
	# call max procedure
	la $a0, A	# load location of array into parameter 
	lw $a1, size	# size of the array loaded into parameter
	jal Maximum	# returns max in $v0
	sw $v0, max	# saves max to be used later
	# Print outputs
	la $a0, outMax
	lw $a1, max	# Set up parameter for printing max
	jal PrintInt
	jal PrintNewLine
		
	# call sum procedure
	la $a0, A	# load location of array into parameter 
	lw $a1, size	# size of the array loaded into parameter
	jal Sum		# returns sum in $v0
	sw $v0, sum	# saves sum to be used later
	# Print outputs
	la $a0, outSum
	lw $a1, sum	# Set up parameter for printing sum
	jal PrintInt
	jal PrintNewLine
	
	# call avg procedure
	lw $a0, sum	# load sum into parameter
	lw $a1, size	# size of the array loaded into parameter
	jal Average	# returns avg in $v0
	sw $v0, average	# saves avg to be used later
	# Print outputs	
	la $a0, outAvg
	lw $a1, average	# Set up parameter for printing avg
	jal PrintInt
	jal PrintNewLine
	
	# call reverseArray procedure
	la $a0, A
	la $a1, B
	lw $a2, size
	jal reverseArray
	# Print output
	la $a0, outRev
	jal PrintString
	la $a0, B	# load address of array B into $a0
	lw $a1, size	# load size of array into $a1
	# loop through array
	li $t0, 0        # start index of array at 0
	# Loop through the array
	start_loop:
		# Check if at end of array
		bge $t0,$a1, exit_loop	# if index >= size exit
		
		# grab the element from the array
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array
		lw $t1,($t2)           # load the value in array[index] into $t1 to use for printing
		
		# Print integer. The integer value is in $a1, and 
		# must # be first moved to $a0.
		move $a0, $t1	# Set up parameter for printing reversed array element
		li $v0, 1
		syscall
		
		# load comma to print
		la $a0, outComma
		jal PrintString
		
		# End of for loop here
    		addi $t0,$t0,1	# increments index
	    	j start_loop	# goes back to start of loop
	exit_loop:
		
		
	# clean exit
	jal Exit
.data
A: .word 11, 250, 20, 70, 60, 140,150, 80, 90,100, 1, 30, 40,120,130, 5
B: .space 64 # length of array * 4 = 16*4
size: .word 16 # length of array A & B
min: .word 0
max: .word 0
sum: .word 0
average: .word 0
largestInt: .word 2147483647 # You may want to use this for min procedure
outMin: .asciiz "The minimum is "
outMax: .asciiz "The maximum is "
outSum: .asciiz "The sum is "
outAvg: .asciiz "The average is "
outRev: .asciiz "The reversed array is: "
outComma: .asciiz " , "
.include "lopez-sami-utils.asm"

#####################################################
# Function: Minimum - finds minimum value in given array
# Parameters:
# $a0 - array location
# $a1 - array size
# Returns
# $v0 - value of minimum
######################################################
.text
Minimum:
	li $t0, 0        # start index of array at 0
	li $t7, 0        # start min at 0
	# Loop through the array
	start_minloop:
	
		# Check if at end of array
		bge $t0,$a1, exit_minloop	# if index >= size exit
		
		# grab the element from the array
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array
		lw $t1,($t2)           # load the value in array[index] into $t1 to use for logic
		
		beqz $t0, setMin # if index == 0 branch to setMin
		checkMin:	# if index!=0 then check
			blt $t1,$t7, setMin	# if value < minValue branch to setMin
			addi $t0,$t0,1		# increments index
		    	j start_minloop		# goes back to start of loop
		setMin:
			move $t7, $t1
		# End of for loop here
    		addi $t0,$t0,1	# increments index
	    	j start_minloop	# goes back to start of loop
	exit_minloop:
		move $v0, $t7
		jr $ra

#####################################################
# Function: Maximum - finds maximum value in given array
# Parameters:
# $a0 - array location
# $a1 - array size
# Returns
# $v0 - value of maximum
######################################################
.text
Maximum:
	li $t0, 0        # start index of array at 0
	li $t7, 0        # start max at 0
	# Loop through the array
	start_maxloop:
	
		# Check if at end of array
		bge $t0,$a1, exit_maxloop	# if index >= size exit
		
		# grab the element from the array
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array
		lw $t1,($t2)           # load the value in array[index] into $t1 to use for logic
		
		beqz $t0, setMax # if index == 0 branch to setMin
		checkMax:	# if index!=0 then check
			bgt $t1,$t7, setMax	# if value > maxValue branch to setMax
			addi $t0,$t0,1		# increments index
		    	j start_maxloop		# goes back to start of loop
		setMax:
			move $t7, $t1
		# End of for loop here
    		addi $t0,$t0,1	# increments index
	    	j start_maxloop	# goes back to start of loop
	exit_maxloop:
		move $v0, $t7
		jr $ra

#####################################################
# Function: Sum - add all values in array
# Parameters:
# $a0 - array location
# $a1 - array size
# Returns
# $v0 - value of sum
######################################################
.text
Sum:
	li $t0, 0        # start index of array at 0
	li $t7, 0        # start sum at 0
	# Loop through the array
	start_sumloop:
	
		# Check if at end of array
		bge $t0,$a1, exit_sumloop	# if index >= size exit
		
		# grab the element from the array
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array
		lw $t1,($t2)           # load the value in array[index] into $t1 to use for logic
		
		# add element to current sum $t7
		add $t7,$t7,$t1
		
		# End of for loop here
    		addi $t0,$t0,1	# increments index
	    	j start_sumloop	# goes back to start of loop
	exit_sumloop:
		move $v0, $t7	# move sum $t7 to return value
		jr $ra

#####################################################
# Function: Average - average of all values in array
# Parameters:
# $a0 - sum value
# $a1 - array size
# Returns
# $v0 - value of current maximum
######################################################
.text
Average:
	# avg = sum/size
	div $v0, $a0, $a1	# $v0 = $a0 / $a1
	jr $ra
	
#####################################################
# Function: reverseArray - reverses all values in givenarray
# Parameters:
# $a0 - array A location
# $a1 - array B location
# $a2 - array size
# Returns
# $v0 - value of current maximum
######################################################
.text
reverseArray:
	move $t0, $a2        	# start index of array at size
	subi $t0, $t0, 1		# subtract size by 1 to get last index of array A
	li $t7, 0		# start index of array B at 0
	# Loop through the array
	start_revloop:
	
		# Check if at end of array
		bltz $t0, exit_revloop	# if index < 0 exit
		
		# grab the element from the array A
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array A
		lw $t1,($t2)           # load the value in array[index] into $t1 to use for logic
		
		# put element into array B
		li $t6,0 	# initialize postion in the array
       		mul $t6,$t7,4	# calculate how far into array to go (index*4)
        		add $t6,$t6,$a1	# set memory location of element in the array B
		sw $t1, ($t6)	# store the value in A[index] into B[index]
		
		# End of for loop here
    		addi $t7,$t7,1	# increments index of Array B
 		subi $t0,$t0,1	# decrements index of Array A
	    	j start_revloop	# goes back to start of loop
	exit_revloop:
		jr $ra
