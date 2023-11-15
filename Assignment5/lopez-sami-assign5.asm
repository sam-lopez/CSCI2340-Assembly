# Samantha Lopez-Montano
# 11-15-2023
# Program: Assignment 5

.text
main:
	# call min procedure
	la $a0, A	# load location of array into parameter 
	lw $a1, size	# size of the array loaded into parameter
	jal Minimum	
	move $s2, $v0 # save minimum value to $s2 to be used later
		
	# call max procedure
	la $a0, A	# load location of array into parameter 
	lw $a1, size	# size of the array loaded into parameter
	jal Maximum	# inside using $t6 as temp max
	move $s3, $v0 # save minimum value to $s3 to be used later
		
	# call sum procedure
	la $a0, A	# load location of array into parameter 
	lw $a1, size	# size of the array loaded into parameter
	jal Sum
	move $s4, $v0 # save sum value to $s4 to be used later
	
	# call avg procedure
	move $a0, $s4	# load sum into parameter
	lw $a1, size	# size of the array loaded into parameter
	
	# Print outputs
	la $a0, outMin
	move $a1,$s2	# Set up parameter for printing min
	jal PrintInt
	jal PrintNewLine
		
	la $a0, outMax
	move $a1,$s3	# Set up parameter for printing max
	jal PrintInt
	jal PrintNewLine
		
	la $a0, outSum
	move $a1,$s4	# Set up parameter for printing sum
	jal PrintInt
	jal PrintNewLine
		
	la $a0, outAvg
	move $a1,$s5	# Set up parameter for printing avg
	jal PrintInt
	jal PrintNewLine
		
	# clean exit
	jal Exit
.data
A: .word 11, 250, 20, 70, 60, 140,150, 80, 90,100, 1, 30, 40,120,130, 5
#B: .space
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
element: .asciiz "\nCurrent value: "
.include "lopez-sami-utils.asm"

#####################################################
# Function: Minimum - compares current value to current minimum value
# Parameters:
# $a0 - array location
# $a1 - array size
# Returns
# $v0 - value of minimum
######################################################
.text
Minimum:
	li $t0, 0        # start index of array at 0
	# Loop through the array
	start_loop:
	
		# Check if at end of array
		bge $t0,$a1,exit_loop	# if index >= size exit
		
		# grab the element from the array
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array
		lw $v0,($t2)           # load the value in array[index] into $v0 to return
		move $t1, $v0	# save element into $t1 to use for logic
		
		beqz $a1, setMin # if index == 0 branch to setMin
		move $v0, $a0	# if index=0 set minimum ($t7) to first array value
		checkMin:	# if index!=0 then check
			blt $a0,$v0, setMin	# if value < minValue branch to setMin
			addi $t0,$t0,1
		    	j start_loop
		setMin:
			move $v0, $a0
		# End of for loop here
    		addi $t0,$t0,1
	    	j start_loop
	exit_loop:
		jr $ra

#####################################################
# Function: Maximum - compares current value to current maximum value
# Parameters:
# $a0 - current array value
# $a1 - current index value
# Returns
# $v0 - value of current maximum
######################################################
.text
Maximum:
	li $t0, 0        # start index of array at 0
	# Loop through the array
	start_loop:
	
		# Check if at end of array
		bge $t0,$a1,exit_loop	# if index >= size exit
		
		# grab the element from the array
		li $t2,0               # initialize postion in the array
       		mul $t2,$t0,4          # calculate how far into array to go (index*4)
        		add $t2,$t2,$a0        # set memory location of element in the array
		lw $v0,($t2)           # load the value in array[index] into $v0 to return
		move $t1, $v0	# save element into $t1 to use for logic
		
		beqz $a1, setMin # if index == 0 branch to setMin
		move $v0, $a0	# if index=0 set minimum ($t7) to first array value
		checkMin:	# if index!=0 then check
			blt $a0,$v0, setMin	# if value < minValue branch to setMin
			addi $t0,$t0,1
		    	j start_loop
		setMin:
			move $v0, $a0
		# End of for loop here
    		addi $t0,$t0,1
	    	j start_loop
	exit_loop:
		jr $ra

# orig using outer loop
	bnez $a1, checkMax # if index != 0 branch to checkMax
	move $t6, $a0	# if index=0 set maximum ($t6) to first array value
	move $v0, $t6
	jr $ra
	checkMax:	# if index!=0 then check
		bgt $a0,$t6, setMax	# if value > maxMValue branch to setMax
		move $v0, $t6
		jr $ra
	setMax:
		move $t6, $a0
		move $v0, $t6
    jr $ra

#####################################################
# Function: Sum - add
# Parameters:
# $a0 - current array value
# $a1 - current index value
# Returns
# $v0 - value of current maximum
######################################################
.text
Sum:

	# get the first element in the array
#	move $a0, $s0	# load array location into parameter for grabbing elements
#	li $a1, 0	# load index into parameter for grabbing elements
#	jal GetElement
#	move $s2, $v0	# save first element into $s2 for later use

	# get the last element in the array
#	move $a0, $s0	# load array location into parameter for grabbing elements
#	lw $a1, size	# load size of array
#	subi $a1, 1	#  (size-1 = 15) is last index
#	jal GetElement
#	move $s3, $v0	# save last element into $s3 for later use