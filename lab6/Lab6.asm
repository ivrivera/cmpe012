#Ivanna Rivera, ivrivera
#CMPE 12 Lab 6
#Due: June 8th, 2018
#Lab 01D, Rebecca R
#------------------------
PrintFloat:
	move	$t0, $a0		#copy a0 into t0
	li	$t8, 1			#counter
	li	$v0, 4			#syscall 4
	la	$a0, printSign		#print sign string "S: "
	syscall
	
#Sign Loop
# if ($a0 == 0)
#	print 0
#else if ($a0 != 0)
#	print 1
	li	$t1, 0x80000000		#bit mask MSB 
	and   	$t2, $t0, $t1		#bitwise AND: a0 and 0x80000000
	blt	$t2, 0, isNegative	#either positive (0) or negative, branch to is Negative if less than 0
	
	subi $sp, $sp, 4		#push to stack pointer
	sw $ra, ($sp)			#store stack pointer address into ra
	
	jal	isPositive		#jump unconditionally to isPositive
isNegative:	
	addi	$t3, $zero, 1		#load 1 into t3
	li	$v0, 1			#print integer 1
	add 	$a0, $t3, $zero
	syscall				#syscall
	b 	exit			#jump unconditionally to exit
isPositive:	
	addi	$t3, $zero, 0		#load 0 into t3
	li	$v0, 1			#print integer 0
	add	$a0, $t3, $zero
	syscall		
			
exit:	li	$v0, 4			#syscall 4 print string	
	la	$a0, newline		#print newline
	syscall	
	
	li	$v0, 4			#syscall print string
	la	$a0, printExponent	#print exponent string
	syscall
	
#Exponent Loop
#if result of masking == 0
#	print 0
#else if != 0
#	print 1
expLoop:	srl 	$t1, $t1, 1		#move the mask toward the right to check exponent
		addi	$t8, $t8, 1		#add 1 to the counter
		and 	$t2, $t0, $t1		#bitwise AND: a0 and next bit mask(0x400000000)
		beq	$t8, 10, exitExpLoop	#when t1 = 0 then exit exponent loop
		beq	$t2, 1, printOne	
		beqz	$t2, printZero
printOne: 
	addi	$t3, $zero, 1			#load 1 into t3
	li	$v0, 1				#print integer 1
	add 	$a0, $t3, $zero
	syscall
	b 	expLoop	
printZero:
	addi	$t3, $zero, 0			#load 0 into t3
	li	$v0, 1				#print integer 0
	add	$a0, $t3, $zero
	syscall
	b 	expLoop
	
#Exit to Mantissa Loop		
exitExpLoop:
	li	$v0, 4				#syscall print string
	la	$a0, newline			#print newline
	syscall
	
	li	$v0, 4				#syscall print string
	la	$a0, printMantissa		#print mantissa string
	syscall
	
#Mantissa Loop
#if result of masking == 0
#	print 0
#else if != 0
#	print 1
ManLoop:	and 	$t2, $t0, $t1		#bitwise AND: a0 and next bit mask(0x400000000)
		srl 	$t1, $t1, 1		#move the mask toward the right to check mantissa
		addi	$t8, $t8, 1		#add 1 to the counter
		
		beq	$t8, 34, exitManLoop	#when t1 = 0 then exit exponent loop
		beq	$t2, 1, printOnes	#print 1 if t2 = 1
		beqz	$t2, printZeroes	#print 0 if t2 = 0
printOnes: 
	addi	$t3, $zero, 1			#load 1 into t3
	li	$v0, 1				#print integer 1
	add 	$a0, $t3, $zero			#add $t3 to a0
	syscall
	b 	ManLoop	
printZeroes:
	addi	$t3, $zero, 0			#load 0 into t3
	li	$v0, 1				#print integer 0
	add	$a0, $t3, $zero			#add $t3 to a0
	syscall
	b 	ManLoop				#branch mantissa loop
	
