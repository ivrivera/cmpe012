#Ivanna Rivera, ivrivera
#CMPE 12 Lab 6
#Due: June 8th, 2018
#Lab 01D, Rebecca R

	#IEEE 754 single precision
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
	
#Exit to Exponent Loop		
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
		beq	$t2, 1, printOnes	
		beqz	$t2, printZeroes
printOnes: 
	addi	$t3, $zero, 1	#load 1 into t3
	li	$v0, 1		#print integer 1
	add 	$a0, $t3, $zero
	syscall
	b 	ManLoop	
printZeroes:
	addi	$t3, $zero, 0		#load 0 into t3
	li	$v0, 1			#print integer 0
	add	$a0, $t3, $zero
	syscall
	b 	ManLoop
	
exitManLoop:
	
	li	$v0, 10
	syscall
	
	jr	$ra
	
	
	#subi	$sp, $sp, 4
	#sw	$ra, ($sp)
	#jal	CompareFloats
	#addi	$sp, $sp, 4
	#lw	$ra, ($sp)
	#jr	$ra
# Prints the sign, mantissa, and exponent of a SP FP value.
# input: $a0 = Single precision float
# Side effects: None
# Notes: See the example for the exact output format.

CompareFloats:
	move	$t0, $a0		#A	
	move 	$t4, $a1		#B
	li	$t1, 0x80000000		#bit mask MSB 
	and   	$t2, $t0, $t1		#bitwise AND: a0 and 0x80000000
	and   	$t3, $t4, $t1		#bitwise AND: a1 and 0x80000000
	sgt	$t5, $t2, $t3		#if $t2 is greater than $t3, set $t5 to 1
	bnez	$t5, isBigger
	b	isSmaller
isBigger:	li	$v0, 1
		move	$a0, $t0
		syscall
isSmaller:	li	$v0, 1
		move	$a0, $t4
		syscall
	
	#compare the sign first
	# if neg or pos, done
	#compare the exponent second
	#mask them out
	#if both are positive, the exponent can be neg or pos
	#check sign of exp, done
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

#AddFloats:
	#change the smaller exponent first
	#by adding the offset
	#to find the offset subtract smaller from larger
	#Need to shift right the smaller number(HB and matissa) by offset
	#Add together updated number and larger number, where the number
	#include HB and mantissa
	#Normalize result if neccessary
	
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

NormalizeFloat:

	#a0 = sign
	#a1 = 63:32  first 18 bits is represented as an integer, the 14 bits is where the mantissa starts
	#a2 = 31:0	the remaining mantissa gets stored into a2  (first 9 bits are important)
	#a3 = exponent		first filled with zeroes and the exponent is filled in the right
	
	#if the value is anything but 1 we know the value is too high
	#shift to the right
	
	#keep track of how many times you shift them
	#make a loop that counts how far over left 1 is
	#bitwise and a0 with a mask to look for 1^^
	
	#first step:
	#$t1 = shift amount
	
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
	
	#eighth step
	
	
	move	$t0, $a1
	li	$t9, 1			#counter
	#loop that counts how far over left 1 is
	#bitwise and a0 with a mask to look for 1^^
	li	$t1, 0x80000000		#bit mask MSB 
	and   	$t2, $t0, $t1		#bitwise AND: a0 and 0x80000000
	blt	$t2, 0, isOne		#if my number is a one print 1
	beqz	$t2, isZero		#if my number is a 0 print 0
isOne:
	addi	$t3, $zero, 1	#load 1 into t3
	li	$v0, 1		#print integer 1
	add 	$a0, $t3, $zero
	syscall			#syscall
	jal	exit1		#jump unconditionally to exit
isZero:
	addi	$t3, $zero, 0		#load 0 into t3
	li	$v0, 1			#print integer 0
	add	$a0, $t3, $zero
	syscall		
	
exit1: 	li	$v0, 4
	la	$a0, newline
	syscall	
	
NormLoop:	srl 	$t1, $t1, 1	#move the mask toward the right to check exponent
		addi	$t9, $t9, 1
		and 	$t2, $t0, $t1	#bitwise AND: a0 and next bit mask(0x400000000)
		beq	$t9, 20, exitNormLoop	#when t1 = 0 then exit exponent loop
		beq	$t2, 1, One	
		beqz	$t2, Zero
One: 
	addi	$t3, $zero, 1	#load 1 into t3
	li	$v0, 1		#print integer 1
	add 	$a0, $t3, $zero
	syscall
	b 	NormLoop	
Zero:
	addi	$t3, $zero, 0		#load 0 into t3
	li	$v0, 1			#print integer 0
	add	$a0, $t3, $zero
	syscall
	b 	NormLoop
	
#Exit to Normalize Float Loop		
exitNormLoop:
	
	li	$v0, 4
	la	$a0, newline
	syscall
	
	li	$v0, 10
	syscall
	
	jr	$ra
	
	
	
	
	

	#shift exponent if neccessary by adding to the exponent
	#
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
