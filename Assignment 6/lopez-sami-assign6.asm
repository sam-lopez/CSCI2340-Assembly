# Samantha Lopez-Montano
# 11-29-23
# Program: Assignment 6

# Pseudo Code/Comment
# My thoughts are always to outline the code of what I need to do first
# I do not normally write pseudocode before I begin my programs
# I try to make thorough comments throughout explaining why instead
# In my head I knew I needed to loop through the arrays to get the data
# it was just a matter of using assembly conventions to accomplish grabbing everything

.text
main:
# prompt for string to convert to lowercase a0 - prompt label 
la $a0, promptLo
lw $a1, strSize
la $a2, inputLoStr
jal PromptString
# input is saved into inputLoStr label

# load parameters to call convert to lowercase
la $a0, inputLoStr
la $a1, convertLoStr
jal tolow
move $s0, $v0	# move number of translations to low to $s0

# print converted string label
la $a0, outString
jal PrintString
# print converted string 
la $a0, convertLoStr
jal PrintString
# prints the number of translations for conversion to lowercase
la $a0, outTrans
move $a1, $s0
jal PrintInt

# prompt for string to convert to uppercase a0 - prompt label 
la $a0, promptUp
lw $a1, strSize
la $a2, inputUpStr
jal PromptString
# input is saved into inputUpStr label

# load parameters to call convert to uppercase
la $a0, inputUpStr
la $a1, convertUpStr
jal toup
move $s1, $v0	# move number of translations to upper to $s1

# print converted string label
la $a0, outString
jal PrintString
# print converted string 
la $a0, convertUpStr
jal PrintString
# prints the number of translations for conversion to uppercase
la $a0, outTrans
move $a1, $s1
jal PrintInt

#################### Bonus Starts Here
jal PrintNewLine
la $a0, inputLoStr
la $a1, convertLoStr
la $a2, conStr
jal strcat
move $s2, $v0	# $s2 concatenated string of to lowercase
# Print out results of strcat
la $a0, bonusStr
jal PrintString
la $a0, conStr	# prints out the two strings without their newlines
jal PrintString
la $a0, bonusLen
jal PrintString
move $a0, $s2	# print integer length of string
li $v0, 1
syscall
###################

# clean exit
j Exit

.data
promptLo: .asciiz "Enter a string to convert to lowercase: "
promptUp: .asciiz "\nEnter a string to convert to uppercase: "
outString: .asciiz "The converted string is: "
outTrans: .asciiz "The number of translations is: "
bonusStr: .asciiz "\nThe concatenated string is (input+conversion no \\n): "
bonusLen: .asciiz "\nThe length is: "
strSize: .word 80
inputLoStr: .space 81
inputUpStr: .space 81
convertUpStr: .space 81
convertLoStr: .space 81
conStr: .space 81
.include "lopez-sami-utils.asm"
#####################################################
# Function: toup - to convert a null terminated ascii string 
#	to all uppercase letters (only lower to upper)
# Parameters:
# $a0 - memory location of string
# $a1 - memory address of modified string
# Returns
# $v0 - number of character translations
######################################################
toup: 
	li $v0,0   	# Set up for number translations return value
	move $t7,$a0	# $t7 = character array
	move $t3, $a1	# $t3 = modified array
	li $t2,0 	# string array index
	li $t6, 97	# setup lowrange of lowercase letters
	li $t5, 122	# setup upperrange of lowercase letters
	loop:
		add $t0,$t2,$t7	# increment character
		add $t4,$t2,$t3	# $t4 should be used to store to modified array label
		lb $t1,($t0)	# load character
		bge $t1,$t6, translateLo	# if char is >= 97 it is maybe lowercase (check low range)
		beq $t1,$zero, exitFor
		addi $t2,$t2,1
		sb $t1,($t4)	# store character
		j loop
	translateLo:
		ble $t1, $t5, translateHi # if char is <= 122 within lowercase range and needs to be translated
		addi $t2,$t2,1
		sb $t1,($t4)	# store character
		j loop
	translateHi:
		# Add one to the counter if lowercase character is found
		addi $v0,$v0,1
		addi $t2,$t2,1
		# subtract 32 to get uppercase letter
		subi $t1, $t1, 32
		sb $t1,($t4)	# store new character
		j loop	
	exitFor:
		# return value saved in $v0 number of translations
		# return from the procedure	
		jr $ra