exitManLoop:
	lw $ra, ($sp)				#pop from stack pointer
	addi $sp, $sp, 4			
	
	jr	$ra				#jump register

		
CompareFloats:
	#compare the sign first
	# if neg or pos, done
	#compare the exponent second
	#mask them out
	#if both are positive, the exponent can be neg or pos
	#check sign of exp, done
	#check the sign of exponent by masking the MSB bit (if == 0, negative; if == 1, positive)
	#if both are negative, the exponent can be neg or pos
	#the bigger negative exponent is greater, done
	#if same exponents, check the magnitude of the mantissas
	#greater mantissa wins, done
	
	move	$t0, $a0			#A	
	move 	$t1, $a1			#B
	
	beq	$t0, $t1, A_is_equal_to_B
	li	$t2, 0x80000000			#bit mask MSB 
	and   	$t3, $t0, $t2			#bitwise AND: a0 and 0x80000000
	beqz	$t3, A_is_pos			#a0 and 0x80000000 == 0 it is a positive FP
	b	A_is_neg			#otherwise it is a negative FP
A_is_neg:
	li	$t3, -1				#load -1 into $t3
	b 	what_is_B
A_is_pos:
	li	$t3, 0				#loading 0 into $t3 again

what_is_B:					#checking the sign of B
	and	$t4, $t1, $t2			#a1 and 0x80000000
	beqz	$t4, B_is_pos			#if result == 0 it is a positive
	b 	B_is_neg			#otherwise it is a negative
B_is_neg:
	li	$t4, -1				#load -1 into $t4
	b 	compareSigns			#branch to compare A&B
B_is_pos:
	li	$t4, 0				#load 0 into t4

compareSigns:
		beq	$t3, $t4, A_is_equal_to_B		#both are equal load 0 into v0
		sgt	$t1, $t3, $t4				#if A > B set $t1 to hold a 1
		
		beq	$t1, 1, A_is_greater_than_B		#if so it is true, print a 1
		beqz	$t1, B_is_greater_than_A		#if A not > B it is false, set $t1 to zero
		
A_is_greater_than_B:
		addi	$v0, $zero, 1				#add a 1 into v0
		b 	signCheckDone
B_is_greater_than_A:
		addi	$v0, $zero, -1				#add a -1 into v0
		b 	signCheckDone
A_is_equal_to_B:
		addi	$v0, $zero, 0				#add a 0 into v0
	
signCheckDone:
	
	jr	$ra


AddFloats:
	#change the smaller exponent first
	#subtract bigger exponent by smaller exponent to get the offset
	#add the offset to the smaller exponent
	#add	$a1, $zero, 0x00400000 to add the HB 
	#to find the offset subtract smaller from larger
	#Need to shift right the smaller number(HB and matissa) by offset
	#Add together updated number and larger number, where the number
	#include HB and mantissa
	#Normalize result if neccessary
	move	$t0, $a0			#copy a0 to t0
	move	$t1, $a1			#copy a1 to t1
	
	li	$t2, 0x80000000			#bit mask
	li	$t8, 1				#counter
	
	and	$t3, $t2, $t0			#bitwise AND of 0x80000000 and a0
	beqz	$t3, continueShifts
	b 	hiddenOnes
continueShifts:
	srl	$t2, $t2, 1			#add 1 to the mask (0x40000000)
	addi	$t8, $t8, 1			#add 1 to the counter
	and 	$t3, $t2, $t0			#bitwise AND: a0 and next bit mask(0x400000000)
	beq	$t8, 10, exitShiftsLoop		#when t1 = 0 then exit exponent loop
	beq	$t3, 1, hiddenOnes
	
hiddenOnes:
	li	$v0, 1				#print value in t8
	add	$a0, $t8, $zero
	syscall
	
exitShiftsLoop:
	li	$v0, 4
	la	$a0, newline
	syscall
	
	jr	$ra


