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
	
	li 	$s0, 0		#load zeroes into s0
	
	addi 	$t0, $t0, 2	#byte addressable: skip over the first 2 characters (set to 0x7fffeff2)
	
	lbu	$t1, ($t0)
	beq	$t1, 45, negativeSign		#45 is the aascii character for the negative sign
	
	b loop
	
negativeSign:	
	li	$s1, 1		#set a flag so you can print a negative sign before printing a negative number
	addi	$t0, $t0, 1	#increment string counter past the negative
		
loop:
	lb	$t1, ($t0)		#store the address space from offset 2($t0) into $t1
	beqz	$t1, endloop		#Checks if whatever string you loaded is null, because 
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
	sub	$t2, $t1, 55
isDigit:	
		#Start with shifting s0 4 logical bits to the left
		#OR the memory inside of t2 with s0
		#Check LSB and shift it 4 logical bits to the left until you break
		sll	$s0,$s0, 4		#shift logical left 4 bits
		or	$s0, $s0, $t2		#bitwise OR the 32-bit numbers
		
		addi	$t0, $t0, 1
		
		#Check the magnitude
		#Invert the bits and add 1
		xori	$t1, $s0, 1		#invert the bits
		addi	$t2, $t1, 0001		#add 1
		
		b loop
	
		
endloop: 		li	$v0, 4
			la 	$a0, output
			syscall
			
			li	$v0, 4
			la	$a0, newline
			syscall
			
			li	$v0, 1
			move	$a0, $t2
			syscall					
			
			li 	$v0, 10
			syscall 
		
.data
char: .asciiz "Char is: "
userInput: .asciiz "Input a hex number: "
newline: .asciiz "\n"
#negative_sign: .asciiz "-"
output: .asciiz "The decimal value is: "
	
