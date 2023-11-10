# Partner’s name: Samantha Lopez-Montano & Connor
# 11-13-23
# Program: Lab – Partner Work

.text
main:
# prompt for string a0 - prompt label 
la $a0, promptStr
lw $a1, strSize
la $a2, inputStr
jal PromptString
# input is saved into inputStr label

# prompt for character a0 - prompt label
la $a0, promptCha
jal PromptCharacter
move $s0, $v0	# input moved from $v0 to $s0
jal PrintNewLine

# load/move user input into parameters for procedure
la $a0, inputStr # move string into $a0 for parameter of procedure
move $a1, $s0 # move character into $a1 for parameter of procedure

# call procedure
#jal CountOccur

# print the search output and string searched
la $a0, outStr
jal PrintString
la $a0, inputStr
jal PrintString

# print the character label string
la $a0, outCh
jal PrintString
# print the character searched for
move $a0, $s0
jal PrintCharacter
# print space between character and value
la $a0, space
jal PrintString

# print the value from CountOccur
#
#jal PrintInt
# print the string label times
la $a0, outTime
jal PrintString

# clean exit
j Exit

.data
promptStr: .asciiz "Please enter a string: "
inputStr: .space 81
strSize: .word 80
promptCha: .asciiz "Please enter a character to search for: "
outStr: .asciiz "Search string = "
outCh: .asciiz "We found the character "
space: .asciiz " "
outTime: .asciiz " times"
.include "utils.asm"
.include "count-occur.asm"