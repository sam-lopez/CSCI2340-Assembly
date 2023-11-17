# Samantha Lopez-Montano
# 11-8-2023
# Program: Lab 12

# n = input("Please enter an integer: ")
# if n != 0: 
#	return n + add_r(n - 1)
# else: 
#	return 0
# print("Returned value = ", n)

.text
main:
# prompt for integer a0 - prompt label 
la $a0, prompt
jal PromptInt
move $a0, $v0	# save integer into $a0 for parameter of procedure

# call procedure add_r
jal add_r
move $a1, $v0	# save final value in $a1 for parameter of print procedure

# print final value a0 - return label a1 - integer
la $a0, return
jal PrintInt
jal PrintNewLine

# exit cleanly
j Exit

.data
prompt: .asciiz "Please enter an integer: "
return: .asciiz "Returned value = "
.include "lopez-sami-utils.asm"

##############################################	
# add_r
# Description:
#      if(n != 0) return n + add_r(n - 1);
#        else return 0;
#
# Parameters:
#    $a0 - n
#
# Returns:
#   $v0 - the calculated value
##############################################	
add_r:
	# Push $ra on the stack
	addi $sp, $sp, -4     # adjust stack 
	sw   $ra, 0($sp)      # save return address
	
	# Push $a0 on the stack
	addi $sp, $sp, -4     # adjust stack
	sw   $a0, 0($sp)      # save argument
	
	# Procedure logic starts heres  
	bnez $a0,recur      # if n != 0, branch to recur 
	add $v0, $zero, $zero    # else, result is 0 in $v0 - exit condition
	    
	# Pop $a0 off the stack    
	lw   $a0,0($sp)       
	addi $sp, $sp, 4        
	# Pop $ra off the stack   
	lw   $ra,0($sp)	     
	addi $sp, $sp, 4

	jr   $ra              # Last return

recur:	
	addi $a0, $a0, -1     # decrement n-1 ($a0)
	jal  add_r             # recursive call
	    
	# Pop $a0 off the stack    
	lw   $a0,0($sp)        
	addi $sp, $sp, 4        
	# Pop $ra off the stack   
	lw   $ra,0($sp)	
	addi $sp, $sp, 4
	
	add  $v0, $a0, $v0    # add to get result    
	jr   $ra              # and return
