--------------------------------
LAB 4: FEEDBABE in MIPS
CMPE 012 Spring 2018


Ivanna Rivera, ivrivera
Section 01D, Rebecca
--------------------------------
I learned how to translate a C program into a compiler language in MIPS. The most difficult thing
for me was the Branch if Not Equal because I was unaware that it existed and I was trying to figure out how use the BEQ Branch somehow to test if the remainder was zero. Registers practically make computers work and it was super cool loading useful information into them. They help me store a value which I can use at a later time. It took me a cold minute to get the hang of MIPS branches, but the one that makes the most sense to me is blt because it works as the “LOOP” branch if i<k then LOOP again. The thing that annoyed me the most was figuring out how to print FEED and BABE just by itself without the integer. I tried multiple Jumps to the END after printing “FEED” and “BABE” but none of them worked for both %4 and %3. I realized that I had to make a branch for both of the REM registers (div by 3-->rem = 0), and (div by 4--> rem = 0). I wrote a conditional statement Not_4: beqz $t3, END beqz $t5, END skip the print integer to END: print newline. This fixed my bugs and I was able to print out the single FEED without the integer.
--------------------------------
1. N can be up to about 2,000,000 large. The total number of bytes inside the memory locations determines this limit. To answer this I tested my code up to 2,000,000 and it would keep crashing.
2. The range of addresses is 0x00400000 to 0x0040000c.
3. The pseudo-ops I used were rem, li, and move. The remainder is turned into a div $(register), $(register) mfhi $(t0). It produces the same result as the rem operation. The MIPS assembler extends the pseudo op using $at into basic ops and produces the appropriate result, for example, a load immediate is turned into an addi $(register), $zero, (16-bit immediate). This produces the same result as the li operation. The move op is turned expanded to addiu $(register), $(t0), 0.
4. I used 6 different registers, not including the print string and the print integer input register syscalls; the 6 were the register counter, the register max value, the argument registers for 3 and 4, and the remainder registers for 3 and 4. You could use less because it would make the code look cleaner. There are trade-offs for using less registers because if you use too few than the code will be hard to read to another pair of eyes.