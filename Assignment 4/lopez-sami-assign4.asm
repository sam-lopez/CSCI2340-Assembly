# Samantha Lopez-Montano
# Progam: Assignment 4
# 10-24-23

# Pseudocode: 
# sentinel = input("Please enter the edge length of the base of right triangle: ")
# while(sentinel > 0){
# 	for (counter = 0; counter < sentinel; counter++){
#		inner = counter + 1
#		while (inner > 0){
#			print("#")
#			inner--
#		print("\n")	
#		}
#	}
# sentinel = input("Please enter the edge length of the base of right triangle: ")
# }

.text
.globl main
main:
# while loop to keep program from exiting after one triangle has been set
# step 2: create label for start loop
start_loop:
	# step 1 & 5: set sentinel value ($s0)
	la $a0, prompt
	jal PromptInt
	move $s0, $v0
	# set parameter of ending condition of the for loop inside procedure
	move $a0, $v0 # $a0 - value counting up to (ending for loop) 
	
	# step 4: check the sentinel ($s0 > 0)
	sgt $t1, $s0, 0
	beqz $t1, end_loop
	
	# step 6: call procedure to print triangle
	jal printTriangle
	
	j start_loop
# step 3: create end loop
end_loop:
	# print end program
	la $a0, farewell
	move $a1, $s2
	jal PrintString
	j Exit

.data
prompt: .asciiz "Please enter the edge length of the base of right triangle: "
farewell: .asciiz "Exiting the program."
.include "lopez-sami-utils.asm"

#########################################
# Function: printTriangle
# Parameters:
#   $a0 - number for length of base of triangle 
# Return Values:
#   none
#########################################
.text
printTriangle:
	# Step 1: initialize counter ($s0) and ending condition ($s1)
	li $s0, 0 # counter
	move $s1, $a0 # $s1 - value counting up to (ending for loop)
	# initialize total
	li $s2, 0

	# create start label of outer loop
	start_floop:
		# Step 3: check condition ($s0 is counter, $s1 is ending condition)
		# $s0 < $s1
		sltu $t1, $s0, $s1
		beqz $t1, end_floop
		# Step 5: implement code block
		# create label for start while loop
		# set sentinel value $s4 to index of outer loop
		move $s4, $s0
		addi $s4, $s4, 1
		start_wloop:
			# check the sentinel ($s4 > 0)
			sgt $t1, $s4, 0
			beqz $t1, end_wloop
			# print triangle
			la $a0, triangle
			addi $v0, $zero, 4
			syscall
			# decrement sentinel
			subi $s4,$s4,1
		
			j start_wloop
		# step 3: create end while loop
		end_wloop:
		
		# print newline
		li $v0, 4
		la $a0, __PNL_newline
		syscall
		
		# Step 4: increment counter ($s0)
		addi $s0, $s0, 1
		j start_floop
	end_floop:
	 
jr $ra

.data
triangle: .asciiz "#"