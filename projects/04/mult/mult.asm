// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// psuedocode
//    n = R0
//    i = 1
//    product = 0

//  LOOP
//    if i > n goto STOP
//    product = product + R1
//    i = i + 1
//    goto LOOP

//  STOP
//    R2 = product


// HACK CODE

// create variables
  @R0
  D=M
  @n
  M=D     // n = R0

  @i
  M=1     // i = 1

  @product
  M=0     // product = 0

(LOOP)
  @n
  D=M
  @i
  D=D-M
  @STOP
  D;JLT   // if i > n goto STOP

  @R1
  D=M
  @product
  M=M+D   // product = product + R1

  @i
  M=M+1   // i = i + 1

  @LOOP
  0;JMP

(STOP)
  @product
  D=M
  @R2
  M=D
  @END
  0;JMP

(END)
  @END
  0;JMP


