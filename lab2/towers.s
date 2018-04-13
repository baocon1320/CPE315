	.arch armv6
	.fpu vfp
	.text

@ print function is complete, no modifications needed
    .global	print
print:
	stmfd	sp!, {r3, lr}
	mov	r3, r0
	mov	r2, r1
	ldr	r0, startstring
	mov	r1, r3
	bl	printf
	ldmfd	sp!, {r3, pc}

startstring:
	.word	string0

    .global	towers
towers:
   push {r3, r4, lr}            /* Save calllee-saved registers to stack */
   
   push {r0, r1, r2}    /* Save a copy of all 3 incoming parameters */

if:
   cmp r0, #2           /* Compare numDisks with 2 or (numDisks - 2)*/
   bge else             /* Check if less than, else branch to else */
   
   mov r0, r1           /* set print function's start to incoming start */
   mov r1, r2           /* set print function's end to goal */
   bl print             /* call print function */
   mov r0, #1           /* Set return register to 1 */
   b endif              /* branch to endif */
else:
   mov r4, #6           /* Use a callee-saved varable for temp and set it to 6 */
   sub r4, r4, r1       /* Subract start from temp and store to itself */
   sub r4, r4, r2       /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/

   sub r0, r0, #1       /* subtract 1 from original numDisks and store it to numDisks parameter */

   mov r2, r4           /* Set end parameter as temp */
   bl towers            /* Call towers function */
   mov r3, r0           /* Save result to callee-saved register for total steps */
   mov r0, #1           /* Set numDiscs parameter to 1 */
   ldr r1, [sp, #4]     /* Set start parameter to original start */
   ldr r2, [sp, #8]     /* Set goal parameter to original goal */
   bl towers            /* Call towers function */
   add r3, r3, r0       /* Add result to total steps so far */
   
   ldr r0, [sp, #0]     /* Set numDisks parameter to original numDisks - 1 */
   sub r0, r0, #1
   mov r1, r4           /* set start parameter to temp */
   ldr r2, [sp, #8]     /* set goal parameter to original goal */
   bl towers            /* Call towers function */
   add r0, r3, r0       /* Add result to total steps so far and save it to return register */

endif:
   add sp, sp, #12     /* Restore Registers */
   pop {r3, r4, lr}
   mov pc, lr
@ Function main is complete, no modifications needed
    .global	main
main:
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r0, printdata
	bl	printf
	ldr	r0, printdata+4
	add	r1, sp, #12
	bl	scanf
	ldr	r0, [sp, #12]
	mov	r1, #1
	mov	r2, #3
	bl	towers
	str	r0, [sp]
	ldr	r0, printdata+8
	ldr	r1, [sp, #12]
	mov	r2, #1
	mov	r3, #3
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	ldr	pc, [sp], #4
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"
