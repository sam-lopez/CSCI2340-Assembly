# Samantha Lopez-Montano
# 11-17-2023
# Program: Lab13

# Pseudocode:
# size = input("What is the size of the array to be created? ")
# new array = new array[size]
# seed(time)
# for (int i = 0; i < size; i++)
#	num = rand() + 100
# 	array[i] = num
# for (int i = 0; i < size; i++)
#	print("Element: "+ array[i] + "\n")

.text
main:
	# prompt user for array size
	la $a0, prompt
	jal PromptInt
	move $s0, $v0	# save user input into $s0 (array size)
	
	# call procedure to allocate array of inputted size
	move $a0, $s0	# put user input into parameter for size
	li $a1, 4	# load the number of bytes for each element (4 bytes = int)
	jal AllocateArray
	move $s1, $v0	# save array address
	
	# call procedure to create array of randomly generated numbers
	move $a0, $s1	# array address as parameter 1
	move $a1, $s0	# array size as parameter 2
	jal createArray
	
	# call procedure to print array with "Element: "
	move $a0, $s1	# array address as parameter 1
	move $a1, $s0	# array size as parameter 2
	jal PrintArray
	
	# clean exit
	j Exit
.data
prompt: .asciiz "What is the size of the array to be created? "
outE: .asciiz "Element: "
.include "lopez-sami-utils.asm"

#####################################################
# Function: AllocateArray - to allocate an array of $a0 values each of size $a1
# Parameters:
# $a0 - array size
# $a1 - array element size
# Returns
# $v0 - address of array allocated
######################################################
.text
AllocateArray:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	mul $a0, $a0, $a1
	li $v0, 9
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#####################################################
# Function: createArray - based on given size randomly generates array values for array
# Parameters:
# $a0 - array location
# $a1 - array size
# Returns
# none
######################################################
.text
createArray:
	addi $sp, $sp, -12       # Push stack
	sw $ra, 0($sp)		# store $ra
	sw $a0, 4($sp)		# store array address
	sw $a1, 8($sp)		# store array size
	
	# set the seed for random number generator
	# get the time for seed
	li $v0, 30	# syscall for getting time in ms
	syscall
	move $a1, $a0	# save the time for the set seed syscall
	li $a0, 123	# i.d. of psuedorandom number generator
	li $v0, 40	# syscall for set seed
	syscall
	
	# Restore array size, address, $ra
 	lw $a1, 8($sp)	# Pop stack restore array size
 	lw $a0, 4($sp)	# Pop stack restore array address
 	lw $ra, 0($sp)	# Pop stack restore $ra
	
	li $t0, 0	# start index of array at 0
	# Loop through the array
	start_cloop:
		addi $sp, $sp, -12       # Push stack
		sw $ra, 0($sp)		# store $ra
		sw $a0, 4($sp)		# store array address
		sw $a1, 8($sp)		# store array size
		# Check if at end of array
		bge $t0, $a1, exit_cloop	# if index >= size exit
		
		# randomly generate a number <= 100
		li $a0, 123	# i.d. of psuedorandom number generator
		li $a1, 100	# $a1 = 100
		li $v0, 42	# syscall for random int with upper range
		syscall
		move $t1, $a0	# save randomly generated number to $t1
		
		# Restore array size, address, $ra
 		lw $a1, 8($sp)	# Pop stack restore array size
 		lw $a0, 4($sp)	# Pop stack restore array address
 		lw $ra, 0($sp)	# Pop stack restore $r
		
		# put element into array
		li $t2,0 	# initialize postion in the array
       		mul $t2,$t0,4	# calculate how far into array to go (index*4)
        		add $t2,$t2,$a0	# set memory location of element in the array
		sw $t1, ($t2)	# store the value in $t1 into array[index]
		
		# End of for loop here
 		addi $t0,$t0,1	# increments index of Array A
 		j start_cloop	# goes back to start of loop
	exit_cloop:
		jr $ra
		
#####################################################
# Function: PrintArray - prints all values in given array
# in format:
# Element: #
# Parameters:
# $a0 - array location
# $a1 - array size
# Returns
# None
######################################################
.text
PrintArray:
	# save parameters to be restored 
	addi $sp, $sp, -12       # Push stack
	sw $ra, 0($sp)		# store $ra
	sw $a0, 4($sp)		# store array address
	sw $a1, 8($sp)		# store array size
	
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
		
		# load label to print
		la $a0, outE
		jal PrintString
		
		# Print integer. The integer value is in $a1, and # must 
		# be first moved to $a0.
		move $a0, $t1	# Set up parameter for printing reversed array element
		li $v0, 1
		syscall
		
		# print newline
		jal PrintNewLine
		
		# restore given parameters
		# Restore array size, address, $ra
 		lw $a1, 8($sp)	# Pop stack restore array size
 		lw $a0, 4($sp)	# Pop stack restore array address
 		lw $ra, 0($sp)	# Pop stack restore $ra

		# End of for loop here
    		addi $t0,$t0,1	# increments index
	    	j start_loop	# goes back to start of loop
	exit_loop:
		jr $ra
