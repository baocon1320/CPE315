    .syntax unified

    @ intmul function
    @ Bao Nguyen && Jeevan

    .arch armv6
    .fpu vfp 

    @ -------------------------------
    .global intmul
intmul:
    push    {r2, r3, r4}
    push    {r5, r6, lr}
    mov     r5, r0         /* r5 is Mcand */
    mov     r6, r1         /* r6 is Mplier */
    mov     r2, #0         /* result R2 */
    mov     r3, #1         /* mask r3 = 0001 */
    and     r4, r6, r3     /* check first bit of Mplier */
loopmul:
    cmp     r3, #0         /* check to do 32 time */
    beq     exitmul
    cmp     r4, #0         /* check if next bit of Mplier is 1 or 0 */
    beq     doshif
    mov     r0, r2         /* result is first arg of addint */
    mov     r1, r5         /* Mcand is the second arg of addin */
    bl      intadd
    mov     r2, r0         /* return result to result */

doshif:
    mov     r5, r5, lsl #1 /* left shift Mcand */
    mov     r3, r3, lsl #1 /* left shift mask */
    and     r4, r3, r6     /* check next bit of Mplier */
    b       loopmul    

exitmul:
    mov     r0, r2
    pop     {r5, r6, lr}
    pop     {r2, r3, r4}
    mov     pc, lr