#####################################################
# Function: tolow - to convert a null terminated ascii string 
#	to all lowercase letters (only upper to lower)
# Parameters:
# $a0 - memory location of string
# $a1 - memory address of modified string
# Returns
# $v0 - number of character translations
######################################################
tolow:
	li $v0,0   	# Set up for number translations return value
	move $t7,$a0	# $t7 = character array
	move $t3, $a1	# $t3 = modified array
	li $t2,0 	# string array index
	li $t6, 65	# setup low range of uppercase letters
	li $t5, 90	# setup upper range of uppercase letters
	low_loop:
		add $t0,$t2,$t7	# increment character
		add $t4,$t2,$t3	# $t4 should be used to store to modified array label
		lb $t1,($t0)	# load character
		bge $t1,$t6, translateLow	# if char is >= 65 it is maybe uppercase (check low range)
		beq $t1,$zero, exitForLow
		addi $t2,$t2,1
		sb $t1,($t4)	# store character
		j low_loop
	translateLow:
		ble $t1,$t5, translateHigh # if char is <= 90 within uppercase range and needs to be translated
		addi $t2,$t2,1
		sb $t1,($t4)	# store character
		j low_loop
	translateHigh:
		# Add one to the counter if uppercase character is found
		addi $v0,$v0,1	# increment translation
		addi $t2,$t2,1
		# add 32 to get lowercase letter
		addi $t1, $t1, 32
		sb $t1,($t4)	# store new character
		j low_loop
	exitForLow:
		# return value saved in $v0 number of translations
		# return from the procedure
		jr $ra
		
#####################################################
# Function: strcat -  concatenates the first and second string 
#	saving it in the location of the third string
#	returning the length of the third string
# Logic: loops through the first string then restarts when
# 	it finds \n then it loops through second string; 
# 	returns the index (string length)
# Parameters:
# $a0 - memory location of first string
# $a1 - memory address of second string
# $a2 - memory address of third string
# Returns
# $v0 - length of third string
######################################################
strcat:
	li $v0,0   	# Set up for length of string return value
	move $t7,$a0	# $t7 = input first array
	move $t3,$a2	# $t3 = concatenated array
	li $t2,0 	# concatenated string array index
	li $t5,0		# array index
	li $t6, 10	# use newline character to end loop
	conloop:
		add $t0,$t5,$t7	# increment character
		add $t4,$t2,$t3	# $t4 should be used to store to concatated array label
		lb $t1,($t0)	# load character
		beq $t1,$t6, exitCon1	# if char == "\n"
		addi $t2,$t2,1	# increment concatenated string array index
		addi $t5,$t5,1	# increment array index
		sb $t1,($t4)	# store character
		j conloop
	exitCon1:
		li $t5,0		# array index
		move $t7,$a1	# $t7 = input second array
		conloop2:
			add $t0,$t5,$t7	# increment character
			add $t4,$t2,$t3	# $t4 should be used to store to concatated array label
			lb $t1,($t0)	# load character
			beq $t1,$t6, exitCon2 # if char == "\n"
			addi $t2,$t2,1	# increment concatenated string array index
			addi $t5,$t5,1	# increment array index
			sb $t1,($t4)	# store character
			j conloop2
		exitCon2:
			# return value length of string in $t2
			#subi $t2, $t2, 2	# decrease index by two to remove null terminators
			move $v0, $t2
			# return from the procedure	
			jr $ra
