--------------------------------
LAB 6: FLOATING POINT MATH
CMPE 012 Spring 2018
Ivanna Rivera, ivrivera
Section 01D, Rebecca R.
--------------------------------
----------------
LEARNING
My favorite thing was probably discovering new things as I go. I definitely got a better perspective on the memory addresses in MIPS and how the program counter increments by 4 for every jump and link. It was an eye-opening experience coding the normalize float because I had to test the sign and exponent and mantissas separately and store them into v0 in the right pattern. It was frustrating making silly mistakes but I have always found that making mistakes helps me become smarter. One basic idea of how you would round is like perhaps you would mask the LSB of the mantissa with a 1 and if it is a 1 you add 1, on the other hand you would not add 1 to the mantissa, you would leave it as is if the result of the bitwise and is a 0. I spent the most time on Compare Floats and Normalize Float. My code only works for certain cases that are probably the easiest cases for that matter. Though I understand the basics of floating point math it may not seem so in the completion of MultFloats and AddFloats.
----------------
ANSWERS TO QUESTIONS
1.
I made additional test code for my normalize float function because I could not figure out how to start. Truthfully, creating my own inputs in hex and testing those numbers really made the process clearer. I was able to use paper logic, writing out each 32 bit address of a1 and a2, and shifting them and loading them in order into v0.
2.
Floating point overflow is an error in output functions, it can be caused by the data returned from a function. For instance, if you have a very large exponent that is over +/- 127 you will have overflow error.
3.
Rounding seems easy enough. It was round the mantissa up if the 24th bit is a 1 and if it is a zero don’t change the mantissa. Adding both mantissas gave me 26 bits so I had to find a way to check the 24th bit and then round the previous bit to a 0 or a 1 so that it would fit the allocated space. I ran out of time so I could not implement rounding into my functions.
4.
At first I tested adding two integer in MIPS using the int instead of float op and that gave me a head start on how the adding in MIPS registers would look like. I created my own subroutine call for Normalize Float, which tested a floating point that was already normalized; I programmed for other cases and my code was working properly.