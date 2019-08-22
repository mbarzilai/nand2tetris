// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// if keyboard = 0
// loop through whole screen
// set to 0

// if keyboard != 0
// loop through whole screen
// set to -1

// how to loop through whole screen?!?!

// Put your code here.
(START)
  @row
  M=0     //initialize row to 1
  @SCREEN
  D=A
  @addr
  M=D

  // //determine color for painting
  // @KBD
  // D=M
  // @WHITE
  // D;JEQ   //if keyboard input = 0 jump to white

  // @color
  // M=-1    //set c to -1 (i.e. all ones in binary)
  // @COLOR_SCREEN
  // 0;JMP

// (WHITE)
//   @color
//   M=0     //set c to 0
//   @COLOR_SCREEN
//   0;JMP

(COLOR_SCREEN)
  @row
  MD=M+1
  @256
  D=A-D
  @END
  D;JLT    //if row > 256 goto END

  @word
  M=1       //initialize word to 1 before each row
  @COLOR_ROW
  0;JMP     //otherwise, go to color row


(COLOR_ROW)
  @32
  D=A
  @word
  D=D-M
  @COLOR_SCREEN
  D;JLT     //if word > 32 goto COLORSCREEN

  //determine color for painting
  @KBD
  D=M
  @WHITE
  D;JEQ   //if keyboard input = 0 jump to white

  @addr
  A=M
  M=-1    //set c to -1 (i.e. all ones in binary)
  @FINISH_ROW
  0;JMP

(WHITE)
  @addr
  A=M
  M=0
  @FINISH_ROW
  0;JMP

(FINISH_ROW)
  @word
  M=M+1     //increment word
  @addr
  M=M+1     //increment address

  @COLOR_ROW
  0;JMP

(END)
  @START
  0;JMP
