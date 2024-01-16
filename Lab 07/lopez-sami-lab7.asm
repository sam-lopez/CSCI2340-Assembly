# Samantha Lopez-Montano
# Assembly 10-11-2023
# Program: Lab 7

.text
# Write code to load x,y,z, and q 
# into registers $s0-$s3 with lw using labels
lw $s0, x
lw $s1, y
lw $s2, z
lw $s3, q

# Write the code to print the value
# in registers $s0-$s3
la $a0, prompt1
move $a1, $s0
jal printInt
      jal printNewLine
la $a0, prompt2
move $a1, $s1
jal printInt
      jal printNewLine
la $a0, prompt3
move $a1, $s2
jal printInt
      jal printNewLine
la $a0, prompt4
move $a1, $s3
jal printInt
      jal printNewLine
# Write code to load the 4 integers starting
# at label a using register indirect access 
# into registers $s0-$s3
# Make sure the memory location is always set 
# to point to the integer you want to load
# Example: 
# After loading the address into $t0
# use lw to load the value from the address
# lw $s0,($t0)
# After loading the value, you need to advance
# the memory pointer to point to the next integer
la $t0, a
# Access by register indirect (label a)
lw $s0,($t0)
# Increment address pointer by 4 (b)
addi $t0,$t0,4
lw $s1,($t0)
# Increment address pointer by 4 (c)
addi $t0,$t0,4
lw $s2,($t0)
# address pointer by 4 (d)
addi $t0,$t0,4
lw $s3,($t0)

# Write the code to print the value
# in registers $s0-$s3
la $a0, prompt1
move $a1, $s0
jal printInt
      jal printNewLine
la $a0, prompt2
move $a1, $s1
jal printInt
      jal printNewLine
la $a0, prompt3
move $a1, $s2
jal printInt
      jal printNewLine
la $a0, prompt4
move $a1, $s3
jal printInt
      jal printNewLine

# Write code to load the 4 integers starting
# at label e using register indirect plus offset access
# into registers $s0-$s3
# Example: 
# After loading the address into $t0
# use lw to load the value from the address
# Use the offset into the memory location to
# get to the correct address
# lw $s0,0($t0)
la $t0, e
# Access by offset = 0 (e)
lw $s0,0($t0)
# Access by offset = 4 (f)
lw $s1,4($t0)
# Access by offset = 8 (g)
lw $s2,8($t0)
# Access by offset = 12 (h)
lw $s3,12($t0)

# Write the code to print the value
# in registers $s0-$s3
la $a0, prompt1
move $a1, $s0
jal printInt
      jal printNewLine
la $a0, prompt2
move $a1, $s1
jal printInt
      jal printNewLine
la $a0, prompt3
move $a1, $s2
jal printInt
      jal printNewLine
la $a0, prompt4
move $a1, $s3
jal printInt

#Exit the program
j Exit

.data

x: .word 10
y: .word 15
z: .word 7
q: .word 8
a: .word 2
   .word 4
   .word 6 
   .word 12
e: .word 5
   .word 10
   .word 15
   .word 20
prompt1: .asciiz "The value in $s0 is : "
prompt2: .asciiz "The value in $s1 is : "
prompt3: .asciiz "The value in $s2 is : "
prompt4: .asciiz "The value in $s3 is : "

#########################################
# Function: printInt
# Parameters:
#   $a0 - the address of the string to print
#   $a1 - the value of the integer to print
# Return Values:
#   none
#########################################
.text
printInt:
# print the prompt string in $a0
li $v0, 4
# $a0 already contains the prompt string location
syscall

# print the integer
li $v0, 1
move $a0, $a1
syscall

jr $ra

#########################################
# Function: printNewLine
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
printNewLine:
	li $v0,4
	la $a0,__PNL_newline
	syscall 
jr $ra

.data
__PNL_newline: .asciiz "\n"

#########################################
# Function: Exit
# Parameters:
#   none
# Return Values:
#   none
#########################################
.text
Exit:
li $v0,10
syscall