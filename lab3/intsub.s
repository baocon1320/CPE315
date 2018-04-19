    .syntax unified

    @ intsub function
    @ Bao Nguyen && Jeevan

    .arch armv6
    .fpu vfp 

    @----------------------------------
    .global intsub
intsub:
    push {r2,r3,r4}
    push {r5,r6,r7}
    mov r7, #1       /* use to keep track */
    mov r3, #1       /* carry  = 1 */
    mov r5, #0       /* sum = 0 */
    mvn r1, r1       /* not r1 */ 
loopsub:
    cmp r7, #0       /* while r7 >= 0 */
    beq exitsub
    and r2, r0, r7   /* get a bit at a time */
    and r6, r1, r7
    eor r4, r2, r6   /* r4 = r2 xor r6 xor r3 */
    eor r4, r4, r3
    orr r5, r4, r5   /* sum = sum or r4 */
    and r4, r2, r6   /* carry */
    and r2, r2, r3
    and r6, r6, r3
    orr r2, r2, r6
    orr r3, r2, r4
    mov r3, r3, lsl #1
    mov r7, r7, lsl #1
    b loopsub
exitsub:
   mov r0, r5
   pop {r5, r6, r7}
   pop {r2, r3, r4}
   mov pc, lr
