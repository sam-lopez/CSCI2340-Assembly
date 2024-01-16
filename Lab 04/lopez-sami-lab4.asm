# Samantha Lopez-Montano
# Assembly 9-18-2023
# Program: Lab 4

# Pseudo Code:
# load kernel with string service, load prompt into register, invoke kernel to perform print action
# load kernel with integer service, invoke kernel to read integer, move integer to a temporary register
# repeat three times utilizing the respective labels
# add the first two inputted integers and save into register
# utilize saved addition to subtract the third value from it and save into another register
# load kernel to print string service, load result string into register, invoke kernel to perform print action
# load kernel with integer printing service, move result value into register, invoke kernel to perform print action
# exit cleanly

.text
main:
# display prompt first value
li $v0,4		# service from kernel to print string
la $a0,prompt1	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# read first integer from user
li $v0, 5 	# service for integer input
syscall		# executes service and places integer input into $v0
move $t0, $v0	# moves input to not be overwritten later

# display prompt second value
li $v0,4		# service from kernel to print string
la $a0,prompt2	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# read second integer from user
li $v0, 5 	# service for integer input
syscall		# executes service and places integer input into $v0
move $t1, $v0	# moves input to not be overwritten later

# display prompt third value
li $v0,4		# service from kernel to print string
la $a0,prompt3	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# read third integer from user
li $v0, 5 	# service for integer input
syscall		# executes service and places integer input into $v0
move $t2, $v0	# moves input to not be overwritten later

# calculate result
add $s0,$t0,$t1	# $s0 = $t0+$t1
subu $s1,$s0,$t2	# $s1 = $s0-$t2

# display result
li $v0,4		# service from kernel to print string
la $a0,output	# load the memory location of output into registers
syscall
li $v0,1		# service from kernel to print integer
move $a0,$s1	# load calculated result into register
syscall		# invoke the kernel to perform an action (print integer)

# exit program cleanly
li $v0,10	# service from kernel to exit program
syscall		# inside the kernel

.data
prompt1: .asciiz "Please enter the first value to add: "
prompt2: .asciiz "Please enter the second value to add: "
prompt3: .asciiz "Please enter the third value to subtract: "
output: .asciiz "The result is "