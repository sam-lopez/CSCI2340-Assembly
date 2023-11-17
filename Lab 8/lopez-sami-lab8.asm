# Samantha Lopez-Montano
# Program: Lab 8
# 10-16-23

.text
main:
# prompt
la $a0, prompt
jal PromptInt
# store k in $s0
move $s0, $v0

# if-else statements
b k_check0
b end_if
# k = 0 then a = b+c (a = 15)
k_check0:
	seq $t1, $s0, 0
	beqz $t1, k_check1
	lw $t2, b
	lw $t3, c
	add $t4, $t2, $t3
	sw $t4, a
	b end_if
# k = 1 then a = d+e (a = 16)
k_check1:
	seq $t1, $s0, 1
	beqz $t1, k_check2
	lw $t2, d
	lw $t3, e
	add $t4, $t2, $t3
	sw $t4, a
	b end_if
# k = 2 then a = d-e (a = 2)
k_check2:
	seq $t1, $s0, 2
	beqz $t1, k_check3
	lw $t2, d
	lw $t3, e
	sub $t4, $t2, $t3
	sw $t4, a
	b end_if
# k = 3 then b-c (a = 5)
k_check3:
	seq $t1, $s0, 3
	beqz $t1, else
	lw $t2, b
	lw $t3, c
	sub $t4, $t2, $t3
	sw $t4, a
	b end_if
else:
	b end_if
	
end_if:
	# print output
	la $a0, output
	lw $a1, a
	jal PrintInt

# exit cleanly
j Exit

.data
a: .word 0
b: .word 10
c: .word 5
d: .word 9
e: .word 7
prompt: .asciiz "Please enter a value for k: "
output: .asciiz "The value of a is: "
.include "lopez-sami-utils.asm"
