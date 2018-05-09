#Ivanna Rivera, ivrivera@ucsc.edu
#Lab 4
#Due: May 11, 2018
#Lab 01D, Rebecca
.data
greeting: .asciiz "Please input a number: " #The string to print.
newline: .asciiz "\n"			#new line to print.]
feed: .asciiz "FEED"
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
	addi $t0, $zero, 0	#Initialize i=1
	
LOOP:
	addi $t0, $t0, 1	#i++
	li $v0, 1		#Print integer syscall
	move $a0, $t0		#move $t0 into $a0.
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	blt $t0, $t1, LOOP	#If i<k go to LOOP

	li $v0, 10		#Load a 10 (halt) into $v0.
	syscall			#The program ends.

