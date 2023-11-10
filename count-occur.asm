# Partner Lab
# Count-Occur.asm

.text
##############################################	
# CountOccur
# Parameters:
#    $a0 - character array
#    $a1 - character being searched for
# Returns:
#   $v0 - number of times the character appears
##############################################
CountOccur:

	li $s0,0   	# Set up for return value
	move $t3,$a0
	li $t2,0 # strlen and string array index
loop:
	add $t0,$t2,$t3
	lb $t1,($t0)
	beq $t1,$a1,increment
	beq $t1,$zero,exitFor
	addi $t2,$t2,1
	j loop
increment:
	# Add one to the counter if the character is found
	addi $s0,$s0,1
	j loop	

exitFor:
	# Set up return value and return from the procedure	
	move $v0,$s0
	jr $ra

.data
