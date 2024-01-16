# Samantha Lopez-Montano
# Program: Lab 17
# 12-6-23

# k = prompt("Please enter a value for k:");
# switch (k) {
#	case 0:
#		a = b + c;
#	break;
#	case 1:
#		a = d + e;
#	break;
#	case 2:
#		a = d – e;
#	break;
#	case 3:
#		a = b – c;
#	break;
#	default:
#		a = 0;
#	break;
#}
# print("The value of a is: " + a); 

.text
main:
# prompt
la $a0, prompt
jal PromptInt
# store k in $s1
move $s1, $v0

# Default for less than zero
bltz $s1, default
# Default for greater than 3 
bgt $s1, 3, default

# Load address of jumptable 
la $s3, jumptable  
# Compute word offset using sll or mul
#sll $t0, $s1, 2  
mul $t0,$s1,4
# Compute word offset into the jumptable
add $t1, $s3, $t0     
#Load a  a pointer into jumptable 
lw $t2, 0($t1) 
# Jump to the location in the jumptable 
jr $t2 

# Jump to specific case "switch" 
case0:	# k = 0 then a = b+c (a = 15)
	lw $t2, b
	lw $t3, c
	add $t4, $t2, $t3
	sw $t4, a
b end_case 

case1:	# k = 1 then a = d+e (a = 16)
	lw $t2, d
	lw $t3, e
	add $t4, $t2, $t3
	sw $t4, a
b end_case 

case2:	# k = 2 then a = d-e (a = 2)
	lw $t2, d
	lw $t3, e
	sub $t4, $t2, $t3
	sw $t4, a
b end_case 

case3:	# k = 3 then b-c (a = 5)
	lw $t2, b
	lw $t3, c
	sub $t4, $t2, $t3
	sw $t4, a
b end_case

default:	# k = anything else (a = 0)
	li $t4, 0
	sw $t4, a

end_case: 
# print output
	la $a0, output
	lw $a1, a
	jal PrintInt

# clean exit
j Exit

.data
a: .word 0
b: .word 10
c: .word 5
d: .word 9
e: .word 7
prompt: .asciiz "Please enter a value for k: "
output: .asciiz "The value of a is: "
.align   2 
jumptable: .word   case0, case1, case2, case3, default
.include "lopez-sami-utils.asm"
