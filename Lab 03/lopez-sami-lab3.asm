# Samantha Lopez-Montano
# Assembly 9-8-2023 
# Program: Lab 3

.text
main:
li $v0,4		# service from kernel to print string
la $a0,greeting	# load the memory location of greeting into registers
syscall		# invoke the kernel to perform an action (print string)

li $v0,4		# service from kernel to print string
la $a0,farewell	# load the memory location of farewell into registers
syscall		# invoke the kernel to perform an action (print string)

li $v0,10	# service from kernel to exit program
syscall		# inside the kernel


.data
greeting: .asciiz "Hello World!\n"	# could have combined both labels in one as the newline would have separated it
farewell: .asciiz "Goodbye Cruel World!" # on the next line and shortened the lines of code necessary
