#Ivanna Rivera, ivrivera@ucsc.edu
#CMPE 012
#Lab 5
#Due: May 18th, 2018
#Lab 01D, Rebecca R.

.text
.main:
	lw	$t0, ($a1)	#loads address of the start of string
	la	$a0, userInput
	li	$v0, 4		#print string
	syscall			#syscall 4
	
	la	$a0, newline	#print new line
	li	$v0, 4		#syscall 4
	syscall
	
	la	$a0, ($t0)	#output user string
	syscall
	
	la	$a0, newline		#print new line
	li	$v0, 4			#syscall 4
	syscall
			li	$v0, 4			#syscall 4
		la 	$a0, output		#print output string
		syscall
			
		li	$v0, 4			#syscall 4
		la	$a0, newline		#print string newline
		syscall
	li 	$s0, 0		#load zeroes into s0
	
	la	$t8, array	#load size of digits into array
	
	addi 	$t0, $t0, 2	#byte addressable: skip over the first 2 characters (set to 0x7fffeff2
	
	b loop
loop:
	lb	$t1, ($t0)		#store the address space from offset 2($t0) into $t1
	beqz	$t1, exitloop		#Checks if whatever string you loaded is null, because 
					#the ASCII value for null is 0
	
	#if $t0 < 58 && $t0 > 47)			#A-F in ASCII decimal is 65 to 70  (sub 55)
	#	sub 48					#0-9 in ASCII decimal is 48 to 57  (sub 48)
	#if anything else
	#	sub 55				#subtract offset 55 from ASCII decimal to get decimal value
	li	$t2, 58
	slt	$t8, $t1, $t2			#if $t1 is less than 58, set $t8 to 1
	li	$t5, 47
	sgt 	$t3, $t1, $t5			#if $t1 is greater than 47, set $t3 to 1
	and 	$t9, $t8, $t3			#AND both conditionals set result to $t9
	beqz	$t9, isLetter 			#if $t9 is zero branch to isLetter (sub 55)
	sub	$t2, $t1, 48
	b 	isDigit
isLetter:	
	sub	$t2, $t1, 55		#subtract 55 if it is a letter
isDigit:	
		#Start with shifting s0 4 logical bits to the left
		#OR the memory inside of t2 with s0
		#Check LSB and shift it 4 logical bits to the left until you break
		sll	$s0,$s0, 4		#shift logical left 4 bits
		or	$s0, $s0, $t2		#bitwise OR the 32-bit number		
		
		addi	$t0, $t0, 1
		
		b loop
		
exitloop:	li	$t2, 0x80000000	#check msb, bitwise AND 0x80000000 with s0
		move 	$t1, $s0		#move address space of s0 into t1
		and  	$t3, $t1, $t2		#Bitwise AND t1 and 0x80000000
		bltz    $t3, negativeSignDetected	#if value is negative then branch to negativeSignDetected
		b	getRemainder	#if value is positive branch to countDigits

negativeSignDetected:	
		#Directly store the ASCII character for the negative sign (45) into the first element of the array
		#and add 1 to the array pointer
		
		#Check the magnitude
		#Invert the bits and add 1
		li	$t4, 45		#load ascii 45 into $t4
		not	$t1, $t1		#invert the bits
		add	$t1, $t1, 1		#add 1
		li	$v0, 11
		move	$a0, $t4
		syscall
		addi	$t8, $t8, 1		#skip the first space in the array, add 1 to the array pointer
getRemainder:	li	$t7, 1		#load 1 into t7
		li	$t5, 10		#load 10 into t5
divideloop:	divu 	$t1, $t5	#divide decimal value by 10
		mfhi	$t6		#set high remainder to t6
		mflo	$t1		#set lo remainder to t1
		addi	$t2, $t6, 48		#add 48 to convert to ascii and store into t2
		#Store byte t2 into the next box of array
		sb	$t2, array($t7)		#offset array by 1	
		
		addi	$t7, $t7, 1		#keep adding 1 to the offset
	
		bnez	$t1, divideloop	 	#branch to division
		
		subi 	$t7, $t7, 1
		li      $v0, 11		#syscall 11
		
reverseLoop:
		lb      $t0, array($t7)   #loading value into offset array t2
		move      $a0, $t0	#loading byte of a0 into t0
		syscall			#call system print charcter
		sub     $t7, $t7, 1	#subtract by 1
		bnez    $t7, reverseLoop	#branch if t2 does not equal zero
		
endProgram:

		
		li 	$v0, 10			#syscall 10
		syscall 			#terminate
						

.data
userInput: .asciiz "Input a hex number: "
newline: .asciiz "\n"
output: .asciiz "The decimal value is: "
array: .space 10 #max 10 digits (-2^31)

	
