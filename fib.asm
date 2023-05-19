# Shivam Kundan
# ID: 853725987
# Lab2

# This program implements the function f(n) = 2f(n-1) + 4f(n-2); f(0)=1,f(1)=3.

.data
	msg1: .asciiz "Enter N: "

.text
.globl main

main:
	# Print msg1
	li $v0,4
	la $a0,msg1
	syscall
	
	# Get N from user and save to $a0
	li $v0,5
	syscall 
	add $a0,$v0,$zero 

	# Call function
	jal func

	# Print sum
	add $a0,$v0,$zero
	li $v0,1
	syscall

	# Exit
	li $v0,10
	syscall

func:
	# Allocate space in stack
	addi $sp,$sp,-12
	
	# Save in stack
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)

	# $s0=$a0
	add $s0,$a0,$zero

	# $t1 stores the value 1
	addi $t1,$zero,1
	
	# Base cases
	beq $s0,$zero, return0
	beq $s0,$t1, return1

	# Decrement n
	addi $a0,$s0,-1

	jal func

	add $s1,$zero,$v0     	# $s1=func(n-1)
	sll $s1,$s1,1		# $s1=$s1*2
	
	addi $a0,$s0,-2

	jal func               	# $v0=func(n-2)
	sll $v0,$v0,2		# $v0=$v0*4

	add $v0,$v0,$s1       	# $v0=func(n-2)+$s1

exitfunc:
	# Pop registers from stack
	lw $ra,0($sp)       
	lw $s0,4($sp)
	lw $s1,8($sp)
	
	# Restore stack
	addi $sp,$sp,12       
	jr $ra

return0:     
	li $v0,1
 	j exitfunc

return1:
 	li $v0,3
 	j exitfunc
