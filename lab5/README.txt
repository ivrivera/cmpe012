--------------------------------
LAB 5: HEX TO DECIMAL CONVERSION
CMPE 012 Spring 2018
Ivanna Rivera, ivrivera
Section 01D, Rebecca R.
--------------------------------
LEARNING
<<Describe what you learned, what was surprising, what worked well and
what did not.>>
I learned more about looking inside of the memory and configuring the registers to ASCII to decimal value. It was surprisingly difficult to reverse the string. I figured out how to manipulate the number of digits within the array to give me the output that I wanted. I was stumped after I converted the program argument from HEX to Decimal because I didn’t know how to convert it into a string. I was able to manipulate each decimal value into a character and store them into an array. It had a space of 10 because 10 is the maximum digits possible for a two’s complement number in a 32-bit address. It also worked well to shift logical left s0 by 4 bits instead of 28 and then bitwise OR s0 with t2(my register that holds the HEX to Decimal conversion) and loop again until my s0 hit null. Another thing that was difficult for me was printing the string “The decimal value is: “ before the syscall 11 character but I realized that I had to place the syscall command at the start of the main instead of the very end.
----------------
ANSWERS TO QUESTIONS
1.
Since we have a two’s complement number we have one representation of 0: 00000000 (+0). It is the same in the case of an Unsigned interpretation.
2.
The largest input value is 2^31 - 1 or ‘2147483647’.
3.
The smallest most negative input value is’-2147483648’.
4.
The difference between signed and unsigned arithmetic in MIPS is that add instructions will raise an exception if they cause an overflow, while addu does not raise exceptions on overflow. For adding I used unsigned arithmetic but when I divided my s0 I used unsigned arithmetic. The advantages of using unsigned arithmetic was, for instance, the addition of 127 and -126 gives the same binary bit pattern as an unsigned addition of 127 and 126.
5.
I would write this binary-to-decimal converter as a ascii to decimal converter by loading the input into my my register a1 into t0. Then I would make a loop that has a conditional argument checking if it was a 0 or a 1; if its a 0 or a 1 add 48, else if null branch to exitloop. I would store my value into s0 by shifting and lastly bitwise OR my result. In my exitloop I would use the syscall 1 to print the integer decimal value of the OR result and terminate the program using syscall 10.