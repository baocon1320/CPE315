    /* This function has 5 parameters, and the declaration in the
       C-language would look like:

       void matadd (int **C, int **A, int **B, int height, int width)

       C, A, B, and height will be passed in r0-r3, respectively, and
       width will be passed on the stack.

       You need to write a function that computes the sum C = A + B.

       A, B, and C are arrays of arrays (matrices), so for all elements,
       C[i][j] = A[i][j] + B[i][j]

       You should start with two for-loops that iterate over the height and
       width of the matrices, load each element from A and B, compute the
       sum, then store the result to the correct element of C. 

       This function will be called multiple times by the driver, 
       so don't modify matrices A or B in your implementation.

       As usual, your function must obey correct ARM register usage
       and calling conventions. */

	.arch armv7-a
	.text
	.align	2
	.global	matadd
	.syntax unified
	.arm

matadd:
    push {r4}
    ldr r4, [sp, #4]
    push {r5,r6,r7,r8,r9,r10}
    
    mov r3, r3, LSL #2
    mov r4, r4, LSL #2
    
RowLoop:
    sub r3, r3, #4
    cmp r3, #0
    blt EndRowLoop
    
    ldr r5, [r0, r3]
    ldr r6, [r1, r3]
    ldr r7, [r2, r3]
     
    mov r10, r4
    
ColLoop:

    sub r10, r10, #8
    cmp r10, #0  
    blt EndColLoop
   
    add r10, r10, #4
    ldr r8, [r6, r10]
    ldr r9, [r7, r10]
    add r9, r9, r8
    str r9, [r5, r10] 
   
    sub r10, r10, #4
    ldr r8, [r6, r10]
    ldr r9, [r7, r10]
    add r9, r9, r8
    str r9, [r5, r10] 
    
    b ColLoop

EndColLoop:
    b RowLoop    

EndRowLoop:
    pop {r5,r6,r7,r8,r9,r10}
    pop {r4}
    bx lr
    
 