MultFloats:
	#Add the exponents then subtract bias ( n + 127)+( n + 127) - 127 = x
	#x - 127 = exponent
	#Multiply the HB and mantissa of each number using the mult function
	##hi into a1
	#lo into a2
	#Normalize result if neccessary
	
	jr $ra
	
	
NormalizeFloat:

	#a0 = sign
	#a1 = 63:32 		first 18 bits is represented as an integer, the 14 bits is where the mantissa starts
	#a2 = 31:0		the remaining mantissa gets stored into a2  (first 9 bits are important)
	#a3 = exponent		first filled with zeroes and the exponent is filled in the right, this is the initial exp
	
	li $a0, 0x00000001
	li $a1, 0x00006543
	li $a2, 0x21987654
	li $a3, 0x00000020
	
	move	$t0, $a1			#integer and mantissa placeholder
	move	$t1, $a2			#mantissa placeholder
	
	add	$v0, $zero, $a0			#add $a0 (sign) into $v0
	
	li	$t2, 0x80000000			#load the mask with a leading one and 31 zeroes
	li	$t8, 0 				#counter starts at 0
	
	and 	$t3, $t2, $t0			#bitwise AND a1 and 0x80000000
	bgt	$t3, 0, found_a_1
	beqz 	$t3, keepShifting		#loop that counts how far over left 1 is
						#bitwise and a0 with a mask to look for 1^^
keepShifting:					#move the mask toward the right to check the exponent
	srl	$t2, $t2, 1			#shift by 1
	addi	$t8, $t8, 1			#add 1 to the counter to keep track of how many bits the bit was found
	and	$t3, $t2, $t0
	bgt	$t3, 0, found_a_1
	b 	keepShifting
	
found_a_1:
	sll	$v0, $v0, 8			#shift v0 8 bits to make room for exponent
	li	$t4, 17				#load 17 into reg t4
	
	beq	$t8, 17, normalized		#if the counter is at 17 (18th bit) then the input is normalized	
	blt	$t8, 17, left_of_decimal
	bgt	$t8, 17, right_of_decimal	#if the counter is more than 18 bits 
				
left_of_decimal:				#if the counter is less than 18
						#find shift amount by subtracting 17 by the counter
	sub 	$t3, $t4, $t8		
	add	$a3, $zero, $t3			#add the shift amount to the exponent
	add	$v0, $v0, $a3			#add exponent into v0
	
	b mantissa
	
right_of_decimal:

	subi	$t3, $t8, 17			#find shift amount by subtracting the counter by 17
	sub	$a3, $a3, $t3			#adjust the exponent, subtract the shift amount
	add	$v0, $v0, $a3			#add exponent into v0
	
	b mantissa
		
normalized:
	add	$v0, $v0, $a3			#add a3 into v0
	
mantissa:
	sll	$v0, $v0, 23			#shift v0 23 times to the left so that it is in the correct order
	
	li	$t4, 32				#load 32 into t4
	sub	$t4, $t4, $t8			#subtract 32 by counter to get how many bits are next to the leading 1
	addi	$t8, $t8, 1
	sllv	$t6, $t0, $t8			#shift a1 to the left 
	srl	$t6, $t6, 9			#shift a1 9 bits to the right
	
	add	$v0, $v0, $t6			#load a1 into v0

	li	$t7, 23				#load 23 into t7
	sub	$t7, $t7, $t4			#t7 holds remaining mantissa values in a2
	
	li	$t5, 31				#load 31 into t5
	sub	$t5, $t5, $t7			#subtract 32 by the number of the meaningful bits in a2
	
	srlv	$t9, $t1, $t5			#shift a2 to the right to clear the unwanted mantissas
	
	add	$v0, $v0, $t9			#load a2 into v0
	
	jr $ra

.data
printSign: .asciiz "SIGN: "
printExponent: .asciiz "EXPONENT: "
printMantissa: .asciiz "MANTISSA: "
newline: .asciiz "\n"
