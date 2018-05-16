#Ivanna Rivera, ivrivera@ucsc.edu
#CMPE 012
#Lab 5
#Due: May 18th, 2018
#Lab 01D, Rebecca R.
.data
prompt: .asciiz "Input a hex number: \n"
newline: .asciiz "\n"
.text
.main:
	lw	$s0, ($a1)	#loads address of the start of string
	la	$a0, prompt
	li	$v0, 4		#print string
	syscall		#syscall 4
	la	$a0, ($s0)	#output user string
	syscall
	la	$a0, newline
	li	$v0, 4
	syscall
	addi 	$s0, $s0, 2	#looking at the 2 step up address (0x7fffeff2)	
	li 	$s1, 0
	
loop:
	lb	$t0, ($s0)	#t0 store the address space from offset 2($s0)
	beqz	$t0, end
	#Checks if whatever string you loaded is null, becaause the ASCII value for null is 0
	
	#if $t0 < 58 && $t0 > 47)			#A-F in ASCII decimal is 65 to 70  (sub 55)
	#	sub 48					#0-9 in ASCII decimal is 48 to 57  (sub 48)
	#if else $t0 < 71 && $t0 > 64)
	#	sub 55				#subtract 55 from ASCII decimal to get decimal value
	li	$t4, 58
	slt	$t1, $t0, $t4
	li	$t5, 47
	sgt 	$t2, $t0, $t5
	and 	$t1, $t1, $t2
	sub	$t3, $t1, 48
	beqz	$t1, else_if 
		else_if:	li 	$t6, 71
				slt	$t1, $t0, $t6
				li	$t7, 64
				sgt	$t2, $t0, $t7
				and	$t1, $t1, $t2
				sub	$t3, $t1, 55
	#shift logical left 4 bits
	#bitwise OR the 32-bit numbers
				
	sll 	$s1, $s1, 4
	or	$s1, $t3, $s1
	
	addi $s0, $s0, 1
	b loop
	
	end: 	li $v0, 1
		move $a0, $s1
		syscall
		li $v0, 10
		syscall 
	
