#Ivanna Rivera, ivrivera
#CMPE 12 Lab 6
#Due: June 8th, 2018
#Lab 01D, Rebecca R

#F = fraction for the mantissa
#S = sign
#E = exponent
#(-1)^S x (1+F) x 2base10^(E - 127base10)

PrintFloat:
	move	$t0, $a0		#copy a0 to t0
	li	$t8, 1			#counter
	li	$v0, 4		#syscall 4
	la	$a0, printSign	#print sign string "S: "
	syscall
	
	# if ($a0 == 0)
	#	print 0
	#else if ($a0 != 0)
	#	print 1
	li	$t1, 0x80000000		#bit mask MSB 
	and   	$t2, $t0, $t1		#bitwise AND: a0 and 0x80000000
	blt	$t2, 0, isNegative	#either positive (0) or negative, branch to is Negative if less than 0
	jal	isPositive	#jump unconditionally to isPositive
isNegative:	
	addi	$t3, $zero, 1	#load 1 into t3
	li	$v0, 1		#print integer 1
	add 	$a0, $t3, $zero
	syscall			#syscall
	jal	exit		#jump unconditionally to exit
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
expLoop:	srl 	$t1, $t1, 1	#move the mask toward the right to check exponent
		addi	$t8, $t8, 1
		and 	$t2, $t0, $t1	#bitwise AND: a0 and next bit mask(0x400000000)
		beq	$t8, 10, exitExpLoop	#when t1 = 0 then exit exponent loop
		beq	$t2, 1, printOne	
		beqz	$t2, printZero
printOne: 
	addi	$t3, $zero, 1	#load 1 into t3
	li	$v0, 1		#print integer 1
	add 	$a0, $t3, $zero
	syscall
	b 	expLoop	
printZero:
	addi	$t3, $zero, 0		#load 0 into t3
	li	$v0, 1			#print integer 0
	add	$a0, $t3, $zero
	syscall
	b 	expLoop
	
#Exit to Mantissa Loop		
exitExpLoop:
	li	$v0, 4			#syscall print string
	la	$a0, newline		#print newline
	syscall
	
	li	$v0, 4			#syscall print string
	la	$a0, printMantissa	#print mantissa string
	syscall
	
ManLoop:	srl 	$t1, $t1, 1	#move the mask toward the right to check mantissa
		addi	$t8, $t8, 1	#my counter
		and 	$t2, $t0, $t1	#bitwise AND: a0 and next bit mask(0x400000000)
		beq	$t8, 34, exitManLoop	#when t1 = 0 then exit exponent loop
		beq	$t2, 1, printOnes	#print 1 if t2 = 1
		beqz	$t2, printZeroes	#print 0 if t2 = 0
printOnes: 
	addi	$t3, $zero, 1	#load 1 into t3
	li	$v0, 1		#print integer 1
	add 	$a0, $t3, $zero	#add $t3 to a0
	syscall
	b 	ManLoop	
printZeroes:
	addi	$t3, $zero, 0		#load 0 into t3
	li	$v0, 1			#print integer 0
	add	$a0, $t3, $zero		#add $t3 to a0
	syscall
	b 	ManLoop		#branch mantissa loop
	
exitManLoop:
	
	li	$v0, 10		#syscall 10
	syscall			#terminate
	
	jr	$ra
	
CompareFloats:
	move	$t0, $a0		#A	
	move 	$t1, $a1		#B
	li	$t2, 0x80000000		#bit mask MSB 
	and   	$t3, $t0, $t2		#bitwise AND: a0 and 0x80000000
	and   	$t4, $t1, $t2		#bitwise AND: a1 and 0x80000000
	sgt	$t5, $t3, $t4		#if $t3 is greater than $t4, set $t5 to 1
	bnez	$t5, isBigger
	b	isSmaller
isBigger:	li	$v0, 1
		move	$a0, $t0
		syscall
isSmaller:	li	$v0, 1
		move	$a0, $t4
		syscall
	
	#don't use branches
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
	
# Compares two floating point values A and B.
# input: $a0 = Single precision float A
# $a1 = Single precision float B
# output: $v0 = Comparison result
# Side effects: None
# Notes: Returns 1 if A>B, 0 if A==B, and -1 if A<B

AddFloats:
	#change the smaller exponent first
	#by adding the offset
	#to find the offset subtract smaller from larger
	#Need to shift right the smaller number(HB and matissa) by offset
	#Add together updated number and larger number, where the number
	#include HB and mantissa
	#Normalize result if neccessary
	
	move	$t0, $a0
	move	$t1, $a1
	
	li	$t2, 0x80000000	#bit mask
	li	$t8, 1		#counter
	
	and	$t3, $t2, $t0	#bitwise AND of 0x80000000 and a0
	beqz	$t3, continueShifts
	b 	hiddenOnes
