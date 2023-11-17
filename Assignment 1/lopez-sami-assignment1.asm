# Samantha Lopez-Montano
# Assembly 9-18-2023
# Program: Assignment 1

.text
main:
# display greeting
li $v0,4		# service from kernel to print string
la $a0,greeting	# load the memory location of greeting into registers
syscall		# invoke the kernel to perform an action (print string)

# display prompt
li $v0,4		# service from kernel to print string
la $a0,prompt1	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)

# read string input save in input label
li $v0,8		# service for string input
la $a0,input	# setting string into a0 for entered string for syscall to understand/use
lw $a1,inputSize	# setting string max size into a1 for syscall to understand/use
syscall 		

# display prompt
li $v0,4		# service from kernel to print string
la $a0,prompt2	# load the memory location of prompt into registers
syscall		# invoke the kernel to perform an action (print string)

# read integer from user
li $v0, 5 	# service for integer input
syscall		# executes service and places integer input into $v0
move $t0, $v0	# moves input to not be overwritten later

# display confirmation output
li $v0,4		# service from kernel to print string
la $a0,output1	
syscall		# invoke the kernel to perform an action (print string)

li $v0,4		# service from kernel to print string
la $a0,input	# load the memory location of user input into registers
syscall		# invoke the kernel to perform an action (print string)

li $v0,4		# service from kernel to print string
la $a0,output2	
syscall		# invoke the kernel to perform an action (print string)

li $v0,1		# service from kernel to print integer
move $a0,$t0	# load user inputted integer into register
syscall		# invoke the kernel to perform an action (print integer)

li $v0,4		# service from kernel to print string
la $a0,output3	
syscall		# invoke the kernel to perform an action (print string)

# display farewell
li $v0,4		# service from kernel to print string
la $a0,farewell	# load the memory location of farewell into registers
syscall		# invoke the kernel to perform an action (print string)

# exit program cleanly
li $v0,10	# service from kernel to exit program
syscall		# inside the kernel

.data
greeting: .asciiz "Welcome.\n"
input: .space 81	
inputSize: .word 80
prompt1: .asciiz "What is your favorite food? "
prompt2: .asciiz "How many times a week do you eat your favorite food? "
output1: .asciiz "\nYour favorite food is "
output2: .asciiz "and you eat it "
output3: .asciiz " times a week."
farewell: .asciiz "\n\nGoodbye!"