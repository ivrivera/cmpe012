#Ivanna Rivera, ivrivera@ucsc.edu
#Lab 4
#Due: May 12, 2018
#Lab 01D, Rebecca
.data
greeting: .asciiz "Please input a number: "	#The string to print.
newline: .asciiz "\n"				#new line to print.
feed: .asciiz "FEED"
babe: .asciiz "BABE"

.text				#Define the program instructions.
main:				#Label to define the main program.
	la $a0, greeting	#Load the address of the greeting into $a0.
	li $v0, 4		#Load 4 into $v0 to indicate a print string.
	syscall			#Print greeting. The print is indicated by 
				#$v0 having a value of 4, and the string to 
				#print is stored at the address in $a0.
	li $v0, 5		#Load a 5 into $v0; reads the integer.
	syscall			#Execute system call 5.
	
	addi $t1, $v0, 0	#Load k into the address in $t1 ("MAX" value).
	addi $t0, $zero, 0	#Initialize i=0
	addi $t2, $t2, 3	#initialize $t2 = 3
	addi $t4, $t4, 4	#initialize $t4 = 4
LOOP:
	addi $t0, $t0, 1	#i++
	rem $t3, $t0, $t2	#Sets remainder of the input div by 3 into register $t3
	rem $t5, $t0, $t4	#Sets remainder of the input div by 4 into register $t5
	
	bne $t3, $zero, Not_3	#conditional statement: divisible by 3 
	la $a0, feed		#print feed
	li $v0, 4
	syscall
Not_3:	bne $t5, $zero, Not_4	#conditional statement: divisible by 4
	la $a0, babe		#print babe
	li $v0, 4
	syscall			#print feedbabe if both are true.
Not_4:  beqz $t3, END		#skips to a newline if $t3 = 0.
	beqz $t5, END		#skips to a newline if $t5 = 0.
	move $a0, $t0		#move $t0 into $a0.
	li $v0, 1		#print integer syscall.
	syscall
END:	la $a0, newline		#print newline.
	li $v0, 4
	syscall
	blt $t0, $t1, LOOP	#If i<k go to LOOP

	li $v0, 10		#Load a 10 (halt) into $v0.
	syscall			#The program ends.


