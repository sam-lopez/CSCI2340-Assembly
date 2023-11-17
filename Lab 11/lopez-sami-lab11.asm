# Samantha Lopez-Montano
# 11-3-2023
# Program: Lab 11

.text
main:
# load labels into registers a0-a3
lw $a0, g
lw $a1, h
lw $a2, i
lw $a3, x

# load labels into stack registers s0-s2
lw $s0, test
lw $s1, test2
lw $s2, test3

# call procedure
jal sum_proc

# print return value (sum = $v0)
la $a0, return
move $a1, $v0	# move returned value from procedure to be passed to print 
jal PrintInt
jal PrintNewLine

# print s0
la $a0, s0
move $a1, $s0
jal PrintInt
jal PrintNewLine

# print s1
la $a0, s1
move $a1, $s1
jal PrintInt
jal PrintNewLine

# print s2
la $a0, s2
move $a1, $s2
jal PrintInt
jal PrintNewLine

# clean exit
j Exit

.data
g: .word 10
h: .word 15
i: .word 3
x: .word 2
test: .word 56
test2: .word 78
test3: .word 91
return: .asciiz "Returned value = "
s0: .asciiz "s0 = "
s1: .asciiz "s1 = "
s2: .asciiz "s2 = "
.include "lopez-sami-utils.asm"


#####################################################
# Function: sum_proc - calculates the sum of f and k
#           f = g+h
#           k = (i+x)*2
#           sum = f+k
# Parameters:
# $a0 - label g
# $a1 - label h
# $a2 - label i
# $a3 - label x
# Returns
# $v0 - sum (f+k)
######################################################
.text
sum_proc:
	# push the value test (56) onto the stack - push($s0)
	addi $sp , $sp, -4
	sw $s0, 0($sp)
	# push the value test2 (78) onto the stack - push($s1)
	addi $sp , $sp, -4
	sw $s1, 0($sp)
	# push the value test3 (91) onto the stack - push($s2)
	addi $sp , $sp, -4
	sw $s2, 0($sp)

	# over write with values for calculations
	add $s0, $a0, $a1 # f = s0 = g + h
	
	add $s1, $a2, $a3 # s1 = i + x
	mul $s1, $s1, 2  # k = s1 = (i + x)*2
	
	add $s2, $s0, $s1 # sum = s2 = f + k
	# move sum to return value
	move $v0, $s2
	
	# Grab values from stack to put in s0-s2 after being overwritten
	# stack pointing at last in (LIFO)
	# pop value test3 (91) from stack - pop()
	lw $s2, 0($sp)
	addi $sp, $sp, 4
	# pop value test2 (78) from stack - pop()
	lw $s1, 0($sp)
	addi $sp, $sp, 4
	# pop value test (56) from stack - pop()
	lw $s0, 0($sp)
	addi $sp, $sp, 4
jr $ra	# return to main
