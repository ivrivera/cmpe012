#Ivanna Rivera, ivrivera@ucsc.edu
#Lab 4
#Due: May 11, 2018
#Lab 01D, Rebecca

.text				#Define the program instructions
main:				#Label to define the main program

	li $v0, 4		#Load 4 into $v0 to indicate a print string.
	la $a0, greeting	#Load the address of the greeting into $a0.
	syscall			#Print greeting. The print is indicated by 
				#$v0 having a value of 4, and the string to 
				#print is stored at the address in $a0.
	li $v0, 5		#Service reads the integer.
	add $a0, $t0, $zero	#Load desired value into the address in $a0.
	syscall			#Executes system call 5.
	li $v0, 10		#Load a 10 (halt) into $v0.
	syscall			#The program ends.
	
.data				#Define the program data.
greeting:
.asciiz "Please input a number: " #The string to print.
