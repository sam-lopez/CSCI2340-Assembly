# Samantha Lopez-Montano
# Assembly 9-18-2023
# Program: Lab 5

# Pseudo Code:
# load kernel with string service, load prompt into register, invoke kernel to perform print action
# load kernel with integer service, invoke kernel to read integer, move integer to a temporary register
# invoke shift right logical of the temporary register w/ shift amount 3 (where 2^3=8)
# load kernel with string service, load output1 into register, invoke kernel to perform print action
# load kernel with integer printing service, move result value into register, invoke kernel to perform print action

# load kernel with string service, load prompt into register, invoke kernel to perform print action
# load kernel with integer service, invoke kernel to read integer, move integer to a temporary register
#invoke shift left logical of the temporary register w/ shift amount 2 (where 2^2=4)
# load kernel with string service, load output2 into register, invoke kernel to perform print action
# load kernel with integer printing service, move result value into register, invoke kernel to perform print action
# exit cleanly

.text
main:
# display prompt first value
li $v0,4		# service from kernel to print string
la $a0,prompt1	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# read integer from user
li $v0, 5 	# service for integer input
syscall		# executes service and places integer input into $v0
move $t0, $v0	# moves input to not be overwritten later

# calculate input/8 
srl $s0,$t0, 3	# uses shift right to simulate division

# display output value
li $v0,4		# service from kernel to print string
la $a0,output1	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# display result value
li $v0,1		# service from kernel to print integer
move $a0,$s0	# load result integer into register
syscall		# invoke the kernel to perform an action (print integer)


# display prompt second value
li $v0,4		# service from kernel to print string
la $a0,prompt2	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# read integer from user
li $v0, 5 	# service for integer input
syscall		# executes service and places integer input into $v0
move $t1, $v0	# moves input to not be overwritten later

# calculate input*4 
sll $s1,$t1, 2	# uses shift left to simulate multiplication

# display output value
li $v0,4		# service from kernel to print string
la $a0,output2	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# display result value
li $v0,1		# service from kernel to print integer
move $a0,$s1	# load result integer into register
syscall		# invoke the kernel to perform an action (print integer)


# exit program cleanly
li $v0,10	# service from kernel to exit program
syscall		# inside the kernel

.data
prompt1: .asciiz "Please enter the number to divide by 8: "
output1: .asciiz "That number divided by 8 is "
prompt2: .asciiz "\nPlease enter the number to multiply by 4: "
output2: .asciiz "That number multiplied by 4 is "
