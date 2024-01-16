# Samantha Lopez-Montano
# 11-27-23
# Program: Lab 16

.text
main:
# prompt for fahrenheit float
la $a0, inputF
jal PromptFloat
swc1 $f0, fahrenheit	# Store value to memory

# load fahrenheit for parameter
lwc1 $f12, fahrenheit
jal FtoC
swc1 $f0, celsius	# Store value to memory

# Print Celsius
la $a0, msgC
jal PrintString
lwc1 $f12, celsius
jal PrintFloat

# Print boiling or freezing message if applicable
lwc1 $f1, fTemp 	# load freezing temp
c.le.s $f0, $f1	# if temp <= freezing point (0) then == 1
bc1t freeze

lwc1 $f1, bTemp	# load boiling temp
c.lt.s $f0, $f1	# if temp < boiling point (100) then == 1 (true)
bc1f boil	# if temp was false (>= 100) branch to boil

j Exit	# clean exit if not boiling or freezing

freeze:
	la $a0, msgFreeze
	jal PrintString
	j Exit	# clean exit
boil:
	la $a0, msgBoil
	jal PrintString
	j Exit # clean exit

.data
fahrenheit: .float 0
celsius: .float 0
bTemp: .float 100
fTemp: .float 0
inputF: .asciiz "Please enter the temperature in Fahrenheit: "
msgC: .asciiz "The temperature in Celsius is "
msgBoil: .asciiz "\nYou could boil water."
msgFreeze: .asciiz "\nYou could freeze water."
.include "lopez-sami-utils.asm"

#####################################################
# Function: FtoC - Calculates Fahrenheit to Celsius
#	Celsius = (Fahrenheit - 32.0) * 5.0/9.0
# Parameters:
# $f12 - Fahrenheit input
# Returns
# $f0 - Celsius return value
######################################################
.text
FtoC:
	lwc1 $f18, const1
	lwc1 $f19, const2	# $f19 could be storing doubles which use two registers so storing on even registers is preferred
	lwc1 $f20, const3
	# calculate conversion
	div.s $f4, $f19, $f20 # $f4 = $f19/$f20 (5.0/9.0)
	sub.s $f0, $f12, $f18 # f0 = $f12 - $f18 (fahren - 32.0)
	mul.s $f0, $f0, $f4 # $f0 = (fahren - 32.0) * (5.0/9.0)
	# return value $f0 contains Celsius value   
jr $ra
.data
const1: .float 32.0
const2: .float 5.0
const3: .float 9.0