continueShifts:
	srl	$t2, $t2, 1	#add 1 to the mask (0x40000000)
	addi	$t8, $t8, 1	#add 1 to the counter
	and 	$t3, $t2, $t0	#bitwise AND: a0 and next bit mask(0x400000000)
	beq	$t8, 10, exitShiftsLoop	#when t1 = 0 then exit exponent loop
	beq	$t3, 1, hiddenOnes
	
hiddenOnes:
	li	$v0, 1
	add	$a0, $t8, $zero
	syscall
	
exitShiftsLoop:
	li	$v0, 4
	la	$a0, newline
	syscall
	
	li	$v0, 10
	syscall
	
	jr	$ra
	
# Adds together two floating point values A and B.
# input: $a0 = Single precision float A
# $a1 = Single precision float B
# output: $v0 = Addition result A+B
# Side effects: None
# Notes: Returns the normalized FP result of A+B

#MultFloats:
	#Add the exponents, subtract bias(???)
	#Multiply the HB and mantissa of each number
	#Normalize result if neccessary
# Multiplies two floating point values A and B.
# input: $a0 = Single precision float A
# $a1 = Single precision float B
# output: $v0 = Multiplication result A*B
# Side effects: None
# Notes: Returns the normalized FP result of A*B

NormalizeFloats:

	#a0 = sign
	#a1 = 63:32  first 18 bits is represented as an integer, the 14 bits is where the mantissa starts
	#a2 = 31:0	the remaining mantissa gets stored into a2  (first 9 bits are important)
	#a3 = exponent		first filled with zeroes and the exponent is filled in the right
	
	#if the value is anything but 1 we know the value is too high
	#shift to the right
	
	#first step:
	#$t8 = shift amount
	
	#second step
	#shift a2 right the shift amount 
	
	#third step
	#and a mask with the right couple bits
	#$t2 = lost bits
	#save them into reg t2
	
	#fourth step
	#shift the lost bits by 30 to the left
	
	#fifth step
	#or this with a2 (OR) add lost bits onto a2
	
	#sixth step
	#we can now shift a1 by n bits right
	
	#seventh step
	#mask the 14 bits of mantissa by 11111111111111
	#store value into t2
	
	#eighth step
	#shift t2 left to align
	
	#ninth step
	#Shift 9-bits from a2 to be right aligned
	
	#10th step
	#add t2 and a2 into v0
	
	#loop that counts how far over left 1 is
	#bitwise and a0 with a mask to look for 1^^
	#move the mask toward the right to check exponent
	move	$t0, $a1
	move	$t1, $a2
	li	$t2, 0x80000000	#bit mask
	li	$t8, 0		#counter
	
	and	$t3, $t2, $t0	#bitwise AND of 0x80000000 and a0
	beqz	$t3, continueShift
continueShift:
	srl	$t2, $t2, 1	#add 1 to the mask (0x40000000)
	addi	$t8, $t8, 1	#add 1 to the counter
	and 	$t3, $t2, $t0	#bitwise AND: a0 and next bit mask(0x400000000)
	beq	$t8, 18, exitShiftLoop	#when counter reaches 18 stop looping
	
	b	continueShift
	
#reg t8 = SHIFT AMOUNT
exitShiftLoop:
	li	$t7, 17
	sub	$t8, $t8, $t7		#t8 holds the shift amount, subtract 17 to get the actual value of the shift amount
	
	and	$t3, $t0, 0x00000001	#bitwise AND a1 and 0x00000001 ($t8)
	sll	$t4, $t3, 31
	
	or	$t4, $t4, $t1	#add lost bits onto a2
	srl	$t0, $t0, 1	#shift a1 right by shift amount ($t8)
	
ShiftMantissa:
	and	$t2, $t0, 0x00003FFF	#mask 14 bits of mantissa with 14 ones right aligned
	sll	$t2, $t2, 18		#shift t2 left to align
	
	srl	$t1, $t1, 23		#shift 9-bits from a2 to be right aligned
	
	add	$v0, $t2, $t1		#add t2 and a2 to add the 14 bit mantissa and 9 bit mantissa
	
endNormalize:

	li	$v0, 10
	syscall
	
	jr	$ra
	

	#shift exponent if neccessary by adding to the exponent
	
# Normalizes, rounds, and “packs” a floating point value.
# input: $a0 = 1-bit Sign bit (right aligned)
# $a1 = [63:32] of Mantissa
# $a2 = [31:0] of Mantissa
# $a3 = 8-bit Biased Exponent (right aligned)
# output: $v0 = Normalized FP result of $a0, $a1, $a2
# Side effects: None
# Notes: Returns the normalized FP value by adjusting the
# exponent and mantissa so that the 23-bit result
# mantissa has the leading 1(hidden bit). More than
# 23-bits will be rounded. Two words are used to
# represent an 18-bit integer plus 46-bit fraction
# Mantissa for the MultFloats function. (HINT: This
# can be the output of the MULTU HI/LO registers!)

.data
printSign: .asciiz "SIGN: "
printExponent: .asciiz "EXPONENT: "
printMantissa: .asciiz "MANTISSA: "
newline: .asciiz "\n"
