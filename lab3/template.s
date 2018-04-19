    .syntax unified

    @ main file Lab 3
    @ Bao Nguyen && Jeevan

    .arch armv6
    .fpu vfp 
    @ --------------------------------
    .global main
main:
    @ driver function main lives here, modify this for your other functions

      str      lr, [sp, #-4]!
      sub      sp, sp, #20
loop:
      ldr      r0, printdata       /* enter #1 */
      bl       printf
      ldr      r0, printdata+4
      add      r1, sp, #16
      bl       scanf                /* read #1 */
      
      ldr      r0, printdata+8     /* enter #2 */
      bl       printf
      ldr      r0, printdata+12
      add      r1, sp, #12
      bl       scanf                /* read #2 */
      

      ldr      r0, printdata+24    /* enter operator */
      bl       printf
      ldr      r0, =scanchar
      add      r1, sp, #8
      bl       scanf
      ldr      r1, =add1
      ldrb     r1, [r1]
      ldrb     r0,[sp, #8]
      cmp      r0, r1
      beq      doadd
      
      ldr      r1, =sub1
      ldrb     r1, [r1]
      cmp      r0, r1
      beq      dosub
      
      ldr      r1, =mul1
      ldrb     r1, [r1]
      cmp      r0, r1
      beq      domul

      b        invalid

doadd:
      ldr      r0, [sp, #16]
      ldr      r1, [sp, #12]
      bl       intadd
      b        doagain

dosub:
      ldr      r0, [sp, #16]
      ldr      r1, [sp, #12]
      bl       intsub
      b        doagain
domul:
      ldr      r0, [sp, #16]
      ldr      r1, [sp, #12]
      bl       intmul
      b        doagain
invalid:
      ldr      r0, printdata+28
      bl       printf
      b        newloop
       
      
doagain:
      mov      r1, r0
      ldr      r0, printdata+16
      bl       printf

    @ You'll need to scan characters for the operation and to determine
    @ if the program should repeat.
    @ To scan a character, and compare it to another, do the following
newloop:
      ldr r0, printdata+20
      bl printf
      ldr     r0, =scanchar
      mov     r1, sp          @ Save stack pointer to r1, you must create space
      bl      scanf           @ Scan user's answer
      ldr     r1, =yes        @ Put address of 'y' in r1
      ldrb    r1, [r1]        @ Load the actual character 'y' into r1
      ldrb    r0, [sp]        @ Put the user's value in r0
      cmp     r0, r1          @ Compare user's answer to char 'y'
      beq     loop            @ branch to appropriate location
    
      mov r0, #0
      add sp, sp, #20
      ldr pc, [sp], #4
    @ this only works for character scans. You'll need a different
    @ format specifier for scanf for an integer ("%d"), and you'll
    @ need to use the ldr instruction instead of ldrb to load an int.
end:

add1:
    .byte   '+'
sub1:
    .byte   '-'
mul1:
    .byte   '*'
yes:
    .byte   'y'
scanchar:
    .asciz  " %c"

printdata:
    .word string1
    .word string2
    .word string3
    .word string4
    .word string5
    .word string6
    .word string7
    .word string8
string1:
    .asciz "Enter Number 1: "
string2:
    .asciz "%d"
string3:
    .asciz "Enter Number 2: "
string4:
    .asciz "%d"
string5:
    .asciz "Result: %d\n"
string6:
    .asciz "Again? "
string7:
    .asciz "Enter Operation: "
string8:
    .asciz "Invalid\n"
