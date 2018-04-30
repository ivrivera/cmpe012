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
if it would just store the keypad input and not perform any of the three logic operations
(INVERT, AND, OR). It was also surprising that MML has a keypad input that can be divided into bits
so it is easier for programmers to make a structure that implements individual gates into a larger
structure like a logic ALU. It is super cool how everything gets puzzled together.  

----------------
ISSUES
I had issues with figuring out how to revise the Flip Flop to jibe with the data. I
thought I could build the registers before the MUX but I learned that the output of
the MUX has to be the input of the register otherwise the register would not know which
operation the user wants. Some challenges I faced were figuring out if my MUX
was working properly so I implemented some debugging tools to figure out the core to my errors.
I messed around with the 7-segment display of the Register Value that way I could see if my MUXes
were working correctly. While testing my first bit register and MUX, I connected 3 grounds to the 
7 segmenet display so that I could see if my Register and MUX were working properly together.
----------------
DEBUGGING

I added an LED to the output of my MUX to check if my logic gates and operations were
perfomring correctly. I connected the MUX receiver to an LED and if the light turned on,
that meant that the result of the operation was a 1. FOr instance, if my input was 2 then stored it
and ORed it with 1, my MUX1 would return a lit LED. I first created 1 bit and tested that
then I started creating one additional bit after test running each of them. This way I single-handenly
and painlessly fixed my mistakes. 

----------------
QUESTIONS

What is the difference between a bit-wise and reduction logic operation?
A "bit-wise" operation are logical operations done in parallel for corresponding bits. For example,
the operation X OR Y would look something like this: 
					 0011
					+1010
					---------
					 1011
The difference between bit wise and reduction logic is that the following logic operation uses logic
for each single bit. For instance, the operation AND(x) would look something like:
					&(X) 0*0*1*1 = 0
In other words, the logical bit-wise operation is performed on the result of a previous operation and
 on the next bit of the operand. Reduction logic operators only produce a single bit output (True or 
False).

What operations did we implement?
We implemented the operators AND (0b01), OR (0b10) and the invert (0b11).
These all functioned after you pressed the store operation. We also created 4 1-bit, 4-way MUXes out of
 logic gates which takes into account the bit and performf operation. The register (Flip Flops) stores
a multibit value which latches the n-bit value and is either Anded, Ored or inverted, or simply
stored into the register. 

Why might we want to use the other type of logic operations?
<<insert your answer>>

