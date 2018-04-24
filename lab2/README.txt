Ivanna Rivera (ivrivera@ucsc.edu)
ID 1473756
Lab 2
Section 01D, Rebecca

In this lab i learned how to use truth tables and how to implement logic gates to create a circuit. 
The last Part (D) was really surprising to me because the only way for the Guessing game to work is
to use a NOT XOR gate that compares the guess and the number that was generated in the random number
generator. At first I tried doing my logic gate ciruit the beat force way but I just ended up making
a truth table for any 3-bit inputs and it had 8 logic gates which would always output a 1. I
realized that I was forgetting to compare the guesses with the answer of the random number generator.
The was missing the logic of the NOT XOR gate so, ultimately, I used a total of 3 NOT XOR gates
which all fed into an AND gate.

I could recreate a 7-segment display by coming up with a function to decode each 4 input variant
or I could use 7 LED lights to act like the 7-segements in the original display. I do not
recommend doing it this way because without the 7-segment display the circuit would be too big
and inconvenient.

I think the random number generator works in a sequential form because they generate a number sequence
that appears random, even though the computer is made of deterministic logic gates.

The randomness in a computer does follow some logic, but they carry properties such as non-repeating
and low predictablity qualities that are basically distinct algoritms which make the output appear
random. It must be because of the different sequential circuits and they generate a non-repeating,
low-predictability "random" outputs.
