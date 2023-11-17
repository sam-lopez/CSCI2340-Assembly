# Samantha Lopez-Montano
# Assembly 9-18-2023
# Program: Assignment 2

# Pseudo Code:
# load kernel with string service, load prompt into register, invoke kernel to perform print action
# load kernel with integer service, invoke kernel to read integer, move integer to a temporary register
# repeat for the three total values

# expression 1:
# calculate 5*x input, calculate 3*y input, calculate adding both results,
# calculate adding result with z input,
# calculate result/2 using srl,
# calculate result/3
# load kernel with string service, load output1 into register, invoke kernel to perform print action 
# load kernel with integer printing service, move result value into register, invoke kernel to perform print action

# expression 2: 
# calculate x*x, calculate x*x*x, calculate 2*(x*x), calculate 3*x,
# calculate x^3 + 2x^2 saving result,
# calculate result + 3x saving result,
# calculate result + 4
# load kernel with string service, load output2 into register, invoke kernel to perform print action 
# load kernel with integer printing service, move result value into register, invoke kernel to perform print action

# load kernel with string service, load farewell into register, invoke kernel to perform print action
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

# calculate expression 1: ((5x + 3y + z) / 2) * 3
mul $s0,$t0,5	# $s0 = x*5
mul $s1,$t1,3	# $s1 = y*3
add $t3, $s0, $s1	# $t3 = $s0 + $s1 (5x + 3y)
add $t4, $t2,$t3	# $t4 = z + $t3 (5x + 3y + z)
srl $s3,$t4,1	# $s3 = $t4 / 2 ((5x + 3y + z) / 2)
mul $s4,$s3,3	# $s4 = $s3 * 3 (((5x + 3y + z) / 2) * 3)

# display output value
li $v0,4		# service from kernel to print string
la $a0,output1	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# display expression 1 result value
li $v0,1		# service from kernel to print integer
move $a0,$s4	# load result integer into register
syscall		# invoke the kernel to perform an action (print integer)

# calculate expression 2: x^3 + 2x^2 + 3x + 4
mul $s0,$t0,$t0	# $s0 = $t0 * $t0 (x^2)
mul $s1,$s0,$t0	# $s1 = $s0 * $t0 (x^3)
mul $s2,$s0,2	# $s2 = $s0 * 2 (2 * x^2)
mul $s3,$t0,3	# $s3 = $t0 * 3 (3 * x)
add $s4,$s1,$s2	# $s4 = $s1 + $s2 (x^3 + 2x^2)
add $s5,$s4,$s3	# $s5 = $s4 + $s3 (x^3 + 2x^2 + 3x)
add $s6,$s5,4	# $s6 = $s5 + 4 (x^3 + 2x^2 + 3x + 4)

# display output value
li $v0,4		# service from kernel to print string
la $a0,output2	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)
# display expression 2 result value
li $v0,1		# service from kernel to print integer
move $a0,$s6	# load result integer into register
syscall		# invoke the kernel to perform an action (print integer)

# display farewell
li $v0,4		# service from kernel to print string
la $a0,farewell	# load the memory location of farewell into registers
syscall		# invoke the kernel to perform an action (print string)

# exit program cleanly
li $v0,10	# service from kernel to exit program
syscall		# inside the kernel

.data
prompt1: .asciiz "Enter a value for x: "
prompt2: .asciiz "Enter a value for y: "
prompt3: .asciiz "Enter a value for z: "
output1: .asciiz "The result for expression 1 is: "
output2: .asciiz "\nThe result for expression 2 is: "
farewell: .asciiz "\nGoodbye!"
