#Ivanna Rivera, ivrivera@ucsc.edu
#CMPE 012
#Lab 5
#Due: May 18th, 2018
#Lab 01D, Rebecca R.
.data
prompt: .asciiz "Input a hex number: "
newline: .asciiz "\n"
.text
.main:
	lw	$s0, ($a1)	#loads address of the start of string
	la	$a0, prompt
	li	$v0, 4		#print string
	syscall		#syscall 4
	la	$a0, newline
	li	$v0, 4
	syscall
	addi $s0, $s0, 2	#looking at the 2 step up address (0x7fffeff2)	
	
loop:
	lb	$t1, ($s0)	#t0 store the address space from offset 2($s0)
	#if $t1 < 58 & $t1 > 47)			#A-F in ASCII decimal is 65 to 70  (sub 55)
	#	sub 48					#0-9 in ASCII decimal is 48 to 57  (sub 48)
	#if else $t1 < 71 & $t1 > 64)
	#	sub 55
	li	$t4, 58
	slt	$t0, $t1, $t4
	li	$t5, 47
	sgt	$t2, $t1, $t5
	and 	$t0, $t0, $t2
	sub	$t3, $t1, 48
	
	li $v0 10
	syscall 
	
