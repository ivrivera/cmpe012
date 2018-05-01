--------------------------------
LAB 3: LOGIC UNIT WITH MEMORY
CMPE 012 Spring 2018

Ivanna Rivera, ivrivera
Section 01D, Rebecca
--------------------------------

----------------
LEARNING

I gained more familiarity with how to use logic gates alsolearned that each register has to
have a reset button and a store button. It was kind of surprising to me when I realized
that the register needed the 1-bit 4-way MUX in order to function properly otherwise
it would just store the keypad input and not perform any of the 3 logic operations.
It was also interesting to me how the MML program has a keypad input which can be sub-divided into
binary bits, that way programmers can make structures like this lab. It is super cool how everything
 gets puzzled together to form this Arithmetic Logic Unit.

----------------
ISSUES
I had issues with figuring out how to revise the Flip Flop to jibe with the data. I
thought I could build the registers before the MUX but I learned that the output of
the MUX has to be the input of the register otherwise the register would not know which
operation the user wants. Some challenges I faced were figuring out if my MUX
was working properly so I implemented some debugging tools to figure out the core of my errors.
I messed around with the 7-segment display of the Register Value that way I could see if my MUXes
were working correctly. By connecting a receiver transistor to the MUX sender I could check each single MUX.
I connected 3 grounds to the 7 segmenet display so that I could see if my initial Register and MUX
 were working properly together for a single bit. 
----------------
DEBUGGING

I added an LED to the output of my MUX to check if my logic gates and operations were
perfomring correctly. I connected the MUX receiver to an LED and if the light turned on,
that meant that the result of the operation was a 1. FOr instance, if my input was 2 then stored it
and ORed it with 1, my MUX1 would return a lit LED. I first created a 1 bit register and a 1 bit MUX
and tested for that one then I started creating one additional bit after the other. This way I single-handedly
and effortlessly fixed many minor errors rather than waiting till the very end to fix all of the mistakes.
----------------
QUESTIONS

What is the difference between a bit-wise and reduction logic operation?
A "bit-wise" operation are logical operations done in parallel for corresponding bits. For example,
the operation X OR Y would look something like this: 
					 0011
					+1010
					---------
					 1011
A bit-wise AND means that if you are ANDing two 4-bit inputs you will get a 4-bit output. 
The difference between bit wise and reduction logic is that the following logic operation uses logic
for each single bit. For instance, the reduation logic operation AND(x) would look something like:
					&(X) 0*0*1*1 = 0
In other words, the logical bit-wise operation is performed on the result of a previous operation and
 on the next bit of the operand. Reduction logic operators only produce a single bit output (True or 
False).

What operations did we implement?
We implemented the operators AND (0b01), OR (0b10) and the invert (0b11).
These operations were performed after you pressed the store operation. We also created 4 1-bit, 4-way MUXes
 out of logic gates which read the MSBsel and the LSBsel and send it to the register. The register (Flip Flops)
store a multibit value which latches the n-bit value and is either ANDed and stored, ORed and stored, or Inverted
and stored, or simply stored directly into the register. 

Why might we want to use the other type of logic operations?
We might want to use the other type of logic operations because NAND and NOR gates use less transistors. In
other words they would make a cleaner circuit and, today, almost all modern processors use NAND gates to 
build their processors. This lab specifically required AND and OR gates because we had to implement out 
transistors to operate the Sum of Products but we could have also used NAND gates to get the same outcome,
 although it would have required more skillful thinking. 

